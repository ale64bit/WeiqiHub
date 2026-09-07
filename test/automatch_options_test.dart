import 'package:flutter_test/flutter_test.dart';
import 'package:wqhub/game_client/automatch_options.dart';

void main() {
  test('defaults use the OGS default rank difference', () {
    const opts = AutomatchOptions.defaults();
    expect(opts.upperRankDiff, AutomatchOptions.defaultRankDiff);
    expect(opts.lowerRankDiff, AutomatchOptions.defaultRankDiff);
  });

  test('copyWith replaces only the given field', () {
    const opts = AutomatchOptions(upperRankDiff: 3, lowerRankDiff: 3);
    expect(opts.copyWith(upperRankDiff: 5),
        const AutomatchOptions(upperRankDiff: 5, lowerRankDiff: 3));
    expect(opts.copyWith(lowerRankDiff: 1),
        const AutomatchOptions(upperRankDiff: 3, lowerRankDiff: 1));
  });

  test('value equality', () {
    expect(const AutomatchOptions(upperRankDiff: 2, lowerRankDiff: 4),
        const AutomatchOptions(upperRankDiff: 2, lowerRankDiff: 4));
    expect(const AutomatchOptions(upperRankDiff: 2, lowerRankDiff: 4),
        isNot(const AutomatchOptions(upperRankDiff: 4, lowerRankDiff: 2)));
  });
}
