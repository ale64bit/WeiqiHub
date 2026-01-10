import 'package:wqhub/train/task.dart';
import 'package:wqhub/train/task_source/task_source.dart';
import 'package:wqhub/train/variation_tree.dart';

final class BlackToPlaySource extends TaskSource {
  final TaskSource source;
  final bool blackToPlay;

  @override
  late Task task;

  BlackToPlaySource({required this.source, required this.blackToPlay}) {
    task = source.task;
    if (blackToPlay) task = task.withBlackToPlay();
  }

  @override
  double get rank => source.rank;

  @override
  bool next(VariationStatus prevStatus, Duration prevSolveTime,
      {Function(double)? onRankChanged}) {
    if (!source.next(prevStatus, prevSolveTime, onRankChanged: onRankChanged)) {
      return false;
    }
    task = source.task;
    if (blackToPlay) task = task.withBlackToPlay();
    return true;
  }
}
