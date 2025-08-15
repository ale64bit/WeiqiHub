import 'package:flutter/foundation.dart';
import 'package:wqhub/wq/rank.dart';

@immutable
class RankRange {
  final Rank from;
  final Rank to;

  const RankRange({required this.from, required this.to});

  const RankRange.single(Rank rank)
      : from = rank,
        to = rank;

  bool isSingle() => from == to;

  bool isInside(RankRange that) => that.from <= from && to <= that.to;

  @override
  int get hashCode => Object.hash(from, to);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is RankRange && other.from == from && other.to == to;
  }

  @override
  String toString() =>
      from == to ? from.toString() : '${from.toString()}-${to.toString()}';
}
