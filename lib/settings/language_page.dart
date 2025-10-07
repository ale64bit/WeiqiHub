import 'package:flutter/material.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';

class LanguagePage extends StatefulWidget {
  static const routeName = '/settings/language';

  final Function() rebuildApp;

  const LanguagePage({super.key, required this.rebuildApp});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  static final Map<String, String> nativeLanguageName = {
    'en': 'English',
    'es': 'Español',
    'zh': '中文 – 简体',
    'ru': 'Русский',
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.language)),
      body: RadioGroup(
        groupValue: context.settings.locale,
        onChanged: (Locale? loc) {
          context.settings.locale = loc!;
          widget.rebuildApp();
        },
        child: ListView(
          children: <RadioListTile>[
            for (final loc in AppLocalizations.supportedLocales)
              RadioListTile<Locale>(
                title: Text(nativeLanguageName[loc.languageCode]!),
                value: loc,
              )
          ],
        ),
      ),
    );
  }
}
