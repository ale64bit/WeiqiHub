import 'dart:math';

import 'package:extension_type_unions/extension_type_unions.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wqhub/audio/audio_controller.dart';
import 'package:wqhub/board/board_annotation.dart';
import 'package:wqhub/game_client/time_state.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/confirm_dialog.dart';
import 'package:wqhub/stats/stats_db.dart';
import 'package:wqhub/train/response_delay.dart';
import 'package:wqhub/train/solve_status_notifier.dart';
import 'package:wqhub/train/task_action_bar.dart';
import 'package:wqhub/turn_icon.dart';
import 'package:wqhub/wq/annotated_game_tree.dart';
import 'package:wqhub/board/board.dart';
import 'package:wqhub/board/board_settings.dart';
import 'package:wqhub/board/coordinate_style.dart';
import 'package:wqhub/train/task_source/task_source.dart';
import 'package:wqhub/time_display.dart';
import 'package:wqhub/train/variation_tree.dart';
import 'package:wqhub/wq/wq.dart' as wq;

class ExamPage extends StatefulWidget {
  const ExamPage({
    super.key,
    required this.title,
    required this.taskCount,
    required this.taskSource,
    required this.timePerTask,
    required this.maxMistakes,
    required this.onPass,
    required this.onFail,
    required this.buildRedoPage,
    this.buildNextPage,
  });

  final String title;
  final int taskCount;
  final TaskSource taskSource;
  final Duration timePerTask;
  final int maxMistakes;
  final Function() onPass;
  final Function() onFail;
  final Widget Function() buildRedoPage;
  final Widget Function()? buildNextPage;

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> with SolveStatusNotifier {
  final _timeDisplayKey = GlobalKey(debugLabel: 'time-display');
  final _stopwatch = Stopwatch();
  VariationTreeIterator? _vtreeIt;
  var _gameTree = AnnotatedGameTree(19);
  var _turn = wq.Color.black;
  var _taskNumber = 1;
  VariationStatus? _solveStatus;
  bool _solveStatusNotified = false;
  var _totalTime = Duration.zero;
  var _mistakeCount = 0;
  IMapOfSets<wq.Point, Annotation>? _continuationAnnotations;

  @override
  void initState() {
    super.initState();
    _stopwatch.start();
    _setupCurrentTask();
  }

  @override
  void dispose() {
    _stopwatch.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wideLayout = MediaQuery.sizeOf(context).aspectRatio > 1.5;
    final borderSize =
        1.5 * (Theme.of(context).textTheme.labelMedium?.fontSize ?? 0);
    final border = context.settings.showCoordinates
        ? BoardBorderSettings(
            size: borderSize,
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
            rowCoordinates: CoordinateStyle(
              labels: CoordinateLabels.numbers,
              reverse: true,
            ),
            columnCoordinates: CoordinateStyle(
              labels: CoordinateLabels.alphaNoI,
            ),
          )
        : null;

    final boardSettings = BoardSettings(
      size: widget.taskSource.task.boardSize,
      subBoard: SubBoard(
        topLeft: widget.taskSource.task.topLeft,
        size: widget.taskSource.task.subBoardSize,
      ),
      theme: context.settings.boardTheme,
      edgeLine: context.settings.edgeLine,
      border: border,
      stoneShadows: context.settings.stoneShadows,
    );

    final board = LayoutBuilder(
      builder: (context, constraints) {
        final boardSize = constraints.biggest.shortestSide -
            2 * (boardSettings.border?.size ?? 0);
        return Board(
          size: boardSize,
          settings: boardSettings,
          onPointClicked: (p) => _onPointClicked(p, wideLayout),
          turn: _turn,
          stones: _gameTree.stones,
          annotations: _continuationAnnotations ?? _gameTree.annotations,
          confirmTap: context.settings.confirmMoves,
        );
      },
    );

    final taskTitle =
        '[${widget.taskSource.task.rank.toString()}] ${widget.taskSource.task.type.toString()}';

    final timeDisplay = TimeDisplay(
      key: _timeDisplayKey,
      timeState: TimeState(
        mainTimeLeft: widget.timePerTask,
        periodTimeLeft: Duration.zero,
        periodCount: 0,
      ),
      warningDuration: const Duration(seconds: 9),
      enabled: _solveStatus == null,
      tickerEnabled: true,
      voiceCountdown: false,
      onTimeout: () => _onTimeout(wideLayout),
    );

    if (wideLayout) {
      return Scaffold(
        body: Center(
          child: Row(
            children: <Widget>[
              Expanded(child: Center(child: board)),
              VerticalDivider(thickness: 1, width: 8),
              _SideBar(
                title: widget.title,
                taskTitle: taskTitle,
                taskNumber: _taskNumber,
                taskCount: widget.taskCount,
                color: widget.taskSource.task.first,
                status: _solveStatus,
                onShowSolution: _onShowContinuations,
                onShare: _onShare,
                onReplay: _onReplay,
                onNext: _onNext,
                onCancelExam: () {
                  widget.onFail();
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
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
              TurnIcon(color: widget.taskSource.task.first),
              Text(taskTitle),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => ConfirmDialog(
                    title: 'Confirm',
                    content:
                        'Are you sure that you want to stop the ${widget.title}?',
                    onYes: () {
                      widget.onFail();
                      Navigator.popUntil(context, (route) => route.isFirst);
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
        body: Center(
          child: board,
        ),
        bottomNavigationBar: BottomAppBar(
          child: (_solveStatus == null)
              ? Center(child: timeDisplay)
              : TaskActionBar(
                  onShowSolution: _onShowContinuations,
                  onShare: _onShare,
                  onReplay: _onReplay,
                  onNext: _onNext,
                ),
        ),
      );
    }
  }

  void _onReplay() {
    setState(() {
      _setupCurrentTask();
    });
  }

  void _onNext() {
    if (_taskNumber == widget.taskCount) {
      final passed = _mistakeCount <= widget.maxMistakes;
      if (passed) {
        widget.onPass();
      } else {
        widget.onFail();
      }
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => _ResultDialog(
          totalTime: _totalTime,
          passed: passed,
          mistakeCount: _mistakeCount,
          taskCount: widget.taskCount,
          onExit: () => Navigator.popUntil(context, (route) => route.isFirst),
          onRedo: () {
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PopScope(
                  canPop: false,
                  child: widget.buildRedoPage(),
                ),
              ),
            );
          },
          onNext: _mistakeCount <= widget.maxMistakes &&
                  widget.buildNextPage != null
              ? () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PopScope(
                        canPop: false,
                        child: widget.buildNextPage!(),
                      ),
                    ),
                  );
                }
              : null,
        ),
      );
      return;
    }
    widget.taskSource
        .next(_solveStatus ?? VariationStatus.wrong, _stopwatch.elapsed);
    _taskNumber++;
    _solveStatus = null;
    setState(() {
      _setupCurrentTask();
    });
    _stopwatch.reset();
    _stopwatch.start();
  }

  void _setupCurrentTask() {
    _continuationAnnotations = null;
    _vtreeIt =
        VariationTreeIterator(tree: widget.taskSource.task.variationTree);
    _gameTree = AnnotatedGameTree(widget.taskSource.task.boardSize);
    for (final entry in widget.taskSource.task.initialStones.entries) {
      for (final p in entry.value) {
        _gameTree
            .moveAnnotated((col: entry.key, p: p), mode: AnnotationMode.none);
      }
    }
    _turn = widget.taskSource.task.first;
    _solveStatusNotified = false;
  }

  void _onPointClicked(wq.Point p, bool wideLayout) {
    if (!(_solveStatusNotified || _turn == widget.taskSource.task.first)) {
      return;
    }

    if (_gameTree.moveAnnotated((col: _turn, p: p),
            mode: AnnotationMode.variation) !=
        null) {
      if (context.settings.sound) {
        AudioController().playForNode(_gameTree.curNode);
      }
      _continuationAnnotations = null;
      final status = _vtreeIt!.move(p);
      _turn = _turn.opposite;
      if (status != null) {
        _setSolveStatus(status, wideLayout);
      } else {
        switch (context.settings.responseDelay) {
          case ResponseDelay.none:
            _generateResponseMove(wideLayout);
          default:
            Future.delayed(context.settings.responseDelay.duration, () {
              _generateResponseMove(wideLayout);
            });
        }
      }
      setState(() {/* Update board */});
    }
  }

  void _generateResponseMove(bool wideLayout) {
    if (_solveStatusNotified) return;

    final resp = _vtreeIt!.genMove();
    _gameTree
        .moveAnnotated((col: _turn, p: resp), mode: AnnotationMode.variation);
    _turn = _turn.opposite;
    final status = _vtreeIt!.move(resp);
    if (status != null) {
      _setSolveStatus(status, wideLayout);
    }
    setState(() {/* Update board */});
  }

  void _setSolveStatus(VariationStatus status, bool wideLayout) {
    setState(() {
      _continuationAnnotations = null;
    });
    if (!_solveStatusNotified) {
      notifySolveStatus(status, wideLayout);
      _solveStatusNotified = true;
    }
    if (_solveStatus == null) {
      final curTask = widget.taskSource.task;
      StatsDB().addTaskAttempt(curTask.rank, curTask.type, curTask.id,
          status == VariationStatus.correct);
      if (status == VariationStatus.correct) {
        if (context.settings.sound) AudioController().correct();
        context.stats.incrementTotalPassCount(curTask.rank);
      } else {
        if (context.settings.sound) AudioController().wrong();
        context.stats.incrementTotalFailCount(curTask.rank);
        _mistakeCount++;
      }
      _stopwatch.stop();
      _totalTime += _stopwatch.elapsed;
      _solveStatus = status;
    }
  }

  void _onTimeout(bool wideLayout) {
    if (_solveStatus == null) {
      _mistakeCount++;
      _totalTime += widget.timePerTask;
      _solveStatus = VariationStatus.wrong;
      if (!_solveStatusNotified) {
        notifySolveTimeout(wideLayout);
        _solveStatusNotified = true;
      }
      setState(() {});
    }
  }

  _onShowContinuations() {
    _continuationAnnotations = IMapOfSets.empty();
    for (final (p, st)
        in _vtreeIt?.continuations() ?? <(wq.Point, VariationStatus)>[]) {
      _continuationAnnotations = _continuationAnnotations?.add(p, (
        type: AnnotationShape.dot.u21,
        color: switch (st) {
          VariationStatus.correct => Colors.green,
          VariationStatus.wrong => Colors.red,
        },
      ));
    }
    if (_continuationAnnotations?.isNotEmpty ?? false) {
      setState(() {
        // Update board annotations
      });
    }
  }

  _onShare() {
    final link = widget.taskSource.task.deepLink();
    Clipboard.setData(ClipboardData(text: link)).then((void _) {
      if (context.mounted) notifyTaskLinkCopied();
    });
  }
}

class _SideBar extends StatelessWidget {
  final String title;
  final String taskTitle;
  final int taskNumber;
  final int taskCount;
  final wq.Color color;
  final VariationStatus? status;
  final Function()? onShowSolution;
  final Function()? onShare;
  final Function()? onReplay;
  final Function()? onNext;
  final Function() onCancelExam;
  final Widget timeDisplay;

  const _SideBar({
    required this.title,
    required this.taskTitle,
    required this.taskNumber,
    required this.taskCount,
    required this.color,
    this.status,
    required this.onShowSolution,
    required this.onShare,
    required this.onReplay,
    required this.onNext,
    required this.onCancelExam,
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
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => ConfirmDialog(
                        title: 'Confirm',
                        content:
                            'Are you sure that you want to stop the $title?',
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
                    onShowSolution: onShowSolution,
                    onShare: onShare,
                    onNext: onNext,
                    onReplay: onReplay,
                  ),
          ],
        ),
      ),
    );
  }
}

class _ResultDialog extends StatelessWidget {
  final Duration totalTime;
  final bool passed;
  final int mistakeCount;
  final int taskCount;
  final Function() onExit;
  final Function() onRedo;
  final Function()? onNext;

  const _ResultDialog(
      {required this.totalTime,
      required this.passed,
      required this.mistakeCount,
      required this.taskCount,
      required this.onExit,
      required this.onRedo,
      required this.onNext});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: passed
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Icon(Icons.verified), const Text('Passed')],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Icon(Icons.cancel), const Text('Failed')],
            ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Total time'),
            trailing: Text(totalTime.toString().substring(2, 7)),
          ),
          ListTile(
            title: const Text('Avg time per task'),
            trailing: Text(
                '${(totalTime.inSeconds / taskCount).toStringAsFixed(1)}s'),
          ),
          ListTile(
            title: const Text('Mistakes'),
            trailing: Text('$mistakeCount'),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: <Widget>[
        TextButton(
          onPressed: onExit,
          child: const Text('Exit'),
        ),
        TextButton(
          onPressed: onRedo,
          child: const Text('Redo'),
        ),
        if (onNext != null)
          TextButton(
            onPressed: onNext,
            child: const Text('Next'),
          ),
      ],
    );
  }
}
