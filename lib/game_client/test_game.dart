import 'dart:async';

import 'package:wqhub/game_client/automatic_counting_info.dart';
import 'package:wqhub/game_client/counting_result.dart';
import 'package:wqhub/game_client/game.dart';
import 'package:wqhub/game_client/game_result.dart';
import 'package:wqhub/wq/wq.dart' as wq;

class TestGame extends Game {
  TestGame({
    required super.id,
    required super.boardSize,
    required super.rules,
    required super.handicap,
    required super.komi,
    required super.myColor,
    required super.timeControl,
    required super.previousMoves,
  }) : _countingResultController = StreamController.broadcast();

  final StreamController<CountingResult> _countingResultController;

  @override
  Future<void> acceptCountingResult(bool agree) => Future.value();

  @override
  Future<void> agreeToAutomaticCounting(bool agree) => Future.value();

  @override
  Future<void> aiReferee() => Future.value();

  @override
  Future<AutomaticCountingInfo> automaticCounting() =>
      Future.value(AutomaticCountingInfo(timeout: Duration.zero));

  @override
  Stream<bool> automaticCountingResponses() => Stream.empty();

  @override
  Stream<bool> countingResultResponses() => Stream.empty();

  @override
  Stream<CountingResult> countingResults() => _countingResultController.stream;

  @override
  Future<void> toggleManuallyRemovedStones(
          List<wq.Point> stones, bool removed) =>
      Future.value();

  @override
  Future<void> forceCounting() => Future.value();

  @override
  Future<void> move(wq.Move move) => Future.value();

  @override
  Stream<wq.Move> moves() => Stream.empty();

  @override
  Future<void> pass() {
    _countingResultController.add(CountingResult(
      winner: wq.Color.black,
      scoreLead: 0,
      ownership: List.empty(),
      isFinal: false,
    ));
    return Future.value();
  }

  @override
  Future<void> resign() => Future.value();

  @override
  Future<GameResult> result() => Completer<GameResult>().future;
}
