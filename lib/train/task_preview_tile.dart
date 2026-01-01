import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:wqhub/board/board.dart';
import 'package:wqhub/board/board_settings.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/stats/stats_db.dart';
import 'package:wqhub/train/single_task_page.dart';
import 'package:wqhub/train/task_repository.dart';
import 'package:wqhub/wq/wq.dart' as wq;

class TaskPreviewTile extends StatefulWidget {
  final TaskRef task;
  final bool? solved;
  final TaskSolveStats? solveStats;
  final Function()? onHideTask;

  const TaskPreviewTile({
    super.key,
    required this.task,
    this.solved,
    this.solveStats,
    this.onHideTask,
  });

  @override
  State<TaskPreviewTile> createState() => _TaskPreviewTileState();
}

class _TaskPreviewTileState extends State<TaskPreviewTile> {
  final MenuController _menuController = MenuController();
  late var taskFut = Future(() {
    return TaskRepository()
        .readById(widget.task.rank, widget.task.type, widget.task.id);
  });

  @override
  void didUpdateWidget(covariant TaskPreviewTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.task != oldWidget.task) {
      taskFut = Future(() {
        return TaskRepository()
            .readById(widget.task.rank, widget.task.type, widget.task.id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: taskFut,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final task = snapshot.data;
          if (task == null) {
            return const Text('Not found');
          } else {
            final boardSettings = BoardSettings(
              size: task.boardSize,
              subBoard: SubBoard(
                topLeft: task.topLeft,
                size: task.subBoardSize,
              ),
              theme: context.settings.boardTheme,
              edgeLine: context.settings.edgeLine,
              stoneShadows: context.settings.stoneShadows,
              interactive: false,
            );

            var stones = const IMap<wq.Point, wq.Color>.empty();
            for (final entry in task.initialStones.entries) {
              for (final p in entry.value) {
                stones = stones.add(p, entry.key);
              }
            }

            final board = LayoutBuilder(
              builder: (context, constraints) {
                final boardSize = constraints.biggest.shortestSide -
                    2 * (boardSettings.border?.size ?? 0);
                return Board(
                  size: boardSize,
                  settings: boardSettings,
                  cursor: SystemMouseCursors.click,
                  turn: null,
                  stones: stones,
                  annotations: const IMapOfSetsConst(IMapConst({})),
                  confirmTap: context.settings.confirmMoves,
                );
              },
            );

            return Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        SingleTaskPage.routeName,
                        arguments: SingleTaskRouteArguments(task: task),
                      );
                    },
                    onLongPressStart: (details) {
                      _menuController.open(position: details.localPosition);
                    },
                    onSecondaryTapDown: (details) {
                      _menuController.open(position: details.localPosition);
                    },
                    child: MenuAnchor(
                      controller: _menuController,
                      menuChildren: <Widget>[
                        MenuItemButton(
                          onPressed: () => widget.onHideTask?.call(),
                          child: const Text('Hide task'),
                        ),
                      ],
                      child: Center(
                        child: board,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (widget.solved != null)
                      switch (widget.solved!) {
                        true => Icon(Icons.check, color: Colors.green),
                        false => Icon(Icons.close, color: Colors.red),
                      },
                    Text(widget.task.rank.toString()),
                    if (widget.solveStats != null)
                      Text(
                          '${widget.solveStats!.correctAttempts} / ${widget.solveStats!.correctAttempts + widget.solveStats!.wrongAttempts}',
                          style: TextTheme.of(context).labelSmall),
                  ],
                )
              ],
            );
          }
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
