import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/stats/stats_db.dart';
import 'package:wqhub/train/task_action_bar.dart';
import 'package:wqhub/train/task_repository.dart';
import 'package:wqhub/train/task_solving_state_mixin.dart';
import 'package:wqhub/train/upsolve_mode.dart';
import 'package:wqhub/turn_icon.dart';
import 'package:wqhub/board/board.dart';
import 'package:wqhub/board/board_settings.dart';
import 'package:wqhub/board/coordinate_style.dart';
import 'package:wqhub/train/task_source/task_source.dart';
import 'package:wqhub/train/variation_tree.dart';
import 'package:wqhub/wq/rank.dart';
import 'package:wqhub/wq/wq.dart' as wq;

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
          onPointClicked: (p) => onMove(p, wideLayout),
          turn: turn,
          stones: gameTree.stones,
          annotations: continuationAnnotations ?? gameTree.annotations,
          confirmTap: context.settings.confirmMoves,
        );
      },
    );

    final taskTitle =
        '[${widget.taskSource.task.rank.toString()}] ${widget.taskSource.task.type.toLocalizedString(loc)}';

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
                status: solveStatus,
                upsolveMode: upsolveMode,
                onShowSolution: onShowContinuations,
                onPlayVariation: onPlaySolution,
                onShareTask: onShareTask,
                onCopySgf: onCopySgf,
                onResetTask: onResetTask,
                onNextTask: onNextTask,
                onPreviousMove: onPreviousMove,
                onNextMove: onNextMove,
                onUpdateUpsolveMode: onUpdateUpsolveMode,
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
          height: upsolveMode == UpsolveMode.auto ? 80.0 : 160.0,
          child: (solveStatus == null)
              ? Center(child: rankDisplay)
              : TaskActionBar(
                  upsolveMode: upsolveMode,
                  onShowSolution: onShowContinuations,
                  onPlayVariation: onPlaySolution,
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
    } else {
      context.stats.incrementTotalFailCount(currentTask.rank);
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

class _SideBar extends StatelessWidget {
  final String taskTitle;
  final int taskNumber;
  final wq.Color color;
  final VariationStatus? status;
  final UpsolveMode upsolveMode;
  final Function()? onShowSolution;
  final Function()? onPlayVariation;
  final Function()? onShareTask;
  final Function()? onCopySgf;
  final Function()? onResetTask;
  final Function()? onNextTask;
  final Function() onPreviousMove;
  final Function() onNextMove;
  final Function(UpsolveMode) onUpdateUpsolveMode;
  final Widget timeDisplay;

  const _SideBar({
    required this.taskTitle,
    required this.taskNumber,
    required this.color,
    this.status,
    required this.upsolveMode,
    required this.onShowSolution,
    this.onPlayVariation,
    required this.onShareTask,
    this.onCopySgf,
    required this.onResetTask,
    required this.onNextTask,
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
                    upsolveMode: upsolveMode,
                    onShowSolution: onShowSolution,
                    onPlayVariation: onPlayVariation,
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
