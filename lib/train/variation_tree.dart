import 'dart:math';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/wq/wq.dart' as wq;

enum VariationStatus {
  correct,
  wrong;

  String toLocalizedString(AppLocalizations loc) => switch (this) {
        VariationStatus.correct => loc.taskCorrect,
        VariationStatus.wrong => loc.taskWrong,
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
  final _trees = <VariationTree?>[];
  final _moves = <wq.Point>[];
  var _cur = 0;

  VariationTreeIterator({required tree}) {
    _trees.add(tree);
  }

  int get depth => _cur;

  VariationTree? get tree => _trees[_cur];

  VariationStatus? move(wq.Point p) {
    if (_cur < _moves.length) {
      if (_moves[_cur] == p) {
        _cur++;
      } else {
        while (_cur < _moves.length) {
          _trees.removeLast();
          _moves.removeLast();
        }
        _trees.add(tree?.children[p]);
        _moves.add(p);
        _cur++;
      }
    } else {
      _trees.add(tree?.children[p]);
      _moves.add(p);
      _cur++;
    }
    return (tree != null) ? tree!.status : VariationStatus.wrong;
  }

  void undo() {
    _cur--;
  }

  wq.Point? redo() {
    if (_cur >= _moves.length) return null;
    final p = _moves[_cur];
    _cur++;
    return p;
  }

  wq.Point genMove() {
    assert(tree!.children.isNotEmpty);
    return tree!.children.keys
        .elementAt(Random().nextInt(tree!.children.length));
  }

  wq.Point? nextProperMove() {
    if (tree == null || tree!.children.isEmpty) return null;

    for (final entry in tree!.children.entries) {
      if (entry.value.finalStatus() == VariationStatus.correct) {
        return entry.key;
      }
    }

    return null;
  }

  List<(wq.Point, VariationStatus)> continuations() =>
      tree?.children.entries
          .map((e) => (e.key, e.value.finalStatus()))
          .toList() ??
      List.empty();
}
