import 'package:flutter/material.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/stats/stats_db.dart';
import 'package:wqhub/train/custom_exam_selection_page.dart';
import 'package:wqhub/train/custom_exam_settings.dart';
import 'package:wqhub/train/exam_page.dart';
import 'package:wqhub/train/task_repository.dart';
import 'package:wqhub/train/task_source/black_to_play_source.dart';
import 'package:wqhub/train/task_source/const_task_ref_source.dart';
import 'package:wqhub/train/task_source/task_source.dart';
import 'package:wqhub/train/task_source/task_source_type.dart';

class CustomExamRouteArguments {
  final CustomExamSettings settings;

  const CustomExamRouteArguments({required this.settings});
}

class CustomExamPage extends StatelessWidget {
  static const routeName = '/train/custom_exam';

  final CustomExamSettings settings;

  const CustomExamPage({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return ExamPage(
      title: loc.customExam,
      examEvent: ExamEvent(type: ExamType.custom),
      rankRange: settings.rankRange,
      taskCount: settings.taskCount,
      timePerTask: settings.timePerTask,
      maxMistakes: settings.maxMistakes,
      createTaskSource: createTaskSource,
      onPass: () {},
      onFail: () {},
      baseRoute: routeName,
      exitRoute: CustomExamSelectionPage.routeName,
      redoRouteArguments: CustomExamRouteArguments(
        settings: settings,
      ),
      collectStats: settings.collectStats,
    );
  }

  TaskSource createTaskSource(BuildContext context) {
    final taskSource = switch (settings.taskSourceType) {
      TaskSourceType.fromTaskTypes => TaskRepository()
          .taskSourceByTypes(settings.rankRange, settings.taskTypes!),
      TaskSourceType.fromTaskTag => TaskRepository()
          .taskSourceByTags(settings.rankRange, settings.taskSubtags!),
      TaskSourceType.fromMistakes => ConstTaskRefSource(
          taskRefs: StatsDB()
              .mistakesByRankRange(settings.rankRange, settings.taskCount)),
    };
    return BlackToPlaySource(
      source: taskSource,
      blackToPlay: context.settings.alwaysBlackToPlay,
    );
  }
}
