import 'package:flutter/widgets.dart';
import 'package:wqhub/wq/wq.dart' as wq;

@immutable
class CountingResult {
  final wq.Color winner;
  final double scoreLead;
  final List<List<wq.Color?>> ownership;
  final bool isFinal;

  const CountingResult({
    required this.winner,
    required this.scoreLead,
    required this.ownership,
    required this.isFinal,
  });

  @override
  int get hashCode => Object.hash(winner, scoreLead, ownership, isFinal);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is CountingResult &&
        other.winner == winner &&
        other.scoreLead == scoreLead &&
        other.isFinal == isFinal &&
        _eqOwnership(other.ownership, ownership);
  }

  bool _eqOwnership(List<List<wq.Color?>> x, List<List<wq.Color?>> y) {
    if (x.length != y.length) return false;
    for (int i = 0; i < x.length; ++i) {
      if (x[i].length != y[i].length) return false;
      for (int j = 0; j < x[i].length; ++j)
        if (x[i][j] != y[i][j]) return false;
    }
    return true;
  }
}
