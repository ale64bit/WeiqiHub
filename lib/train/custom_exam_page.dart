import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:wqhub/stats/stats_db.dart';
import 'package:wqhub/train/exam_page.dart';
import 'package:wqhub/train/rank_range.dart';
import 'package:wqhub/train/task_repository.dart';
import 'package:wqhub/train/task_source/const_task_ref_source.dart';
import 'package:wqhub/train/task_source/task_source_type.dart';
import 'package:wqhub/train/task_tag.dart';
import 'package:wqhub/train/task_type.dart';

class CustomExamPage extends StatelessWidget {
  final int taskCount;
  final Duration timePerTask;
  final RankRange rankRange;
  final int maxMistakes;
  final TaskSourceType taskSourceType;
  final ISet<TaskType>? taskTypes;
  final TaskTag? taskTag;
  final bool collectStats;

  const CustomExamPage(
      {super.key,
      required this.taskCount,
      required this.timePerTask,
      required this.rankRange,
      required this.maxMistakes,
      required this.taskSourceType,
      this.taskTypes,
      this.taskTag,
      required this.collectStats});

  @override
  Widget build(BuildContext context) {
    final taskSource = switch (taskSourceType) {
      TaskSourceType.fromTaskTypes =>
        TaskRepository().taskSourceByTypes(rankRange, taskTypes!),
      TaskSourceType.fromTaskTag =>
        TaskRepository().taskSourceByTag(rankRange, taskTag!),
      TaskSourceType.fromMistakes => ConstTaskRefSource(
          taskRefs: StatsDB().getMistakesByRange(rankRange, taskCount)),
    };
    return ExamPage(
      title: 'Custom Exam',
      taskCount: taskCount,
      taskSource: taskSource,
      timePerTask: timePerTask,
      maxMistakes: maxMistakes,
      onPass: () {},
      onFail: () {},
      buildRedoPage: () => CustomExamPage(
        taskCount: taskCount,
        timePerTask: timePerTask,
        rankRange: rankRange,
        maxMistakes: maxMistakes,
        taskSourceType: taskSourceType,
        collectStats: collectStats,
      ),
      collectStats: collectStats,
    );
  }
}
