// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get analysis => 'Analyse';

  @override
  String get winrate => 'Gewinnwahrscheinlichkeit';

  @override
  String get scoreLead => 'Punktevorsprung';

  @override
  String get about => 'Über';

  @override
  String get acceptDeadStones => 'Tote Steine akzeptieren';

  @override
  String get accuracy => 'Genauigkeit';

  @override
  String get aiReferee => 'KI-Schiedsrichter';

  @override
  String get aiSensei => 'AI Sensei';

  @override
  String get alwaysBlackToPlay => 'Immer Schwarz am Zug';

  @override
  String get alwaysBlackToPlayDesc =>
      'Alle Aufgaben mit Schwarz am Zug aufbauen, um Verwechslung zu vermeiden';

  @override
  String get appearance => 'Aussehen';

  @override
  String get autoCounting => 'Automatisches Auszählen';

  @override
  String get autoMatch => 'Automatisches Match';

  @override
  String get avgRank => 'Durchschn. Rang';

  @override
  String get behaviour => 'Verhalten';

  @override
  String get bestResult => 'Bestes Ergebnis';

  @override
  String get black => 'Schwarz';

  @override
  String get board => 'Brett';

  @override
  String get boardSize => 'Brettgröße';

  @override
  String get boardTheme => 'Brett Aussehen';

  @override
  String get byRank => 'Nach Rang';

  @override
  String get byType => 'Nach Typ';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get captures => 'Gefangene';

  @override
  String get chartTitleCorrectCount => 'Richtige Antworten';

  @override
  String get chartTitleExamCompletionTime => 'Prüfungsdauer';

  @override
  String get charts => 'Diagramme';

  @override
  String get clearBoard => 'Brett leeren';

  @override
  String get collectStats => 'Statistiken erfassen';

  @override
  String get collections => 'Sammlungen';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get confirmBoardSize => 'Brettgröße bestätigen';

  @override
  String get confirmBoardSizeDesc =>
      'Bretter dieser Größe oder größer erfordern eine Zugbestätigung';

  @override
  String get confirmMoves => 'Züge bestätigen';

  @override
  String get confirmMovesDesc =>
      'Doppelt tippen, um Züge auf großen Brettern zu bestätigen und Fehlklicks zu vermeiden';

  @override
  String get continue_ => 'Fortfahren';

  @override
  String get copySGF => 'SGF kopieren';

  @override
  String get copyTaskLink => 'Aufgabenlink kopieren';

  @override
  String get customExam => 'Benutzerdefinierte Prüfung';

  @override
  String get dark => 'Dunkel';

  @override
  String get deselectAll => 'Alle abwählen';

  @override
  String get dontShowAgain => 'Nicht erneut anzeigen';

  @override
  String get download => 'Herunterladen';

  @override
  String get edgeLine => 'Randlinie';

  @override
  String get empty => 'leer';

  @override
  String get endgameExam => 'Endspiel-Prüfung';

  @override
  String get enterTaskLink => 'Aufgabenlink eingeben';

  @override
  String get errCannotBeEmpty => 'Darf nicht leer sein';

  @override
  String get errFailedToDownloadGame =>
      'Spiel konnte nicht heruntergeladen werden';

  @override
  String get errFailedToLoadGameList =>
      'Spielliste konnte nicht geladen werden. Bitte versuche es erneut.';

  @override
  String get errFailedToUploadGameToAISensei =>
      'Spiel konnte nicht zu AI Sensei hochgeladen werden';

  @override
  String get errIncorrectUsernameOrPassword =>
      'Falscher Benutzername oder falsches Passwort';

  @override
  String errLoginFailedWithDetails(String message) {
    return 'Anmeldung fehlgeschlagen: $message';
  }

  @override
  String errMustBeAtLeast(num n) {
    return 'Muss mindestens $n sein';
  }

  @override
  String errMustBeAtMost(num n) {
    return 'Darf höchstens $n sein';
  }

  @override
  String get errMustBeInteger => 'Muss eine ganze Zahl sein';

  @override
  String get errNetworkError =>
      'Netzwerkfehler. Bitte überprüfe deine Verbindung und versuche es erneut.';

  @override
  String get error => 'Fehler';

  @override
  String get exit => 'Beenden';

  @override
  String get exitTryMode => 'Testmodus beenden';

  @override
  String get find => 'Suchen';

  @override
  String get findTask => 'Problem suchen';

  @override
  String get findTaskByLink => 'Mit einem Link';

  @override
  String get findTaskByPattern => 'Mit Mustererkennung';

  @override
  String get findTaskResults => 'Suchergebnisse';

  @override
  String get findTaskSearching => 'Suche...';

  @override
  String get forceCounting => 'Auszählen erzwingen';

  @override
  String get foxwqDesc => 'Der beliebteste Server in China und weltweit.';

  @override
  String get foxwqName => 'Fox Weiqi';

  @override
  String get fullscreen => 'Vollbild';

  @override
  String get fullscreenDesc =>
      'App im Vollbildmodus anzeigen. Die App muss neu gestartet werden, damit diese Einstellung wirksam wird.';

  @override
  String get gameInfo => 'Spielinfo';

  @override
  String get gameRecord => 'Spielaufzeichnung';

  @override
  String get gradingExam => 'Einstufungsprüfung';

  @override
  String get handicap => 'Vorgabe';

  @override
  String get help => 'Hilfe';

  @override
  String get hidePlayerRanks => 'Spielerränge verbergen';

  @override
  String get hidePlayerRanksDesc =>
      'Ränge in der Server-Lobby und während des Spiels verbergen';

  @override
  String get helpDialogCollections =>
      'Kollektionen sind klassische, kuratierte Sets von hochwertigen Aufgaben, die gemeinsam einen besonderen Wert als Trainingsressource bilden.\n\nDas Hauptziel ist es, eine Kollektion mit einer hohen Erfolgsquote zu lösen. Ein Nebenziel ist es, sie so schnell wie möglich zu lösen.';

  @override
  String get helpDialogEndgameExam =>
      '- Endspielprüfungen bestehen aus 10 Endspielaufgaben, und du hast 45 Sekunden pro Aufgabe.\n\n- Du bestehst die Prüfung, wenn du 8 oder mehr Aufgaben korrekt löst (80 % Erfolgsquote).\n\n- Das Bestehen der Prüfung für einen bestimmten Rang schaltet die Prüfung für den nächsten Rang frei.';

  @override
  String get helpDialogGradingExam =>
      '- Einstufungsprüfung bestehen aus 10 Aufgaben, und du hast 45 Sekunden pro Aufgabe.\n\n- Du bestehst die Prüfung, wenn du 8 oder mehr Aufgaben korrekt löst (80 % Erfolgsquote).\n\n- Das Bestehen der Prüfung für einen bestimmten Rang schaltet die Prüfung für den nächsten Rang frei.';

  @override
  String get helpDialogRankedMode =>
      '- Löse Aufgaben ohne Zeitlimit.\n\n- Die Schwierigkeit der Aufgaben steigt entsprechend deiner Lösungs­geschwindigkeit.\n\n- Konzentriere dich darauf, korrekt zu lösen und den höchstmöglichen Rang zu erreichen.';

  @override
  String get helpDialogTimeFrenzy =>
      '- Du hast 3 Minuten Zeit, um so viele Aufgaben wie möglich zu lösen.\n\n- Die Aufgaben werden zunehmend schwieriger, je mehr du löst.\n\n- Wenn du 3 Fehler machst, bist du raus.';

  @override
  String get home => 'Startseite';

  @override
  String get komi => 'Komi';

  @override
  String get language => 'Sprache';

  @override
  String get leave => 'Verlassen';

  @override
  String get light => 'Hell';

  @override
  String get login => 'Anmelden';

  @override
  String get logout => 'Abmelden';

  @override
  String get long => 'Lang';

  @override
  String mMinutes(int m) {
    return '${m}min';
  }

  @override
  String get maxChartPoints => 'Max. Punkte';

  @override
  String get maxNumberOfMistakes => 'Maximale Fehleranzahl';

  @override
  String get maxRank => 'Max. Rang';

  @override
  String get medium => 'Mittel';

  @override
  String get minRank => 'Min. Rang';

  @override
  String get minutes => 'Minuten';

  @override
  String get month => 'Monat';

  @override
  String get msgCannotUseAIRefereeYet =>
      'Der KI-Schiedsrichter kann noch nicht verwendet werden';

  @override
  String get msgCannotUseForcedCountingYet =>
      'Erzwungenes Zählen kann noch nicht verwendet werden';

  @override
  String get msgConfirmDeleteCollectionProgress =>
      'Bist du sicher, dass du den bisherigen Fortschritt löschen möchtest?';

  @override
  String get msgConfirmDeletePreset =>
      'Möchten Sie diese Vorlage wirklich löschen?';

  @override
  String get msgConfirmResignation =>
      'Bist du sicher, dass du aufgeben möchtest?';

  @override
  String msgConfirmStopEvent(String event) {
    return 'Bist du sicher, dass du $event beenden möchtest?';
  }

  @override
  String get msgDownloadingGame => 'Spiel wird heruntergeladen';

  @override
  String msgGameSavedTo(String path) {
    return 'Spiel gespeichert unter $path';
  }

  @override
  String get msgPleaseWaitForYourTurn => 'Bitte warte auf deinen Zug';

  @override
  String get msgPresetAlreadyExists =>
      'Eine Vorlage mit diesem Namen existiert bereits.';

  @override
  String get msgSearchingForGame => 'Suche nach einem Spiel...';

  @override
  String get msgSgfCopied => 'SGF in die Zwischenablage kopiert.';

  @override
  String get msgTaskLinkCopied => 'Aufgabenlink kopiert.';

  @override
  String get msgWaitingForOpponentsDecision =>
      'Warte auf die Entscheidung deines Gegners...';

  @override
  String get msgYouCannotPass => 'Du kannst nicht passen';

  @override
  String get msgYourOpponentDisagreesWithCountingResult =>
      'Dein Gegner ist mit der Auszählung nicht einverstanden';

  @override
  String get msgYourOpponentRefusesToCount =>
      'Dein Gegner weigert sich zu auszuzählen';

  @override
  String get msgYourOpponentRequestsAutomaticCounting =>
      'Dein Gegner fordert automatisches Auszählen an. Bist du damit einverstanden?';

  @override
  String get myGames => 'Meine Spiele';

  @override
  String get myMistakes => 'Meine Fehler';

  @override
  String nTasks(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString Aufgaben',
      one: '1 Aufgabe',
      zero: 'Keine Aufgaben',
    );
    return '$_temp0';
  }

  @override
  String nTasksAvailable(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString Aufgaben verfügbar',
      one: '1 Aufgabe verfügbar',
      zero: 'Keine Aufgaben verfügbar',
    );
    return '$_temp0';
  }

  @override
  String get newBestResult => 'Neuer Rekord!';

  @override
  String get no => 'Nein';

  @override
  String get none => 'Keine';

  @override
  String get numberOfTasks => 'Anzahl der Aufgaben';

  @override
  String nxnBoardSize(int n) {
    return '$n×$n';
  }

  @override
  String get ogsDesc =>
      'Ein internationaler Server welcher am meisten in Europa und Amerika genutzt wird.';

  @override
  String get ogsName => 'Online Go Server';

  @override
  String get ok => 'OK';

  @override
  String get pass => 'Passen';

  @override
  String get password => 'Passwort';

  @override
  String get perTask => 'per task';

  @override
  String get play => 'Spielen';

  @override
  String get pleaseMarkDeadStones => 'Bitte markiere die toten Steine.';

  @override
  String get presetName => 'Vorlagenname';

  @override
  String get presets => 'Vorlagen';

  @override
  String get promotionRequirements => 'Anforderungen zum Auftsieg';

  @override
  String pxsByoyomi(int p, int s) {
    return '$p×${s}s';
  }

  @override
  String get randomizeTaskOrientation => 'Zufällige Aufgabenorientierung';

  @override
  String get randomizeTaskOrientationDesc =>
      'Zufälliges Drehen und Spiegeln von Aufgaben entlang horizontaler, vertikaler und diagonaler Achsen, um Auswendiglernen zu verhindern und die Mustererkennung zu verbessern.';

  @override
  String get rank => 'Rang';

  @override
  String get rankedMode => 'Gewerteter Modus';

  @override
  String get recentRecord => 'Letzte Ergebnisse';

  @override
  String get register => 'Registrieren';

  @override
  String get rejectDeadStones => 'Tote Steine ablehnen';

  @override
  String get resign => 'Aufgeben';

  @override
  String get responseDelay => 'Antwortverzögerung';

  @override
  String get responseDelayDesc =>
      'Dauer der Verzögerung, bevor beim Lösen einer Aufgabe die Antwort erscheint';

  @override
  String get responseDelayLong => 'Lang';

  @override
  String get responseDelayMedium => 'Mittel';

  @override
  String get responseDelayNone => 'Keine';

  @override
  String get responseDelayShort => 'Kurz';

  @override
  String get result => 'Ergebnis';

  @override
  String get resultAccept => 'Akzeptieren';

  @override
  String get resultReject => 'Ablehnen';

  @override
  String get rules => 'Regeln';

  @override
  String get rulesChinese => 'Chinesisch';

  @override
  String get rulesJapanese => 'Japanisch';

  @override
  String get rulesKorean => 'Koreanisch';

  @override
  String sSeconds(int s) {
    return '${s}s';
  }

  @override
  String get save => 'Sichern';

  @override
  String get savePreset => 'Vorlage speichern';

  @override
  String get saveSGF => 'SGF speichern';

  @override
  String get seconds => 'Sekunden';

  @override
  String get selectAll => 'Alle auswählen';

  @override
  String get settings => 'Einstellungen';

  @override
  String get short => 'Kurz';

  @override
  String get showCoordinates => 'Koordinaten anzeigen';

  @override
  String get showMoveErrorsAsCrosses => 'Falsche Züge als Kreuz darstellen';

  @override
  String get showMoveErrorsAsCrossesDesc =>
      'Falsche Züge werden als rotes Kreuz anstatt eines roiten Punkts angezeigt';

  @override
  String get simple => 'Einfach';

  @override
  String get sortModeDifficult => 'Schwierig';

  @override
  String get sortModeRecent => 'Neueste';

  @override
  String get sound => 'Ton';

  @override
  String get start => 'Start';

  @override
  String get statistics => 'Statistiken';

  @override
  String get statsDateColumn => 'Datum';

  @override
  String get statsDurationColumn => 'Dauer';

  @override
  String get statsTimeColumn => 'Zeit';

  @override
  String get stoneShadows => 'Steinschatten';

  @override
  String get stones => 'Steine';

  @override
  String get subtopic => 'Unterthema';

  @override
  String get system => 'System';

  @override
  String get task => 'Aufgabe';

  @override
  String get taskCorrect => 'Richtig';

  @override
  String get taskNext => 'Weiter';

  @override
  String get taskNotFound => 'Aufgabe nicht gefunden';

  @override
  String get taskRedo => 'Erneut versuchen';

  @override
  String get taskSource => 'Quelle der Aufgaben';

  @override
  String get taskSourceFromMyMistakes => 'Aus meinen Fehlern';

  @override
  String get taskSourceFromTaskTopic => 'Aus dem Aufgabenthema';

  @override
  String get taskSourceFromTaskTypes => 'Aus den Aufgabentypen';

  @override
  String get taskTimeout => 'Zeitüberschreitung';

  @override
  String get taskTypeAppreciation => 'Wertschätzung';

  @override
  String get taskTypeCapture => 'Steine fangen';

  @override
  String get taskTypeCaptureRace => 'Freiheitskampf';

  @override
  String get taskTypeEndgame => 'Endspiel';

  @override
  String get taskTypeJoseki => 'Joseki';

  @override
  String get taskTypeLifeAndDeath => 'Leben & Tod';

  @override
  String get taskTypeMiddlegame => 'Mittelspiel';

  @override
  String get taskTypeOpening => 'Eröffnung';

  @override
  String get taskTypeTesuji => 'Tesuji';

  @override
  String get taskTypeTheory => 'Theorie';

  @override
  String get taskWrong => 'Falsch';

  @override
  String get tasksSolved => 'Gelöste Aufgaben';

  @override
  String get test => 'Test';

  @override
  String get theme => 'Thema';

  @override
  String get thick => 'Dick';

  @override
  String get timeFrenzy => 'Zeitrausch';

  @override
  String get timeFrenzyMistakes => 'Zeitrausch Fehler';

  @override
  String get timeFrenzyMistakesDesc =>
      'Fehler im Zeitrausch Modus werden gespeichert';

  @override
  String get timePerTask => 'Zeit pro Aufgabe';

  @override
  String get today => 'Heute';

  @override
  String get tooltipAnalyzeWithAISensei => 'Mit AI Sensei analysieren';

  @override
  String get tooltipDownloadGame => 'Spiel herunterladen';

  @override
  String get topic => 'Thema';

  @override
  String get topicExam => 'Themen Prüfung';

  @override
  String get topics => 'Themen';

  @override
  String get train => 'Trainieren';

  @override
  String get trainingAvgTimePerTask => 'Durchschn. Zeit pro Aufgabe';

  @override
  String get trainingFailed => 'Nicht bestanden';

  @override
  String get trainingMistakes => 'Fehler';

  @override
  String get trainingPassed => 'Bestanden';

  @override
  String get trainingTotalTime => 'Gesamtzeit';

  @override
  String get tryCustomMoves => 'Eigene Züge ausprobieren';

  @override
  String get tygemDesc =>
      'Der beliebteste Server in Korea und einer der beliebtesten weltweit.';

  @override
  String get tygemName => 'Tygem Baduk';

  @override
  String get type => 'Typ';

  @override
  String get ui => 'UI';

  @override
  String get userInfo => 'Benutzerinfo';

  @override
  String get username => 'Benutzername';

  @override
  String get voice => 'Stimme';

  @override
  String get week => 'Woche';

  @override
  String get white => 'Weiß';

  @override
  String get yes => 'Ja';
}
