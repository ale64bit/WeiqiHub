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
  final Interpreter _interpreter;
  final _history = <List<List<wq.Color?>>>[];

  AIBot._internal({
    required this.boardSize,
    required this.historySize,
    required this.moveSelection,
    required playInterpreter,
  }) : _interpreter = playInterpreter {
    for (int t = 0; t < historySize; ++t) {
      _history.add(List.generate(
          boardSize, (_) => List.generate(boardSize, (_) => null)));
    }
  }

  static Future<AIBot> _fromAssets({
    required int boardSize,
    required int historySize,
    required String modelAsset,
    required MoveSelection moveSelection,
  }) async {
    return AIBot._internal(
      boardSize: boardSize,
      historySize: historySize,
      moveSelection: moveSelection,
      playInterpreter: await Interpreter.fromAsset(modelAsset),
    );
  }

  static Future<AIBot> new9x9(MoveSelection moveSelection) {
    return _fromAssets(
      boardSize: 9,
      historySize: 4,
      modelAsset: 'assets/models/play_9x9.tflite',
      moveSelection: moveSelection,
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
    _interpreter.run(
        input.reshape([1, boardSize, boardSize, 2 * historySize + 1]), output);

    return output[0] as List<double>;
  }

  void close() {
    _interpreter.close();
  }
}
