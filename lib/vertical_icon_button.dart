import 'package:flutter/material.dart';

class VerticalIconButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final Function() onTap;

  const VerticalIconButton(
      {super.key,
      required this.icon,
      required this.label,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 4.0,
        children: [
          icon,
          Text(label),
        ],
      ),
    );
  }
}
