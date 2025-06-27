import 'dart:math';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';

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
