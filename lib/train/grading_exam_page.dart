import 'dart:math';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/stats/stats_db.dart';
import 'package:wqhub/train/exam_page.dart';
import 'package:wqhub/train/grading_exam_selection_page.dart';
import 'package:wqhub/train/rank_range.dart';
import 'package:wqhub/train/task_repository.dart';
import 'package:wqhub/train/task_source/black_to_play_source.dart';
import 'package:wqhub/train/task_source/const_task_source.dart';
import 'package:wqhub/train/task_source/task_source.dart';
import 'package:wqhub/train/task_type.dart';
import 'package:wqhub/wq/rank.dart';

class GradingExamRouteArguments {
  final Rank rank;

  const GradingExamRouteArguments({required this.rank});
}

class GradingExamPage extends StatelessWidget {
  static const routeName = '/train/grading_exam';

  static const taskTypes = ISetConst({
    TaskType.lifeAndDeath,
    TaskType.tesuji,
    TaskType.capture,
    TaskType.captureRace,
  });
  static const taskCount = 10;
  static const timePerTask = Duration(seconds: 45);
  static const maxMistakes = 2;

  final Rank rank;

  const GradingExamPage({super.key, required this.rank});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final nextRank = Rank.values[min(rank.index + 1, Rank.p10.index)];
    return ExamPage(
      title: loc.gradingExam,
      examEvent: ExamEvent(type: ExamType.grading),
      rankRange: RankRange.single(rank),
      taskCount: taskCount,
      timePerTask: timePerTask,
      maxMistakes: maxMistakes,
      createTaskSource: createTaskSource,
      onPass: () => context.stats.incrementGradingExamPassCount(rank),
      onFail: () => context.stats.incrementGradingExamFailCount(rank),
      baseRoute: routeName,
      exitRoute: GradingExamSelectionPage.routeName,
      redoRouteArguments: GradingExamRouteArguments(rank: rank),
      nextRouteArguments: GradingExamRouteArguments(rank: nextRank),
    );
  }

  TaskSource createTaskSource(BuildContext context) {
    return BlackToPlaySource(
      source: ConstTaskSource(
          tasks: TaskRepository()
              .readByTypes(rank, taskTypes, taskCount)
              .map((task) => task.withRandomSymmetry(
                  randomize: context.settings.randomizeTaskOrientation))
              .toIList()),
      blackToPlay: context.settings.alwaysBlackToPlay,
    );
  }
}
