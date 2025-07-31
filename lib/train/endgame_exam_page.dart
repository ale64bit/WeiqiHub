import 'dart:math';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/train/endgame_exam_selection_page.dart';
import 'package:wqhub/train/exam_page.dart';
import 'package:wqhub/train/task_repository.dart';
import 'package:wqhub/train/task_source/black_to_play_source.dart';
import 'package:wqhub/train/task_source/const_task_source.dart';
import 'package:wqhub/train/task_source/task_source.dart';
import 'package:wqhub/train/task_type.dart';
import 'package:wqhub/wq/rank.dart';

class EndgameExamRouteArguments {
  final Rank rank;

  const EndgameExamRouteArguments({required this.rank});
}

class EndgameExamPage extends StatelessWidget {
  static const routeName = '/train/endgame_exam';

  static const taskTypes = const ISetConst({TaskType.endgame});
  static const taskCount = 10;
  static const timePerTask = const Duration(seconds: 45);
  static const maxMistakes = 2;

  final Rank rank;

  const EndgameExamPage({super.key, required this.rank});

  @override
  Widget build(BuildContext context) {
    final nextRank = Rank.values[min(rank.index + 1, Rank.p10.index)];
    return ExamPage(
      title: "Endgame Exam",
      taskCount: taskCount,
      timePerTask: timePerTask,
      maxMistakes: maxMistakes,
      createTaskSource: createTaskSource,
      onPass: () => context.stats.incrementEndgameExamPassCount(rank),
      onFail: () => context.stats.incrementEndgameExamFailCount(rank),
      baseRoute: routeName,
      exitRoute: EndgameExamSelectionPage.routeName,
      redoRouteArguments: EndgameExamRouteArguments(rank: rank),
      nextRouteArguments: EndgameExamRouteArguments(rank: nextRank),
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
