import 'package:flutter/material.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/main_page.dart';
import 'package:wqhub/routes.dart';
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
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: context.settings.locale,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: context.settings.themeMode,
      home: MainPage(
        destination: MainPageDestination.home,
        rebuildApp: () {
          setState(() {});
        },
      ),
      routes: routes,
      onGenerateRoute: onGenerateRoute,
      navigatorObservers: [routeObserver],
      debugShowCheckedModeBanner: false,
    );
  }
}
