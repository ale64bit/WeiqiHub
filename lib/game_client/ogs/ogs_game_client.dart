import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wqhub/game_client/automatch_preset.dart';
import 'package:wqhub/game_client/game.dart';
import 'package:wqhub/game_client/game_client.dart';
import 'package:wqhub/game_client/game_record.dart';
import 'package:wqhub/game_client/game_result.dart';
import 'package:wqhub/game_client/ogs/game_utils.dart';
import 'package:wqhub/game_client/ogs/ogs_game.dart';
import 'package:wqhub/game_client/ogs/ogs_websocket_manager.dart';
import 'package:wqhub/game_client/rules.dart';
import 'package:wqhub/game_client/server_features.dart';
import 'package:wqhub/game_client/server_info.dart';
import 'package:wqhub/game_client/time_control.dart';
import 'package:wqhub/game_client/user_info.dart';
import 'package:wqhub/wq/rank.dart';
import 'package:wqhub/wq/wq.dart' as wq;
import 'package:uuid/uuid.dart';
import 'package:logging/logging.dart';

class OGSGameClient extends GameClient {
  final Logger _logger = Logger('OGSGameClient');

  static const String _userAgent = 'WeiqiHub/1.0';

  /// OGS default rank difference for automatch requests
  /// https://github.com/online-go/online-go.com/blob/b0d661e69cef0ce57c2c5d4e2e04109227ba9a96/src/lib/preferences.ts#L57-L58
  static const int _defaultRankDiff = 3;

  final ValueNotifier<UserInfo?> _userInfo = ValueNotifier(null);
  final ValueNotifier<DateTime> _disconnected = ValueNotifier(DateTime.now());

  final String serverUrl;
  final String aiServerUrl;
  late final OGSWebSocketManager _webSocketManager;

  OGSGameClient({required this.serverUrl, required this.aiServerUrl}) {
    _webSocketManager = OGSWebSocketManager(serverUrl: serverUrl);

    // Listen to WebSocket connection status
    _webSocketManager.connected.addListener(() {
      if (!_webSocketManager.connected.value) {
        _disconnected.value = DateTime.now();
      }
    });
  }

  String? _csrfToken;
  String? _jwtToken;

  String? _currentAutomatchUuid;

  Completer<Game>? _automatchCompleter;
  StreamSubscription<Map<String, dynamic>>? _messageSubscription;
  final http.Client _httpClient = http.Client();

  @override
  ServerInfo get serverInfo => ServerInfo(
        id: 'ogs',
        name: (loc) => loc.ogsName,
        nativeName: 'OGS',
        description: (loc) => loc.ogsDesc,
        homeUrl: serverUrl,
        registerUrl: Uri.parse('$serverUrl/register'),
      );

  @override
  ServerFeatures get serverFeatures => ServerFeatures(
        manualCounting: true,
        automaticCounting: true,
        aiReferee: false, // OGS's AI referee cannot be called on-demand
        aiRefereeMinMoveCount: const IMapConst({}),
        forcedCounting: false, // OGS handles counting differently
        forcedCountingMinMoveCount: const IMapConst({}),
        localTimeControl: true,
      );

  @override
  ValueNotifier<UserInfo?> get userInfo => _userInfo;

  @override
  ValueNotifier<DateTime> get disconnected => _disconnected;

  @override
  IList<AutomatchPreset> get automatchPresets => _createAutomatchPresets();

  static IList<AutomatchPreset> _createAutomatchPresets() {
    const boardSizes = [9, 13, 19];
    const speeds = ['blitz', 'rapid', 'live'];

    // Define time controls for each board size and speed combination based on OGS SPEED_OPTIONS
    // https://github.com/online-go/online-go.com/blob/4ed60176f8fe21960376b663515f4721dad22ab1/src/views/Play/SPEED_OPTIONS.ts#L40
    final timeControlsBySpeedAndSize = {
      '9x9': {
        'blitz': TimeControl(
          mainTime: Duration(seconds: 30),
          periodCount: 5,
          timePerPeriod: Duration(seconds: 10),
        ),
        'rapid': TimeControl(
          mainTime: Duration(minutes: 2),
          periodCount: 5,
          timePerPeriod: Duration(seconds: 30),
        ),
        'live': TimeControl(
          mainTime: Duration(minutes: 5),
          periodCount: 5,
          timePerPeriod: Duration(seconds: 30),
        ),
      },
      '13x13': {
        'blitz': TimeControl(
          mainTime: Duration(seconds: 30),
          periodCount: 5,
          timePerPeriod: Duration(seconds: 10),
        ),
        'rapid': TimeControl(
          mainTime: Duration(minutes: 3),
          periodCount: 5,
          timePerPeriod: Duration(seconds: 30),
        ),
        'live': TimeControl(
          mainTime: Duration(minutes: 10),
          periodCount: 5,
          timePerPeriod: Duration(seconds: 30),
        ),
      },
      '19x19': {
        'blitz': TimeControl(
          mainTime: Duration(seconds: 30),
          periodCount: 5,
          timePerPeriod: Duration(seconds: 10),
        ),
        'rapid': TimeControl(
          mainTime: Duration(minutes: 5),
          periodCount: 5,
          timePerPeriod: Duration(seconds: 30),
        ),
        'live': TimeControl(
          mainTime: Duration(minutes: 20),
          periodCount: 5,
          timePerPeriod: Duration(seconds: 30),
        ),
      },
    };

    final presets = <AutomatchPreset>[];

    for (final boardSize in boardSizes) {
      for (final speed in speeds) {
        final sizeKey = '${boardSize}x$boardSize';
        final timeControl = timeControlsBySpeedAndSize[sizeKey]![speed]!;

        presets.add(AutomatchPreset(
          id: '${boardSize}_${speed}',
          boardSize: boardSize,
          variant: Variant.standard,
          rules: Rules.japanese, // OGS uses Japanese rules for automatch
          timeControl: timeControl,
        ));
      }
    }

    return presets.lock;
  }

  @override
  Future<ReadyInfo> ready() async {
    return ReadyInfo();
  }

  @override
  Future<UserInfo> login(String username, String password) async {
    try {
      // First, get the CSRF token
      final csrfResponse = await _httpClient.get(
        Uri.parse('$serverUrl/api/v1/ui/config'),
        headers: {'User-Agent': _userAgent},
      );

      if (csrfResponse.statusCode != 200) {
        throw Exception('Failed to get CSRF token');
      }

      final csrfData = jsonDecode(csrfResponse.body);
      _csrfToken = csrfData['csrf_token'];

      // Now attempt login
      final loginResponse = await _httpClient.post(
        Uri.parse('$serverUrl/api/v0/login'),
        headers: {
          'Content-Type': 'application/json',
          'User-Agent': _userAgent,
          'X-CSRFToken': _csrfToken!,
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (loginResponse.statusCode == 200) {
        final loginData = jsonDecode(loginResponse.body);
        final userData = loginData['user'];

        // Extract JWT token for WebSocket authentication
        _jwtToken = loginData['user_jwt'] ?? '';

        final user = UserInfo(
          userId: userData['id'].toString(),
          username: userData['username'],
          rank: _ratingToRank(userData['ratings']['overall']['rating']),
          online: true,
          winCount: 0,
          lossCount: 0,
        );

        _userInfo.value = user;

        await _webSocketManager.connect();

        // Authenticate with WebSocket if JWT token is available
        if (_jwtToken != null && _jwtToken!.isNotEmpty) {
          await _webSocketManager.authenticate(jwtToken: _jwtToken!);
        } else {
          throw Exception('No JWT token received');
        }

        return user;
      } else {
        throw Exception('Login failed: ${loginResponse.statusCode}');
      }
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }

  @override
  void logout() {
    _csrfToken = null;
    _jwtToken = null;
    _currentAutomatchUuid = null;
    _userInfo.value = null;
    _webSocketManager.disconnect();
  }

  @override
  Future<Game?> ongoingGame() async {
    try {
      // Get the current user ID for the games API endpoint
      final userInfo = _userInfo.value;
      if (userInfo == null) {
        throw Exception('Not logged in');
      }

      // Query: all ongoing games where the user is a player and "time per move" is less than 1 hour
      final response = await _httpClient.get(
        Uri.parse('$serverUrl/api/v1/players/${userInfo.userId}/games/')
            .replace(
          queryParameters: {
            'page_size': '10',
            'page': '1',
            'source': 'play',
            'ended__isnull': 'true',
            'time_per_move__lt': '3600',
          },
        ),
        headers: {
          'User-Agent': _userAgent,
          if (_csrfToken != null) 'X-CSRFToken': _csrfToken!,
        },
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to fetch ongoing games: ${response.statusCode}');
      }

      final data = jsonDecode(response.body);
      final List<dynamic> results = data['results'] ?? [];

      if (results.isEmpty) {
        return null;
      }

      final gameData = results.first;
      final gameId = gameData['id'].toString();

      return await getGameFromId(gameId);
    } catch (e) {
      _logger.warning('Failed to get ongoing game: $e');
      return null;
    }
  }

  /// Creates an OGSGame instance by fetching game data from the OGS API
  Future<Game> getGameFromId(String gameId) async {
    final userInfo = _userInfo.value;
    if (userInfo == null) {
      throw Exception('Not logged in');
    }

    final response = await _httpClient.get(
      Uri.parse('$serverUrl/api/v1/games/$gameId'),
      headers: {
        'User-Agent': _userAgent,
        if (_csrfToken != null) 'X-CSRFToken': _csrfToken!,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch game details: ${response.statusCode}');
    }

    final gameData =
        jsonDecode(response.body)['gamedata'] as Map<String, dynamic>;

    // Parse game information
    final boardSize = gameData['width'] as int? ?? 19;
    final handicap = gameData['handicap'] as int? ?? 0;
    final freeHandicapPlacement =
        gameData['free_handicap_placement'] as bool? ?? false;
    final komi = (gameData['komi'] as num?)?.toDouble() ?? 6.5;

    // Parse rules
    final rulesString = gameData['rules'] as String?;
    final rules = switch (rulesString?.toLowerCase()) {
      'chinese' => Rules.chinese,
      'korean' => Rules.korean,
      _ => Rules.japanese,
    };

    // Parse time control
    final timeControlData = gameData['time_control'] as Map<String, dynamic>?;
    final timeControl = TimeControl(
      mainTime: Duration(seconds: timeControlData?['main_time'] as int? ?? 300),
      timePerPeriod:
          Duration(seconds: timeControlData?['period_time'] as int? ?? 30),
      periodCount: timeControlData?['periods'] as int? ?? 5,
    );

    // Determine our color
    final players = gameData['players'] as Map<String, dynamic>?;
    final blackPlayerId = players?['black']?['id']?.toString();
    final whitePlayerId = players?['white']?['id']?.toString();

    wq.Color myColor;
    if (userInfo.userId == blackPlayerId) {
      myColor = wq.Color.black;
    } else if (userInfo.userId == whitePlayerId) {
      myColor = wq.Color.white;
    } else {
      throw Exception('Unable to determine player color for game $gameId');
    }

    final previousMoves =
        _parseMovesFromGameData(gameData, handicap, freeHandicapPlacement);

    return OGSGame(
      id: gameId,
      boardSize: boardSize,
      rules: rules,
      handicap: handicap,
      komi: komi,
      myColor: myColor,
      timeControl: timeControl,
      previousMoves: previousMoves,
      webSocketManager: _webSocketManager,
      myUserId: userInfo.userId,
      freeHandicapPlacement: freeHandicapPlacement,
      jwtToken: _jwtToken ?? '',
      aiServerUrl: aiServerUrl,
    );
  }

  @override
  Future<Game> findGame(String presetId) async {
    // Parse the preset ID to extract board size and speed (format: "9_blitz", "19_live", etc.)
    final parts = presetId.split('_');
    final boardSize = int.parse(parts[0]);
    final speed = parts.length >= 2 ? parts[1] : 'rapid';

    // Generate a UUID for the automatch request and store it for later cancellation
    _currentAutomatchUuid = const Uuid().v4();
    _automatchCompleter = Completer<Game>();

    // Set up message listener for automatch responses
    _messageSubscription =
        _webSocketManager.messages.listen(_handleAutomatchResponse);

    // Create the automatch payload data matching OGS format
    final automatchData = {
      "uuid": _currentAutomatchUuid!,
      "size_speed_options": [
        {"size": "${boardSize}x$boardSize", "speed": speed, "system": "byoyomi"}
      ],
      "lower_rank_diff": _defaultRankDiff,
      "upper_rank_diff": _defaultRankDiff,
      "rules": {"condition": "required", "value": "japanese"},
      "handicap": {"condition": "preferred", "value": "enabled"}
    };

    // Send the automatch request via WebSocket
    _webSocketManager.send('automatch/find_match', automatchData);

    return _automatchCompleter!.future;
  }

  void _handleAutomatchResponse(Map<String, dynamic> message) async {
    // Check if this is an automatch/start message
    if (message['event'] == 'automatch/start' &&
        message['data']['uuid'] == _currentAutomatchUuid) {
      final gameId = message['data']['game_id'] as int;

      // Clean up resources
      _messageSubscription?.cancel();
      _messageSubscription = null;
      _currentAutomatchUuid = null;

      try {
        final game = await getGameFromId(gameId.toString());

        // TODO: there's chance of a race where the automatch may have been created, but
        // the user has already cancelled it.  We should think about how to
        // avoid getting the user in trouble in this scenario.
        _automatchCompleter?.complete(game);
        _automatchCompleter = null;
      } catch (e) {
        _logger.warning("Error creating game: $e");
        _automatchCompleter?.completeError(e);
        _automatchCompleter = null;
      }
    }
  }

  @override
  void stopAutomatch() {
    // Send automatch cancel request to OGS with the stored UUID
    if (_currentAutomatchUuid != null) {
      _webSocketManager
          .send('automatch/cancel', {'uuid': _currentAutomatchUuid!});
      _currentAutomatchUuid = null; // Clear the stored UUID after cancellation
    }

    // Clean up message subscription and completer
    _messageSubscription?.cancel();
    _messageSubscription = null;
    _automatchCompleter?.completeError('Automatch cancelled');
    _automatchCompleter = null;
  }

  @override
  Future<List<GameSummary>> listGames() async {
    try {
      // Get the current user ID for the games API endpoint
      final userInfo = _userInfo.value;
      if (userInfo == null) {
        throw Exception('Not logged in');
      }

      final response = await _httpClient.get(
        Uri.parse('$serverUrl/api/v1/players/${userInfo.userId}/games/')
            .replace(
          queryParameters: {
            'page_size': '50',
            'page': '1',
            'source': 'play',
            'ended__isnull': 'false',
            'ordering': '-ended',
          },
        ),
        headers: {
          'User-Agent': _userAgent,
          if (_csrfToken != null) 'X-CSRFToken': _csrfToken!,
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to fetch games: ${response.statusCode}');
      }

      final data = jsonDecode(response.body);
      final List<dynamic> results = data['results'] ?? [];

      return results.map<GameSummary>((gameData) {
        // Parse basic game info
        final gameId = gameData['id'].toString();
        final boardSize = gameData['width'] as int? ?? 19;

        // Parse dates
        final endedStr = gameData['ended'] as String?;
        final dateTime =
            endedStr != null ? DateTime.parse(endedStr) : DateTime.now();

        // Parse players
        final blackPlayerData = gameData['players']['black'];
        final whitePlayerData = gameData['players']['white'];

        final blackPlayer = UserInfo(
          userId: blackPlayerData['id'].toString(),
          username: blackPlayerData['username'] ?? '',
          rank:
              _ratingToRank(blackPlayerData['ratings']?['overall']?['rating']),
          online: false, // Not available in this API
          winCount: 0, // Not available in this API
          lossCount: 0, // Not available in this API
        );

        final whitePlayer = UserInfo(
          userId: whitePlayerData['id'].toString(),
          username: whitePlayerData['username'] ?? '',
          rank:
              _ratingToRank(whitePlayerData['ratings']?['overall']?['rating']),
          online: false, // Not available in this API
          winCount: 0, // Not available in this API
          lossCount: 0, // Not available in this API
        );

        // Parse game result
        final outcome = gameData['outcome'] as String? ?? '';
        final blackLost = gameData['black_lost'] as bool? ?? false;
        final whiteLost = gameData['white_lost'] as bool? ?? false;

        wq.Color? winner;
        if (blackLost && !whiteLost) {
          winner = wq.Color.white;
        } else if (whiteLost && !blackLost) {
          winner = wq.Color.black;
        }
        // If both lost or neither lost, winner remains null (draw/unknown)

        final result = GameResult(
          winner: winner,
          result: outcome,
        );

        return GameSummary(
          id: gameId,
          boardSize: boardSize,
          white: whitePlayer,
          black: blackPlayer,
          dateTime: dateTime,
          result: result,
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to list games: $e');
    }
  }

  @override
  Future<GameRecord> getGame(String gameId) async {
    try {
      final response = await _httpClient.get(
        Uri.parse('$serverUrl/api/v1/games/$gameId/sgf'),
        headers: {
          'User-Agent': _userAgent,
          if (_csrfToken != null) 'X-CSRFToken': _csrfToken!,
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to fetch SGF: ${response.statusCode}');
      }

      final sgfContent = response.body;
      return GameRecord.fromSgf(sgfContent);
    } catch (e) {
      throw Exception('Failed to get game record: $e');
    }
  }

  Rank _ratingToRank(dynamic rating) {
    // OGS Glicko2 rating to rank conversion
    const minRating = 100;
    const maxRating = 6000;
    const a = 525;
    const c = 23.15;

    if (rating is num) {
      final clipped = rating.clamp(minRating, maxRating);
      final rankNum = (math.log(clipped / a) * c).round();

      final clampedRankNum = rankNum.clamp(0, Rank.values.length - 1);
      return Rank.values[clampedRankNum];
    }
    return Rank.k6; // Default
  }

  List<wq.Move> _parseMovesFromGameData(
      Map<String, dynamic> gameData, int handicap, bool freeHandicapPlacement) {
    final moves = <wq.Move>[];

    // Extract initial_state - this powers "forked" games, and, more importantly, handicap stones
    final initialState = gameData['initial_state'] as Map<String, dynamic>?;
    if (initialState != null) {
      moves.addAll(parseStonesString(
          initialState['black'] as String? ?? "", wq.Color.black));
      moves.addAll(parseStonesString(
          initialState['white'] as String? ?? "", wq.Color.white));
    }

    final movesData = gameData['moves'] as List<dynamic>?;
    if (movesData == null) {
      return moves;
    }

    for (int i = 0; i < movesData.length; i++) {
      final moveData = movesData[i];

      final color = colorToMove(i,
          handicap: handicap, freeHandicapPlacement: freeHandicapPlacement);

      if (moveData is List && moveData.length >= 2) {
        // OGS format: [col, row, time] where -1,-1 is pass
        final col = moveData[0] as int;
        final row = moveData[1] as int;
        moves.add((col: color, p: (row, col)));
      }
    }

    return moves;
  }

  void dispose() {
    _httpClient.close();
    _userInfo.dispose();
    _disconnected.dispose();
    _webSocketManager.dispose();
    _messageSubscription?.cancel();
  }
}
