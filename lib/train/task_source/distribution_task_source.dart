import 'package:wqhub/random_util.dart';
import 'package:wqhub/train/task.dart';
import 'package:wqhub/train/task_source/task_source.dart';
import 'package:wqhub/train/variation_tree.dart';

class DistributionTaskSource<T> extends TaskSource {
  final List<(T, int)> buckets;
  final Task Function(T) nextTask;
  late Task _curTask = _takeTask();

  DistributionTaskSource({required this.buckets, required this.nextTask});

  @override
  bool next(VariationStatus prevStatus, Duration prevSolveTime,
      {Function(double p1)? onRankChanged}) {
    _curTask = _takeTask();
    return true;
  }

  @override
  double get rank =>
      throw UnimplementedError('rank not supported on DistributionTaskSource');

  @override
  Task get task => _curTask;

  Task _takeTask() => nextTask(randomDist(buckets));
}
