import 'package:flutter/material.dart';
import 'package:wqhub/board/board_sizes.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/train/response_delay.dart';

class BehaviourSettingsPage extends StatefulWidget {
  const BehaviourSettingsPage({super.key});

  @override
  State<BehaviourSettingsPage> createState() => _BehaviourSettingsPageState();
}

class _BehaviourSettingsPageState extends State<BehaviourSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Behaviour')),
      body: ListView(
        children: <ListTile>[
          ListTile(
            title: const Text('Confirm moves'),
            subtitle: const Text(
                'Double-tap to confirm moves on large boards to avoid misclicks'),
            trailing: Switch(
              value: context.settings.confirmMoves,
              onChanged: (value) {
                context.settings.confirmMoves = value;
                setState(() {});
              },
            ),
          ),
          if (context.settings.confirmMoves)
            ListTile(
              title: const Text('Confirm board size'),
              subtitle: const Text(
                  'Boards of this size or larger require move confirmation'),
              trailing: DropdownButton<int>(
                value: context.settings.confirmMovesBoardSize,
                items: BoardSizes.values.map((boardSize) {
                  return DropdownMenuItem<int>(
                    value: boardSize.value,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${boardSize.value}×${boardSize.value}'),
                    ),
                  );
                }).toList(),
                borderRadius: BorderRadius.circular(8),
                onChanged: (int? boardSize) {
                  context.settings.confirmMovesBoardSize =
                      boardSize ?? BoardSizes.size_9.value;
                  setState(() {});
                },
              ),
            ),
          ListTile(
            title: const Text('Response delay'),
            subtitle: const Text(
                'Duration of the delay before the response appears while solving tasks'),
            trailing: DropdownButton<ResponseDelay>(
              value: context.settings.responseDelay,
              items: ResponseDelay.values.map((delay) {
                return DropdownMenuItem<ResponseDelay>(
                  value: delay,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(delay.name),
                  ),
                );
              }).toList(),
              borderRadius: BorderRadius.circular(8),
              onChanged: (ResponseDelay? delay) {
                context.settings.responseDelay = delay!;
                setState(() {});
              },
            ),
          ),
          ListTile(
            title: const Text('Always black-to-play'),
            subtitle:
                const Text('Set all tasks as black-to-play to avoid confusion'),
            trailing: Switch(
              value: context.settings.alwaysBlackToPlay,
              onChanged: (value) {
                context.settings.alwaysBlackToPlay = value;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
