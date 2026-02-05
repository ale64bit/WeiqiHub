import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:wqhub/board/board_annotation.dart';
import 'package:wqhub/wq/game_tree.dart';
import 'package:wqhub/wq/wq.dart' as wq;

enum AnnotationMode {
  none,
  mainline,
  variation,
}

typedef _AnnotationDiff = ({
  IMap<wq.Point, BoardAnnotation> added,
  IMap<wq.Point, BoardAnnotation> removed
});

class AnnotatedGameTree<T> extends GameTree<T> {
  AnnotatedGameTree(
    super.size, {
    super.initialStones,
    this.lastMoveMainlineAnnotationFunc = defaultLastMoveMainlineAnnotation,
    this.lastMoveVariationAnnotationFunc = defaultLastMoveVariationAnnotation,
  });

  final BoardAnnotation Function(GameTreeNode<T>)
      lastMoveMainlineAnnotationFunc;
  final BoardAnnotation Function(GameTreeNode<T>, int)
      lastMoveVariationAnnotationFunc;
  var _annotations = IMap<wq.Point, BoardAnnotation>();
  final List<_AnnotationDiff> _variationStack = [];

  IMap<wq.Point, BoardAnnotation> get annotations => _annotations;

  bool get isVariation => _variationStack.isNotEmpty;

  static BoardAnnotation defaultLastMoveMainlineAnnotation(GameTreeNode node) {
    final (:col, :p) = node.move!;
    return LastMoveAnnotation(turn: col);
  }

  static BoardAnnotation defaultLastMoveVariationAnnotation(
      GameTreeNode node, int variationMoveNumber) {
    final (:col, :p) = node.move!;
    return VariationAnnotation(
      moveNumber: variationMoveNumber,
      turn: col,
    );
  }

  GameTreeNode<T>? moveAnnotated(wq.Move mv, {required AnnotationMode mode}) {
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
          _annotations = _annotations.remove(prevNode.move!.p);
        }
        // Add new annotations
        final lastMove = lastMoveMainlineAnnotationFunc(node);
        _annotations = _annotations.add(p, lastMove);
      case AnnotationMode.variation:
        // Compute annotation diff
        final lastMove =
            lastMoveVariationAnnotationFunc(node, _variationStack.length + 1);
        var added = IMap<wq.Point, BoardAnnotation>({p: lastMove});
        var removed = IMap.fromEntries([
          for (final p in node.diff)
            if (_annotations.containsKey(p)) MapEntry(p, _annotations.get(p)!)
        ]);
        if (prevNode.move != null) {
          // Remove last move annotation
          final mv = prevNode.move!;
          removed = removed.add(mv.p, _annotations.get(mv.p)!);
          if (_variationStack.isNotEmpty && stones.containsKey(mv.p)) {
            // Add back a move number annotation for variation moves
            added = added.add(
              prevNode.move!.p,
              TextAnnotation(
                text: '${_variationStack.length}',
                color: switch (prevNode.move!.col) {
                  wq.Color.black => Colors.white,
                  wq.Color.white => Colors.black,
                },
              ),
            );
          }
        }
        final diff = (added: added, removed: removed);
        // Apply diff
        _annotations = _applyAnnotationDiff(_annotations, diff);
        _variationStack.add(diff);
    }
    return node;
  }

  GameTreeNode<T>? redo() {
    final nextNode = curNode.next;
    if (nextNode == null) return null;
    if (nextNode.move == null) return null;
    return moveAnnotated(nextNode.move!,
        mode: _variationStack.isEmpty
            ? AnnotationMode.mainline
            : AnnotationMode.variation);
  }

  @override
  GameTreeNode<T>? undo() {
    final prevNode = curNode;
    final node = super.undo();
    if (node == null) return null;

    if (prevNode.move != null) {
      _annotations = _annotations.remove(prevNode.move!.p);
    }

    if (_variationStack.isEmpty) {
      // Mainline mode
      // Add new annotations
      if (node.move != null) {
        final lastMove = lastMoveMainlineAnnotationFunc(node);
        _annotations = _annotations.add(node.move!.p, lastMove);
      }
    } else {
      // Variation mode
      final diff = _variationStack.removeLast();
      _annotations = _applyAnnotationDiff(
          annotations, (added: diff.removed, removed: diff.added));
      if (prevNode.move != null && node.next != prevNode) {
        node.prune(prevNode.move!);
      }
    }

    return node;
  }

  IMap<wq.Point, BoardAnnotation> _applyAnnotationDiff(
      IMap<wq.Point, BoardAnnotation> annotations, _AnnotationDiff diff) {
    for (final p in diff.removed.keys) {
      annotations = annotations.remove(p);
    }
    return annotations.addAll(diff.added);
  }
}
