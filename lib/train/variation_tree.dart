import 'dart:math';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:wqhub/wq/wq.dart' as wq;

enum VariationStatus {
  correct,
  wrong;

  @override
  String toString() => switch (this) {
        VariationStatus.correct => 'Correct',
        VariationStatus.wrong => 'Wrong',
      };
}

class VariationTree {
  final VariationStatus? status;
  final IMap<wq.Point, VariationTree> children;

  VariationTree({required this.status, required this.children});

  VariationStatus finalStatus() =>
      status ??
      children.values.fold(
          VariationStatus.wrong,
          (cur, t) => t.finalStatus() == VariationStatus.correct
              ? VariationStatus.correct
              : cur);
}

class VariationTreeIterator {
  VariationTree _tree;

  VariationTreeIterator({required tree}) : _tree = tree;

  VariationStatus? move(wq.Point p) {
    final next = _tree.children[p];
    if (next == null) return VariationStatus.wrong;

    _tree = next;
    return _tree.status;
  }

  wq.Point genMove() {
    assert(_tree.children.isNotEmpty);
    return _tree.children.keys
        .elementAt(Random().nextInt(_tree.children.length));
  }

  List<(wq.Point, VariationStatus)> continuations() => _tree.children.entries
      .map((e) => (e.key, e.value.finalStatus()))
      .toList();
}
