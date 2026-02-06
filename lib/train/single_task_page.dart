import 'package:flutter/material.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/train/task.dart';
import 'package:wqhub/train/task_side_bar.dart';
import 'package:wqhub/train/task_solving_state_mixin.dart';
import 'package:wqhub/board/board.dart';
import 'package:wqhub/board/board_settings.dart';
import 'package:wqhub/board/coordinate_style.dart';
import 'package:wqhub/train/variation_tree.dart';

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

    return TaskSideBar(
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
      notificationMessage: notificationMessage,
      notificationColor: notificationColor,
      notificationIcon: notificationIcon,
      leading: wideLayout
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            )
          : null,
      child: board,
    );
  }

  @override
  Task get currentTask => widget.task;

  @override
  void onSolveStatus(VariationStatus status) {}
}
