import 'dart:math';

import 'package:extension_type_unions/extension_type_unions.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wqhub/audio/audio_controller.dart';
import 'package:wqhub/board/board_annotation.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/train/response_delay.dart';
import 'package:wqhub/train/solve_status_notifier.dart';
import 'package:wqhub/train/task_action_bar.dart';
import 'package:wqhub/train/task_repository.dart';
import 'package:wqhub/turn_icon.dart';
import 'package:wqhub/wq/annotated_game_tree.dart';
import 'package:wqhub/board/board.dart';
import 'package:wqhub/board/board_settings.dart';
import 'package:wqhub/board/coordinate_style.dart';
import 'package:wqhub/train/variation_tree.dart';
import 'package:wqhub/wq/wq.dart' as wq;

class SingleTaskPage extends StatefulWidget {
  const SingleTaskPage({super.key, required this.task});

  final Task task;

  @override
  State<SingleTaskPage> createState() => _SingleTaskPageState();
}

class _SingleTaskPageState extends State<SingleTaskPage>
    with SolveStatusNotifier {
  VariationTreeIterator? _vtreeIt;
  var _gameTree = AnnotatedGameTree(19);
  var _turn = wq.Color.black;
  VariationStatus? _solveStatus;
  bool _solveStatusNotified = false;
  IMapOfSets<wq.Point, Annotation>? _continuationAnnotations;

  @override
  void initState() {
    super.initState();
    _setupCurrentTask();
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
      size: widget.task.boardSize,
      subBoard: SubBoard(
        topLeft: widget.task.topLeft,
        size: widget.task.subBoardSize,
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
        '[${widget.task.rank.toString()}] ${widget.task.type.toString()}';

    if (wideLayout) {
      return Scaffold(
        body: Center(
          child: Row(
            children: <Widget>[
              Expanded(child: Center(child: board)),
              VerticalDivider(thickness: 1, width: 8),
              _SideBar(
                taskTitle: taskTitle,
                color: widget.task.first,
                status: _solveStatus,
                onShowSolution: _onShowContinuations,
                onShare: _onShare,
                onReplay: _onReplay,
                timeDisplay: Text(widget.task.deepLink()),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            spacing: 4,
            children: <Widget>[
              TurnIcon(color: widget.task.first),
              Text(taskTitle),
            ],
          ),
        ),
        body: Center(
          child: board,
        ),
        bottomNavigationBar: BottomAppBar(
          child: (_solveStatus == null)
              ? Center(child: Text(widget.task.deepLink()))
              : TaskActionBar(
                  onShowSolution: _onShowContinuations,
                  onShare: _onShare,
                  onReplay: _onReplay,
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

  void _setupCurrentTask() {
    _continuationAnnotations = null;
    _vtreeIt = VariationTreeIterator(tree: widget.task.variationTree);
    _gameTree = AnnotatedGameTree(widget.task.boardSize);
    for (final entry in widget.task.initialStones.entries) {
      for (final p in entry.value) {
        _gameTree
            .moveAnnotated((col: entry.key, p: p), mode: AnnotationMode.none);
      }
    }
    _turn = widget.task.first;
    _solveStatusNotified = false;
  }

  void _onPointClicked(wq.Point p, bool wideLayout) {
    if (!(_solveStatusNotified || _turn == widget.task.first)) {
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
      _solveStatus = status;
      if (status == VariationStatus.correct) {
        if (context.settings.sound) AudioController().correct();
      } else {
        if (context.settings.sound) AudioController().wrong();
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
    final link = widget.task.deepLink();
    Clipboard.setData(ClipboardData(text: link)).then((void _) {
      if (context.mounted) notifyTaskLinkCopied();
    });
  }
}

class _SideBar extends StatelessWidget {
  final String taskTitle;
  final wq.Color color;
  final VariationStatus? status;
  final Function()? onShowSolution;
  final Function()? onShare;
  final Function()? onReplay;
  final Widget timeDisplay;

  const _SideBar({
    required this.taskTitle,
    required this.color,
    this.status,
    required this.onShowSolution,
    required this.onShare,
    required this.onReplay,
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
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
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
                    onReplay: onReplay,
                  ),
          ],
        ),
      ),
    );
  }
}
