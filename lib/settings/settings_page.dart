import 'package:flutter/material.dart';
import 'package:wqhub/settings/about_page.dart';
import 'package:wqhub/settings/appearance_settings_page.dart';
import 'package:wqhub/settings/behavior_settings_page.dart';
import 'package:wqhub/settings/settings_route_arguments.dart';
import 'package:wqhub/settings/sound_settings_page.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = '/settings';

  final Function() reloadAppTheme;

  const SettingsPage({super.key, required this.reloadAppTheme});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: <ListTile>[
          ListTile(
            title: const Text('Appearance'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(
                context,
                AppearanceSettingsPage.routeName,
                arguments: SettingsRouteArguments(
                    reloadAppTheme: widget.reloadAppTheme),
              );
            },
          ),
          ListTile(
            title: const Text('Behaviour'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(context, BehaviourSettingsPage.routeName);
            },
          ),
          ListTile(
            title: const Text('Sound'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(context, SoundSettingsPage.routeName);
            },
          ),
          ListTile(
            title: const Text('About'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(context, AboutPage.routeName);
            },
          ),
        ],
      ),
    );
  }
}
