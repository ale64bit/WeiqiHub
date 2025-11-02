import 'package:wqhub/wq/wq.dart' as wq;

enum Symmetry {
  identity,
  rotate1,
  rotate2,
  rotate3,
  mirror1,
  mirror2,
  diagonal1,
  diagonal2;

  // Utilities

  static wq.Point transformPoint(wq.Point p, Symmetry symmetry, int boardSize) {
    final (r, c) = p;
    final maxCoord = boardSize - 1;

    return switch (symmetry) {
      Symmetry.identity => p,
      Symmetry.rotate1 => (c, maxCoord - r),
      Symmetry.rotate2 => (maxCoord - r, maxCoord - c),
      Symmetry.rotate3 => (maxCoord - c, r),
      Symmetry.mirror1 => (maxCoord - r, c),
      Symmetry.mirror2 => (r, maxCoord - c),
      Symmetry.diagonal1 => (c, r),
      Symmetry.diagonal2 => (maxCoord - c, maxCoord - r),
    };
  }
}
