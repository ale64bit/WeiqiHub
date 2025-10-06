import 'package:flutter/material.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/train/ranked_mode_page.dart';
import 'package:wqhub/train/task_source/black_to_play_source.dart';
import 'package:wqhub/train/task_source/ranked_mode_task_source.dart';

class RankedModeHelpDialog extends StatefulWidget {
  @override
  State<RankedModeHelpDialog> createState() => _RankedModeHelpDialogState();
}

class _RankedModeHelpDialogState extends State<RankedModeHelpDialog> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 8.0,
        children: [
          const Icon(Icons.help),
          Text(loc.help),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(loc.helpDialogRankedMode),
          SizedBox(height: 16.0),
          CheckboxListTile(
              title: Text(loc.dontShowAgain),
              value: !context.settings.showRankedModeHelp,
              onChanged: (value) {
                context.settings.showRankedModeHelp = !value!;
                setState(() {});
              }),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.pushNamed(
              context,
              RankedModePage.routeName,
              arguments: RankedModeRouteArguments(
                taskSource: BlackToPlaySource(
                  source: RankedModeTaskSource(context.stats.rankedModeRank),
                  blackToPlay: context.settings.alwaysBlackToPlay,
                ),
              ),
            );
          },
          child: Text(loc.ok),
        ),
      ],
    );
  }
}
