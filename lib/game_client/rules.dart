import 'package:wqhub/l10n/app_localizations.dart';

enum Rules {
  chinese,
  japanese,
  korean;

  String toLocalizedString(AppLocalizations loc) => switch (this) {
        Rules.chinese => loc.rulesChinese,
        Rules.japanese => loc.rulesJapanese,
        Rules.korean => loc.rulesKorean,
      };
}
