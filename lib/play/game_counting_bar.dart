import 'package:flutter/material.dart';
import 'package:wqhub/l10n/app_localizations.dart';

class GameCountingBar extends StatelessWidget {
  final Function()? onAcceptDeadStones;
  final Function() onRejectDeadStones;
  final List<(String, bool)> acceptStatus;

  const GameCountingBar({
    super.key,
    required this.onAcceptDeadStones,
    required this.onRejectDeadStones,
    required this.acceptStatus,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final acceptDeadStonesButton = ElevatedButton.icon(
      onPressed: onAcceptDeadStones,
      label: Text(loc.acceptDeadStones),
      icon: Icon(Icons.check_circle),
    );
    final rejectDeadStonesButton = ElevatedButton.icon(
      onPressed: onRejectDeadStones,
      label: Text(loc.rejectDeadStones),
      icon: Icon(Icons.cancel),
    );
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          Text(loc.pleaseMarkDeadStones),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            spacing: 4,
            children: [
              if (onAcceptDeadStones != null)
                Expanded(child: acceptDeadStonesButton),
              Expanded(child: rejectDeadStonesButton),
            ],
          ),
          SizedBox(height: 16.0),
          for (final (nick, accepted) in acceptStatus)
            Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 4.0,
              children: [
                Icon(accepted ? Icons.check_circle : Icons.cancel,
                    color: accepted ? Colors.green : Colors.redAccent),
                Text(nick),
              ],
            )
        ],
      ),
    );
  }
}
