import 'dart:math';

import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:wqhub/random_util.dart';
import 'package:wqhub/wq/game_tree.dart';
import 'package:wqhub/wq/wq.dart' as wq;

enum MoveSelection {
  top,
  dist,
}

class AIBot {
  final int boardSize;
  final int historySize;
  final MoveSelection moveSelection;
  final Interpreter _playInterpreter;
  final Interpreter _scoreInterpreter;
  final _history = <List<List<wq.Color?>>>[];

  AIBot._internal(
      {required this.boardSize,
      required this.historySize,
      required this.moveSelection,
      required playInterpreter,
      required scoreInterpreter})
      : _playInterpreter = playInterpreter,
        _scoreInterpreter = scoreInterpreter {
    for (int t = 0; t < historySize; ++t) {
      _history.add(List.generate(
          boardSize, (_) => List.generate(boardSize, (_) => null)));
    }
  }

  static Future<AIBot> _fromAssets(
      {required int boardSize,
      required int historySize,
      required String playModelAsset,
      required String scoreModelAsset}) async {
    return AIBot._internal(
      boardSize: boardSize,
      historySize: historySize,
      moveSelection: MoveSelection.top,
      playInterpreter: await Interpreter.fromAsset(playModelAsset),
      scoreInterpreter: await Interpreter.fromAsset(scoreModelAsset),
    );
  }

  static Future<AIBot> new9x9() {
    return _fromAssets(
      boardSize: 9,
      historySize: 4,
      playModelAsset: 'assets/models/play_9x9.tflite',
      scoreModelAsset: 'assets/models/score_9x9.tflite',
    );
  }

  void update(GameTree gameTree) {
    for (int t = historySize - 1; t > 0; --t) {
      for (int i = 0; i < boardSize; ++i) {
        for (int j = 0; j < boardSize; ++j) {
          _history[t][i][j] = _history[t - 1][i][j];
        }
      }
    }
    for (int i = 0; i < boardSize; ++i) {
      for (int j = 0; j < boardSize; ++j) {
        _history[0][i][j] = null;
      }
    }
    for (final e in gameTree.stones.entries) {
      final (r, c) = e.key;
      _history[0][r][c] = e.value;
    }
  }

  wq.Move genMove(wq.Color turn) {
    final output = policy(turn);

    final moves = <(wq.Point, double)>[];
    for (int i = 0; i < boardSize; ++i) {
      for (int j = 0; j < boardSize; ++j) {
        moves.add(((i, j), output[i * boardSize + j]));
      }
    }
    moves.add(((-1, -1), output[boardSize * boardSize]));

    switch (moveSelection) {
      case MoveSelection.top:
        moves.sort((a, b) => b.$2.compareTo(a.$2));
        return (col: turn, p: moves.first.$1);
      case MoveSelection.dist:
        return (col: turn, p: randomDistFloat(moves));
    }
  }

  List<double> policy(wq.Color turn) {
    final input = <double>[];
    for (int i = 0; i < boardSize; ++i) {
      for (int j = 0; j < boardSize; ++j) {
        for (int t = 0; t < historySize; ++t) {
          input.add(_history[t][i][j] == turn ? 1.0 : 0.0);
        }
        for (int t = 0; t < historySize; ++t) {
          input.add(_history[t][i][j] == turn.opposite ? 1.0 : 0.0);
        }
        input.add(turn == wq.Color.black ? 0.0 : 1.0);
      }
    }
    final numMoves = boardSize * boardSize + 1;
    final output = List.filled(numMoves, 0.0).reshape([1, numMoves]);
    _playInterpreter.run(
        input.reshape([1, boardSize, boardSize, 2 * historySize + 1]), output);

    return output[0] as List<double>;
  }

  List<List<wq.Color?>> ownership() {
    final input = <double>[];
    for (int i = 0; i < boardSize; ++i) {
      for (int j = 0; j < boardSize; ++j) {
        input.addAll(switch (_history[0][i][j]) {
          null => [0.0, 0.0],
          wq.Color.black => [1.0, 0.0],
          wq.Color.white => [0.0, 1.0],
        });
      }
    }
    final output = List.filled(boardSize * boardSize * 3, 0.0)
        .reshape([1, boardSize, boardSize, 3]);
    _scoreInterpreter.run(input.reshape([1, boardSize, boardSize, 2]), output);

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
      }
    }
    return ret;
  }

  void close() {
    _playInterpreter.close();
    _scoreInterpreter.close();
  }
}
