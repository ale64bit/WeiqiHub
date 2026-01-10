import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:wqhub/wq/rank.dart';

@immutable
class RankRange with IterableMixin<Rank> {
  final Rank from;
  final Rank to;

  const RankRange({required this.from, required this.to});

  const RankRange.single(Rank rank)
      : from = rank,
        to = rank;

  bool isSingle() => from == to;

  bool isInside(RankRange that) => that.from <= from && to <= that.to;

  bool containsRank(Rank rank) => from <= rank && rank <= to;

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

  Iterable<Rank> get all sync* {
    for (int i = from.index; i <= to.index; ++i) {
      yield Rank.values[i];
    }
  }

  @override
  Iterator<Rank> get iterator => RankIterator(this);
}

class RankIterator implements Iterator<Rank> {
  final RankRange range;
  int _cur;

  RankIterator(this.range) : _cur = range.from.index - 1;

  @override
  Rank get current => Rank.values[_cur];

  @override
  bool moveNext() {
    _cur++;
    return _cur <= range.to.index;
  }
}
