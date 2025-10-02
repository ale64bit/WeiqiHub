import 'package:wqhub/l10n/app_localizations.dart';

enum TaskType {
  lifeAndDeath,
  tesuji,
  capture,
  captureRace,
  opening,
  joseki,
  middlegame,
  endgame,
  theory,
  appreciation;

  String toLocalizedString(AppLocalizations loc) => switch (this) {
        TaskType.lifeAndDeath => loc.taskTypeLifeAndDeath,
        TaskType.tesuji => loc.taskTypeTesuji,
        TaskType.capture => loc.taskTypeCapture,
        TaskType.captureRace => loc.taskTypeCaptureRace,
        TaskType.opening => loc.taskTypeOpening,
        TaskType.joseki => loc.taskTypeJoseki,
        TaskType.middlegame => loc.taskTypeMiddlegame,
        TaskType.endgame => loc.taskTypeEndgame,
        TaskType.theory => loc.taskTypeTheory,
        TaskType.appreciation => loc.taskTypeAppreciation,
      };
}
