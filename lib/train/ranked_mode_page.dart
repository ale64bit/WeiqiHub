import 'package:flutter/material.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/stats/stats_db.dart';
import 'package:wqhub/train/task.dart';
import 'package:wqhub/train/task_board.dart';
import 'package:wqhub/train/task_side_bar.dart';
import 'package:wqhub/train/task_solving_state_mixin.dart';
import 'package:wqhub/train/task_source/task_source.dart';
import 'package:wqhub/train/variation_tree.dart';
import 'package:wqhub/wq/rank.dart';

class RankedModeRouteArguments {
  final TaskSource taskSource;

  RankedModeRouteArguments({required this.taskSource});
}

class RankedModePage extends StatefulWidget {
  static const routeName = '/train/ranked_mode';

  const RankedModePage({super.key, required this.taskSource});

  final TaskSource taskSource;

  @override
  State<RankedModePage> createState() => _RankedModePageState();
}

class _RankedModePageState extends State<RankedModePage>
    with TaskSolvingStateMixin {
  final _stopwatch = Stopwatch();
  var _taskNumber = 1;

  @override
  void initState() {
    super.initState();
    _stopwatch.start();
    enableSidebarNotifications(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _stopwatch.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final wideLayout = MediaQuery.sizeOf(context).aspectRatio > 1.5;

    final boardArea = TaskBoard(
      task: currentTask,
      turn: turn,
      stones: gameTree.stones,
      annotations: continuationAnnotations ?? gameTree.annotations,
      dismissable: solveStatus != null,
      onPointClicked: (p) => onMove(p, wideLayout),
      onDismissed: onNextTask,
    );

    final taskTitle =
        '[${widget.taskSource.task.ref.rank.toString()}] ${widget.taskSource.task.ref.type.toLocalizedString(loc)}';

    final rankDisplay = Text(Rank.decimalString(widget.taskSource.rank),
        style: TextTheme.of(context).titleLarge);

    return TaskSideBar(
      taskTitle: taskTitle,
      color: widget.taskSource.task.first,
      upsolveMode: (solveStatus == null) ? null : upsolveMode,
      onShowSolution: onShowContinuations,
      onShareTask: onShareTask,
      onCopySgf: onCopySgf,
      onResetTask: onResetTask,
      onNextTask: onNextTask,
      onPreviousMove: onPreviousMove,
      onNextMove: onNextMove,
      onUpdateUpsolveMode: onUpdateUpsolveMode,
      timeDisplay: (solveStatus == null) ? rankDisplay : null,
      notificationMessage: notificationMessage,
      notificationColor: notificationColor,
      notificationIcon: notificationIcon,
      leading: Center(child: Text('$_taskNumber')),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.cancel),
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
      ],
      footer: [
        if (wideLayout && solveStatus != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(child: rankDisplay),
          ),
      ],
      child: boardArea,
    );
  }

  @override
  Task get currentTask => widget.taskSource.task;

  @override
  void onSolveStatus(VariationStatus status) {
    _stopwatch.stop();
    StatsDB()
        .addTaskAttempt(currentTask.ref, status == VariationStatus.correct);
    if (status == VariationStatus.correct) {
      context.stats.incrementTotalPassCount(currentTask.ref.rank);
    } else {
      context.stats.incrementTotalFailCount(currentTask.ref.rank);
    }
  }

  void onNextTask() {
    widget.taskSource.next(
        solveStatus ?? VariationStatus.wrong, _stopwatch.elapsed,
        onRankChanged: context.stats.updateRankedModeRank);
    _taskNumber++;
    solveStatus = null;
    setState(() {
      setupCurrentTask();
    });
    _stopwatch.reset();
    _stopwatch.start();
  }
}
