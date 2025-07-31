import 'package:flutter/material.dart';
import 'package:wqhub/audio/audio_controller.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';

class SoundSettingsPage extends StatefulWidget {
  static const routeName = '/settings/sound';

  const SoundSettingsPage({super.key});

  @override
  State<SoundSettingsPage> createState() => _SoundSettingsPageState();
}

class _SoundSettingsPageState extends State<SoundSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sound')),
      body: ListView(
        children: <ListTile>[
          ListTile(
            title: const Text('Sound'),
            trailing: Switch(
              value: context.settings.sound,
              onChanged: (value) {
                context.settings.sound = value;
                if (value) AudioController().correct();
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
