import 'package:wqhub/l10n/app_localizations.dart';

enum TaskSourceType {
  fromTaskTypes,
  fromTaskTag,
  fromMistakes;

  String toLocalizedString(AppLocalizations loc) => switch (this) {
        TaskSourceType.fromTaskTypes => loc.taskSourceFromTaskTypes,
        TaskSourceType.fromTaskTag => loc.taskSourceFromTaskTopic,
        TaskSourceType.fromMistakes => loc.taskSourceFromMyMistakes,
      };
}
