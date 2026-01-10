import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:wqhub/board/board.dart';
import 'package:wqhub/board/board_annotation.dart';
import 'package:wqhub/board/board_settings.dart';
import 'package:wqhub/board/coordinate_style.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/train/task.dart';
import 'package:wqhub/wq/wq.dart' as wq;

class TaskBoard extends StatelessWidget {
  final Task task;
  final wq.Color turn;
  final IMap<wq.Point, wq.Color> stones;
  final IMapOfSets<wq.Point, Annotation> annotations;
  final bool dismissable;
  final Function(wq.Point) onPointClicked;
  final Function() onDismissed;

  const TaskBoard({
    super.key,
    required this.task,
    required this.turn,
    required this.stones,
    required this.annotations,
    required this.dismissable,
    required this.onPointClicked,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
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
      size: task.boardSize,
      subBoard: SubBoard(
        topLeft: task.topLeft,
        size: task.subBoardSize,
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
          onPointClicked: onPointClicked,
          turn: turn,
          stones: stones,
          annotations: annotations,
          confirmTap: context.settings.confirmMoves,
        );
      },
    );

    return Dismissible(
      key: ValueKey(task.id),
      resizeDuration: null,
      direction:
          dismissable ? DismissDirection.endToStart : DismissDirection.none,
      onDismissed: (_) => onDismissed(),
      child: Center(child: board),
    );
  }
}
