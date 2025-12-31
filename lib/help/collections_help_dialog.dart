import 'package:flutter/material.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';

class CollectionsHelpDialog extends StatefulWidget {
  const CollectionsHelpDialog({super.key});

  @override
  State<CollectionsHelpDialog> createState() => _CollectionsHelpDialogState();
}

class _CollectionsHelpDialogState extends State<CollectionsHelpDialog> {
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
          Text(loc.helpDialogCollections),
          SizedBox(height: 8.0),
          Container(
            color: ColorScheme.of(context).primaryContainer,
            width: 100,
            child: Icon(Icons.swipe_left),
          ),
          SizedBox(height: 8.0),
          CheckboxListTile(
              title: Text(loc.dontShowAgain),
              value: !context.settings.showCollectionsHelp,
              onChanged: (value) {
                context.settings.showCollectionsHelp = !value!;
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
