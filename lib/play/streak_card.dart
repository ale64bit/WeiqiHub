import 'package:flutter/material.dart';

class StreakCard extends StatelessWidget {
  final String streak;

  const StreakCard({super.key, required this.streak});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: streak.characters
            .map((ch) => switch (ch) {
                  'W' => const Icon(Icons.circle_outlined,
                      color: Colors.green, size: 16),
                  'L' => const Icon(Icons.close, color: Colors.red, size: 16),
                  '=' =>
                    const Icon(Icons.drag_handle, color: Colors.blue, size: 16),
                  '.' =>
                    const Icon(Icons.more_horiz, color: Colors.grey, size: 16),
                  _ => const Icon(Icons.question_mark, size: 16),
                })
            .toList(),
      ),
    );
  }
}
