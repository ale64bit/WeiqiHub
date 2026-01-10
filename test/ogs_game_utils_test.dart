import 'package:flutter_test/flutter_test.dart';
import 'package:wqhub/game_client/ogs/game_utils.dart';
import 'package:wqhub/wq/wq.dart' as wq;

void main() {
  group('colorToMove', () {
    test('basic alternating turns - no handicap or handicap 1', () {
      // Handicap 0 (even game) should start with black
      expect(colorToMove(0), equals(wq.Color.black));
      expect(colorToMove(1), equals(wq.Color.white));
      expect(colorToMove(2), equals(wq.Color.black));
      expect(colorToMove(3), equals(wq.Color.white));
      expect(colorToMove(10), equals(wq.Color.black));
      expect(colorToMove(11), equals(wq.Color.white));

      // Handicap 1 also starts with black
      expect(colorToMove(0, handicap: 1), equals(wq.Color.black));
      expect(colorToMove(1, handicap: 1), equals(wq.Color.white));
      expect(colorToMove(2, handicap: 1), equals(wq.Color.black));
    });

    test('handicap game with pre-placed stones (Japanese)', () {
      // With pre-placed handicap stones (handicap > 1), white plays first
      expect(colorToMove(0, handicap: 2), equals(wq.Color.white));
      expect(colorToMove(1, handicap: 2), equals(wq.Color.black));
      expect(colorToMove(2, handicap: 2), equals(wq.Color.white));
      expect(colorToMove(3, handicap: 2), equals(wq.Color.black));

      expect(colorToMove(0, handicap: 9), equals(wq.Color.white));
      expect(colorToMove(1, handicap: 9), equals(wq.Color.black));
    });

    test('handicap game with free placement (Chinese)', () {
      // With free handicap placement, black plays first to place handicap stones
      // After handicap stones are placed, the game continues alternating
      expect(colorToMove(0, handicap: 2, freeHandicapPlacement: true),
          equals(wq.Color.black)); // Placing first handicap stone
      expect(colorToMove(1, handicap: 2, freeHandicapPlacement: true),
          equals(wq.Color.black)); // Placing second handicap stone
      expect(
          colorToMove(2, handicap: 2, freeHandicapPlacement: true),
          equals(wq.Color
              .white)); // First regular move (white starts after handicap)
      expect(colorToMove(3, handicap: 2, freeHandicapPlacement: true),
          equals(wq.Color.black)); // Second regular move

      expect(colorToMove(0, handicap: 5, freeHandicapPlacement: true),
          equals(wq.Color.black)); // Placing handicap stones
      expect(colorToMove(4, handicap: 5, freeHandicapPlacement: true),
          equals(wq.Color.black)); // Still placing handicap stones
      expect(
          colorToMove(5, handicap: 5, freeHandicapPlacement: true),
          equals(wq.Color
              .white)); // First regular move after all handicap stones placed
    });

    test('free handicap 0 and 1 cases', () {
      // No handicap should always start with black regardless of freeHandicapPlacement
      expect(colorToMove(0, handicap: 0, freeHandicapPlacement: true),
          equals(wq.Color.black));
      expect(colorToMove(1, handicap: 0, freeHandicapPlacement: true),
          equals(wq.Color.white));

      // Handicap 1 also starts with black
      expect(colorToMove(0, handicap: 1, freeHandicapPlacement: true),
          equals(wq.Color.black));
    });
  });
}
