import 'package:flutter/material.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/train/task_source/black_to_play_source.dart';
import 'package:wqhub/train/task_source/time_frenzy_task_source.dart';
import 'package:wqhub/train/time_frenzy_page.dart';

class TimeFrenzyHelpDialog extends StatefulWidget {
  const TimeFrenzyHelpDialog({super.key});

  @override
  State<TimeFrenzyHelpDialog> createState() => _TimeFrenzyHelpDialogState();
}

class _TimeFrenzyHelpDialogState extends State<TimeFrenzyHelpDialog> {
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
          Text(loc.helpDialogTimeFrenzy),
          SizedBox(height: 16.0),
          CheckboxListTile(
              title: Text(loc.dontShowAgain),
              value: !context.settings.showTimeFrenzyHelp,
              onChanged: (value) {
                context.settings.showTimeFrenzyHelp = !value!;
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
              TimeFrenzyPage.routeName,
              arguments: TimeFrenzyRouteArguments(
                taskSource: BlackToPlaySource(
                  source: TimeFrenzyTaskSource(
                      randomizeLayout:
                          context.settings.randomizeTaskOrientation),
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
