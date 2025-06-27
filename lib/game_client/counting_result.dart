import 'package:flutter/widgets.dart';
import 'package:wqhub/wq/wq.dart' as wq;

@immutable
class CountingResult {
  final wq.Color winner;
  final double scoreLead;
  final List<List<wq.Color?>> ownership;

  const CountingResult({
    required this.winner,
    required this.scoreLead,
    required this.ownership,
  });

  @override
  int get hashCode => Object.hash(winner, scoreLead, ownership);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is CountingResult &&
        other.winner == winner &&
        other.scoreLead == scoreLead &&
        other.ownership == ownership;
  }
}
