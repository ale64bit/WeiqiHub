import 'dart:math';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/train/grading_exam_rank_card.dart';
import 'package:wqhub/train/grading_exam_page.dart';
import 'package:wqhub/train/grading_exam_ranks.dart';
import 'package:wqhub/train/grading_exam_task_types.dart';
import 'package:wqhub/train/task_repository.dart';
import 'package:wqhub/train/task_source/black_to_play_source.dart';
import 'package:wqhub/train/task_source/const_task_source.dart';
import 'package:wqhub/window_class_aware_state.dart';
import 'package:wqhub/wq/rank.dart';

class GradingExamSelectionPage extends StatefulWidget {
  const GradingExamSelectionPage({super.key});

  @override
  State<GradingExamSelectionPage> createState() =>
      _GradingExamSelectionPageState();
}

class _GradingExamSelectionPageState
    extends WindowClassAwareState<GradingExamSelectionPage> {
  @override
  Widget build(BuildContext context) {
    final stats = loadStats();
    return Scaffold(
      appBar: AppBar(
        title: Text('Grading exam'),
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
              for (final rank in gradingExamRanks)
                GradingExamRankCard(
                  rank: rank,
                  passCount: stats[rank]?.pass ?? 0,
                  failCount: stats[rank]?.fail ?? 0,
                  isActive: (rank == Rank.k15) ||
                      ((stats[Rank.values[max(Rank.k15.index, rank.index - 1)]]
                                  ?.pass ??
                              0) >
                          0),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PopScope(
                          canPop: false,
                          child: GradingExamPage(
                              rank: rank,
                              taskSource: BlackToPlaySource(
                                source: ConstTaskSource(
                                    tasks: TaskRepository()
                                        .read(rank, gradingExamTaskTypes, 10)),
                                blackToPlay: context.settings.alwaysBlackToPlay,
                              )),
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  IMap<Rank, ({int pass, int fail})> loadStats() {
    final entries = gradingExamRanks.map((rank) {
      final pass = context.stats.getGradingExamPassCount(rank);
      final fail = context.stats.getGradingExamFailCount(rank);
      return (rank, (pass: pass, fail: fail));
    });
    return IMap.fromIterable(
      entries,
      keyMapper: (e) => e.$1,
      valueMapper: (e) => e.$2,
    );
  }
}
