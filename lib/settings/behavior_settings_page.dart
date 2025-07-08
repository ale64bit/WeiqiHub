import 'package:flutter/material.dart';
import 'package:wqhub/settings/confirm_moves.dart';
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
                'Double-tap to confirm moves on boards equal or bigger than select to avoid misclicks'),
            trailing: DropdownButton<String>(
              value: context.settings.confirmMoves,
              items: ConfirmMoves.values.map((boardSize) {
                return DropdownMenuItem<String>(
                  value: boardSize.value,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(boardSize.value),
                  ),
                );
              }).toList(),
              borderRadius: BorderRadius.circular(8),
              onChanged: (String? boardSize) {
                context.settings.confirmMoves = boardSize.toString();
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
            subtitle: const Text(
                'Set all tasks as black-to-play to avoid confusion.'),
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
