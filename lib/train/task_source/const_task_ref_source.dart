import 'package:wqhub/train/task.dart';
import 'package:wqhub/train/task_db.dart';
import 'package:wqhub/train/task_ref.dart';
import 'package:wqhub/train/task_source/task_source.dart';

final class ConstTaskRefSource extends TaskSource {
  final List<TaskRef> taskRefs;
  int _cur = 0;
  late Task _curTask = TaskDB().getTaskByRef(taskRefs.first)!;

  ConstTaskRefSource({required this.taskRefs}) : assert(taskRefs.isNotEmpty);

  @override
  bool next(prevStatus, prevSolveTime, {Function(double)? onRankChanged}) {
    _cur++;
    if (_cur >= taskRefs.length) _cur = 0;
    var ref = taskRefs[_cur];
    _curTask = TaskDB().getTaskByRef(ref)!;
    return true;
  }

  @override
  Task get task => _curTask;

  @override
  double get rank =>
      throw UnimplementedError('rank not supported on ConstTaskRefSource');
}
