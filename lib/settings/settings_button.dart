import 'package:flutter/material.dart';
import 'package:wqhub/settings/settings_page.dart';

class SettingsButton extends StatelessWidget {
  final Function() reloadAppTheme;

  const SettingsButton({super.key, required this.reloadAppTheme});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SettingsPage(reloadAppTheme: reloadAppTheme),
          ),
        );
      },
      icon: Icon(Icons.settings),
    );
  }
}
