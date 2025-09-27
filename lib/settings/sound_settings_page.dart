import 'package:flutter/material.dart';
import 'package:wqhub/audio/audio_controller.dart';
import 'package:wqhub/l10n/app_localizations.dart';
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
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(loc.sound)),
      body: ListView(
        children: <ListTile>[
          ListTile(
            title: Text(loc.stones),
            subtitle: Slider(
              value: context.settings.soundStone,
              label: '${(100 * context.settings.soundStone).floor()}%',
              divisions: 10,
              onChanged: (value) {
                context.settings.soundStone = value;
                AudioController().stoneVolume = value;
                setState(() {});
              },
            ),
            trailing: FilledButton(
              onPressed: () => AudioController().playStone(),
              child: Text(loc.test),
            ),
          ),
          ListTile(
            title: Text(loc.ui),
            subtitle: Slider(
              value: context.settings.soundUI,
              label: '${(100 * context.settings.soundUI).floor()}%',
              divisions: 10,
              onChanged: (value) {
                context.settings.soundUI = value;
                AudioController().uiVolume = value;
                setState(() {});
              },
            ),
            trailing: FilledButton(
              onPressed: () => AudioController().correct(),
              child: Text(loc.test),
            ),
          ),
          ListTile(
            title: Text(loc.voice),
            subtitle: Slider(
              value: context.settings.soundVoice,
              label: '${(100 * context.settings.soundVoice).floor()}%',
              divisions: 10,
              onChanged: (value) {
                context.settings.soundVoice = value;
                AudioController().voiceVolume = value;
                setState(() {});
              },
            ),
            trailing: FilledButton(
              onPressed: () => AudioController().startToPlay(),
              child: Text(loc.test),
            ),
          ),
        ],
      ),
    );
  }
}
