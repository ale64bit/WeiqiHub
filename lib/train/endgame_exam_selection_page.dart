import 'dart:math';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/pop_and_window_class_aware_state.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/train/endgame_exam_page.dart';
import 'package:wqhub/train/endgame_exam_ranks.dart';
import 'package:wqhub/train/exam_rank_card.dart';
import 'package:wqhub/train/rank_range.dart';
import 'package:wqhub/window_class_aware_state.dart';
import 'package:wqhub/wq/rank.dart';

class EndgameExamSelectionPage extends StatefulWidget {
  static const routeName = '/train/endgame_exam_selection';

  const EndgameExamSelectionPage({super.key});

  @override
  State<EndgameExamSelectionPage> createState() =>
      _EndgameExamSelectionPageState();
}

class _EndgameExamSelectionPageState
    extends PopAndWindowClassAwareState<EndgameExamSelectionPage> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final stats = loadStats();
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.endgameExam),
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
              for (final rank in endgameExamRanks)
                ExamRankCard(
                  rankRange: RankRange.single(rank),
                  passCount: stats[rank]?.pass ?? 0,
                  failCount: stats[rank]?.fail ?? 0,
                  isActive: (rank == Rank.k15) ||
                      ((stats[Rank.values[max(Rank.k15.index, rank.index - 1)]]
                                  ?.pass ??
                              0) >
                          0),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      EndgameExamPage.routeName,
                      arguments: EndgameExamRouteArguments(rank: rank),
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
    final entries = endgameExamRanks.map((rank) {
      final pass = context.stats.getEndgameExamPassCount(rank);
      final fail = context.stats.getEndgameExamFailCount(rank);
      return (rank, (pass: pass, fail: fail));
    });
    return IMap.fromIterable(
      entries,
      keyMapper: (e) => e.$1,
      valueMapper: (e) => e.$2,
    );
  }
}
