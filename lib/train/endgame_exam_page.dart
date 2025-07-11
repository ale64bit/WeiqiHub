import 'dart:math';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/train/exam_page.dart';
import 'package:wqhub/train/task_repository.dart';
import 'package:wqhub/train/task_source/black_to_play_source.dart';
import 'package:wqhub/train/task_source/const_task_source.dart';
import 'package:wqhub/train/task_type.dart';
import 'package:wqhub/wq/rank.dart';

class EndgameExamPage extends StatelessWidget {
  static const taskTypes = const ISetConst({TaskType.endgame});
  static const taskCount = 10;
  static const timePerTask = const Duration(seconds: 45);
  static const maxMistakes = 2;

  final Rank rank;

  const EndgameExamPage({super.key, required this.rank});

  @override
  Widget build(BuildContext context) {
    return ExamPage(
      title: "Endgame Exam",
      taskCount: taskCount,
      taskSource: BlackToPlaySource(
        source: ConstTaskSource(
            tasks: TaskRepository().readByTypes(rank, taskTypes, taskCount)),
        blackToPlay: context.settings.alwaysBlackToPlay,
      ),
      timePerTask: timePerTask,
      maxMistakes: maxMistakes,
      onPass: () => context.stats.incrementEndgameExamPassCount(rank),
      onFail: () => context.stats.incrementEndgameExamFailCount(rank),
      buildRedoPage: () => EndgameExamPage(rank: rank),
      buildNextPage: () {
        final nextRank = Rank.values[min(rank.index + 1, Rank.p10.index)];
        return EndgameExamPage(rank: nextRank);
      },
    );
  }
}
