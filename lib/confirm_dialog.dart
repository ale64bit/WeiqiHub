import 'package:flutter/material.dart';

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
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: onNo,
          child: const Text('No'),
        ),
        TextButton(
          onPressed: onYes,
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
