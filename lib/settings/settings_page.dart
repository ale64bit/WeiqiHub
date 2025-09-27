import 'package:flutter/material.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/settings/about_page.dart';
import 'package:wqhub/settings/appearance_settings_page.dart';
import 'package:wqhub/settings/behavior_settings_page.dart';
import 'package:wqhub/settings/language_page.dart';
import 'package:wqhub/settings/settings_route_arguments.dart';
import 'package:wqhub/settings/sound_settings_page.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = '/settings';

  final Function() rebuildApp;

  const SettingsPage({super.key, required this.rebuildApp});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.settings),
      ),
      body: ListView(
        children: <ListTile>[
          ListTile(
            leading: const Icon(Icons.visibility),
            title: Text(loc.appearance),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(
                context,
                AppearanceSettingsPage.routeName,
                arguments:
                    SettingsRouteArguments(rebuildApp: widget.rebuildApp),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.psychology),
            title: Text(loc.behaviour),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(context, BehaviourSettingsPage.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.volume_up),
            title: Text(loc.sound),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(context, SoundSettingsPage.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(loc.language),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(
                context,
                LanguagePage.routeName,
                arguments:
                    SettingsRouteArguments(rebuildApp: widget.rebuildApp),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: Text(loc.about),
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
