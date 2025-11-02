import 'package:flutter_test/flutter_test.dart';
import 'package:wqhub/symmetry.dart';

void main() {
  group('transformPoint', () {
    test('tengen transformations @ 19x19', () {
      final boardSize = 19;
      final tengen = (9, 9);

      expect(Symmetry.transformPoint(tengen, Symmetry.identity, boardSize),
          tengen);

      expect(Symmetry.transformPoint(tengen, Symmetry.diagonal1, boardSize),
          tengen);
      expect(Symmetry.transformPoint(tengen, Symmetry.diagonal2, boardSize),
          tengen);

      expect(
          Symmetry.transformPoint(tengen, Symmetry.mirror1, boardSize), tengen);
      expect(
          Symmetry.transformPoint(tengen, Symmetry.mirror2, boardSize), tengen);

      expect(
          Symmetry.transformPoint(tengen, Symmetry.rotate1, boardSize), tengen);
      expect(
          Symmetry.transformPoint(tengen, Symmetry.rotate2, boardSize), tengen);
      expect(
          Symmetry.transformPoint(tengen, Symmetry.rotate3, boardSize), tengen);
    });

    test('point (1,2) transformations @ 19x19', () {
      final boardSize = 19;
      final p1_2 = (1, 2);

      expect(
          Symmetry.transformPoint(p1_2, Symmetry.identity, boardSize), (1, 2));

      expect(
          Symmetry.transformPoint(p1_2, Symmetry.diagonal1, boardSize), (2, 1));
      expect(Symmetry.transformPoint(p1_2, Symmetry.diagonal2, boardSize),
          (16, 17));

      expect(
          Symmetry.transformPoint(p1_2, Symmetry.mirror1, boardSize), (17, 2));
      expect(
          Symmetry.transformPoint(p1_2, Symmetry.mirror2, boardSize), (1, 16));

      expect(
          Symmetry.transformPoint(p1_2, Symmetry.rotate1, boardSize), (2, 17));
      expect(
          Symmetry.transformPoint(p1_2, Symmetry.rotate2, boardSize), (17, 16));
      expect(
          Symmetry.transformPoint(p1_2, Symmetry.rotate3, boardSize), (16, 1));
    });

    test('point (0,0) transformations @ 4x4', () {
      final boardSize = 4;
      final zero = (0, 0);

      expect(
          Symmetry.transformPoint(zero, Symmetry.identity, boardSize), (0, 0));

      expect(
          Symmetry.transformPoint(zero, Symmetry.diagonal1, boardSize), (0, 0));
      expect(
          Symmetry.transformPoint(zero, Symmetry.diagonal2, boardSize), (3, 3));

      expect(
          Symmetry.transformPoint(zero, Symmetry.mirror1, boardSize), (3, 0));
      expect(
          Symmetry.transformPoint(zero, Symmetry.mirror2, boardSize), (0, 3));

      expect(
          Symmetry.transformPoint(zero, Symmetry.rotate1, boardSize), (0, 3));
      expect(
          Symmetry.transformPoint(zero, Symmetry.rotate2, boardSize), (3, 3));
      expect(
          Symmetry.transformPoint(zero, Symmetry.rotate3, boardSize), (3, 0));
    });
  });
}
