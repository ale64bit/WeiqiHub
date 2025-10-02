import 'package:flutter_test/flutter_test.dart';
import 'package:wqhub/wq/grid.dart';

void main() {
  group('generate2D', () {
    test('creates correct size grid with generator function', () {
      final grid = generate2D(3, (i, j) => '$i,$j');
      expect(grid.length, 3);
      expect(grid[0].length, 3);
      expect(grid[0][0], '0,0');
      expect(grid[1][1], '1,1');
      expect(grid[2][2], '2,2');
    });

    test('handles edge case of empty grid', () {
      final grid = generate2D(0, (i, j) => 'never called');
      expect(grid.length, 0);
    });
  });

  group('count2D', () {
    test('counts different elements including nulls', () {
      final grid = [
        ['A', 'B', null],
        ['B', 'A', 'A'],
        [null, 'B', 'A']
      ];

      final counts = count2D(grid);
      expect(counts['A'], 4);
      expect(counts['B'], 3);
      expect(counts[null], 2);
    });

    test('handles empty grid', () {
      final List<List<String>> grid = [];
      final counts = count2D(grid);
      expect(counts.isEmpty, true);
    });
  });
}
