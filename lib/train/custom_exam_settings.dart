import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:wqhub/train/rank_range.dart';
import 'package:wqhub/train/task_source/task_source_type.dart';
import 'package:wqhub/train/task_tag.dart';
import 'package:wqhub/train/task_type.dart';
import 'package:wqhub/wq/rank.dart';

class CustomExamSettings {
  final int taskCount;
  final Duration timePerTask;
  final RankRange rankRange;
  final int maxMistakes;
  final TaskSourceType taskSourceType;
  final ISet<TaskType>? taskTypes;
  final TaskTag? taskTag;
  final ISet<TaskTag>? taskSubtags;
  final bool collectStats;

  const CustomExamSettings(
      {required this.taskCount,
      required this.timePerTask,
      required this.rankRange,
      required this.maxMistakes,
      required this.taskSourceType,
      required this.taskTypes,
      required this.taskTag,
      required this.taskSubtags,
      required this.collectStats});

  Map<String, dynamic> toJson() => {
        'taskCount': taskCount,
        'timePerTask': timePerTask.inSeconds,
        'rankRangeFrom': rankRange.from.index,
        'rankRangeTo': rankRange.to.index,
        'maxMistakes': maxMistakes,
        'taskSourceType': taskSourceType.index,
        if (taskSourceType == TaskSourceType.fromTaskTypes)
          'taskTypes': taskTypes!.map((t) => t.index).toList(),
        if (taskSourceType == TaskSourceType.fromTaskTag)
          'taskTag': taskTag!.index,
        if (taskSourceType == TaskSourceType.fromTaskTag)
          'taskSubtags': taskSubtags!.map((st) => st.index).toList(),
        'collectStats': collectStats,
      };

  CustomExamSettings.fromJson(Map<String, dynamic> json)
      : taskCount = json['taskCount'] as int,
        timePerTask = Duration(seconds: json['timePerTask'] as int),
        rankRange = RankRange(
          from: Rank.values[json['rankRangeFrom'] as int],
          to: Rank.values[json['rankRangeTo'] as int],
        ),
        maxMistakes = json['maxMistakes'] as int,
        taskSourceType = TaskSourceType.values[json['taskSourceType'] as int],
        taskTypes = _maybeTaskTypes(json['taskTypes'] as List<dynamic>?),
        taskTag = _maybeTaskTag(json['taskTag'] as int?),
        taskSubtags = _maybeTaskSubtags(json['taskSubtags'] as List<dynamic>?),
        collectStats = json['collectStats'] as bool;

  static ISet<TaskType>? _maybeTaskTypes(List<dynamic>? types) =>
      types?.map((index) => TaskType.values[index as int]).toISet();

  static TaskTag? _maybeTaskTag(int? index) =>
      index == null ? null : TaskTag.values[index];

  static ISet<TaskTag>? _maybeTaskSubtags(List<dynamic>? subtags) =>
      subtags?.map((index) => TaskTag.values[index as int]).toISet();
}
