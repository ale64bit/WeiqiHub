import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:wqhub/train/task.dart';
import 'package:wqhub/train/task_db.dart';
import 'package:wqhub/train/task_ref.dart';
import 'package:wqhub/train/task_collection.dart';
import 'package:wqhub/train/task_source/task_source.dart';

final class CollectionTaskSource extends TaskSource {
  final IList<TaskRef> _tasks;
  late Task _task;
  var _cur = 0;

  CollectionTaskSource(TaskCollection collection, {required int offset})
      : _tasks = collection.allTasks().skip(offset).toIList() {
    var ref = _tasks[0];
    _task = TaskDB().getTaskByRef(ref)!;
  }

  @override
  bool next(prevStatus, prevSolveTime, {Function(double)? onRankChanged}) {
    _cur++;
    if (_cur >= _tasks.length) return false;
    var ref = _tasks[_cur];
    _task = TaskDB().getTaskByRef(ref)!;
    return true;
  }

  @override
  Task get task => _task;

  @override
  double get rank => _task.rank.index.toDouble();
}
