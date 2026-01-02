import 'package:flutter/material.dart';
import 'package:wqhub/pop_aware_state.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/train/circular_percent_text.dart';
import 'package:wqhub/train/rank_range.dart';
import 'package:wqhub/train/task_tag.dart';
import 'package:wqhub/wq/rank.dart';

class TagCompletionRate extends StatefulWidget {
  final TaskTag tag;

  const TagCompletionRate({super.key, required this.tag});

  @override
  State<TagCompletionRate> createState() => _TagCompletionRateState();
}

class _TagCompletionRateState extends PopAwareState<TagCompletionRate> {
  Future<_TagCompletionData>? completionRateFut;

  @override
  void initState() {
    _updateFut();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateFut();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: completionRateFut,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          return Row(
            spacing: 8.0,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: ColorScheme.of(context).secondaryContainer,
                ),
                child: Text(data.rank.toString()),
              ),
              CircularPercentText(value: data.rate),
            ],
          );
        }
        return CircularProgressIndicator();
      },
    );
  }

  (int, int, RankRange) compute(BuildContext context, TaskTag tag) {
    var total = 0;
    var passed = 0;
    var minRank = Rank.p10;
    var maxRank = Rank.k30;
    final rankRanges = tag.ranks();
    for (final rankRange in rankRanges) {
      final pass = context.stats.getTagExamPassCount(tag, rankRange);
      total++;
      if (pass > 0) {
        passed++;
        if (rankRange.to > maxRank) maxRank = rankRange.to;
      } else if (rankRange.from < minRank) {
        minRank = rankRange.from;
      }
    }
    for (final subtag in tag.subtags()) {
      final (t, p, rr) = compute(context, subtag);
      total += t;
      passed += p;
      if (rr.from < minRank) minRank = rr.from;
      if (rr.to > maxRank) maxRank = rr.to;
    }
    if (minRank == Rank.p10 && maxRank != Rank.k30) minRank = maxRank;
    return (total, passed, RankRange.single(minRank));
  }

  void _updateFut() {
    completionRateFut = Future(() {
      final (total, passed, curRank) = compute(context, widget.tag);
      return _TagCompletionData(
        rate: (100 * passed / total).floor(),
        rank: curRank,
      );
    });
  }
}

class _TagCompletionData {
  final int rate;
  final RankRange rank;

  const _TagCompletionData({required this.rate, required this.rank});
}
