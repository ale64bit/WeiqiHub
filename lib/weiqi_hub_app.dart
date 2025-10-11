import 'dart:io';

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
    return MaterialApp(
      title: 'WeiqiHub',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _defaultToCN(context.settings.locale),
      theme: _buildTheme(context.settings.locale, Brightness.light),
      darkTheme: _buildTheme(context.settings.locale, Brightness.dark),
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

  ThemeData _buildTheme(Locale locale, Brightness brightness) {
    final isWinChinese = Platform.isWindows && locale.languageCode == 'zh';
    final fontFamily = isWinChinese ? '微软雅黑' : null;
    final fontFamilyFallback = isWinChinese ? ['Microsoft YaHei'] : null;
    return ThemeData(
      colorSchemeSeed: Colors.blueAccent,
      brightness: brightness,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    );
  }

  Locale _defaultToCN(Locale loc) {
    if (loc.languageCode == 'zh' && loc.countryCode == null) {
      // This is to avoid font issues on Windows: https://github.com/flutter/flutter/issues/103811#issuecomment-1199012026
      return Locale('zh', 'CN');
    }
    return loc;
  }
}
