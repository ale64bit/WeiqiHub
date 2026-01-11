import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wqhub/game_client/time_state.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/confirm_dialog.dart';
import 'package:wqhub/stats/stats_db.dart';
import 'package:wqhub/train/exam_result_page.dart';
import 'package:wqhub/train/rank_range.dart';
import 'package:wqhub/train/task.dart';
import 'package:wqhub/train/task_action_bar.dart';
import 'package:wqhub/train/task_board.dart';
import 'package:wqhub/train/task_ref.dart';
import 'package:wqhub/train/task_solving_state_mixin.dart';
import 'package:wqhub/train/upsolve_mode.dart';
import 'package:wqhub/turn_icon.dart';
import 'package:wqhub/train/task_source/task_source.dart';
import 'package:wqhub/time_display.dart';
import 'package:wqhub/train/variation_tree.dart';
import 'package:wqhub/wq/wq.dart' as wq;

class ExamPage extends StatefulWidget {
  const ExamPage({
    super.key,
    required this.title,
    required this.examEvent,
    required this.rankRange,
    required this.taskCount,
    required this.timePerTask,
    required this.maxMistakes,
    required this.createTaskSource,
    required this.onPass,
    required this.onFail,
    required this.baseRoute,
    required this.exitRoute,
    required this.redoRouteArguments,
    this.nextRouteArguments,
    this.collectStats = true,
  });

  final String title;
  final ExamEvent examEvent;
  final RankRange rankRange;
  final int taskCount;
  final Duration timePerTask;
  final int maxMistakes;
  final TaskSource Function(BuildContext) createTaskSource;
  final Function() onPass;
  final Function() onFail;
  final String baseRoute;
  final String exitRoute;
  final dynamic redoRouteArguments;
  final dynamic nextRouteArguments;
  final bool collectStats;

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> with TaskSolvingStateMixin {
  final _timeDisplayKey = GlobalKey(debugLabel: 'time-display');
  final _stopwatch = Stopwatch();
  late final _taskSource = widget.createTaskSource(context);
  var _taskNumber = 1;
  var _totalTime = Duration.zero;
  var _mistakeCount = 0;
  final _completedTasks = <(TaskRef, bool)>[];

  @override
  void initState() {
    super.initState();
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
      onDismissed: _onNext,
    );

    final taskTitle =
        '[${_taskSource.task.ref.rank.toString()}] ${_taskSource.task.ref.type.toLocalizedString(loc)}';

    final timeDisplay = TimeDisplay(
      key: _timeDisplayKey,
      timeState: TimeState(
        mainTimeLeft: widget.timePerTask,
        periodTimeLeft: Duration.zero,
        periodCount: 0,
      ),
      warningDuration: const Duration(seconds: 9),
      enabled: solveStatus == null,
      tickerEnabled: true,
      voiceCountdown: false,
      onTimeout: () => _onSolveTimeout(wideLayout),
    );

    if (wideLayout) {
      return Scaffold(
        body: Center(
          child: Row(
            children: <Widget>[
              Expanded(child: boardArea),
              VerticalDivider(thickness: 1, width: 8),
              _SideBar(
                title: widget.title,
                taskTitle: taskTitle,
                taskNumber: _taskNumber,
                taskCount: widget.taskCount,
                color: _taskSource.task.first,
                status: solveStatus,
                upsolveMode: upsolveMode,
                onShowSolution: onShowContinuations,
                onShareTask: onShareTask,
                onCopySgf: onCopySgf,
                onResetTask: onResetTask,
                onNextTask: _onNext,
                onCancelExam: () {
                  widget.onFail();
                  if (widget.collectStats) {
                    final curCount =
                        _taskNumber - (solveStatus == null ? 1 : 0);
                    StatsDB().addExamAttempt(
                        widget.examEvent,
                        widget.rankRange,
                        curCount - _mistakeCount,
                        _mistakeCount + widget.taskCount - curCount,
                        false,
                        _totalTime);
                  }
                  Navigator.popUntil(
                      context, ModalRoute.withName(widget.exitRoute));
                },
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
          leading: Center(child: Text('$_taskNumber/${widget.taskCount}')),
          title: Row(
            spacing: 4,
            children: <Widget>[
              TurnIcon(color: _taskSource.task.first),
              Expanded(
                child: Text(
                  taskTitle,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => ConfirmDialog(
                    title: loc.confirm,
                    content: loc.msgConfirmStopEvent(widget.title),
                    onYes: () {
                      widget.onFail();
                      if (widget.collectStats) {
                        final curCount =
                            _taskNumber - (solveStatus == null ? 1 : 0);
                        StatsDB().addExamAttempt(
                            widget.examEvent,
                            widget.rankRange,
                            curCount - _mistakeCount,
                            _mistakeCount + widget.taskCount - curCount,
                            false,
                            _totalTime);
                      }
                      Navigator.popUntil(
                          context, ModalRoute.withName(widget.exitRoute));
                    },
                    onNo: () {
                      Navigator.pop(context);
                    },
                  ),
                );
              },
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
                  onNextTask: _onNext,
                  onPreviousMove: onPreviousMove,
                  onNextMove: onNextMove,
                  onUpdateUpsolveMode: onUpdateUpsolveMode,
                ),
        ),
      );
    }
  }

  @override
  Task get currentTask => _taskSource.task;

  @override
  void onSolveStatus(VariationStatus status) {
    _stopwatch.stop();
    _totalTime += _stopwatch.elapsed;
    if (status != VariationStatus.correct) _mistakeCount++;

    if (widget.collectStats) {
      StatsDB()
          .addTaskAttempt(currentTask.ref, status == VariationStatus.correct);
      if (status == VariationStatus.correct) {
        context.stats.incrementTotalPassCount(currentTask.ref.rank);
      } else {
        context.stats.incrementTotalFailCount(currentTask.ref.rank);
      }
    }

    _completedTasks.add((currentTask.ref, status == VariationStatus.correct));
  }

  void _finishExam() {
    final passed = _mistakeCount <= widget.maxMistakes;
    if (passed) {
      widget.onPass();
    } else {
      widget.onFail();
    }
    if (widget.collectStats) {
      StatsDB().addExamAttempt(widget.examEvent, widget.rankRange,
          widget.taskCount - _mistakeCount, _mistakeCount, passed, _totalTime);
    }
    Navigator.pushReplacementNamed(
      context,
      ExamResultPage.routeName,
      arguments: ExamResultRouteArguments(
        event: widget.examEvent,
        totalTime: _totalTime,
        passed: passed,
        taskCount: widget.taskCount,
        mistakeCount: _mistakeCount,
        completedTasks: _completedTasks,
        onRedo: (context) {
          Navigator.pushReplacementNamed(
            context,
            widget.baseRoute,
            arguments: widget.redoRouteArguments,
          );
        },
        onNext: _mistakeCount <= widget.maxMistakes &&
                widget.nextRouteArguments != null
            ? (context) {
                Navigator.pushReplacementNamed(
                  context,
                  widget.baseRoute,
                  arguments: widget.nextRouteArguments,
                );
              }
            : null,
      ),
    );
  }

  void _onNext() {
    if (_taskNumber == widget.taskCount) {
      _finishExam();
      return;
    }
    _taskSource.next(solveStatus ?? VariationStatus.wrong, _stopwatch.elapsed);
    _taskNumber++;
    solveStatus = null;
    setState(() {
      setupCurrentTask();
    });
    _stopwatch.reset();
    _stopwatch.start();
  }

  void _onSolveTimeout(bool wideLayout) {
    if (solveStatus == null) {
      _mistakeCount++;
      _totalTime += widget.timePerTask;
      solveStatus = VariationStatus.wrong;
      if (!solveStatusNotified) {
        notifySolveTimeout(wideLayout);
        solveStatusNotified = true;
      }
      setState(() {});
    }
  }
}

class _SideBar extends StatelessWidget {
  final String title;
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
  final Function() onCancelExam;
  final Function() onPreviousMove;
  final Function() onNextMove;
  final Function(UpsolveMode) onUpdateUpsolveMode;
  final Widget timeDisplay;

  const _SideBar({
    required this.title,
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
    required this.onCancelExam,
    required this.onPreviousMove,
    required this.onNextMove,
    required this.onUpdateUpsolveMode,
    required this.timeDisplay,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
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
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => ConfirmDialog(
                        title: loc.confirm,
                        content: loc.msgConfirmStopEvent(title),
                        onYes: onCancelExam,
                        onNo: () {
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
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
                ? Center(
                    child: timeDisplay,
                  )
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
