import 'dart:math';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/train/exam_page.dart';
import 'package:wqhub/train/task_repository.dart';
import 'package:wqhub/train/task_source/black_to_play_source.dart';
import 'package:wqhub/train/task_source/const_task_source.dart';
import 'package:wqhub/train/task_source/task_source.dart';
import 'package:wqhub/train/task_type.dart';
import 'package:wqhub/wq/rank.dart';

class GradingExamPage extends StatelessWidget {
  static const taskTypes = const ISetConst({
    TaskType.lifeAndDeath,
    TaskType.tesuji,
    TaskType.capture,
    TaskType.captureRace,
  });
  static const taskCount = 10;
  static const timePerTask = const Duration(seconds: 45);
  static const maxMistakes = 2;

  final Rank rank;

  const GradingExamPage({super.key, required this.rank});

  @override
  Widget build(BuildContext context) {
    return ExamPage(
      title: "Grading Exam",
      taskCount: taskCount,
      timePerTask: timePerTask,
      maxMistakes: maxMistakes,
      createTaskSource: createTaskSource,
      onPass: () => context.stats.incrementGradingExamPassCount(rank),
      onFail: () => context.stats.incrementGradingExamFailCount(rank),
      buildRedoPage: () => GradingExamPage(rank: rank),
      buildNextPage: () {
        final nextRank = Rank.values[min(rank.index + 1, Rank.p10.index)];
        return GradingExamPage(rank: nextRank);
      },
    );
  }

  TaskSource createTaskSource(BuildContext context) {
    return BlackToPlaySource(
      source: ConstTaskSource(
          tasks: TaskRepository().readByTypes(rank, taskTypes, taskCount)),
      blackToPlay: context.settings.alwaysBlackToPlay,
    );
  }
}
