import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/train/task.dart';
import 'package:wqhub/train/task_action_bar.dart';
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
  void initState() {
    super.initState();
    // NEW: Enable sidebar notifications for this page
    enableSidebarNotifications(() {
      if (mounted) setState(() {}); // Rebuild when notification changes
    });
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
        '[${widget.task.ref.rank.toString()}] ${widget.task.ref.type.toLocalizedString(loc)}';

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
                onCopySgf: onCopySgf,
                onResetTask: onResetTask,
                onPreviousMove: onPreviousMove,
                onNextMove: onNextMove,
                onUpdateUpsolveMode: onUpdateUpsolveMode,
                timeDisplay: Text(widget.task.ref.uri()),
                notificationMessage: notificationMessage,
                notificationColor: notificationColor,
                notificationIcon: notificationIcon,
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
            onCopySgf: onCopySgf,
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
  final Function()? onCopySgf;
  final Function()? onResetTask;
  final Function() onPreviousMove;
  final Function() onNextMove;
  final Function(UpsolveMode) onUpdateUpsolveMode;
  final Widget timeDisplay;
  final String? notificationMessage;
  final Color? notificationColor;
  final IconData? notificationIcon;

  const _SideBar({
    required this.taskTitle,
    required this.color,
    required this.upsolveMode,
    required this.onShowSolution,
    required this.onShareTask,
    this.onCopySgf,
    required this.onResetTask,
    required this.onPreviousMove,
    required this.onNextMove,
    required this.onUpdateUpsolveMode,
    required this.timeDisplay,
    this.notificationMessage,
    this.notificationColor,
    this.notificationIcon,
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
            if (notificationMessage != null) ...[
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: notificationColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 8,
                  children: [
                    Icon(notificationIcon, color: Colors.white),
                    Flexible(
                      child: Text(
                        notificationMessage!,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            TaskActionBar(
              upsolveMode: upsolveMode,
              onShowSolution: onShowSolution,
              onShareTask: onShareTask,
              onCopySgf: onCopySgf,
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
