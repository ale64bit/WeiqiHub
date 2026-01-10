import 'package:flutter/foundation.dart';
import 'package:wqhub/train/task_type.dart';
import 'package:wqhub/wq/rank.dart';

@immutable
class TaskRef {
  final Rank rank;
  final TaskType type;
  final int id;

  const TaskRef({required this.rank, required this.type, required this.id});

  factory TaskRef.ofUri(String link) {
    final uri = Uri.parse(link);
    if (uri.scheme != 'wqhub') {
      throw FormatException('unrecognized scheme: ${uri.scheme}');
    }
    final p = uri.pathSegments.last;
    return TaskRef(
      rank: Rank.values[int.parse(p.substring(0, 2), radix: 16)],
      type: TaskType.values[int.parse(p.substring(2, 4), radix: 16)],
      id: int.parse(p.substring(4), radix: 16),
    );
  }

  @override
  int get hashCode => Object.hash(rank, type, id);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is TaskRef &&
        other.rank == rank &&
        other.type == type &&
        other.id == id;
  }
}
