import 'package:flutter/material.dart';

class TaskActionBar extends StatelessWidget {
  final Function()? onShowSolution;
  final Function()? onShare;
  final Function()? onReplay;
  final Function()? onNext;

  const TaskActionBar(
      {super.key,
      this.onShowSolution,
      this.onShare,
      this.onReplay,
      this.onNext});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: IconButton(
            icon: Icon(Icons.lightbulb),
            onPressed: onShowSolution,
          ),
        ),
        Expanded(
          child: IconButton(
            icon: Icon(Icons.share),
            onPressed: onShare,
          ),
        ),
        Expanded(
          child: IconButton(
            icon: Icon(Icons.replay),
            onPressed: onReplay,
          ),
        ),
        if (onNext != null)
          Expanded(
            child: IconButton(
              icon: Icon(Icons.navigate_next),
              onPressed: onNext,
            ),
          ),
      ],
    );
  }
}
