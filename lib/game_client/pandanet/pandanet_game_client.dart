import 'dart:async';
import 'dart:convert';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:wqhub/game_client/automatch_preset.dart';
import 'package:wqhub/game_client/game.dart';
import 'package:wqhub/game_client/game_client.dart';
import 'package:wqhub/game_client/game_record.dart';
import 'package:wqhub/game_client/rules.dart';
import 'package:wqhub/game_client/server_features.dart';
import 'package:wqhub/game_client/server_info.dart';
import 'package:wqhub/game_client/time_control.dart';
import 'package:wqhub/game_client/user_info.dart';
import 'pandanet_html_parser.dart';
import 'pandanet_sgf_parser.dart';
import 'pandanet_tcp_manager.dart';
import 'pandanet_game.dart';
import 'package:wqhub/wq/wq.dart' as wq;
import 'package:wqhub/wq/rank.dart';

class PandaNetGameClient extends GameClient {
  final Logger _logger = Logger('PandaNetGameClient');
  static const String _userAgent = 'WeiqiHub/1.0';

  final ValueNotifier<UserInfo?> _userInfo = ValueNotifier(null);
  final ValueNotifier<String> _password = ValueNotifier('');
  final ValueNotifier<DateTime> _disconnected = ValueNotifier(DateTime.now());
  final http.Client _httpClient = http.Client();

  final String serverUrl = 'https://pandanet-igs.com/';
  final String apiUrl = 'https://my.pandanet.co.jp/';
  final String snsUrl = 'https://sns.pandanet.co.jp/';
  final PandanetTcpManager _tcpManager = PandanetTcpManager();

  @override
  ServerInfo get serverInfo => ServerInfo(
        id: 'pandanet',
        name: (loc) => 'PandaNet (IGS)',
        nativeName: 'PandaNet (IGS)',
        description: (loc) => 'Internet Go Server - PandaNet',
        homeUrl: serverUrl,
        registerUrl: Uri.parse('${serverUrl}igs_users/register'),
      );

  @override
  ServerFeatures get serverFeatures => ServerFeatures(
        manualCounting: true,
        automaticCounting: true,
        aiReferee: false,
        aiRefereeMinMoveCount: const IMapConst({}),
        forcedCounting: false,
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
    const speeds = ['blitz', 'rapid', 'fast', 'slow'];
    final timeControls = {
      'blitz': TimeControl(
        // Pandanet has Canadian time controls (primarily, Japanese rules possible in some hacky workaround
        // will need to implement the change app-wide or make find how to enforce japanese rules.
        mainTime: Duration(minutes: 1),
        periodCount: 1,
        timePerPeriod: Duration(minutes: 5),
      ), //stonesPerPeriod: 25),
      'rapid': TimeControl(
        mainTime: Duration(minutes: 1),
        periodCount: 1,
        timePerPeriod: Duration(minutes: 7),
      ), //stonesPerPeriod: 25),
      'fast': TimeControl(
        mainTime: Duration(minutes: 1),
        periodCount: 1,
        timePerPeriod: Duration(minutes: 10),
      ), //stonesPerPeriod: 25),
      'slow': TimeControl(
        mainTime: Duration(minutes: 1),
        periodCount: 1,
        timePerPeriod: Duration(minutes: 15),
      ), //stonesPerPeriod: 25),
    };

    final presets = <AutomatchPreset>[];
    for (final speed in speeds) {
      presets.add(AutomatchPreset(
        id: '19x19_$speed',
        boardSize: 19,
        variant: Variant.standard,
        rules: Rules.japanese,
        timeControl: timeControls[speed]!,
      ));
    }
    return presets.lock;
  }

  @override
  Future<ReadyInfo> ready() async => ReadyInfo();

  Future<void> _connectTcp(String username, String password) async {
    if (_tcpManager.isConnected) return;

    try {
      await _tcpManager.connect(username, password);
      _tcpManager.messages.listen((m) => _logger.fine('PandaNet TCP: $m'),
          onError: (e) => _logger.warning('PandaNet TCP stream error: $e'));
      _logger.info('TCP connection established');
    } catch (e) {
      _logger.warning('Failed to connect to PandaNet TCP: $e');
    }
  }

  @override
  Future<UserInfo> login(String username, String password) async {
    try {
      _logger.info('Attempting login for user "$username"...');
      final loginResponse = await _httpClient.post(
        Uri.parse('${serverUrl}igs_users/jwt_token.json'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
          'lang': 'en',
        }),
      );

      if (loginResponse.statusCode != 200) {
        throw Exception('Login failed: ${loginResponse.statusCode}');
      }

      final data = jsonDecode(loginResponse.body);
      if (data['success'] != true) throw Exception('Login unsuccessful.');

      final user = await _fetchUserInfo(username, password);
      _userInfo.value = user;
      _password.value = password;

      unawaited(_connectTcp(username, password));

      return user;
    } catch (e, st) {
      _logger.warning('Login error: $e\n$st');
      rethrow;
    }
  }

  Future<UserInfo> _fetchUserInfo(String username, String password) async {
    final cgiResponse = await _httpClient.post(
      Uri.parse('${apiUrl}cgi-bin/cgi.exe?MH'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'page': 'profile',
        'param': 'id=$username',
        'userid': username,
        'password': password,
      },
    );

    final accKey = parseKey(cgiResponse.body);

    final profileResponse = await _httpClient.get(
      Uri.parse('${snsUrl}mypage.php?key=$accKey'),
      headers: {'User-Agent': _userAgent},
    );

    final parsed = parseUserInfo(profileResponse.body);
    final rank = parseRankString(parsed.rankStr);

    return UserInfo(
      userId: username,
      username: username,
      rank: rank,
      online: true,
      winCount: parsed.wins,
      lossCount: parsed.losses,
    );
  }

  @override
  void logout() {
    _userInfo.value = null;
    _password.value = '';
    try {
      _tcpManager.close();
    } catch (e) {
      _logger.fine('Error closing TCP manager: $e');
    }
  }

  @override
  Future<Game?> ongoingGame() async => null;

  @override
  Future<Game> findGame(String presetId) async {
    final username = _userInfo.value?.username;
    if (username == null || username.isEmpty) {
      throw Exception('Not logged in');
    }

    final preset = automatchPresets.firstWhere(
      (p) => p.id == presetId,
      orElse: () => automatchPresets.first,
    );

    if (!_tcpManager.isConnected) {
      await _tcpManager.connect(username, _password.value);
    }

    final completer = Completer<Game>();
    StreamSubscription<String>? subscription;

    String? gameId;
    String? whitePlayer;
    String? blackPlayer;
    int handicap = 0;

    subscription = _tcpManager.messages.listen((message) {
      if (message.startsWith('15 Game')) {
        final match =
            RegExp(r'15 Game (\d+) I: (\w+) .* vs (\w+)').firstMatch(message);
        if (match != null) {
          gameId = match.group(1);
          whitePlayer = match.group(2);
          blackPlayer = match.group(3);
          _logger
              .fine('Parsed players → White=$whitePlayer, Black=$blackPlayer');
        }
      } else if (message.contains('Handicap')) {
        final m = RegExp(r'Handicap\s+(\d+)').firstMatch(message);
        if (m != null) {
          handicap = int.parse(m.group(1)!);
          _logger.info('Detected handicap: $handicap');
        }
      } else if (message.contains('Match [') && message.contains('accepted')) {
        _logger.info('Match accepted: $message');

        if (gameId != null && whitePlayer != null && blackPlayer != null) {
          final myColor =
              username == whitePlayer ? wq.Color.white : wq.Color.black;

          final previousMoves = <wq.Move>[];
          if (handicap >= 2) {
            final pts = PandanetGame.handicapPoints19(handicap.clamp(2, 9));
            for (final p in pts) {
              previousMoves.add((col: wq.Color.black, p: p));
            }
          }

          final game = PandanetGame(
            tcp: _tcpManager,
            id: gameId!,
            boardSize: preset.boardSize,
            timeControl: preset.timeControl,
            myColor: handicap > 0 ? wq.Color.white : myColor,
            handicap: handicap,
            komi: handicap > 0 ? 0.0 : 6.5,
            previousMoves: previousMoves,
          );

          game.white.value = UserInfo.empty().copyWith(
            userId: whitePlayer,
            username: whitePlayer,
            online: true,
          );
          game.black.value = UserInfo.empty().copyWith(
            userId: blackPlayer,
            username: blackPlayer,
            online: true,
          );

          _logger.info(
            'Game created: id=$gameId, white=$whitePlayer, black=$blackPlayer, '
            'handicap=$handicap, myColor=${game.myColor.name}',
          );

          subscription?.cancel();
          completer.complete(game);
        }
      } else if (message.contains('declines your request')) {
        subscription?.cancel();
        if (!completer.isCompleted) completer.completeError('Match declined');
      }
    }, onError: (e) {
      subscription?.cancel();
      if (!completer.isCompleted) completer.completeError(e);
    });

    _tcpManager.sendMatch(
      'Hurakami',
      color: 'B',
      main: preset.timeControl.mainTime?.inMinutes ?? 60,
      overtime: preset.timeControl.timePerPeriod?.inMinutes ?? 5,
    );

    _logger.info('Sent match request to Hurakami');
    return completer.future;
  }

  @override
  void stopAutomatch() {
    final username = _userInfo.value?.username;
    if (username != null && username.isNotEmpty) {
      _tcpManager.sendUnmatch(username);
    }
  }

  @override
  Future<List<GameSummary>> listGames() async {
    final username = _userInfo.value?.username;
    final password = _password.value;

    if (username == null || username.isEmpty || password.isEmpty) {
      _logger.warning('Cannot fetch game history: user not logged in.');
      return [];
    }

    final response = await _httpClient.post(
      Uri.parse('${apiUrl}cgi-bin/cgi.exe?MH'),
      headers: {'content-type': 'application/x-www-form-urlencoded'},
      body: {
        'pg': 'SearchResult',
        'PageNo': '1',
        'MyName': username,
        'userid': username,
        'password': password,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch game list: ${response.statusCode}');
    }

    return parseGameList(response.body, parseRankString);
  }

  @override
  Future<GameRecord> getGame(String gameId) async {
    final response = await _httpClient.get(Uri.parse(gameId));
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch SGF: ${response.statusCode}');
    }

    var sgfContent = cleanSgfContent(response.body);
    return PandanetSgfParser.parse(sgfContent);
  }

  void dispose() {
    _httpClient.close();
    _userInfo.dispose();
    _disconnected.dispose();
  }
}
