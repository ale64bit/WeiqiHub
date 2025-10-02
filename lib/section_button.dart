import 'package:flutter/material.dart';

class SectionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function() onPressed;

  const SectionButton(
      {super.key,
      required this.icon,
      required this.label,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8.0,
        children: [
          Flexible(
            child: Icon(icon),
            flex: 1,
          ),
          Flexible(
              child: Text(
                label,
                textAlign: TextAlign.center,
              ),
              flex: 3),
        ],
      ),
    );
  }
}
