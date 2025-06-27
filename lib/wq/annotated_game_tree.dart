import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:wqhub/board/board_annotation.dart';
import 'package:extension_type_unions/extension_type_unions.dart';
import 'package:wqhub/wq/game_tree.dart';
import 'package:wqhub/wq/wq.dart' as wq;

enum AnnotationMode {
  none,
  mainline,
  variation,
}

typedef _AnnotationDiff = ({
  IMapOfSets<wq.Point, Annotation> added,
  IMapOfSets<wq.Point, Annotation> removed
});

class AnnotatedGameTree extends GameTree {
  AnnotatedGameTree(super.size, {super.initialStones});

  var _annotations = IMapOfSets<wq.Point, Annotation>();
  final List<_AnnotationDiff> _variationStack = [];

  IMapOfSets<wq.Point, Annotation> get annotations => _annotations;

  bool get isVariation => _variationStack.isNotEmpty;

  GameTreeNode? moveAnnotated(wq.Move mv, {required AnnotationMode mode}) {
    final prevNode = curNode;
    final node = super.move(mv, prune: mode == AnnotationMode.mainline);
    if (node == null) return null;

    final (:col, :p) = mv;
    switch (mode) {
      case AnnotationMode.none:
        ; // Avoid fallthrough
      case AnnotationMode.mainline:
        // Remove previous annotations
        if (prevNode.move != null) {
          _annotations = _annotations.removeSet(prevNode.move!.p);
        }
        // Add new annotations
        final lastMove = (
          type: AnnotationShape.circle.u21,
          color: col == wq.Color.black ? Colors.white : Colors.black
        );
        _annotations = _annotations.add(p, lastMove);
      case AnnotationMode.variation:
        // Compute annotation diff
        var removed = IMapOfSets.from(IMap.fromIterable(
          node.diff,
          keyMapper: (p) => p,
          valueMapper: (p) => _annotations.get(p),
        ));
        if (prevNode.move != null) {
          // Remove last move annotation
          removed = removed.addValues(prevNode.move!.p,
              _annotations.get(prevNode.move!.p).where((a) => a.isShape));
        }
        final added = IMapOfSets({
          p: _variationAnnotations(col, _variationStack.length + 1),
        });
        final diff = (added: added, removed: removed);
        // Apply diff
        _annotations = _applyAnnotationDiff(_annotations, diff);
        _variationStack.add(diff);
    }
    return node;
  }

  GameTreeNode? redo() {
    final nextNode = curNode.next;
    if (nextNode == null) return null;
    if (nextNode.move == null) return null;
    return moveAnnotated(nextNode.move!,
        mode: _variationStack.isEmpty
            ? AnnotationMode.mainline
            : AnnotationMode.variation);
  }

  @override
  GameTreeNode? undo() {
    final prevNode = curNode;
    final node = super.undo();
    if (node == null) return null;

    if (prevNode.move != null) {
      _annotations = _annotations.removeSet(prevNode.move!.p);
    }

    if (_variationStack.isEmpty) {
      // Mainline mode
      // Add new annotations
      if (node.move != null) {
        final lastMove = (
          type: AnnotationShape.circle.u21,
          color: node.move!.col == wq.Color.black ? Colors.white : Colors.black
        );
        _annotations = _annotations.add(node.move!.p, lastMove);
      }
    } else {
      // Variation mode
      final diff = _variationStack.removeLast();
      _annotations = _applyAnnotationDiff(
          annotations, (added: diff.removed, removed: diff.added));
      if (prevNode.move != null) node.prune(prevNode.move!);
    }

    return node;
  }

  IListConst<Annotation> _variationAnnotations(wq.Color turn, int moveNumber) =>
      IListConst([
        (
          type: AnnotationShape.variation.u21,
          color: turn == wq.Color.black ? Colors.red : Colors.lightBlue
        ),
        (
          type: moveNumber.toString().u22,
          color: turn == wq.Color.black ? Colors.white : Colors.black
        ),
      ]);

  IMapOfSets<wq.Point, Annotation> _applyAnnotationDiff(
      IMapOfSets<wq.Point, Annotation> annotations,
      ({
        IMapOfSets<wq.Point, Annotation> added,
        IMapOfSets<wq.Point, Annotation> removed
      }) diff) {
    for (final e in diff.removed.entries) {
      for (final v in e.value) {
        annotations = annotations.remove(e.key, v);
      }
    }
    for (final e in diff.added.entries) {
      for (final v in e.value) {
        annotations = annotations.add(e.key, v);
      }
    }
    return annotations;
  }
}
