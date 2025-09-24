import 'package:flutter_test/flutter_test.dart';
import 'package:wqhub/train/task_tag.dart';

void main() {
  test('tag rank range consistency', () {
    for (final tag in TaskTag.values) {
      for (final rankRange in tag.ranks()) {
        expect(rankRange.from.index <= rankRange.to.index, true,
            reason: 'tag $tag: bad range $rankRange');
      }
    }
  });
}
