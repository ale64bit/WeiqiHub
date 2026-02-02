import 'package:flutter/material.dart';
import 'package:wqhub/board/board_sizes.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/train/response_delay.dart';

class BehaviourSettingsPage extends StatefulWidget {
  static const routeName = '/settings/behaviour';

  const BehaviourSettingsPage({super.key});

  @override
  State<BehaviourSettingsPage> createState() => _BehaviourSettingsPageState();
}

class _BehaviourSettingsPageState extends State<BehaviourSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(loc.behaviour)),
      body: ListView(
        children: <ListTile>[
          ListTile(
            title: Text(loc.confirmMoves),
            subtitle: Text(loc.confirmMovesDesc),
            trailing: Switch(
              value: context.settings.confirmMoves,
              onChanged: (value) {
                context.settings.confirmMoves = value;
                setState(() {});
              },
            ),
          ),
          if (context.settings.confirmMoves)
            ListTile(
              title: Text(loc.confirmBoardSize),
              subtitle: Text(loc.confirmBoardSizeDesc),
              trailing: DropdownButton<int>(
                value: context.settings.confirmMovesBoardSize,
                items: BoardSizes.values.map((boardSize) {
                  return DropdownMenuItem<int>(
                    value: boardSize.value,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${boardSize.value}×${boardSize.value}'),
                    ),
                  );
                }).toList(),
                borderRadius: BorderRadius.circular(8),
                onChanged: (int? boardSize) {
                  context.settings.confirmMovesBoardSize =
                      boardSize ?? BoardSizes.size_9.value;
                  setState(() {});
                },
              ),
            ),
          ListTile(
            title: Text(loc.responseDelay),
            subtitle: Text(loc.responseDelayDesc),
            trailing: DropdownButton<ResponseDelay>(
              value: context.settings.responseDelay,
              items: ResponseDelay.values.map((delay) {
                return DropdownMenuItem<ResponseDelay>(
                  value: delay,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(delay.toLocalizedString(loc)),
                  ),
                );
              }).toList(),
              borderRadius: BorderRadius.circular(8),
              onChanged: (ResponseDelay? delay) {
                context.settings.responseDelay = delay!;
                setState(() {});
              },
            ),
          ),
          ListTile(
            title: Text(loc.alwaysBlackToPlay),
            subtitle: Text(loc.alwaysBlackToPlayDesc),
            trailing: Switch(
              value: context.settings.alwaysBlackToPlay,
              onChanged: (value) {
                context.settings.alwaysBlackToPlay = value;
                setState(() {});
              },
            ),
          ),
          ListTile(
            title: Text(loc.randomizeTaskOrientation),
            subtitle: Text(loc.randomizeTaskOrientationDesc),
            trailing: Switch(
              value: context.settings.randomizeTaskOrientation,
              onChanged: (value) {
                context.settings.randomizeTaskOrientation = value;
                setState(() {});
              },
            ),
          ),
          ListTile(
            title: Text(loc.showMoveErrorsAsCrosses),
            subtitle: Text(loc.showMoveErrorsAsCrossesDesc),
            trailing: Switch(
              value: context.settings.showMoveErrorsAsCrosses,
              onChanged: (value) {
                context.settings.showMoveErrorsAsCrosses = value;
                setState(() {});
              },
            ),
          ),
          ListTile(
            title: Text(loc.timeFrenzyMistakes),
            subtitle: Text(loc.timeFrenzyMistakesDesc),
            trailing: Switch(
              value: context.settings.trackTimeFrenzyMistakes,
              onChanged: (value) {
                context.settings.trackTimeFrenzyMistakes = value;
                setState(() {});
              },
            ),
          ),
          ListTile(
            title: Text(loc.autoNext),
            subtitle: Text(loc.autoNextDesc),
            trailing: Switch(
              value: context.settings.autoNext,
              onChanged: (value) {
                context.settings.autoNext = value;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
