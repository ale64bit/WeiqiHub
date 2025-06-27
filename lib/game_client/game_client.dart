import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/widgets.dart';
import 'package:wqhub/game_client/automatch_preset.dart';
import 'package:wqhub/game_client/game.dart';
import 'package:wqhub/game_client/game_record.dart';
import 'package:wqhub/game_client/game_result.dart';
import 'package:wqhub/game_client/server_features.dart';
import 'package:wqhub/game_client/server_info.dart';
import 'package:wqhub/game_client/user_info.dart';

enum Variant { standard }

@immutable
class ReadyInfo {}

class GameSummary {
  final String id;
  final int boardSize;
  final UserInfo white;
  final UserInfo black;
  final DateTime dateTime;
  final GameResult result;

  GameSummary(
      {required this.id,
      required this.boardSize,
      required this.white,
      required this.black,
      required this.dateTime,
      required this.result});
}

abstract class GameClient {
  ServerInfo get serverInfo;
  ServerFeatures get serverFeatures;
  ValueNotifier<UserInfo?> get userInfo;
  IList<AutomatchPreset> get automatchPresets;
  ValueNotifier<DateTime> get disconnected;

  Future<ReadyInfo> ready();
  Future<UserInfo> login(String username, String password);
  void logout();
  Future<Game?> ongoingGame();
  Future<Game> findGame(String presetId);
  void stopAutomatch();
  Future<List<GameSummary>> listGames();
  Future<GameRecord> getGame(String gameId);
}
