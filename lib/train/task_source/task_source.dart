import 'package:wqhub/train/task.dart';
import 'package:wqhub/train/variation_tree.dart';

abstract class TaskSource {
  Task get task;
  double get rank;
  bool next(VariationStatus prevStatus, Duration prevSolveTime,
      {Function(double)? onRankChanged});
}
