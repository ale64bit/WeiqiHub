import 'package:flutter/material.dart';
import 'package:wqhub/settings/settings_page.dart';
import 'package:wqhub/settings/settings_route_arguments.dart';

class SettingsButton extends StatelessWidget {
  final Function() reloadAppTheme;

  const SettingsButton({super.key, required this.reloadAppTheme});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pushNamed(
          context,
          SettingsPage.routeName,
          arguments: SettingsRouteArguments(rebuildApp: reloadAppTheme),
        );
      },
      icon: Icon(Icons.settings),
    );
  }
}
