import 'package:flutter/material.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/train/upsolve_mode.dart';

class TaskActionBar extends StatelessWidget {
  static const fastMoveNavCount = 5;

  final UpsolveMode upsolveMode;
  final Function()? onShowSolution;
  final Function()? onShareTask;
  final Function()? onCopySgf;
  final Function()? onHideTask;
  final Function()? onResetTask;
  final Function()? onNextTask;
  final Function() onPreviousMove;
  final Function() onNextMove;
  final Function(UpsolveMode) onUpdateUpsolveMode;

  const TaskActionBar({
    super.key,
    required this.upsolveMode,
    this.onShowSolution,
    this.onShareTask,
    this.onCopySgf,
    this.onHideTask,
    this.onResetTask,
    this.onNextTask,
    required this.onPreviousMove,
    required this.onNextMove,
    required this.onUpdateUpsolveMode,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final backButton = Expanded(
      child: IconButton(
        icon: Icon(Icons.undo),
        onPressed: () => onUpdateUpsolveMode(UpsolveMode.auto),
      ),
    );
    final menuButton = Expanded(
      child: PopupMenuButton(
        icon: Icon(Icons.menu),
        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
          PopupMenuItem(
            onTap: onShareTask,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 8.0,
              children: <Widget>[
                Icon(Icons.share),
                Text(loc.copyTaskLink),
              ],
            ),
          ),
          PopupMenuItem(
            onTap: onCopySgf,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 8.0,
              children: <Widget>[
                Icon(Icons.copy),
                Text(loc.copySGF),
              ],
            ),
          ),
          PopupMenuItem(
            onTap: () => onUpdateUpsolveMode(UpsolveMode.manual),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 8.0,
              children: switch (upsolveMode) {
                UpsolveMode.auto => <Widget>[
                    Icon(Icons.touch_app),
                    Text(loc.tryCustomMoves),
                  ],
                UpsolveMode.manual => <Widget>[
                    Icon(Icons.touch_app),
                    Text(loc.exitTryMode),
                  ],
              },
            ),
          ),
          if (onHideTask != null)
            PopupMenuItem(
              onTap: onHideTask,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 8.0,
                children: <Widget>[
                  Icon(Icons.visibility_off),
                  Text(loc.hideTask),
                ],
              ),
            ),
        ],
      ),
    );
    final mainBar = Row(
      children: [
        if (upsolveMode == UpsolveMode.auto) menuButton else backButton,
        Expanded(
          child: IconButton(
            icon: Icon(Icons.lightbulb),
            onPressed: onShowSolution,
          ),
        ),
        Expanded(
          child: IconButton(
            icon: Icon(Icons.replay),
            onPressed: onResetTask,
          ),
        ),
        if (onNextTask != null)
          Expanded(
            child: IconButton(
              icon: Icon(Icons.navigate_next),
              onPressed: onNextTask,
            ),
          ),
      ],
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (upsolveMode == UpsolveMode.manual)
          Row(
            children: <Widget>[
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.fast_rewind),
                  onPressed: () {
                    for (int i = 0; i < fastMoveNavCount; ++i) onPreviousMove();
                  },
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: Transform.flip(
                    flipX: true,
                    child: Icon(Icons.play_arrow),
                  ),
                  onPressed: onPreviousMove,
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: onNextMove,
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.fast_forward),
                  onPressed: () {
                    for (int i = 0; i < fastMoveNavCount; ++i) onNextMove();
                  },
                ),
              ),
            ],
          ),
        if (upsolveMode == UpsolveMode.manual) Divider(height: 8.0),
        mainBar,
      ],
    );
  }
}
