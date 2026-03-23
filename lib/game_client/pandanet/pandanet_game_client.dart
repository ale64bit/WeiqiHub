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
import 'pandanet_sgf_parser.dart';
import 'pandanet_html_parser.dart';
import 'pandanet_tcp_manager.dart';
import 'pandanet_game.dart';
import 'game_utils.dart';
import 'package:wqhub/wq/wq.dart' as wq;
import 'package:wqhub/wq/rank.dart';

String? _currentGameId;

class PandaNetGameClient extends GameClient {
  final Logger _logger = Logger('PandaNetGameClient');
  static const String _userAgent = 'WeiqiHub/1.0';

  final ValueNotifier<UserInfo?> _userInfo = ValueNotifier(null);
  final ValueNotifier<String> _password = ValueNotifier('');
  final ValueNotifier<DateTime> _disconnected = ValueNotifier(DateTime.now());
  final http.Client _httpClient = http.Client();
  final PandanetTcpManager _tcpManager = PandanetTcpManager();

  final String serverUrl = 'https://pandanet-igs.com/';
  final String apiUrl = 'https://my.pandanet.co.jp/';
  final String snsUrl = 'https://sns.pandanet.co.jp/';

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
        mainTime: Duration(minutes: 100),
        periodCount: 1,
        timePerPeriod: Duration(minutes: 5),
      ),
      'rapid': TimeControl(
        mainTime: Duration(minutes: 100),
        periodCount: 1,
        timePerPeriod: Duration(minutes: 7),
      ),
      'fast': TimeControl(
        mainTime: Duration(minutes: 100),
        periodCount: 1,
        timePerPeriod: Duration(minutes: 10),
      ),
      'slow': TimeControl(
        mainTime: Duration(minutes: 100),
        periodCount: 1,
        timePerPeriod: Duration(minutes: 15),
      ),
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
      _logger.info('TCP connection established');
    } catch (e) {
      _logger.warning('Failed to connect to PandaNet TCP server: $e');
    }
  }

  @override
  Future<UserInfo> login(String username, String password) async {
    try {
      _logger.info('Attempting login for user "$username"...');
      await _connectTcp(username, password);

      final stats = await _tcpManager.getStats();
      final rank = RankParsing.fromString(stats.rank);
      final user = UserInfo(
        userId: stats.player,
        username: stats.player,
        rank: rank,
        online: true,
        winCount: stats.wins,
        lossCount: stats.losses,
      );

      _userInfo.value = user;
      _password.value = password;
      return user;
    } catch (e, st) {
      _logger.warning('Login error: $e:$st');
      rethrow;
    }
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

    // Request players near our rank
    const range = '3k-1d';
    _logger.info('Requesting who $range');
    List<Map<String, String>> whoList = [];
    try {
      whoList = await _tcpManager
          .getWho(range: range)
          .timeout(const Duration(seconds: 3));
      _logger.info('Fetched ${whoList.length} players within $range');
    } catch (e) {
      _logger.warning('getWho() failed or timed out: $e');
    }

    subscription = _tcpManager.messages.listen((message) {
      if (message.contains('15 Game') && message.contains('accepted')) {
        _logger.info('Detected accepted match: $message');

        final gameIdMatch = RegExp(r'15 Game (\d+)').firstMatch(message);
        final playersMatch =
            RegExp(r'I:\s*(\w+).*\s+vs\s+(\w+)').firstMatch(message);

        gameId = gameIdMatch?.group(1);
        whitePlayer = playersMatch?.group(1);
        blackPlayer = playersMatch?.group(2);

        final handicapMatch = RegExp(r'Handicap\s+(\d+)').firstMatch(message);
        handicap = handicapMatch != null
            ? int.tryParse(handicapMatch.group(1)!) ?? 0
            : 0;

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
      }

      if (message.startsWith('36') &&
          message.contains('wants a match with you')) {
        final match = RegExp(r'36\s+(\S+)\s+wants a match').firstMatch(message);
        if (match != null) {
          final opponent = match.group(1)!;
          _logger.info('Auto-accepting incoming match from $opponent');
          _tcpManager.send('automatch $opponent');
        }
      }

      if (message.contains('declines your request')) {
        subscription?.cancel();
        if (!completer.isCompleted) completer.completeError('Match declined');
      }
    }, onError: (e) {
      subscription?.cancel();
      if (!completer.isCompleted) completer.completeError(e);
    });

    _logger.info('Sent match requests to ${whoList.length} candidates');

    for (final p in whoList) {
      if (completer.isCompleted) break;

      final name = p['name'];
      final rank = p['rank'];
      if (name != null && rank != null && name != username) {
        _logger.fine('Matching $name ($rank)');
        _tcpManager.sendMatch(
          name,
          color: 'B',
          main: 1,
          overtime: 5,
        );
        await Future.delayed(const Duration(milliseconds: 100));
      }
    }

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
      _logger.warning('Cannot fetch, not logged in.');
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
    final games = parseGameList(response.body, RankParsing.fromString);
    for (final game in games){
      _logger.info(game.id);
    }
    return games;
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
