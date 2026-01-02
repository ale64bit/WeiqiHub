import 'package:flutter/material.dart';

class CircularPercentText extends StatelessWidget {
  final int value;

  const CircularPercentText({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Text('$value%'),
        CircularProgressIndicator(
          value: value / 100,
          color: valueColor(),
        ),
      ],
    );
  }

  Color? valueColor() {
    if (value == 100) return Colors.green;
    if (value >= 80) {
      return Colors.lightGreen;
    } else if (value >= 30) {
      return Colors.amber;
    } else if (value > 0) {
      return Colors.red;
    }
    return null;
  }
}
