import 'package:flutter/material.dart';
import 'package:wqhub/wq/wq.dart' as wq;

class TurnIcon extends StatelessWidget {
  final wq.Color color;

  const TurnIcon({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.circle,
          color: color == wq.Color.black ? Colors.black : Colors.white),
    );
  }
}
