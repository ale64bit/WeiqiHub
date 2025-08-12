import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:wqhub/game_client/counting_result.dart';
import 'package:wqhub/wq/wq.dart' as wq;

class ScoreEstimator {
  final int boardSize;
  final Interpreter _interpreter;

  ScoreEstimator._internal({required this.boardSize, required interpreter})
      : _interpreter = interpreter {}

  static Future<ScoreEstimator> _fromAssets(
      {required int boardSize, required String modelAsset}) async {
    return ScoreEstimator._internal(
      boardSize: boardSize,
      interpreter: await Interpreter.fromAsset(modelAsset),
    );
  }

  static Future<ScoreEstimator> new9x9() {
    return _fromAssets(
      boardSize: 9,
      modelAsset: 'assets/models/score_9x9.tflite',
    );
  }

  CountingResult estimate(wq.Color? Function(int, int) stateAt,
      {double komi = 0.0}) {
    var blackArea = 0;
    var whiteArea = 0;
    final input = <double>[];
    for (int i = 0; i < boardSize; ++i) {
      for (int j = 0; j < boardSize; ++j) {
        input.addAll(switch (stateAt(i, j)) {
          null => [0.0, 0.0],
          wq.Color.black => [1.0, 0.0],
          wq.Color.white => [0.0, 1.0],
        });
      }
    }
    final output = List.filled(boardSize * boardSize * 3, 0.0)
        .reshape([1, boardSize, boardSize, 3]);
    _interpreter.run(input.reshape([1, boardSize, boardSize, 2]), output);

    List<List<wq.Color?>> ret =
        List.generate(boardSize, (_) => List.generate(boardSize, (_) => null));

    for (int i = 0; i < boardSize; ++i) {
      for (int j = 0; j < boardSize; ++j) {
        var bestp = output[0][i][j][0];
        for (int k = 1; k < 3; ++k) {
          if (output[0][i][j][k] > bestp) {
            bestp = output[0][i][j][k];
            ret[i][j] = wq.Color.values[k - 1];
          }
        }
        switch (ret[i][j]) {
          case null:
          case wq.Color.black:
            blackArea++;
          case wq.Color.white:
            whiteArea++;
        }
      }
    }
    final blackLead = (blackArea - whiteArea - komi) / 2;

    return CountingResult(
      winner: blackLead > 0 ? wq.Color.black : wq.Color.white,
      scoreLead: blackLead.abs(),
      ownership: ret,
    );
  }

  void close() {
    _interpreter.close();
  }
}
