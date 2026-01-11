import 'dart:math';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:wqhub/symmetry.dart';
import 'package:wqhub/train/task_ref.dart';
import 'package:wqhub/train/variation_tree.dart';
import 'package:wqhub/wq/wq.dart' as wq;

class Task {
  final TaskRef ref;
  final wq.Color first;
  final int boardSize;
  final int subBoardSize;
  final wq.Point topLeft;
  final IMapOfSets<wq.Color, wq.Point> initialStones;
  final VariationTree variationTree;
  final List<int> fingerprint;

  const Task({
    required this.ref,
    required this.first,
    required this.boardSize,
    required this.subBoardSize,
    required this.topLeft,
    required this.initialStones,
    required this.variationTree,
    required this.fingerprint,
  });

  Task withBlackToPlay() => switch (first) {
        wq.Color.black => this,
        wq.Color.white => Task(
            ref: ref,
            first: wq.Color.black,
            boardSize: boardSize,
            subBoardSize: subBoardSize,
            topLeft: topLeft,
            initialStones: IMapOfSets({
              wq.Color.black: initialStones.get(wq.Color.white),
              wq.Color.white: initialStones.get(wq.Color.black),
            }),
            variationTree: variationTree,
            fingerprint: fingerprint,
          ),
      };

  Task withSymmetry(Symmetry symmetry) {
    if (symmetry == Symmetry.identity) {
      return this;
    }

    final transformedStonesMap = <wq.Color, ISet<wq.Point>>{};
    for (final entry in initialStones.entries) {
      final transformedPoints = entry.value.fold<ISet<wq.Point>>(
        const ISet<wq.Point>.empty(),
        (accPoints, point) =>
            accPoints.add(symmetry.transformPoint(point, boardSize)),
      );
      transformedStonesMap[entry.key] = transformedPoints;
    }

    return Task(
      ref: ref,
      first: first,
      boardSize: boardSize,
      subBoardSize: subBoardSize,
      topLeft: _transformTopLeft(topLeft, boardSize, subBoardSize, symmetry),
      initialStones: IMapOfSets(transformedStonesMap),
      variationTree: variationTree.withSymmetry(symmetry, boardSize),
      fingerprint: fingerprint,
    );
  }

  static wq.Point _transformTopLeft(
      wq.Point topLeft, int boardSize, int subBoardSize, Symmetry symmetry) {
    if (symmetry == Symmetry.identity) return topLeft;

    final (x1, y1) = topLeft;
    final (x2, y2) = (x1 + subBoardSize - 1, y1 + subBoardSize - 1);

    final topRight = (x2, y1);
    final bottomRight = (x2, y2);
    final bottomLeft = (x1, y2);

    final tlS = symmetry.transformPoint(topLeft, boardSize);
    final trS = symmetry.transformPoint(topRight, boardSize);
    final blS = symmetry.transformPoint(bottomRight, boardSize);
    final brS = symmetry.transformPoint(bottomLeft, boardSize);

    final topLeftS = (
      [tlS.$1, trS.$1, blS.$1, brS.$1].reduce(min),
      [tlS.$2, trS.$2, blS.$2, brS.$2].reduce(min),
    );

    return topLeftS;
  }

  Task withRandomSymmetry({required bool randomize}) => randomize
      ? withSymmetry(Symmetry.values[Random().nextInt(Symmetry.values.length)])
      : this;
}
