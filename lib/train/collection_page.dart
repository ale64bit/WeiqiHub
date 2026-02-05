import 'package:flutter/material.dart';
import 'package:wqhub/game_client/time_state.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/stats/stats_db.dart';
import 'package:wqhub/time_display.dart';
import 'package:wqhub/train/collection_result_page.dart';
import 'package:wqhub/train/task.dart';
import 'package:wqhub/train/task_board.dart';
import 'package:wqhub/train/task_collection.dart';
import 'package:wqhub/train/task_side_bar.dart';
import 'package:wqhub/train/task_solving_state_mixin.dart';
import 'package:wqhub/train/task_source/task_source.dart';
import 'package:wqhub/train/variation_tree.dart';

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

    final taskRank =
        solveStatus != null ? widget.taskSource.task.ref.rank.toString() : '?';
    final taskTitle =
        '[$taskRank] ${widget.taskSource.task.ref.type.toLocalizedString(loc)}';

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
      timeDisplay: (solveStatus == null) ? timeDisplay : null,
      notificationMessage: notificationMessage,
      notificationColor: notificationColor,
      notificationIcon: notificationIcon,
      leading: Center(
          child: Text('$_taskNumber/${widget.taskCollection.taskCount}')),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.cancel),
          onPressed: _onExit,
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
      StatsDB().updateCollectionActiveSession(
        widget.taskCollection.id,
        correctDelta: 1,
        durationDelta: _stopwatch.elapsed,
      );
    } else {
      context.stats.incrementTotalFailCount(currentTask.ref.rank);
      StatsDB().updateCollectionActiveSession(
        widget.taskCollection.id,
        wrongDelta: 1,
        durationDelta: _stopwatch.elapsed,
      );
      StatsDB().addCollectionActiveSessionMistake(
        widget.taskCollection.id,
        currentTask.ref,
      );
    }
  }

  void _onExit() {
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

  void _finishSession() {
    final activeSession =
        StatsDB().collectionActiveSession(widget.taskCollection.id)!;
    final failedTasks =
        StatsDB().collectionActiveSessionMistakes(widget.taskCollection.id);
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
    Navigator.pushReplacementNamed(
      context,
      CollectionResultPage.routeName,
      arguments: CollectionResultRouteArguments(
        taskCollection: widget.taskCollection,
        totalTime: activeSession.duration,
        failedTasks: failedTasks,
        newBest: isNewBest,
      ),
    );
  }
}
