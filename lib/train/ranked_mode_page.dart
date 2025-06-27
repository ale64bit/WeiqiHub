import 'dart:math';

import 'package:extension_type_unions/extension_type_unions.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wqhub/audio/audio_controller.dart';
import 'package:wqhub/board/board_annotation.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
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
import 'package:wqhub/train/variation_tree.dart';
import 'package:wqhub/wq/rank.dart';
import 'package:wqhub/wq/wq.dart' as wq;

class RankedModePage extends StatefulWidget {
  const RankedModePage({super.key, required this.taskSource});

  final TaskSource taskSource;

  @override
  State<RankedModePage> createState() => _RankedModePageState();
}

class _RankedModePageState extends State<RankedModePage>
    with SolveStatusNotifier {
  final _stopwatch = Stopwatch();
  VariationTreeIterator? _vtreeIt;
  var _gameTree = AnnotatedGameTree(19);
  var _turn = wq.Color.black;
  var _taskNumber = 1;
  VariationStatus? _solveStatus;
  bool _solveStatusNotified = false;
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

    final rankDisplay = Text(Rank.decimalString(widget.taskSource.rank),
        style: TextTheme.of(context).titleLarge);

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
                timeDisplay: rankDisplay,
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          leading: Center(child: Text('$_taskNumber')),
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
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
          ],
        ),
        body: Center(
          child: board,
        ),
        bottomNavigationBar: BottomAppBar(
          child: (_solveStatus == null)
              ? Center(child: rankDisplay)
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
    widget.taskSource.next(
        _solveStatus ?? VariationStatus.wrong, _stopwatch.elapsed,
        onRankChanged: context.stats.updateRankedModeRank);
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
      _stopwatch.stop();
      _solveStatus = status;

      final curTask = widget.taskSource.task;
      StatsDB().addTaskAttempt(curTask.rank, curTask.type, curTask.id,
          status == VariationStatus.correct);
      if (status == VariationStatus.correct) {
        if (context.settings.sound) AudioController().correct();
        context.stats.incrementTotalPassCount(curTask.rank);
      } else {
        if (context.settings.sound) AudioController().wrong();
        context.stats.incrementTotalFailCount(curTask.rank);
      }
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
                  '$taskNumber',
                  textAlign: TextAlign.center,
                )),
                IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
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
