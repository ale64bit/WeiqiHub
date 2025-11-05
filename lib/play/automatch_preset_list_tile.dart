import 'package:flutter/material.dart';
import 'package:wqhub/game_client/automatch_preset.dart';
import 'package:wqhub/l10n/app_localizations.dart';

class AutomatchPresetListTile extends StatelessWidget {
  final AutomatchPreset preset;
  final Function() onTap;

  const AutomatchPresetListTile(
      {super.key, required this.preset, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final title = Text(preset.timeControl.mainTime.inMinutes == 0
        ? '${loc.sSeconds(preset.timeControl.mainTime.inSeconds)} ${loc.pxsByoyomi(preset.timeControl.periodCount, preset.timeControl.timePerPeriod.inSeconds)}'
        : '${loc.mMinutes(preset.timeControl.mainTime.inMinutes)} ${loc.pxsByoyomi(preset.timeControl.periodCount, preset.timeControl.timePerPeriod.inSeconds)}');

    return ListTile(
      leading: Text(loc.nxnBoardSize(preset.boardSize)),
      title: title,
      subtitle: Text('${loc.rules}: ${preset.rules.toLocalizedString(loc)}'),
      trailing: (preset.playerCount != null)
          ? Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 4,
              children: <Widget>[
                Icon(Icons.people),
                Text(preset.playerCount.toString()),
              ],
            )
          : null,
      onTap: onTap,
    );
  }
}
