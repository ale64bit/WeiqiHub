import 'package:flutter/widgets.dart';
import 'package:wqhub/game_client/automatic_counting_info.dart';
import 'package:wqhub/game_client/counting_result.dart';
import 'package:wqhub/game_client/game_result.dart';
import 'package:wqhub/game_client/rules.dart';
import 'package:wqhub/game_client/time_control.dart';
import 'package:wqhub/game_client/time_state.dart';
import 'package:wqhub/game_client/user_info.dart';
import 'package:wqhub/wq/wq.dart' as wq;

abstract class Game {
  final String id;
  final int boardSize;
  final Rules rules;
  final int handicap;
  final double komi;
  final black = ValueNotifier<UserInfo>(UserInfo.empty());
  final white = ValueNotifier<UserInfo>(UserInfo.empty());
  final wq.Color myColor;
  final TimeControl timeControl;
  final blackTime = ValueNotifier<(int, TimeState)>((0, TimeState.zero));
  final whiteTime = ValueNotifier<(int, TimeState)>((0, TimeState.zero));
  final List<wq.Move> previousMoves;

  Game({
    required this.id,
    required this.boardSize,
    required this.rules,
    required this.handicap,
    required this.komi,
    required this.myColor,
    required this.timeControl,
    required this.previousMoves,
  }) {
    final t = TimeState(
      mainTimeLeft: timeControl.mainTime,
      periodTimeLeft: timeControl.timePerPeriod,
      periodCount: timeControl.periodCount,
    );
    blackTime.value = (2, t);
    whiteTime.value = (2, t);
  }

  Stream<wq.Move?> moves();
  Stream<bool> automaticCountingResponses();
  Stream<bool> countingResultResponses();
  Stream<CountingResult> countingResults();
  Future<GameResult> result();
  Future<void> move(wq.Move move);
  Future<void> pass();
  Future<void> resign();
  Future<AutomaticCountingInfo> automaticCounting();
  Future<void> manualCounting();
  Future<void> aiReferee();
  Future<void> forceCounting();
  Future<void> agreeToAutomaticCounting(bool agree);
  Future<void> acceptCountingResult(bool agree);
}
