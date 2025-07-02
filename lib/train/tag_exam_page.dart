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
import 'package:wqhub/train/rank_range.dart';
import 'package:wqhub/train/response_delay.dart';
import 'package:wqhub/train/solve_status_notifier.dart';
import 'package:wqhub/train/task_action_bar.dart';
import 'package:wqhub/train/task_repository.dart';
import 'package:wqhub/train/task_source/const_task_source.dart';
import 'package:wqhub/train/task_tag.dart';
import 'package:wqhub/turn_icon.dart';
import 'package:wqhub/wq/annotated_game_tree.dart';
import 'package:wqhub/board/board.dart';
import 'package:wqhub/board/board_settings.dart';
import 'package:wqhub/board/coordinate_style.dart';
import 'package:wqhub/train/task_source/task_source.dart';
import 'package:wqhub/time_display.dart';
import 'package:wqhub/train/variation_tree.dart';
import 'package:wqhub/wq/wq.dart' as wq;

class TagExamPage extends StatefulWidget {
  const TagExamPage(
      {super.key,
      required this.tag,
      required this.rankRange,
      required this.taskSource});

  final TaskTag tag;
  final RankRange rankRange;
  final TaskSource taskSource;

  @override
  State<TagExamPage> createState() => _TagExamPageState();
}

const _timePerTask = Duration(seconds: 300);

class _TagExamPageState extends State<TagExamPage> with SolveStatusNotifier {
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
      timeState: const TimeState(
        mainTimeLeft: _timePerTask,
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
                taskTitle: taskTitle,
                taskNumber: _taskNumber,
                color: widget.taskSource.task.first,
                status: _solveStatus,
                onShowSolution: _onShowContinuations,
                onShare: _onShare,
                onReplay: _onReplay,
                onNext: _onNext,
                onCancelExam: () {
                  context.stats
                      .incrementTagExamFailCount(widget.tag, widget.rankRange);
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
          leading: Center(child: Text('$_taskNumber/10')),
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
                        'Are you sure that you want to stop the Topic Exam?',
                    onYes: () {
                      context.stats.incrementTagExamFailCount(
                          widget.tag, widget.rankRange);
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
    if (_taskNumber == 10) {
      if (_mistakeCount <= 2) {
        context.stats.incrementTagExamPassCount(widget.tag, widget.rankRange);
      } else {
        context.stats.incrementTagExamFailCount(widget.tag, widget.rankRange);
      }
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => _ResultDialog(
          totalTime: _totalTime,
          mistakeCount: _mistakeCount,
          onExit: () => Navigator.popUntil(context, (route) => route.isFirst),
          onRedo: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PopScope(
                  canPop: false,
                  child: TagExamPage(
                    tag: widget.tag,
                    rankRange: widget.rankRange,
                    taskSource: ConstTaskSource(
                        tasks: TaskRepository()
                            .readByTag(widget.tag, widget.rankRange, 10)),
                  ),
                ),
              ),
            );
          },
          onNext: null,
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
      _totalTime += _timePerTask;
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
  final String taskTitle;
  final int taskNumber;
  final wq.Color color;
  final VariationStatus? status;
  final Function()? onShowSolution;
  final Function()? onShare;
  final Function()? onReplay;
  final Function()? onNext;
  final Function() onCancelExam;
  final Widget timeDisplay;

  const _SideBar({
    required this.taskTitle,
    required this.taskNumber,
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
                  '$taskNumber/10',
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
                            'Are you sure that you want to stop the Topic Exam?',
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
  final int mistakeCount;
  final Function() onExit;
  final Function() onRedo;
  final Function()? onNext;

  const _ResultDialog(
      {required this.totalTime,
      required this.mistakeCount,
      required this.onExit,
      required this.onRedo,
      required this.onNext});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: (mistakeCount <= 2)
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
            trailing: Text('${(totalTime.inSeconds / 10).toStringAsFixed(1)}s'),
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
