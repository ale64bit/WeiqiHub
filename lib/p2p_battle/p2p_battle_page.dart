import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wqhub/confirm_dialog.dart';
import 'package:wqhub/p2p_battle/p2p_client.dart';
import 'package:wqhub/p2p_battle/p2p_models.dart';
import 'package:wqhub/p2p_battle/p2p_results_page.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/train/task.dart';
import 'package:wqhub/train/task_db.dart';
import 'package:wqhub/train/task_board.dart';
import 'package:wqhub/train/task_solving_state_mixin.dart';
import 'package:wqhub/train/variation_tree.dart';
import 'package:wqhub/time_display.dart';
import 'package:wqhub/turn_icon.dart';
import 'package:wqhub/game_client/time_state.dart';
import 'package:wqhub/wq/wq.dart' as wq;

class P2PBattleArguments {
  final P2PClient client;
  final P2PRoomSettings settings;
  final DateTime startTime;
  final String roomId;
  final String playerName;

  P2PBattleArguments({
    required this.client,
    required this.settings,
    required this.startTime,
    required this.roomId,
    required this.playerName,
  });
}

class P2PBattlePage extends StatefulWidget {
  static const routeName = '/p2p/battle';
  final P2PBattleArguments args;

  const P2PBattlePage({super.key, required this.args});

  @override
  State<P2PBattlePage> createState() => _P2PBattlePageState();
}

class _P2PBattlePageState extends State<P2PBattlePage>
    with TaskSolvingStateMixin {
  int _currentIndex = 0;
  int _solveCount = 0;
  int _attemptCount = 0;
  final Map<String, bool> _resultsMap = {};
  bool _isFinished = false;

  late List<Task> _tasks;

  @override
  void initState() {
    super.initState();
    widget.args.client.onBattleFinished = () {
      if (mounted) {
        _showResults();
      }
    };
  }

  @override
  Task get currentTask => _tasks[_currentIndex];

  @override
  void onSolveStatus(VariationStatus status) {
    if (status == VariationStatus.correct) {
      _solveCount++;
      _resultsMap[currentTask.ref.uri()] = true;
    } else {
      _resultsMap[currentTask.ref.uri()] = false;
    }
    _attemptCount++;
    _nextTask();
  }

  void _nextTask() {
    if (_currentIndex < _tasks.length - 1) {
      setState(() {
        _currentIndex++;
        setupCurrentTask();
        solveStatus = null;
      });
    } else {
      _finishBattle();
    }
  }

  void _finishBattle() {
    if (_isFinished) return;
    final diff = DateTime.now().difference(widget.args.startTime);
    try {
      widget.args.client.submitResults({
        'solveCount': _solveCount,
        'attemptCount': _attemptCount,
        'results': _resultsMap,
        'timeTakenMs': diff.inMilliseconds,
      });
    } catch (e) {
      print('Error submitting results: $e');
    }
    _showResults();
  }

  void _showResults() {
    if (_isFinished) return;
    setState(() => _isFinished = true);
    Navigator.pushReplacementNamed(
      context,
      P2PResultsPage.routeName,
      arguments: P2PResultsArguments(
        client: widget.args.client,
        roomId: widget.args.roomId,
        playerName: widget.args.playerName,
      ),
    );
  }

  @override
  void dispose() {
    if (!_isFinished) {
      widget.args.client.disconnect();
    }
    super.dispose();
  }

  bool _tasksInitialized = false;

  @override
  void didChangeDependencies() {
    if (!_tasksInitialized) {
      _tasks = widget.args.settings.taskUris
          .map((uri) {
            var task = TaskDB().getByUri(uri);
            if (task != null && context.settings.alwaysBlackToPlay) {
              task = task.withBlackToPlay();
            }
            return task;
          })
          .whereType<Task>()
          .toList();

      if (_tasks.isEmpty) {
        _tasksInitialized = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No tasks could be loaded.')));
          Navigator.pop(context);
        });
        return;
      }
      _tasksInitialized = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final diff = DateTime.now().difference(widget.args.startTime);
    final remainingTime =
        Duration(seconds: widget.args.settings.timeLimitSeconds) - diff;

    if (remainingTime <= Duration.zero && !_isFinished) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _finishBattle());
    }

    final wideLayout = MediaQuery.sizeOf(context).aspectRatio > 1.5;

    final boardArea = TaskBoard(
      task: currentTask,
      stones: gameTree.stones,
      turn: turn,
      annotations: continuationAnnotations ?? gameTree.annotations,
      onPointClicked: (p) => onMove(p, wideLayout),
      dismissable: false,
      onDismissed: () {},
    );

    final taskTitle =
        '[${currentTask.ref.rank.toString()}] ${currentTask.ref.type.name}';

    final timeDisplay = TimeDisplay(
      timeState: TimeState(
        mainTimeLeft: remainingTime,
        periodTimeLeft: Duration.zero,
        periodCount: 0,
      ),
      warningDuration: const Duration(seconds: 9),
      enabled: !_isFinished,
      tickerEnabled: true,
      voiceCountdown: true,
      onTimeout: _finishBattle,
    );

    if (wideLayout) {
      return Scaffold(
        body: Center(
          child: Row(
            children: <Widget>[
              Expanded(child: boardArea),
              VerticalDivider(thickness: 1, width: 8),
              _SideBar(
                taskTitle: taskTitle,
                taskNumber: _currentIndex + 1,
                taskCount: _tasks.length,
                color: currentTask.first,
                timeDisplay: timeDisplay,
                onCancelBattle: () {
                  showDialog(
                    context: context,
                    builder: (context) => ConfirmDialog(
                      title: 'Confirm',
                      content: 'Do you want to stop the battle?',
                      onYes: () =>
                          Navigator.popUntil(context, (route) => route.isFirst),
                      onNo: () => Navigator.pop(context),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: Center(child: Text('${_currentIndex + 1}/${_tasks.length}')),
        title: Row(
          spacing: 4,
          children: <Widget>[
            TurnIcon(color: currentTask.first),
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
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => ConfirmDialog(
                  title: 'Confirm',
                  content: 'Do you want to stop the battle?',
                  onYes: () =>
                      Navigator.popUntil(context, (route) => route.isFirst),
                  onNo: () => Navigator.pop(context),
                ),
              );
            },
          ),
        ],
      ),
      body: boardArea,
      bottomNavigationBar: BottomAppBar(
        child: timeDisplay,
      ),
    );
  }
}

class _SideBar extends StatelessWidget {
  final String taskTitle;
  final int taskNumber;
  final int taskCount;
  final wq.Color color;
  final Widget timeDisplay;
  final VoidCallback onCancelBattle;

  const _SideBar({
    required this.taskTitle,
    required this.taskNumber,
    required this.taskCount,
    required this.color,
    required this.timeDisplay,
    required this.onCancelBattle,
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
                    '$taskNumber/$taskCount',
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: onCancelBattle,
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
