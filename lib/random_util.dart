import 'dart:math';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';

T randomDist<T>(Iterable<(T, int)> dist) {
  final sum = dist.sumBy((e) => e.$2);
  final x = Random().nextInt(sum);
  var cur = 0;
  for (final (t, p) in dist) {
    if (x < cur + p) return t;
    cur += p;
  }
  throw UnimplementedError('cannot happen');
}

T randomDistFloat<T>(Iterable<(T, double)> dist) {
  final sum = dist.sumBy((e) => e.$2);
  final x = clampDouble(sum * Random().nextDouble(), 0, sum);
  var cur = 0.0;
  for (final (t, p) in dist) {
    if (x < cur + p) return t;
    cur += p;
  }
  throw UnimplementedError('cannot happen');
}
