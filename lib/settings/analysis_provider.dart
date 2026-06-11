import 'package:wqhub/l10n/app_localizations.dart';

enum AnalysisProvider {
  kifubara,
  aiSensei;

  String toLocalizedString(AppLocalizations loc) => switch (this) {
        AnalysisProvider.aiSensei => loc.aiSensei,
        AnalysisProvider.kifubara => loc.kifubara,
      };
}
