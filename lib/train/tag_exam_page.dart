import 'package:flutter/material.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/train/exam_page.dart';
import 'package:wqhub/train/rank_range.dart';
import 'package:wqhub/train/subtag_rank_selection_page.dart';
import 'package:wqhub/train/task_repository.dart';
import 'package:wqhub/train/task_source/black_to_play_source.dart';
import 'package:wqhub/train/task_source/const_task_source.dart';
import 'package:wqhub/train/task_source/task_source.dart';
import 'package:wqhub/train/task_tag.dart';

class TagExamRouteArguments {
  final TaskTag tag;
  final RankRange rankRange;

  const TagExamRouteArguments({required this.tag, required this.rankRange});
}

class TagExamPage extends StatelessWidget {
  static const routeName = '/train/tag_exam';

  static const taskCount = 10;
  static const timePerTask = const Duration(minutes: 5);
  static const maxMistakes = 2;

  final TaskTag tag;
  final RankRange rankRange;

  const TagExamPage({super.key, required this.tag, required this.rankRange});

  @override
  Widget build(BuildContext context) {
    final ranks = tag.ranks();
    final currentIndex = ranks.indexWhere(
        (rank) => rank.from == rankRange.from && rank.to == rankRange.to);
    final hasNextRank = currentIndex != -1 && currentIndex + 1 < ranks.length;

    return ExamPage(
      title: "Topic Exam",
      taskCount: taskCount,
      timePerTask: timePerTask,
      maxMistakes: maxMistakes,
      createTaskSource: createTaskSource,
      onPass: () => context.stats.incrementTagExamPassCount(tag, rankRange),
      onFail: () => context.stats.incrementTagExamFailCount(tag, rankRange),
      baseRoute: routeName,
      exitRoute: SubtagRankSelectionPage.routeName,
      redoRouteArguments: TagExamRouteArguments(tag: tag, rankRange: rankRange),
      nextRouteArguments: hasNextRank
          ? TagExamRouteArguments(tag: tag, rankRange: ranks[currentIndex + 1])
          : null,
    );
  }

  TaskSource createTaskSource(BuildContext context) {
    return BlackToPlaySource(
      source: ConstTaskSource(
          tasks: TaskRepository().readByTag(tag, rankRange, taskCount)),
      blackToPlay: context.settings.alwaysBlackToPlay,
    );
  }
}
