import 'package:flutter/material.dart';
import 'package:wqhub/game_client/rules.dart';
import 'package:wqhub/game_client/server_features.dart';
import 'package:wqhub/l10n/app_localizations.dart';

class GameplayMenu extends StatelessWidget {
  final ServerFeatures features;
  final Rules rules;
  final int handicap;
  final double komi;
  final bool isGameOver;
  final Function() onPass;
  final Function() onManualCounting;
  final Function() onAutomaticCounting;
  final Function() onAIReferee;
  final Function() onForceCounting;
  final Function() onResign;
  final Function() onLeave;

  const GameplayMenu({
    super.key,
    required this.features,
    required this.rules,
    required this.handicap,
    required this.komi,
    required this.isGameOver,
    required this.onPass,
    required this.onManualCounting,
    required this.onAutomaticCounting,
    required this.onAIReferee,
    required this.onForceCounting,
    required this.onResign,
    required this.onLeave,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return MenuAnchor(
      menuChildren: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('${loc.rules}: ${rules.toLocalizedString(loc)}'),
        ),
        if (handicap > 1)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${loc.handicap}: $handicap'),
          ),
        if (handicap < 2)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${loc.komi}: $komi'),
          ),
        Divider(thickness: 1, height: 1),
        if (!isGameOver)
          MenuItemButton(
            leadingIcon: Icon(Icons.fast_forward),
            onPressed: onPass,
            child: Text(loc.pass),
          ),
        if (!isGameOver && features.manualCounting)
          MenuItemButton(
            leadingIcon: Icon(Icons.calculate),
            onPressed: onManualCounting,
            child: const Text('Request Counting'),
          ),
        if (!isGameOver && features.automaticCounting)
          MenuItemButton(
            leadingIcon: Icon(Icons.calculate),
            onPressed: onAutomaticCounting,
            child: Text(loc.autoCounting),
          ),
        if (!isGameOver && features.aiReferee)
          MenuItemButton(
            leadingIcon: Icon(Icons.smart_toy),
            onPressed: onAIReferee,
            child: Text(loc.aiReferee),
          ),
        if (!isGameOver && features.forcedCounting)
          MenuItemButton(
            leadingIcon: Icon(Icons.sports),
            onPressed: onForceCounting,
            child: Text(loc.forceCounting),
          ),
        if (!isGameOver)
          MenuItemButton(
            leadingIcon: Icon(Icons.flag),
            onPressed: onResign,
            child: Text(loc.resign),
          ),
        if (isGameOver)
          MenuItemButton(
            leadingIcon: Icon(Icons.logout),
            onPressed: onLeave,
            child: const Text('Leave'),
          ),
      ],
      builder: (context, controller, child) {
        return IconButton(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: Icon(Icons.menu),
        );
      },
    );
  }
}
