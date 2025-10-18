import 'package:flutter/material.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/wq/wq.dart' as wq;

class CountingResultBottomSheet extends StatelessWidget {
  final wq.Color winner;
  final double scoreLead;
  final Function() onAccept;
  final Function()? onReject;

  const CountingResultBottomSheet({
    super.key,
    required this.winner,
    required this.scoreLead,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        spacing: 8,
        children: [
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text('${winner.toString()}+ $scoreLead'),
          ),
          FilledButton(onPressed: onAccept, child: Text(loc.resultAccept)),
          FilledButton(onPressed: onReject, child: Text(loc.resultReject)),
        ],
      ),
    );
  }
}
