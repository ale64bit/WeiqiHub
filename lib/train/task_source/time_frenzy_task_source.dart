import 'dart:math';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:wqhub/train/task.dart';
import 'package:wqhub/train/task_db.dart';
import 'package:wqhub/train/task_source/task_source.dart';
import 'package:wqhub/train/task_type.dart';
import 'package:wqhub/train/variation_tree.dart';
import 'package:wqhub/wq/rank.dart';

final class TimeFrenzyTaskSource extends TaskSource {
  static const _taskTypes = ISetConst({
    TaskType.lifeAndDeath,
    TaskType.tesuji,
    TaskType.capture,
    TaskType.captureRace,
  });

  Task _cur;
  double _rank = Rank.k15.index.toDouble();
  int _mistakeCount = 0;
  bool randomizeLayout = false;

  TimeFrenzyTaskSource({required this.randomizeLayout})
      : _cur = TaskDB()
            .takeByTypes(Rank.k15, _taskTypes, 1)
            .first
            .withRandomSymmetry(randomize: randomizeLayout);

  @override
  bool next(prevStatus, prevSolveTime, {Function(double)? onRankChanged}) {
    switch (prevStatus) {
      case VariationStatus.correct:
        _rank = min(_rank + _rankInc(prevSolveTime), Rank.d7.index.toDouble());
      case VariationStatus.wrong:
        _mistakeCount++;
        _rank = max(_rank - _mistakeCount, Rank.k15.index.toDouble());
    }
    onRankChanged?.call(_rank);
    _cur = TaskDB()
        .takeByTypes(Rank.values[_rank.toInt()], _taskTypes, 1)
        .first
        .withRandomSymmetry(randomize: randomizeLayout);
    return true;
  }

  double _rankInc(Duration d) {
    if (d < Duration(seconds: 5)) {
      return 1.0;
    } else if (d < Duration(seconds: 10)) {
      return 0.7;
    } else {
      return 0.4;
    }
  }

  @override
  Task get task => _cur;

  @override
  double get rank => _rank;
}
