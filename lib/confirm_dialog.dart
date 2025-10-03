import 'package:flutter/material.dart';
import 'package:wqhub/l10n/app_localizations.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final Function() onYes;
  final Function() onNo;

  const ConfirmDialog(
      {super.key,
      required this.title,
      required this.content,
      required this.onYes,
      required this.onNo});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: onNo,
          child: Text(loc.no),
        ),
        TextButton(
          onPressed: onYes,
          child: Text(loc.yes),
        ),
      ],
    );
  }
}
