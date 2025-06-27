import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/train/grading_exam_ranks.dart';
import 'package:wqhub/wq/rank.dart';

class TrainStatsPage extends StatefulWidget {
  const TrainStatsPage({super.key});

  @override
  State<TrainStatsPage> createState() => _TrainStatsPageState();
}

class _TrainStatsPageState extends State<TrainStatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                for (final rank in gradingExamRanks)
                  _RankTotalIndicator(rank: rank)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RankTotalIndicator extends StatelessWidget {
  final Rank rank;

  const _RankTotalIndicator({required this.rank});

  @override
  Widget build(BuildContext context) {
    final pass = context.stats.getTotalPassCount(rank);
    final fail = context.stats.getTotalFailCount(rank);
    final value = (pass / max(pass + fail, 1));
    return ListTile(
      leading: Text(rank.toString()),
      title: LinearProgressIndicator(value: value),
      subtitle: Text('$pass / ${pass + fail}'),
      trailing: Text('${(100 * value).truncate()}%'),
    );
  }
}
