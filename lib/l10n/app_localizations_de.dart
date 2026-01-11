// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

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
      'Kollektionen sind klassische, kuratierte Sets von hochwertigen Aufgaben, die gemeinsam einen besonderen Wert als Trainingsressource bilden.\n\nDas Hauptziel ist es, eine Kollektion mit einer hohen Erfolgsquote zu lösen. Ein Nebenziel ist es, sie so schnell wie möglich zu lösen.\n\nUm eine Kollektion zu starten oder fortzusetzen, wische im Hochformat nach links über die Kachel der Kollektion oder klicke im Querformat auf die Start-/Weiter-Buttons.';

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
  String get taskTag_afterJoseki => 'Nach dem joseki';

  @override
  String get taskTag_aiOpening => 'KI Eröffnung';

  @override
  String get taskTag_aiVariations => 'KI Variationen';

  @override
  String get taskTag_attack => 'Angriff';

  @override
  String get taskTag_attackAndDefenseInKo => 'Angriff und Verteidigung mit Ko';

  @override
  String get taskTag_attackAndDefenseOfCuts =>
      'Angriff und Verteidigung von Schnitten';

  @override
  String get taskTag_attackAndDefenseOfInvadingStones =>
      'Angriff und Verteidigung von Invasionen';

  @override
  String get taskTag_avoidKo => 'Ko vermeiden';

  @override
  String get taskTag_avoidMakingDeadShape => 'Tote Form vermeiden';

  @override
  String get taskTag_avoidTrap => 'Fallen ausweichen';

  @override
  String get taskTag_basicEndgame => 'Endspiel: Grundlagen';

  @override
  String get taskTag_basicLifeAndDeath => 'Leben & Tod: Grundlagen';

  @override
  String get taskTag_basicMoves => 'Grundlagen';

  @override
  String get taskTag_basicTesuji => 'Tesuji';

  @override
  String get taskTag_beginner => 'Beginner';

  @override
  String get taskTag_bend => 'Umbiegen';

  @override
  String get taskTag_bentFour => 'Toter Winkel';

  @override
  String get taskTag_bentFourInTheCorner => 'Toter Winkel in der Ecke';

  @override
  String get taskTag_bentThree => 'Gebogene Drei';

  @override
  String get taskTag_bigEyeLiberties => 'Freiheiten von großen Augen';

  @override
  String get taskTag_bigEyeVsSmallEye => 'Großes Auge vs kleines Auge';

  @override
  String get taskTag_bigPoints => 'Große Punkte';

  @override
  String get taskTag_blindSpot => 'Blinder Fleck';

  @override
  String get taskTag_breakEye => 'Augen verhindern';

  @override
  String get taskTag_breakEyeInOneStep => 'Augen verhindern in einem Zug';

  @override
  String get taskTag_breakEyeInSente => 'Augen verhindern in Vorhand';

  @override
  String get taskTag_breakOut => 'Ausbrechen';

  @override
  String get taskTag_breakPoints => 'Punkte verhindern';

  @override
  String get taskTag_breakShape => 'Form verhindern';

  @override
  String get taskTag_bridgeUnder => 'Untenrum verbinden';

  @override
  String get taskTag_brilliantSequence => 'Brillante Sequenz';

  @override
  String get taskTag_bulkyFive => 'Klotzige-Fünf';

  @override
  String get taskTag_bump => 'Stoßen';

  @override
  String get taskTag_captureBySnapback => 'Fang durch Mausefalle';

  @override
  String get taskTag_captureInLadder => 'Fang in der Treppe';

  @override
  String get taskTag_captureInOneMove => 'Fang in einem Zug';

  @override
  String get taskTag_captureOnTheSide => 'Fang an der Seite';

  @override
  String get taskTag_captureToLive => 'Fang um zu leben';

  @override
  String get taskTag_captureTwoRecaptureOne =>
      'Zwei fangen, einen zurückgewinnen';

  @override
  String get taskTag_capturingRace => 'Freiheitskampf';

  @override
  String get taskTag_capturingTechniques => 'Fangtechniken';

  @override
  String get taskTag_carpentersSquareAndSimilar =>
      'Zimmermannswinkel und ähnliches';

  @override
  String get taskTag_chooseTheFight => 'Wähle den Kampf';

  @override
  String get taskTag_clamp => 'Klemmzug';

  @override
  String get taskTag_clampCapture => 'Klemmzug-Fang';

  @override
  String get taskTag_closeInCapture => 'Closing-in Fang';

  @override
  String get taskTag_combination => 'Kombination';

  @override
  String get taskTag_commonLifeAndDeath => 'Leben & Tod: Häufige Formen';

  @override
  String get taskTag_compareSize => 'Größe vergleichen';

  @override
  String get taskTag_compareValue => 'Werte vergleichen';

  @override
  String get taskTag_completeKoToSecureEndgameAdvantage =>
      'Ko abschließen, um Vorteil im Endspiel zu sichern';

  @override
  String get taskTag_compositeProblems => 'Zusammengesetzte Aufgaben';

  @override
  String get taskTag_comprehensiveTasks => 'Umfassende Aufgaben';

  @override
  String get taskTag_connect => 'Verbinden';

  @override
  String get taskTag_connectAndDie => 'Verbinden und sterben';

  @override
  String get taskTag_connectInOneMove => 'Verbinden in einem Zug';

  @override
  String get taskTag_contactFightTesuji => 'Nahkampf Tesuji';

  @override
  String get taskTag_contactPlay => 'Anlegen';

  @override
  String get taskTag_corner => 'Ecke';

  @override
  String get taskTag_cornerIsGoldSideIsSilverCenterIsGrass =>
      'Ecken sind Gold, Seiten sind Silber, das Zentrum ist Gras';

  @override
  String get taskTag_counter => 'Wiederlegezug';

  @override
  String get taskTag_counterAttack => 'Gegenangriff';

  @override
  String get taskTag_cranesNest => 'Kranichnest';

  @override
  String get taskTag_crawl => 'Kriechen';

  @override
  String get taskTag_createShortageOfLiberties => 'Freiheitsnot schaffen';

  @override
  String get taskTag_crossedFive => 'Stern-Fünf';

  @override
  String get taskTag_cut => 'Schneiden';

  @override
  String get taskTag_cut2 => 'Schneiden';

  @override
  String get taskTag_cutAcross => 'Schneiden';

  @override
  String get taskTag_defendFromInvasion => 'Vor Invasion verteidigen';

  @override
  String get taskTag_defendPoints => 'Punkte verteidigen';

  @override
  String get taskTag_defendWeakPoint => 'Schwachen Punkt verteidigen';

  @override
  String get taskTag_descent => 'Hinabstoßen';

  @override
  String get taskTag_diagonal => 'Diagonal';

  @override
  String get taskTag_directionOfCapture => 'Richtung des Fangens';

  @override
  String get taskTag_directionOfEscape => 'Richtung des Entkommens';

  @override
  String get taskTag_directionOfPlay => 'Richtung des Spiels';

  @override
  String get taskTag_doNotUnderestimateOpponent => 'Gegner nicht unterschätzen';

  @override
  String get taskTag_doubleAtari => 'Doppel Atari';

  @override
  String get taskTag_doubleCapture => 'Doppel-Fang';

  @override
  String get taskTag_doubleKo => 'Doppel-Ko';

  @override
  String get taskTag_doubleSenteEndgame => 'Doppel-Vorhand-Endspiel';

  @override
  String get taskTag_doubleSnapback => 'Doppel-Mausefalle';

  @override
  String get taskTag_endgame => 'Endspiel: Allgemein';

  @override
  String get taskTag_endgameFundamentals => 'Endspielgrundlagen';

  @override
  String get taskTag_endgameIn5x5 => 'Endspiel auf 5x5';

  @override
  String get taskTag_endgameOn4x4 => 'Endspiel auf 4x4';

  @override
  String get taskTag_endgameTesuji => 'Endspiel Tesuji';

  @override
  String get taskTag_engulfingAtari => 'Engulfing Atari';

  @override
  String get taskTag_escape => 'Entkommen';

  @override
  String get taskTag_escapeInOneMove => 'Entkommen in einem Zug';

  @override
  String get taskTag_exploitShapeWeakness => 'Formschwäche ausnutzen';

  @override
  String get taskTag_eyeVsNoEye => 'Auge vs kein Auge';

  @override
  String get taskTag_fillNeutralPoints => 'Neutrale Punkte füllen';

  @override
  String get taskTag_findTheRoot => 'Die Wurzel finden';

  @override
  String get taskTag_firstLineBrilliantMove =>
      'brillante Züge auf der ersten Linie';

  @override
  String get taskTag_flowerSix => 'Blumen-Sechs';

  @override
  String get taskTag_goldenChickenStandingOnOneLeg =>
      'Der goldene Hahn steht auf einem Bein';

  @override
  String get taskTag_groupLiberties => 'Gruppenfreiheiten';

  @override
  String get taskTag_groupsBase => 'Basis der Gruppe';

  @override
  String get taskTag_hane => 'Hane';

  @override
  String get taskTag_increaseEyeSpace => 'Augenraum vergrößern';

  @override
  String get taskTag_increaseLiberties => 'Freiheiten vermehren';

  @override
  String get taskTag_indirectAttack => 'Indirekter Angriff';

  @override
  String get taskTag_influenceKeyPoints => 'Schlüsselstellen für Einfluss';

  @override
  String get taskTag_insideKill => 'Töten von innen';

  @override
  String get taskTag_insideMoves => 'Züge im Inneren';

  @override
  String get taskTag_interestingTasks => 'Interessante Aufgaben';

  @override
  String get taskTag_internalLibertyShortage => 'Interne Freiheitsnot';

  @override
  String get taskTag_invadingTechnique => 'Invasionstechnik';

  @override
  String get taskTag_invasion => 'Invasion';

  @override
  String get taskTag_jGroupAndSimilar => 'J-Gruppe und ähnliche';

  @override
  String get taskTag_josekiFundamentals => 'Joseki-Grundlagen';

  @override
  String get taskTag_jump => 'Springen';

  @override
  String get taskTag_keepSente => 'Vorhand behalten';

  @override
  String get taskTag_killAfterCapture => 'Töten nach dem Fang';

  @override
  String get taskTag_killByEyePointPlacement =>
      'Töten durch Platzierung des Augenpunkts';

  @override
  String get taskTag_knightsMove => 'Rösselsprung';

  @override
  String get taskTag_ko => 'Ko';

  @override
  String get taskTag_kosumiWedge => 'Kosumi Keil';

  @override
  String get taskTag_largeKnightsMove => 'Großer Rösselsprung';

  @override
  String get taskTag_largeMoyoFight => 'Großer Moyo-Kampf';

  @override
  String get taskTag_lifeAndDeath => 'Leben & Tod: Allgemein';

  @override
  String get taskTag_lifeAndDeathOn4x4 => 'Leben und Tod auf 4x4';

  @override
  String get taskTag_lookForLeverage => 'Nach Hebelwirkung suchen';

  @override
  String get taskTag_looseLadder => 'Lose Treppe';

  @override
  String get taskTag_lovesickCut => 'Liebeskummer Schnitt';

  @override
  String get taskTag_makeEye => 'Augen machen';

  @override
  String get taskTag_makeEyeInOneStep => 'Augen in einem Zug machen';

  @override
  String get taskTag_makeEyeInSente => 'Augen in Vorhand machen';

  @override
  String get taskTag_makeKo => 'Ko machen';

  @override
  String get taskTag_makeShape => 'Form machen';

  @override
  String get taskTag_middlegame => 'Mittelspiel';

  @override
  String get taskTag_monkeyClimbingMountain => 'Affe klettert den Berg';

  @override
  String get taskTag_mouseStealingOil => 'Maus stiehlt Öl';

  @override
  String get taskTag_moveOut => 'Entkommen';

  @override
  String get taskTag_moveTowardsEmptySpace =>
      'In Richtung freies Gebiet laufen';

  @override
  String get taskTag_multipleBrilliantMoves => 'Mehrere brillante Züge';

  @override
  String get taskTag_net => 'Netz';

  @override
  String get taskTag_netCapture => 'Netzfang';

  @override
  String get taskTag_observeSubtleDifference =>
      'Subtile Unterschiede beobachten';

  @override
  String get taskTag_occupyEncloseAndApproachCorner =>
      'Besetzen, umschließen und Ecken annähern';

  @override
  String get taskTag_oneStoneTwoPurposes => 'Ein Stein, zwei Zwecke';

  @override
  String get taskTag_opening => 'Eröffnung';

  @override
  String get taskTag_openingChoice => 'Eröffnungswahl';

  @override
  String get taskTag_openingFundamentals => 'Eröffnungsgrundlagen';

  @override
  String get taskTag_orderOfEndgameMoves => 'Reihenfolge der Endspielzüge';

  @override
  String get taskTag_orderOfMoves => 'Reihenfolge der Züge';

  @override
  String get taskTag_orderOfMovesInKo => 'ZUgreihenfolge im Ko';

  @override
  String get taskTag_orioleCapturesButterfly => 'Pirol fängt den Schmetterling';

  @override
  String get taskTag_pincer => 'Klemmzug';

  @override
  String get taskTag_placement => 'Oki (Platzierung)';

  @override
  String get taskTag_plunderingTechnique => 'Plundering Technik';

  @override
  String get taskTag_preventBambooJoint => 'Bambus-Verbindung verhindern';

  @override
  String get taskTag_preventBridgingUnder => 'Unterverbinden verhindern';

  @override
  String get taskTag_preventOpponentFromApproaching => 'Annähern verhindern';

  @override
  String get taskTag_probe => 'Testzug';

  @override
  String get taskTag_profitInSente => 'In Vorhand profitieren';

  @override
  String get taskTag_profitUsingLifeAndDeath => 'Vorteil durch Leben und Tod';

  @override
  String get taskTag_push => 'Oshi (Schieben)';

  @override
  String get taskTag_pyramidFour => 'Vierer-Pyramide';

  @override
  String get taskTag_realEyeAndFalseEye => 'Echtes Auge vs falsches Auge';

  @override
  String get taskTag_rectangularSix => 'Rechteckige Sechs';

  @override
  String get taskTag_reduceEyeSpace => 'Augenraum reduzieren';

  @override
  String get taskTag_reduceLiberties => 'Freiheiten reduzieren';

  @override
  String get taskTag_reduction => 'Reduktion';

  @override
  String get taskTag_runWeakGroup => 'Schwache Gruppe laufen';

  @override
  String get taskTag_sabakiAndUtilizingInfluence =>
      'Sabaki und Einfluss nutzen';

  @override
  String get taskTag_sacrifice => 'Opfer';

  @override
  String get taskTag_sacrificeAndSqueeze => 'Opfer und Auspressen';

  @override
  String get taskTag_sealIn => 'Einschließen';

  @override
  String get taskTag_secondLine => 'Zweite Linie';

  @override
  String get taskTag_seizeTheOpportunity => 'Die Gelegenheit ergreifen';

  @override
  String get taskTag_seki => 'Seki';

  @override
  String get taskTag_senteAndGote => 'Sente und Gote';

  @override
  String get taskTag_settleShape => 'Form festlegen';

  @override
  String get taskTag_settleShapeInSente => 'Form in Vorhand festlegen';

  @override
  String get taskTag_shape => 'Form';

  @override
  String get taskTag_shapesVitalPoint => 'Vitaler Punkt der Form';

  @override
  String get taskTag_side => 'Seite';

  @override
  String get taskTag_smallBoardEndgame => 'Ensdspiel auf kleinem Brett';

  @override
  String get taskTag_snapback => 'Mausefalle';

  @override
  String get taskTag_solidConnection => 'Feste Verbindung';

  @override
  String get taskTag_solidExtension => 'Feste Erweiterung';

  @override
  String get taskTag_splitInOneMove => 'In einem Zug teilen';

  @override
  String get taskTag_splittingMove => 'Teilungszug';

  @override
  String get taskTag_squareFour => 'Klotzige-Vier';

  @override
  String get taskTag_squeeze => 'Auspressen';

  @override
  String get taskTag_standardCapturingRaces => 'Standard Freiheitskämpfe';

  @override
  String get taskTag_standardCornerAndSideEndgame =>
      'Standard Ecken- und Seiten-Endspiel';

  @override
  String get taskTag_straightFour => 'Gerader Vierer';

  @override
  String get taskTag_straightThree => 'Gerader Dreier';

  @override
  String get taskTag_surroundTerritory => 'Territorium umschließen';

  @override
  String get taskTag_symmetricShape => 'Symmetrische Form';

  @override
  String get taskTag_techniqueForReinforcingGroups =>
      'Technik zur Verstärkung von Gruppen';

  @override
  String get taskTag_techniqueForSecuringTerritory =>
      'Technik zur Sicherung des Territoriums';

  @override
  String get taskTag_textbookTasks => 'Textbuch-Aufgaben';

  @override
  String get taskTag_thirdAndFourthLine => 'Dritte und vierte Linie';

  @override
  String get taskTag_threeEyesTwoActions => 'Drei Augen, zwei Aktionen';

  @override
  String get taskTag_threeSpaceExtensionFromTwoStones =>
      'Drei-Raum-Erweiterung von zwei Steinen';

  @override
  String get taskTag_throwIn => 'Einwerfen';

  @override
  String get taskTag_tigersMouth => 'Tigerrachen';

  @override
  String get taskTag_tombstoneSqueeze => 'Grabstein Auspressen';

  @override
  String get taskTag_tripodGroupWithExtraLegAndSimilar =>
      'Tripod-Gruppe mit zusätzlichem Bein und ähnlichem';

  @override
  String get taskTag_twoHaneGainOneLiberty =>
      'Doppel-Hane gewinnt eine Freiheit';

  @override
  String get taskTag_twoHeadedDragon => 'Zweiköpfiger Drache';

  @override
  String get taskTag_twoSpaceExtension => 'Zwei-Raum-Erweiterung';

  @override
  String get taskTag_typesOfKo => 'Arten von Ko';

  @override
  String get taskTag_underTheStones => 'Unter den Steinen';

  @override
  String get taskTag_underneathAttachment => 'Shitatsuke (unterhalb Anlegen)';

  @override
  String get taskTag_urgentPointOfAFight => 'Dringender Punkt eines Kampfes';

  @override
  String get taskTag_urgentPoints => 'Dringende Punkte';

  @override
  String get taskTag_useConnectAndDie => 'Verbinden und sterben';

  @override
  String get taskTag_useCornerSpecialProperties =>
      'Spezielle Eigenschaften der Ecke nutzen';

  @override
  String get taskTag_useDescentToFirstLine => 'Abstieg zur ersten Linie nutzen';

  @override
  String get taskTag_useInfluence => 'Einfluss nutzen';

  @override
  String get taskTag_useOpponentsLifeAndDeath =>
      'Das Leben und Tod des Gegners nutzen';

  @override
  String get taskTag_useShortageOfLiberties => 'Mangel an Freiheiten nutzen';

  @override
  String get taskTag_useSnapback => 'Mausefalle nutzen';

  @override
  String get taskTag_useSurroundingStones => 'Umgebende Steine nutzen';

  @override
  String get taskTag_vitalAndUselessStones => 'Vitale und nutzlose Steine';

  @override
  String get taskTag_vitalPointForBothSides => 'Vitaler Punkt für beide Seiten';

  @override
  String get taskTag_vitalPointForCapturingRace =>
      'Vitaler Punkt für den Freiheitskampf';

  @override
  String get taskTag_vitalPointForIncreasingLiberties =>
      'Vitaler Punkt zur Erhöhung der Freiheiten';

  @override
  String get taskTag_vitalPointForKill => 'Vitaler Punkt für das Töten';

  @override
  String get taskTag_vitalPointForLife => 'Vitaler Punkt für das Leben';

  @override
  String get taskTag_vitalPointForReducingLiberties =>
      'Vitaler Punkt zur Verringerung der Freiheiten';

  @override
  String get taskTag_wedge => 'Warikomi (Keil)';

  @override
  String get taskTag_wedgingCapture => 'Warikomi-Fang';

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
