import 'package:wqhub/train/task_repository.dart';
import 'package:wqhub/train/task_source/task_source.dart';

final class ConstTaskRefSource extends TaskSource {
  final List<TaskRef> taskRefs;
  int _cur = 0;
  late Task _curTask = TaskRepository().readByRef(taskRefs.first)!;

  ConstTaskRefSource({required this.taskRefs}) : assert(taskRefs.isNotEmpty);

  @override
  bool next(prevStatus, prevSolveTime, {Function(double)? onRankChanged}) {
    _cur++;
    if (_cur >= taskRefs.length) _cur = 0;
    _curTask = TaskRepository().readByRef(taskRefs[_cur])!;
    return true;
  }

  @override
  Task get task => _curTask;

  @override
  double get rank =>
      throw UnimplementedError('rank not supported on ConstTaskRefSource');
}
