import 'package:flutter/widgets.dart';
import 'package:wqhub/wq/wq.dart' as wq;

@immutable
class GameResult {
  final wq.Color? winner;
  final String result;
  final String? description;

  const GameResult(
      {required this.winner, required this.result, this.description});

  @override
  int get hashCode => Object.hash(winner, result, description);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is GameResult &&
        other.winner == winner &&
        other.result == result &&
        other.description == description;
  }
}
