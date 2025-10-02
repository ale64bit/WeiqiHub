import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wqhub/game_client/time_state.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/time_display.dart';
import 'package:wqhub/confirm_dialog.dart';
import 'package:wqhub/train/task_repository.dart';
import 'package:wqhub/train/task_solving_state_mixin.dart';
import 'package:wqhub/turn_icon.dart';
import 'package:wqhub/board/board.dart';
import 'package:wqhub/board/board_settings.dart';
import 'package:wqhub/board/coordinate_style.dart';
import 'package:wqhub/train/task_source/task_source.dart';
import 'package:wqhub/train/variation_tree.dart';
import 'package:wqhub/wq/rank.dart';
import 'package:wqhub/wq/wq.dart' as wq;

class TimeFrenzyRouteArguments {
  final TaskSource taskSource;

  const TimeFrenzyRouteArguments({required this.taskSource});
}

class TimeFrenzyPage extends StatefulWidget {
  static const routeName = '/train/time_frenzy';

  const TimeFrenzyPage({super.key, required this.taskSource});

  final TaskSource taskSource;

  @override
  State<TimeFrenzyPage> createState() => _TimeFrenzyPageState();
}

const _sessionLength = Duration(minutes: 3);

class _TimeFrenzyPageState extends State<TimeFrenzyPage>
    with TaskSolvingStateMixin {
  final _timeDisplayKey = GlobalKey(debugLabel: 'time-display');
  final _stopwatch = Stopwatch();
  var _taskNumber = 1;
  var _mistakeCount = 0;
  var _solveCount = 0;
  Rank _maxRank = Rank.k15;

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
          annotations: gameTree.annotations,
          confirmTap: context.settings.confirmMoves,
        );
      },
    );

    final taskTitle =
        '[${widget.taskSource.task.rank.toString()}] ${widget.taskSource.task.type.toLocalizedString(loc)}';

    final timeDisplay = TimeDisplay(
      key: _timeDisplayKey,
      timeState: const TimeState(
        mainTimeLeft: _sessionLength,
        periodTimeLeft: Duration.zero,
        periodCount: 0,
      ),
      warningDuration: Duration(seconds: 9),
      enabled: _mistakeCount < 3,
      tickerEnabled: true,
      voiceCountdown: false,
      onTimeout: _endRun,
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
                timeDisplay: timeDisplay,
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
              TurnIcon(color: widget.taskSource.task.first),
              Text(taskTitle),
            ],
          ),
          leading: Center(child: Text('$_taskNumber')),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => ConfirmDialog(
                    title: loc.confirm,
                    content:
                        'Are you sure that you want to stop the Time Frenzy?',
                    onYes: () =>
                        Navigator.popUntil(context, (route) => route.isFirst),
                    onNo: () => Navigator.pop(context),
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
          child: timeDisplay,
        ),
      );
    }
  }

  @override
  Task get currentTask => widget.taskSource.task;

  @override
  void onSolveStatus(VariationStatus status) {
    if (status == VariationStatus.correct) {
      _solveCount++;
    } else {
      _mistakeCount++;
      if (_mistakeCount == 3) {
        _endRun();
        return;
      }
    }
    widget.taskSource.next(status, _stopwatch.elapsed);
    _taskNumber++;
    if (widget.taskSource.task.rank.index > _maxRank.index) {
      _maxRank = widget.taskSource.task.rank;
    }
    setupCurrentTask();
    _stopwatch.reset();
    solveStatus = null;
  }

  void _endRun() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _ResultDialog(
        solveCount: _solveCount,
        maxRank: _maxRank,
      ),
    );
    context.stats.updateTimeFrenzyHighScore(_solveCount);
    setState(() {/* Stop the timer */});
  }
}

class _SideBar extends StatelessWidget {
  final String taskTitle;
  final int taskNumber;
  final wq.Color color;
  final Widget timeDisplay;

  const _SideBar(
      {required this.taskTitle,
      required this.taskNumber,
      required this.color,
      required this.timeDisplay});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
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
                    showDialog(
                      context: context,
                      builder: (context) => ConfirmDialog(
                        title: loc.confirm,
                        content:
                            'Are you sure that you want to stop the Time Frenzy?',
                        onYes: () => Navigator.popUntil(
                            context, (route) => route.isFirst),
                        onNo: () => Navigator.pop(context),
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
            timeDisplay,
          ],
        ),
      ),
    );
  }
}

class _ResultDialog extends StatelessWidget {
  final int solveCount;
  final Rank maxRank;

  const _ResultDialog({required this.solveCount, required this.maxRank});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(loc.result),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Tasks solved'),
            trailing: Text('$solveCount'),
          ),
          ListTile(
            title: Text(loc.maxRank),
            trailing: Text(maxRank.toString()),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text(loc.ok),
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
      ],
    );
  }
}
