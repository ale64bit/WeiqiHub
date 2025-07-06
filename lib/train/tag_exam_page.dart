import 'package:flutter/material.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/train/exam_page.dart';
import 'package:wqhub/train/rank_range.dart';
import 'package:wqhub/train/task_repository.dart';
import 'package:wqhub/train/task_source/black_to_play_source.dart';
import 'package:wqhub/train/task_source/const_task_source.dart';
import 'package:wqhub/train/task_tag.dart';

class TagExamPage extends StatelessWidget {
  static const taskCount = 10;
  static const timePerTask = const Duration(minutes: 5);
  static const maxMistakes = 2;

  final TaskTag tag;
  final RankRange rankRange;

  const TagExamPage({super.key, required this.tag, required this.rankRange});

  @override
  Widget build(BuildContext context) {
    return ExamPage(
      title: "Topic Exam",
      taskCount: taskCount,
      taskSource: BlackToPlaySource(
        source: ConstTaskSource(
            tasks: TaskRepository().readByTag(tag, rankRange, taskCount)),
        blackToPlay: context.settings.alwaysBlackToPlay,
      ),
      timePerTask: timePerTask,
      maxMistakes: maxMistakes,
      onPass: () => context.stats.incrementTagExamPassCount(tag, rankRange),
      onFail: () => context.stats.incrementTagExamFailCount(tag, rankRange),
      buildRedoPage: () => TagExamPage(tag: tag, rankRange: rankRange),
    );
  }
}
