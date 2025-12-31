import 'package:flutter/material.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';

class GradingExamHelpDialog extends StatefulWidget {
  const GradingExamHelpDialog({super.key});

  @override
  State<GradingExamHelpDialog> createState() => _GradingExamHelpDialogState();
}

class _GradingExamHelpDialogState extends State<GradingExamHelpDialog> {
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
          Text(loc.helpDialogGradingExam),
          SizedBox(height: 16.0),
          CheckboxListTile(
              title: Text(loc.dontShowAgain),
              value: !context.settings.showGradingExamHelp,
              onChanged: (value) {
                context.settings.showGradingExamHelp = !value!;
                setState(() {});
              }),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(loc.ok),
        ),
      ],
    );
  }
}
