import 'package:flutter_test/flutter_test.dart';
import 'package:wqhub/wq/util.dart';

void main() {
  group('parseStonesString', () {
    test('parses valid SGF coordinates correctly', () {
      // Test basic parsing
      final points = parseStonesString('aabbcc');
      expect(points.length, equals(3));
      expect(points[0], equals((0, 0))); // 'aa' -> (0, 0)
      expect(points[1], equals((1, 1))); // 'bb' -> (1, 1)
      expect(points[2], equals((2, 2))); // 'cc' -> (2, 2)
    });

    test('handles empty strings', () {
      final emptyResult = parseStonesString('');
      expect(emptyResult, isEmpty);
    });
  });
}
