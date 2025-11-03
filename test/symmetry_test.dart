import 'package:flutter_test/flutter_test.dart';
import 'package:wqhub/symmetry.dart';

void main() {
  group('transformPoint', () {
    test('tengen transformations @ 19x19', () {
      final boardSize = 19;
      final tengen = (9, 9);

      expect(Symmetry.identity.transformPoint(tengen, boardSize), tengen);

      expect(Symmetry.diagonal1.transformPoint(tengen, boardSize), tengen);
      expect(Symmetry.diagonal2.transformPoint(tengen, boardSize), tengen);

      expect(Symmetry.mirror1.transformPoint(tengen, boardSize), tengen);
      expect(Symmetry.mirror2.transformPoint(tengen, boardSize), tengen);

      expect(Symmetry.rotate1.transformPoint(tengen, boardSize), tengen);
      expect(Symmetry.rotate2.transformPoint(tengen, boardSize), tengen);
      expect(Symmetry.rotate3.transformPoint(tengen, boardSize), tengen);
    });

    test('point (1,2) transformations @ 19x19', () {
      final boardSize = 19;
      final p1_2 = (1, 2);

      expect(Symmetry.identity.transformPoint(p1_2, boardSize), (1, 2));

      expect(Symmetry.diagonal1.transformPoint(p1_2, boardSize), (2, 1));
      expect(Symmetry.diagonal2.transformPoint(p1_2, boardSize), (16, 17));

      expect(Symmetry.mirror1.transformPoint(p1_2, boardSize), (17, 2));
      expect(Symmetry.mirror2.transformPoint(p1_2, boardSize), (1, 16));

      expect(Symmetry.rotate1.transformPoint(p1_2, boardSize), (2, 17));
      expect(Symmetry.rotate2.transformPoint(p1_2, boardSize), (17, 16));
      expect(Symmetry.rotate3.transformPoint(p1_2, boardSize), (16, 1));
    });

    test('point (0,0) transformations @ 4x4', () {
      final boardSize = 4;
      final zero = (0, 0);

      expect(Symmetry.identity.transformPoint(zero, boardSize), (0, 0));

      expect(Symmetry.diagonal1.transformPoint(zero, boardSize), (0, 0));
      expect(Symmetry.diagonal2.transformPoint(zero, boardSize), (3, 3));

      expect(Symmetry.mirror1.transformPoint(zero, boardSize), (3, 0));
      expect(Symmetry.mirror2.transformPoint(zero, boardSize), (0, 3));

      expect(Symmetry.rotate1.transformPoint(zero, boardSize), (0, 3));
      expect(Symmetry.rotate2.transformPoint(zero, boardSize), (3, 3));
      expect(Symmetry.rotate3.transformPoint(zero, boardSize), (3, 0));
    });
  });
}
