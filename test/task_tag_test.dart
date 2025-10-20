import 'package:flutter_test/flutter_test.dart';
import 'package:wqhub/train/task_tag.dart';

void main() {
  test('tag rank range consistency', () {
    for (final tag in TaskTag.values) {
      final ranks = tag.ranks();
      for (final rankRange in ranks) {
        expect(rankRange.from.index <= rankRange.to.index, true,
            reason: 'tag $tag: bad range $rankRange');
      }
      for (int i = 0; i + 1 < ranks.length; ++i) {
        expect(ranks[i].to.index < ranks[i + 1].from.index, true,
            reason:
                'tag: $tag: bad range transition ${ranks[i]} -> ${ranks[i + 1]}');
      }
    }
  });
}
