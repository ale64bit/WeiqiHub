import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return MaterialApp(
      title: 'WeiqiHub',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: context.settings.locale,
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
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

  ThemeData _buildTheme(Brightness brightness) {
    final theme = ThemeData(
      colorSchemeSeed: Colors.blueAccent,
      brightness: brightness,
    );
    return theme.copyWith(
      textTheme: GoogleFonts.notoSansTextTheme(theme.textTheme),
    );
  }
}
