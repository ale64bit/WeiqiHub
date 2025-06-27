import 'package:flutter/material.dart';

class TimedDialog extends StatefulWidget {
  final String title;
  final String content;
  final Duration duration;
  final Function()? onCancel;

  const TimedDialog({
    super.key,
    required this.title,
    required this.content,
    required this.duration,
    this.onCancel,
  });

  @override
  State<TimedDialog> createState() => _TimedDialogState();
}

class _TimedDialogState extends State<TimedDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..addListener(() {
        setState(() {});
      });
    controller.reverse(from: 1.0);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(widget.content),
          SizedBox(height: 16),
          LinearProgressIndicator(
            value: controller.value,
          ),
          SizedBox(height: 16),
          if (widget.onCancel != null)
            ElevatedButton(
              onPressed: widget.onCancel,
              child: const Text('Cancel'),
            ),
        ],
      ),
    );
  }
}
