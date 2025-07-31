import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:wqhub/pop_and_window_class_aware_state.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/train/exam_rank_card.dart';
import 'package:wqhub/train/rank_range.dart';
import 'package:wqhub/train/tag_exam_page.dart';
import 'package:wqhub/train/task_tag.dart';
import 'package:wqhub/window_class_aware_state.dart';

class SubtagRankSelectionRouteArguments {
  final TaskTag subtag;

  const SubtagRankSelectionRouteArguments({required this.subtag});
}

class SubtagRankSelectionPage extends StatefulWidget {
  static const routeName = '/train/subtag_rank_selection';

  final TaskTag subtag;

  const SubtagRankSelectionPage({super.key, required this.subtag});

  @override
  State<SubtagRankSelectionPage> createState() =>
      _SubtagRankSelectionPageState();
}

class _SubtagRankSelectionPageState
    extends PopAndWindowClassAwareState<SubtagRankSelectionPage> {
  @override
  Widget build(BuildContext context) {
    final rankRanges = widget.subtag.ranks();
    final stats = loadStats(rankRanges);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subtag.toString()),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 800),
          child: GridView.count(
            padding: EdgeInsets.all(8),
            crossAxisCount: switch (windowClass) {
              WindowClass.compact => 3,
              WindowClass.medium => 6,
              WindowClass.expanded => 6,
              WindowClass.large => 6,
              WindowClass.extraLarge => 6,
            },
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: <Widget>[
              for (final (i, rankRange) in rankRanges.indexed)
                ExamRankCard(
                  rankRange: rankRange,
                  passCount: stats[rankRange]?.pass ?? 0,
                  failCount: stats[rankRange]?.fail ?? 0,
                  isActive: i == 0 || (stats[rankRanges[i - 1]]?.pass ?? 0) > 0,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      TagExamPage.routeName,
                      arguments: TagExamRouteArguments(
                        tag: widget.subtag,
                        rankRange: rankRange,
                      ),
                    );
                  },
                )
            ],
          ),
        ),
      ),
    );
  }

  IMap<RankRange, ({int pass, int fail})> loadStats(
      IList<RankRange> rankRanges) {
    final entries = rankRanges.map((rankRange) {
      final pass = context.stats.getTagExamPassCount(widget.subtag, rankRange);
      final fail = context.stats.getTagExamFailCount(widget.subtag, rankRange);
      return (rankRange, (pass: pass, fail: fail));
    });
    return IMap.fromIterable(
      entries,
      keyMapper: (e) => e.$1,
      valueMapper: (e) => e.$2,
    );
  }
}
