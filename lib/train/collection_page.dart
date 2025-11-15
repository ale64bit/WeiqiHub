import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wqhub/game_client/time_state.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/stats/stats_db.dart';
import 'package:wqhub/time_display.dart';
import 'package:wqhub/train/task_action_bar.dart';
import 'package:wqhub/train/task_board.dart';
import 'package:wqhub/train/task_repository.dart';
import 'package:wqhub/train/task_solving_state_mixin.dart';
import 'package:wqhub/train/upsolve_mode.dart';
import 'package:wqhub/turn_icon.dart';
import 'package:wqhub/train/task_source/task_source.dart';
import 'package:wqhub/train/variation_tree.dart';
import 'package:wqhub/wq/wq.dart' as wq;

class CollectionRouteArguments {
  final TaskCollection taskCollection;
  final TaskSource taskSource;
  final int initialTask;

  const CollectionRouteArguments(
      {required this.taskCollection,
      required this.taskSource,
      required this.initialTask});
}

class CollectionPage extends StatefulWidget {
  static const routeName = '/train/collection';

  const CollectionPage(
      {super.key,
      required this.taskCollection,
      required this.taskSource,
      required this.initialTask});

  final TaskCollection taskCollection;
  final TaskSource taskSource;
  final int initialTask;

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage>
    with TaskSolvingStateMixin {
  final _timeDisplayKey = GlobalKey(debugLabel: 'time-display');
  final _stopwatch = Stopwatch();
  var _taskNumber = 1;

  @override
  void initState() {
    super.initState();
    _taskNumber = widget.initialTask;
    _stopwatch.start();
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

    final taskRank =
        solveStatus != null ? widget.taskSource.task.rank.toString() : '?';
    final taskTitle =
        '[$taskRank] ${widget.taskSource.task.type.toLocalizedString(loc)}';

    final timeDisplay = TimeDisplay(
      key: _timeDisplayKey,
      timeState: const TimeState(
        mainTimeLeft: Duration.zero,
        periodTimeLeft: Duration.zero,
        periodCount: 0,
      ),
      warningDuration: const Duration(seconds: -1),
      enabled: solveStatus == null,
      tickerEnabled: true,
      tickMode: TickMode.increase,
      voiceCountdown: false,
    );

    if (wideLayout) {
      return Scaffold(
        body: Center(
          child: Row(
            children: <Widget>[
              Expanded(child: boardArea),
              VerticalDivider(thickness: 1, width: 8),
              _SideBar(
                taskTitle: taskTitle,
                taskNumber: _taskNumber,
                taskCount: widget.taskCollection.taskCount,
                color: widget.taskSource.task.first,
                status: solveStatus,
                upsolveMode: upsolveMode,
                onShowSolution: onShowContinuations,
                onShareTask: onShareTask,
                onCopySgf: onCopySgf,
                onResetTask: onResetTask,
                onNextTask: onNextTask,
                onExit: _onExit,
                onPreviousMove: onPreviousMove,
                onNextMove: onNextMove,
                onUpdateUpsolveMode: onUpdateUpsolveMode,
                timeDisplay: timeDisplay,
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          leading: Center(
              child: Text('$_taskNumber/${widget.taskCollection.taskCount}')),
          title: Row(
            spacing: 4,
            children: <Widget>[
              TurnIcon(color: widget.taskSource.task.first),
              Text(taskTitle),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.cancel),
              onPressed: _onExit,
            ),
          ],
        ),
        body: boardArea,
        bottomNavigationBar: BottomAppBar(
          height: upsolveMode == UpsolveMode.auto ? 80.0 : 160.0,
          child: (solveStatus == null)
              ? Center(child: timeDisplay)
              : TaskActionBar(
                  upsolveMode: upsolveMode,
                  onShowSolution: onShowContinuations,
                  onShareTask: onShareTask,
                  onCopySgf: onCopySgf,
                  onResetTask: onResetTask,
                  onNextTask: onNextTask,
                  onPreviousMove: onPreviousMove,
                  onNextMove: onNextMove,
                  onUpdateUpsolveMode: onUpdateUpsolveMode,
                ),
        ),
      );
    }
  }

  @override
  Task get currentTask => widget.taskSource.task;

  @override
  void onSolveStatus(VariationStatus status) {
    _stopwatch.stop();
    StatsDB().addTaskAttempt(currentTask.rank, currentTask.type, currentTask.id,
        status == VariationStatus.correct);
    if (status == VariationStatus.correct) {
      context.stats.incrementTotalPassCount(currentTask.rank);
      StatsDB().updateCollectionActiveSession(
        widget.taskCollection.id,
        correctDelta: 1,
        durationDelta: _stopwatch.elapsed,
      );
    } else {
      context.stats.incrementTotalFailCount(currentTask.rank);
      StatsDB().updateCollectionActiveSession(
        widget.taskCollection.id,
        wrongDelta: 1,
        durationDelta: _stopwatch.elapsed,
      );
    }
  }

  _onExit() {
    if (!solveStatusNotified) {
      StatsDB().updateCollectionActiveSession(widget.taskCollection.id,
          durationDelta: _stopwatch.elapsed);
    }
    Navigator.pop(context);
  }

  void onNextTask() {
    if (widget.taskSource
        .next(solveStatus ?? VariationStatus.wrong, _stopwatch.elapsed)) {
      _taskNumber++;
      solveStatus = null;
      setState(() {
        setupCurrentTask();
      });
      _stopwatch.reset();
      _stopwatch.start();
    } else {
      _finishSession();
    }
  }

  _finishSession() {
    final activeSession =
        StatsDB().collectionActiveSession(widget.taskCollection.id)!;
    final curResult = CollectionStatEntry(
      id: widget.taskCollection.id,
      correctCount: activeSession.correctCount,
      wrongCount: activeSession.wrongCount,
      duration: activeSession.duration,
      completed: DateTime.now(),
    );
    final bestResult = StatsDB().collectionStat(widget.taskCollection.id);
    final isNewBest = (bestResult == null) ||
        (curResult.correctCount *
                (bestResult.correctCount + bestResult.wrongCount) >
            bestResult.correctCount *
                (curResult.correctCount + curResult.wrongCount)) ||
        ((curResult.correctCount *
                    (bestResult.correctCount + bestResult.wrongCount) ==
                bestResult.correctCount *
                    (curResult.correctCount + curResult.wrongCount)) &&
            curResult.duration < bestResult.duration);
    StatsDB().deleteCollectionActiveSession(widget.taskCollection.id);
    if (isNewBest) {
      StatsDB().updateCollectionStat(curResult);
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final loc = AppLocalizations.of(context)!;
        return AlertDialog(
          title: Text(isNewBest ? loc.newBestResult : loc.result),
          icon: isNewBest ? const Icon(Icons.emoji_events) : null,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(loc.accuracy),
                trailing: Text(
                    '${curResult.correctCount}/${curResult.correctCount + curResult.wrongCount} (${(100 * curResult.correctCount / (curResult.correctCount + curResult.wrongCount)).round()}%)'),
              ),
              ListTile(
                title: Text(loc.trainingTotalTime),
                trailing: Text(curResult.duration.toString().split('.').first),
              ),
              ListTile(
                title: Text(loc.trainingAvgTimePerTask),
                trailing: Text(
                    '${(curResult.duration.inSeconds / (curResult.correctCount + curResult.wrongCount)).toStringAsFixed(1)}s'),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(loc.exit),
            ),
          ],
        );
      },
    ).then((_) {
      if (context.mounted) Navigator.pop(context);
    });
  }
}

class _SideBar extends StatelessWidget {
  final String taskTitle;
  final int taskNumber;
  final int taskCount;
  final wq.Color color;
  final VariationStatus? status;
  final UpsolveMode upsolveMode;
  final Function()? onShowSolution;
  final Function()? onShareTask;
  final Function()? onCopySgf;
  final Function()? onResetTask;
  final Function()? onNextTask;
  final Function()? onExit;
  final Function() onPreviousMove;
  final Function() onNextMove;
  final Function(UpsolveMode) onUpdateUpsolveMode;
  final Widget timeDisplay;

  const _SideBar({
    required this.taskTitle,
    required this.taskNumber,
    required this.taskCount,
    required this.color,
    this.status,
    required this.upsolveMode,
    required this.onShowSolution,
    required this.onShareTask,
    this.onCopySgf,
    required this.onResetTask,
    required this.onNextTask,
    required this.onExit,
    required this.onPreviousMove,
    required this.onNextMove,
    required this.onUpdateUpsolveMode,
    required this.timeDisplay,
  });

  @override
  Widget build(BuildContext context) {
    final widgetSize = MediaQuery.sizeOf(context);
    final sidebarSize = min(
        widgetSize.longestSide - widgetSize.shortestSide, widgetSize.width / 3);
    return SizedBox(
      width: sidebarSize,
      child: Container(
        padding: EdgeInsets.all(8),
        color: ColorScheme.of(context).surfaceContainer,
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                    child: Text(
                  '$taskNumber/$taskCount',
                  textAlign: TextAlign.center,
                )),
                IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: onExit,
                ),
              ],
            ),
            Row(
              spacing: 8,
              mainAxisSize: MainAxisSize.min,
              children: [
                TurnIcon(color: color),
                Text(taskTitle),
              ],
            ),
            Expanded(child: Container()),
            (status == null)
                ? Center(child: timeDisplay)
                : TaskActionBar(
                    upsolveMode: upsolveMode,
                    onShowSolution: onShowSolution,
                    onShareTask: onShareTask,
                    onCopySgf: onCopySgf,
                    onNextTask: onNextTask,
                    onResetTask: onResetTask,
                    onPreviousMove: onPreviousMove,
                    onNextMove: onNextMove,
                    onUpdateUpsolveMode: onUpdateUpsolveMode,
                  ),
          ],
        ),
      ),
    );
  }
}
