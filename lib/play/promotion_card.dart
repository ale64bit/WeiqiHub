import 'package:flutter/material.dart';
import 'package:wqhub/game_client/user_info.dart';

class PromotionCard extends StatelessWidget {
  final PromotionRequirements requirements;

  const PromotionCard({super.key, required this.requirements});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(Icons.keyboard_arrow_up, color: Colors.green),
              Text(requirements.up?.toString() ?? '-'),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(Icons.keyboard_double_arrow_up, color: Colors.green),
              Text(requirements.doubleUp?.toString() ?? '-'),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(Icons.keyboard_arrow_down, color: Colors.red),
              Text(requirements.down?.toString() ?? '-'),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(Icons.keyboard_double_arrow_down, color: Colors.red),
              Text(requirements.doubleDown?.toString() ?? '-'),
            ],
          ),
        ],
      ),
    );
  }
}
