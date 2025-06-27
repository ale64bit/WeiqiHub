import 'package:flutter/material.dart';
import 'package:wqhub/main_page.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';

class WeiqiHubApp extends StatefulWidget {
  const WeiqiHubApp({super.key});

  @override
  State<WeiqiHubApp> createState() => _WeiqiHubAppState();
}

class _WeiqiHubAppState extends State<WeiqiHubApp> {
  @override
  Widget build(BuildContext context) {
    final lightTheme = ThemeData(
      colorSchemeSeed: Colors.blueAccent,
      brightness: Brightness.light,
    );
    final darkTheme = ThemeData(
      colorSchemeSeed: Colors.blueAccent,
      brightness: Brightness.dark,
    );
    return MaterialApp(
      title: 'WeiqiHub',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: context.settings.themeMode,
      home: MainPage(reloadAppTheme: () {
        setState(() {});
      }),
      debugShowCheckedModeBanner: false,
    );
  }
}
