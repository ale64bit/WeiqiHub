import 'package:flutter/material.dart';
import 'package:wqhub/train/task_action_bar.dart';
import 'package:wqhub/train/upsolve_mode.dart';
import 'package:wqhub/turn_icon.dart';
import 'package:wqhub/wq/wq.dart' as wq;
import 'dart:math';

class TaskSideBar extends StatelessWidget {
  final Widget child;
  final String taskTitle;
  final wq.Color color;
  final UpsolveMode? upsolveMode;
  final Function()? onShowSolution;
  final Function()? onShareTask;
  final Function()? onCopySgf;
  final Function()? onResetTask;
  final Function()? onNextTask;
  final Function()? onPreviousMove;
  final Function()? onNextMove;
  final Function(UpsolveMode)? onUpdateUpsolveMode;
  final Widget? timeDisplay;
  final String? notificationMessage;
  final Color? notificationColor;
  final IconData? notificationIcon;
  final Widget? leading;
  final List<Widget>? actions;
  final List<Widget>? footer;

  const TaskSideBar({
    super.key,
    required this.child,
    required this.taskTitle,
    required this.color,
    this.upsolveMode,
    this.onShowSolution,
    this.onShareTask,
    this.onCopySgf,
    this.onResetTask,
    this.onNextTask,
    this.onPreviousMove,
    this.onNextMove,
    this.onUpdateUpsolveMode,
    this.timeDisplay,
    this.notificationMessage,
    this.notificationColor,
    this.notificationIcon,
    this.leading,
    this.actions,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    final wideLayout = MediaQuery.sizeOf(context).aspectRatio > 1.5;

    final bottomBar = (timeDisplay != null ||
            (upsolveMode != null &&
                onPreviousMove != null &&
                onNextMove != null &&
                onUpdateUpsolveMode != null))
        ? BottomAppBar(
            height: upsolveMode == UpsolveMode.manual ? 160.0 : 80.0,
            color: wideLayout ? Colors.transparent : null,
            child: timeDisplay ??
                TaskActionBar(
                  upsolveMode: upsolveMode!,
                  onShowSolution: onShowSolution,
                  onShareTask: onShareTask,
                  onCopySgf: onCopySgf,
                  onResetTask: onResetTask,
                  onNextTask: onNextTask,
                  onPreviousMove: onPreviousMove!,
                  onNextMove: onNextMove!,
                  onUpdateUpsolveMode: onUpdateUpsolveMode!,
                ),
          )
        : null;

    if (wideLayout) {
      final widgetSize = MediaQuery.sizeOf(context);
      final sidebarSize = min(widgetSize.longestSide - widgetSize.shortestSide,
          widgetSize.width / 3);

      return Scaffold(
        body: Center(
          child: Row(
            children: <Widget>[
              Expanded(child: Center(child: child)),
              const VerticalDivider(thickness: 1, width: 8),
              SizedBox(
                width: sidebarSize,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  child: Column(
                    children: <Widget>[
                      if (leading != null || (actions?.isNotEmpty ?? false))
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: [
                              if (leading != null)
                                (actions == null || actions!.isEmpty)
                                    ? leading!
                                    : Expanded(child: leading!),
                              if (actions != null) ...actions!,
                            ],
                          ),
                        ),
                      Row(
                        spacing: 8,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TurnIcon(color: color),
                          Flexible(
                              child: Text(taskTitle,
                                  style:
                                      Theme.of(context).textTheme.titleMedium)),
                        ],
                      ),
                      const Spacer(),
                      if (notificationMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                              color: notificationColor ?? Colors.blue,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (notificationIcon != null) ...[
                                  Icon(notificationIcon, color: Colors.white),
                                  const SizedBox(width: 8),
                                ],
                                Flexible(
                                  child: Text(
                                    notificationMessage!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (footer != null) ...footer!,
                      if (bottomBar != null)
                        SizedBox(
                          height:
                              upsolveMode == UpsolveMode.manual ? 160.0 : 80.0,
                          child: bottomBar,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          leading: leading,
          title: Row(
            spacing: 4,
            children: <Widget>[
              TurnIcon(color: color),
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
          actions: actions,
        ),
        body: Center(
          child: child,
        ),
        bottomNavigationBar: bottomBar,
      );
    }
  }
}
