import 'package:flutter/material.dart';
import 'package:wqhub/game_client/server_features.dart';
import 'package:wqhub/l10n/app_localizations.dart';

class GameplayBar extends StatelessWidget {
  final ServerFeatures features;
  final Function() onPass;
  final Function() onManualCounting;
  final Function() onAutomaticCounting;
  final Function() onAIReferee;
  final Function() onForceCounting;
  final Function() onResign;

  const GameplayBar({
    super.key,
    required this.features,
    required this.onPass,
    required this.onManualCounting,
    required this.onAutomaticCounting,
    required this.onAIReferee,
    required this.onForceCounting,
    required this.onResign,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            spacing: 4,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onPass,
                  label: Text(loc.pass),
                  icon: Icon(Icons.fast_forward),
                ),
              ),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onResign,
                  label: Text(loc.resign),
                  icon: Icon(Icons.flag),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            spacing: 4,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed:
                      features.automaticCounting ? onAutomaticCounting : null,
                  label: Text(loc.autoCounting),
                  icon: Icon(Icons.calculate),
                ),
              ),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: features.forcedCounting ? onForceCounting : null,
                  label: Text(loc.forceCounting),
                  icon: Icon(Icons.sports),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            spacing: 4,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: features.aiReferee ? onAIReferee : null,
                  label: Text(loc.aiReferee),
                  icon: Icon(Icons.smart_toy),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
