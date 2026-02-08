import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:wqhub/train/task_db.dart';
import 'package:wqhub/train/task_ref.dart';
import 'package:wqhub/wq/rank.dart';

class TaskCollection {
  final int id;
  final String title;
  final int taskCount;
  final Rank? avgRank;
  final List<TaskCollection> children;

  const TaskCollection({
    required this.id,
    required this.title,
    required this.taskCount,
    this.avgRank,
    required this.children,
  });

  Iterable<TaskRef> allTasks() => children.isNotEmpty
      ? children.expand((child) => child.allTasks())
      : TaskDB().takeByCollection(id);

  IMap<Rank, int> rankDistribution() => allTasks().fold(
      const IMap.empty(),
      (cur, ref) => cur.update(
            ref.rank,
            (k) => k + 1,
            ifAbsent: () => 1,
          ));

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'taskCount': taskCount,
        if (avgRank != null) 'avgRank': avgRank!.index,
        if (children.isNotEmpty)
          'children': [for (final child in children) child.toJson()]
      };

  factory TaskCollection.fromJson(Map<String, dynamic> json) => TaskCollection(
        id: json['id'] as int,
        title: json['title'] as String,
        taskCount: json['taskCount'] as int,
        avgRank: _maybeRank(json['avgRank'] as int?),
        children: [
          for (final child in (json['children'] as List<dynamic>?) ?? [])
            TaskCollection.fromJson(child as Map<String, dynamic>)
        ],
      );

  static Rank? _maybeRank(int? i) => i != null ? Rank.values[i] : null;
}
