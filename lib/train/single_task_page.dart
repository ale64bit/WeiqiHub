import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/train/task_action_bar.dart';
import 'package:wqhub/train/task_repository.dart';
import 'package:wqhub/train/task_solving_state_mixin.dart';
import 'package:wqhub/train/upsolve_mode.dart';
import 'package:wqhub/turn_icon.dart';
import 'package:wqhub/board/board.dart';
import 'package:wqhub/board/board_settings.dart';
import 'package:wqhub/board/coordinate_style.dart';
import 'package:wqhub/train/variation_tree.dart';
import 'package:wqhub/wq/wq.dart' as wq;

class SingleTaskRouteArguments {
  final Task task;

  const SingleTaskRouteArguments({required this.task});
}

class SingleTaskPage extends StatefulWidget {
  static const routeName = '/task';

  const SingleTaskPage({super.key, required this.task});

  final Task task;

  @override
  State<SingleTaskPage> createState() => _SingleTaskPageState();
}

class _SingleTaskPageState extends State<SingleTaskPage>
    with TaskSolvingStateMixin {
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
          onPointClicked: (p) => onMove(p, wideLayout),
          turn: turn,
          stones: gameTree.stones,
          annotations: continuationAnnotations ?? gameTree.annotations,
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
                upsolveMode: upsolveMode,
                onShowSolution: onShowContinuations,
                onShareTask: onShareTask,
                onResetTask: onResetTask,
                onPreviousMove: onPreviousMove,
                onNextMove: onNextMove,
                onUpdateUpsolveMode: onUpdateUpsolveMode,
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
          height: upsolveMode == UpsolveMode.auto ? 80.0 : 160.0,
          child: TaskActionBar(
            upsolveMode: upsolveMode,
            onShowSolution: onShowContinuations,
            onShareTask: onShareTask,
            onResetTask: onResetTask,
            onPreviousMove: onPreviousMove,
            onNextMove: onNextMove,
            onUpdateUpsolveMode: onUpdateUpsolveMode,
          ),
        ),
      );
    }
  }

  @override
  Task get currentTask => widget.task;

  @override
  void onSolveStatus(VariationStatus status) {}
}

class _SideBar extends StatelessWidget {
  final String taskTitle;
  final wq.Color color;
  final UpsolveMode upsolveMode;
  final Function()? onShowSolution;
  final Function()? onShareTask;
  final Function()? onResetTask;
  final Function() onPreviousMove;
  final Function() onNextMove;
  final Function(UpsolveMode) onUpdateUpsolveMode;
  final Widget timeDisplay;

  const _SideBar({
    required this.taskTitle,
    required this.color,
    required this.upsolveMode,
    required this.onShowSolution,
    required this.onShareTask,
    required this.onResetTask,
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
            TaskActionBar(
              upsolveMode: upsolveMode,
              onShowSolution: onShowSolution,
              onShareTask: onShareTask,
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
