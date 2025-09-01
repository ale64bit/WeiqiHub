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
import 'package:wqhub/game_client/server_features.dart';
import 'package:wqhub/game_client/server_info.dart';
import 'package:wqhub/game_client/user_info.dart';
import 'package:wqhub/wq/rank.dart';
import 'package:wqhub/wq/wq.dart' as wq;

class OGSGameClient extends GameClient {
  final ValueNotifier<UserInfo?> _userInfo = ValueNotifier(null);
  final ValueNotifier<DateTime> _disconnected = ValueNotifier(DateTime.now());
  
  final String serverUrl;

  OGSGameClient({required this.serverUrl}) {
    
  }

  String? _csrfToken;
  final http.Client _httpClient = http.Client();

  @override
  ServerInfo get serverInfo => ServerInfo(
        id: 'ogs',
        name: 'Online Go Server',
        nativeName: 'OGS',
        description: 'The premier online Go platform with tournaments, AI analysis, and a vibrant community.',
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
        localTimeControl: false, // OGS handles time control server-side
      );

  @override
  ValueNotifier<UserInfo?> get userInfo => _userInfo;

  @override
  ValueNotifier<DateTime> get disconnected => _disconnected;

  @override
  IList<AutomatchPreset> get automatchPresets => IList();

  @override
  Future<ReadyInfo> ready() async {
    try {
      // Test connection to OGS API
      final response = await _httpClient.get(
        Uri.parse('$serverUrl/api/v1/ui/config'),
        headers: {'User-Agent': 'WeiqiHub/1.0'},
      );
      
      if (response.statusCode == 200) {
        return ReadyInfo();
      } else {
        throw Exception('OGS API not available: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to OGS: $e');
    }
  }

  @override
  Future<UserInfo> login(String username, String password) async {
    try {
      // First, get the CSRF token
      final csrfResponse = await _httpClient.get(
        Uri.parse('$serverUrl/api/v1/ui/config'),
        headers: {'User-Agent': 'WeiqiHub/1.0'},
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
          'User-Agent': 'WeiqiHub/1.0',
          'X-CSRFToken': _csrfToken!,
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );
      
      if (loginResponse.statusCode == 200) {
        final userData = jsonDecode(loginResponse.body)['user'];
        
        final user = UserInfo(
          userId: userData['id'].toString(),
          username: userData['username'],
          rank: _ratingToRank(userData['ratings']['overall']['rating']),
          online: true,
          winCount: 0,
          lossCount: 0,
        );
        
        _userInfo.value = user;
        
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
    _userInfo.value = null;
  }

  @override
  Future<Game?> ongoingGame() async {
    return null;
  }

  @override
  Future<Game> findGame(String presetId) async {
    throw UnimplementedError();
  }

  @override
  void stopAutomatch() {
    throw UnimplementedError();
  }

@override
  Future<List<GameSummary>> listGames() async {
    try {
      // Get the current user ID for the games API endpoint
      final userInfo = _userInfo.value;
      if (userInfo == null) {
        throw Exception('Not logged in');
      }
      print(userInfo);

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
          'User-Agent': 'WeiqiHub/1.0',
          if (_csrfToken != null) 'X-CSRFToken': _csrfToken!,
        },
      );

      print("got here ${response.statusCode}");
      print('$serverUrl/api/v1/players/${userInfo.userId}/games/');

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
    throw UnimplementedError();
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

  void dispose() {
    _httpClient.close();
    _userInfo.dispose();
    _disconnected.dispose();
  }
}
