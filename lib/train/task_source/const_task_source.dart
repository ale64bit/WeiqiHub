import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:wqhub/train/task_repository.dart';
import 'package:wqhub/train/task_source/task_source.dart';
import 'package:wqhub/wq/rank.dart';

final class ConstTaskSource extends TaskSource {
  final IList<Task> tasks;
  int _cur;

  ConstTaskSource({required this.tasks})
      : assert(tasks.isNotEmpty),
        _cur = 0;

  @override
  bool next(prevStatus, prevSolveTime, {Function(double)? onRankChanged}) {
    _cur++;
    if (_cur >= tasks.length) _cur = 0;
    return true;
  }

  @override
  Task get task => tasks[_cur];

  @override
  double get rank =>
      tasks.firstOrNull?.rank.index.toDouble() ?? Rank.k15.index.toDouble();
}
