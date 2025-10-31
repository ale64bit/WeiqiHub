import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:wqhub/game_client/automatch_preset.dart';
import 'package:wqhub/game_client/game.dart';
import 'package:wqhub/game_client/game_client.dart';
import 'package:wqhub/game_client/game_record.dart';
import 'package:wqhub/game_client/game_result.dart';
import 'package:wqhub/game_client/rules.dart';
import 'package:wqhub/game_client/server_features.dart';
import 'package:wqhub/game_client/server_info.dart';
import 'package:wqhub/game_client/time_control.dart';
import 'package:wqhub/game_client/user_info.dart';
import 'package:wqhub/wq/rank.dart';

class PandaNetGameClient extends GameClient {
  final Logger _logger = Logger('PandaNetGameClient');
  static const String _userAgent = 'WeiqiHub/1.0';

  final ValueNotifier<UserInfo?> _userInfo = ValueNotifier(null);
  final ValueNotifier<DateTime> _disconnected = ValueNotifier(DateTime.now());
  final http.Client _httpClient = http.Client();

  final String serverUrl = 'https://pandanet-igs.com/';

  @override
  ServerInfo get serverInfo => ServerInfo(
        id: 'pandanet',
        name: (loc) => 'PandaNet (IGS)', //TODO: localization/translation
        nativeName: 'PandaNet (IGS)',
        description: (loc) =>
            'Internet Go Server - PandaNet', //TODO: localization/translation
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
  IList<AutomatchPreset> get automatchPresets => const IListConst([]);

  @override
  Future<ReadyInfo> ready() async {
    _logger.info('PandaNetGameClient ready() called.');
    return ReadyInfo();
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

      _logger.info('Login HTTP status: ${loginResponse.statusCode}');
      if (loginResponse.statusCode != 200) {
        throw Exception('Login failed: ${loginResponse.statusCode}');
      }

      final data = jsonDecode(loginResponse.body);
      final successFlag = data['success'] == true;
      _logger.info('Login success flag: $successFlag');
      if (!successFlag) throw Exception('Login unsuccessful.');

      _logger.info(
          'JWT token retrieved (length=${(data['token'] as String?)?.length ?? 0}). Fetching user info...');

      final user = await _fetchUserInfo(username, password);
      _userInfo.value = user;
      return user;
    } catch (e, st) {
      _logger.warning('Login error: $e\n$st');
      rethrow;
    }
  }

  Future<UserInfo> _fetchUserInfo(String username, String password) async {
    try {
      _logger.info('Requesting AccKey for $username...');
      final cgiResponse = await _httpClient.post(
        Uri.parse('https://my.pandanet.co.jp/cgi-bin/cgi.exe?MH'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'page': 'profile',
          'param': 'id=$username',
          'userid': username,
          'password': password,
        },
      );

      final accKeyMatch =
          RegExp(r'key=([A-Z0-9]{10,})').firstMatch(cgiResponse.body);
      final accKey = accKeyMatch?.group(1);
      if (accKey == null) {
        throw Exception('Failed to obtain AccKey for user $username');
      }

      _logger.info('AccKey obtained: $accKey');

      final profileUrl = 'https://sns.pandanet.co.jp/mypage.php?key=$accKey';
      _logger.info('Fetching self stats from $profileUrl');
      final profileResponse = await _httpClient.get(
        Uri.parse(profileUrl),
        headers: {'User-Agent': _userAgent},
      );

      final html = profileResponse.body;
      _logger.fine('Fetched HTML length: ${html.length}');

      final parsed = _parseDdPoint(html);
      final rank = _parseRankString(parsed.rankStr);

      final user = UserInfo(
        userId: username,
        username: username,
        rank: rank,
        online: true,
        winCount: parsed.wins,
        lossCount: parsed.losses,
      );

      _logger.info(
          'User info fetch complete. Username=${user.username}, Rank=${user.rank}, W/L=${user.winCount}/${user.lossCount}');
      return user;
    } catch (e, st) {
      _logger.warning('Failed to fetch user info: $e\n$st');
      throw Exception('Failed to fetch user info: $e');
    }
  }

  ({int wins, int losses, String rankStr}) _parseDdPoint(String html) {
    final blockMatch = RegExp(
      r'<dd\s+class="dd-point"\s*>([\s\S]*?)</dd>',
      caseSensitive: false,
    ).firstMatch(html);

    if (blockMatch == null) {
      _logger.warning('dd-point block not found');
      return (wins: 0, losses: 0, rankStr: '');
    }

    final block = blockMatch.group(1)!;
    _logger.fine('dd-point block:\n$block');

    final winsMatch =
        RegExp(r'>(\d+)<[^>]*>\s*wins', caseSensitive: false).firstMatch(block);
    final lossesMatch =
        RegExp(r'>(\d+)<[^>]*>\s*loss', caseSensitive: false).firstMatch(block);

    final wins = int.tryParse(winsMatch?.group(1) ?? '') ?? 0;
    final losses = int.tryParse(lossesMatch?.group(1) ?? '') ?? 0;

    final rankMatch = RegExp(
      r'/\s*<font[^>]*>([^<]+)</font>\s*\(',
      caseSensitive: false,
    ).firstMatch(block);

    final rankStr = rankMatch?.group(1)?.trim() ?? '';

    _logger.info('dd-point parsed → wins=$wins losses=$losses rank="$rankStr"');
    return (wins: wins, losses: losses, rankStr: rankStr);
  }

  Rank _parseRankString(String str) {
    if (str.isEmpty) return Rank.unknown;

    final cleaned = str.toLowerCase().trim().replaceAll(RegExp(r'[+?]'), '');
    final match = RegExp(r'(\d+)\s*([kdp])$').firstMatch(cleaned);
    if (match == null) return Rank.unknown;

    final number = match.group(1);
    final suffix = match.group(2);
    final name = '$suffix$number';
    return Rank.values.firstWhere(
      (r) => r.name.toLowerCase() == name,
      orElse: () => Rank.unknown,
    );
  }

  @override
  void logout() {
    _userInfo.value = null;
  }

  @override
  Future<Game?> ongoingGame() async {
    _logger.info('ongoingGame() not implemented.');
    return null;
  }

  @override
  Future<Game> findGame(String presetId) {
    throw UnimplementedError();
  }

  @override
  void stopAutomatch() {}

  @override
  Future<List<GameSummary>> listGames() async {
    _logger.info('listGames() not implemented.');
    return [];
  }

  @override
  Future<GameRecord> getGame(String gameId) async {
    _logger.info('getGame() not implemented.');
    throw UnimplementedError();
  }

  void dispose() {
    _httpClient.close();
    _userInfo.dispose();
    _disconnected.dispose();
  }
}
