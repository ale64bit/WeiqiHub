import 'dart:math';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:wqhub/train/task.dart';
import 'package:wqhub/train/task_db.dart';
import 'package:wqhub/train/task_source/task_source.dart';
import 'package:wqhub/train/task_type.dart';
import 'package:wqhub/train/variation_tree.dart';
import 'package:wqhub/wq/rank.dart';

final class RankedModeTaskSource extends TaskSource {
  static const _taskTypes = ISetConst({
    TaskType.lifeAndDeath,
    TaskType.tesuji,
    TaskType.capture,
    TaskType.captureRace,
  });

  Task _cur;
  double _rank;
  bool randomizeLayout;

  RankedModeTaskSource(double rank, this.randomizeLayout)
      : _rank = rank,
        _cur = TaskDB()
            .takeByTypes(Rank.values[rank.toInt()], _taskTypes, 1)
            .first
            .withRandomSymmetry(randomize: randomizeLayout);

  @override
  bool next(prevStatus, prevSolveTime, {Function(double)? onRankChanged}) {
    switch (prevStatus) {
      case VariationStatus.correct:
        _rank = min(_rank + _rankInc(prevSolveTime), Rank.d7.index.toDouble());
      case VariationStatus.wrong:
        _rank = max(_rank - _rankDec(prevSolveTime), Rank.k15.index.toDouble());
    }
    onRankChanged?.call(_rank);
    _cur = TaskDB()
        .takeByTypes(Rank.values[_rank.toInt()], _taskTypes, 1)
        .first
        .withRandomSymmetry(randomize: randomizeLayout);
    return true;
  }

  double _rankInc(Duration d) {
    if (d < Duration(seconds: 10)) {
      return 1.0;
    } else if (d < Duration(seconds: 20)) {
      return 0.5;
    } else if (d < Duration(seconds: 30)) {
      return 0.2;
    } else if (d < Duration(minutes: 1)) {
      return 0.1;
    } else {
      return 0.05;
    }
  }

  double _rankDec(Duration d) {
    if (d < Duration(seconds: 30)) {
      return 0.5;
    } else {
      return 0.2;
    }
  }

  @override
  Task get task => _cur;

  @override
  double get rank => _rank;
}
