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
  String get cancel => 'Abbrechen';

  @override
  String get captures => 'Gefangene';

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
  String get msgSearchingForGame => 'Suche nach einem Spiel...';

  @override
  String get msgSgfCopied => 'SGF copied to clipboard';

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
  String get ogsDesc => 'Einer der beliebtesten Server im Westen.';

  @override
  String get ogsName => 'Online Go Server';

  @override
  String get ok => 'OK';

  @override
  String get pass => 'Passen';

  @override
  String get password => 'Passwort';

  @override
  String get play => 'Spielen';

  @override
  String get pleaseMarkDeadStones => 'Please mark the dead stones.';

  @override
  String get promotionRequirements => 'Anforderungen zum Auftsieg';

  @override
  String pxsByoyomi(int p, int s) {
    return '$p×${s}s';
  }

  @override
  String get rank => 'Rang';

  @override
  String get rankedMode => 'Gewerteter Modus';

  @override
  String get recentRecord => 'Letzte Ergebnisse';

  @override
  String get register => 'Registrieren';

  @override
  String get rejectDeadStones => 'Reject dead stones';

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
  String get saveSGF => 'SGF speichern';

  @override
  String get seconds => 'Sekunden';

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
      'ngriff und Verteidigung von Invasionen';

  @override
  String get taskTag_avoidKo => 'Ko vermeiden';

  @override
  String get taskTag_avoidMakingDeadShape => 'Tote Form vermeiden';

  @override
  String get taskTag_avoidTrap => 'Falle ausweichen';

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
  String get taskTag_bend => 'Bend';

  @override
  String get taskTag_bentFour => 'Bent four';

  @override
  String get taskTag_bentFourInTheCorner => 'Bent four in the corner';

  @override
  String get taskTag_bentThree => 'Bent three';

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
  String get taskTag_breakShape => 'Shape verhindern';

  @override
  String get taskTag_bridgeUnder => 'Bridge under';

  @override
  String get taskTag_brilliantSequence => 'Brilliant sequence';

  @override
  String get taskTag_bulkyFive => 'Bulky five';

  @override
  String get taskTag_bump => 'Bump';

  @override
  String get taskTag_captureBySnapback => 'Capture by snapback';

  @override
  String get taskTag_captureInLadder => 'Capture in ladder';

  @override
  String get taskTag_captureInOneMove => 'Capture in one move';

  @override
  String get taskTag_captureOnTheSide => 'Capture on the side';

  @override
  String get taskTag_captureToLive => 'Capture to live';

  @override
  String get taskTag_captureTwoRecaptureOne => 'Capture two, recapture one';

  @override
  String get taskTag_capturingRace => 'Capturing race';

  @override
  String get taskTag_capturingTechniques => 'Capturing techniques';

  @override
  String get taskTag_carpentersSquareAndSimilar =>
      'Carpenter\'s square and similar';

  @override
  String get taskTag_chooseTheFight => 'Choose the fight';

  @override
  String get taskTag_clamp => 'Clamp';

  @override
  String get taskTag_clampCapture => 'Clamp capture';

  @override
  String get taskTag_closeInCapture => 'Closing-in capture';

  @override
  String get taskTag_combination => 'Combination';

  @override
  String get taskTag_commonLifeAndDeath => 'Life & death: common shapes';

  @override
  String get taskTag_compareSize => 'Compare size';

  @override
  String get taskTag_compareValue => 'Compare value';

  @override
  String get taskTag_completeKoToSecureEndgameAdvantage =>
      'Complete ko to secure endgame advantage';

  @override
  String get taskTag_compositeProblems => 'Composite tasks';

  @override
  String get taskTag_comprehensiveTasks => 'Comprehensive tasks';

  @override
  String get taskTag_connect => 'Connect';

  @override
  String get taskTag_connectAndDie => 'Connect and die';

  @override
  String get taskTag_connectInOneMove => 'Connect in one move';

  @override
  String get taskTag_contactFightTesuji => 'Contact fight tesuji';

  @override
  String get taskTag_contactPlay => 'Contact play';

  @override
  String get taskTag_corner => 'Corner';

  @override
  String get taskTag_cornerIsGoldSideIsSilverCenterIsGrass =>
      'Corner is gold, side is silver, center is grass';

  @override
  String get taskTag_counter => 'Counter';

  @override
  String get taskTag_counterAttack => 'Counter-attack';

  @override
  String get taskTag_cranesNest => 'Crane\'s nest';

  @override
  String get taskTag_crawl => 'Crawl';

  @override
  String get taskTag_createShortageOfLiberties =>
      'Create shortage of liberties';

  @override
  String get taskTag_crossedFive => 'Crossed five';

  @override
  String get taskTag_cut => 'Cut';

  @override
  String get taskTag_cut2 => 'Cut';

  @override
  String get taskTag_cutAcross => 'Cut across';

  @override
  String get taskTag_defendFromInvasion => 'Defend from invasion';

  @override
  String get taskTag_defendPoints => 'Defend points';

  @override
  String get taskTag_defendWeakPoint => 'Defend weak point';

  @override
  String get taskTag_descent => 'Descent';

  @override
  String get taskTag_diagonal => 'Diagonal';

  @override
  String get taskTag_directionOfCapture => 'Direction of capture';

  @override
  String get taskTag_directionOfEscape => 'Direction of escape';

  @override
  String get taskTag_directionOfPlay => 'Direction of play';

  @override
  String get taskTag_doNotUnderestimateOpponent =>
      'Do not underestimate opponent';

  @override
  String get taskTag_doubleAtari => 'Double atari';

  @override
  String get taskTag_doubleCapture => 'Double capture';

  @override
  String get taskTag_doubleKo => 'Double ko';

  @override
  String get taskTag_doubleSenteEndgame => 'Double sente endgame';

  @override
  String get taskTag_doubleSnapback => 'Double snapback';

  @override
  String get taskTag_endgame => 'Endgame: general';

  @override
  String get taskTag_endgameFundamentals => 'Endgame fundamentals';

  @override
  String get taskTag_endgameIn5x5 => 'Endgame on 5x5';

  @override
  String get taskTag_endgameOn4x4 => 'Endgame on 4x4';

  @override
  String get taskTag_endgameTesuji => 'Endgame tesuji';

  @override
  String get taskTag_engulfingAtari => 'Engulfing atari';

  @override
  String get taskTag_escape => 'Escape';

  @override
  String get taskTag_escapeInOneMove => 'Escape in one move';

  @override
  String get taskTag_exploitShapeWeakness => 'Exploit shape weakness';

  @override
  String get taskTag_eyeVsNoEye => 'Eye vs no-eye';

  @override
  String get taskTag_fillNeutralPoints => 'Fill neutral points';

  @override
  String get taskTag_findTheRoot => 'Find the root';

  @override
  String get taskTag_firstLineBrilliantMove => 'First line brilliant move';

  @override
  String get taskTag_flowerSix => 'Flower six';

  @override
  String get taskTag_goldenChickenStandingOnOneLeg =>
      'Golden rooster standing on one leg';

  @override
  String get taskTag_groupLiberties => 'Group liberties';

  @override
  String get taskTag_groupsBase => 'Group\'s base';

  @override
  String get taskTag_hane => 'Hane';

  @override
  String get taskTag_increaseEyeSpace => 'Increase eye space';

  @override
  String get taskTag_increaseLiberties => 'Increase liberties';

  @override
  String get taskTag_indirectAttack => 'Indirect attack';

  @override
  String get taskTag_influenceKeyPoints => 'Influence key points';

  @override
  String get taskTag_insideKill => 'Inside kill';

  @override
  String get taskTag_insideMoves => 'Inside moves';

  @override
  String get taskTag_interestingTasks => 'Interesting tasks';

  @override
  String get taskTag_internalLibertyShortage => 'Internal liberty shortage';

  @override
  String get taskTag_invadingTechnique => 'Invading technique';

  @override
  String get taskTag_invasion => 'Invasion';

  @override
  String get taskTag_jGroupAndSimilar => 'J-group and similar';

  @override
  String get taskTag_josekiFundamentals => 'Joseki fundamentals';

  @override
  String get taskTag_jump => 'Jump';

  @override
  String get taskTag_keepSente => 'Keep sente';

  @override
  String get taskTag_killAfterCapture => 'Kill after capture';

  @override
  String get taskTag_killByEyePointPlacement => 'Kill by eye point placement';

  @override
  String get taskTag_knightsMove => 'Knight\'s move';

  @override
  String get taskTag_ko => 'Ko';

  @override
  String get taskTag_kosumiWedge => 'Kosumi wedge';

  @override
  String get taskTag_largeKnightsMove => 'Large knight move';

  @override
  String get taskTag_largeMoyoFight => 'Large moyo fight';

  @override
  String get taskTag_lifeAndDeath => 'Life & death: general';

  @override
  String get taskTag_lifeAndDeathOn4x4 => 'Life and death on 4x4';

  @override
  String get taskTag_lookForLeverage => 'Look for leverage';

  @override
  String get taskTag_looseLadder => 'Loose ladder';

  @override
  String get taskTag_lovesickCut => 'Lovesick cut';

  @override
  String get taskTag_makeEye => 'Make eye';

  @override
  String get taskTag_makeEyeInOneStep => 'Make eye in one step';

  @override
  String get taskTag_makeEyeInSente => 'Make eye in sente';

  @override
  String get taskTag_makeKo => 'Make ko';

  @override
  String get taskTag_makeShape => 'Make shape';

  @override
  String get taskTag_middlegame => 'Middlegame';

  @override
  String get taskTag_monkeyClimbingMountain => 'Monkey climbing the mountain';

  @override
  String get taskTag_mouseStealingOil => 'Mouse stealing oil';

  @override
  String get taskTag_moveOut => 'Move out';

  @override
  String get taskTag_moveTowardsEmptySpace => 'Move towards empty space';

  @override
  String get taskTag_multipleBrilliantMoves => 'Multiple brilliant moves';

  @override
  String get taskTag_net => 'Net';

  @override
  String get taskTag_netCapture => 'Net capture';

  @override
  String get taskTag_observeSubtleDifference => 'Observe subtle difference';

  @override
  String get taskTag_occupyEncloseAndApproachCorner =>
      'Occupy, enclose and approach corners';

  @override
  String get taskTag_oneStoneTwoPurposes => 'One stone, two purposes';

  @override
  String get taskTag_opening => 'Opening';

  @override
  String get taskTag_openingChoice => 'Opening choice';

  @override
  String get taskTag_openingFundamentals => 'Opening fundamentals';

  @override
  String get taskTag_orderOfEndgameMoves => 'Order of endgame moves';

  @override
  String get taskTag_orderOfMoves => 'Order of moves';

  @override
  String get taskTag_orderOfMovesInKo => 'Order of moves in a ko';

  @override
  String get taskTag_orioleCapturesButterfly => 'Oriole captures the butterfly';

  @override
  String get taskTag_pincer => 'Pincer';

  @override
  String get taskTag_placement => 'Placement';

  @override
  String get taskTag_plunderingTechnique => 'Plundering technique';

  @override
  String get taskTag_preventBambooJoint => 'Prevent the bamboo joint';

  @override
  String get taskTag_preventBridgingUnder => 'Prevent bridging under';

  @override
  String get taskTag_preventOpponentFromApproaching =>
      'Prevent opponent from approaching';

  @override
  String get taskTag_probe => 'Probe';

  @override
  String get taskTag_profitInSente => 'Profit in sente';

  @override
  String get taskTag_profitUsingLifeAndDeath => 'Profit using life and death';

  @override
  String get taskTag_push => 'Push';

  @override
  String get taskTag_pyramidFour => 'Pyramid four';

  @override
  String get taskTag_realEyeAndFalseEye => 'Real eye vs false eye';

  @override
  String get taskTag_rectangularSix => 'Rectangular six';

  @override
  String get taskTag_reduceEyeSpace => 'Reduce eye space';

  @override
  String get taskTag_reduceLiberties => 'Reduce liberties';

  @override
  String get taskTag_reduction => 'Reduction';

  @override
  String get taskTag_runWeakGroup => 'Run weak group';

  @override
  String get taskTag_sabakiAndUtilizingInfluence =>
      'Sabaki and utilizing influence';

  @override
  String get taskTag_sacrifice => 'Sacrifice';

  @override
  String get taskTag_sacrificeAndSqueeze => 'Sacrifice and squeeze';

  @override
  String get taskTag_sealIn => 'Seal in';

  @override
  String get taskTag_secondLine => 'Second line';

  @override
  String get taskTag_seizeTheOpportunity => 'Seize the opportunity';

  @override
  String get taskTag_seki => 'Seki';

  @override
  String get taskTag_senteAndGote => 'Sente and gote';

  @override
  String get taskTag_settleShape => 'Settle shape';

  @override
  String get taskTag_settleShapeInSente => 'Settle shape in sente';

  @override
  String get taskTag_shape => 'Shape';

  @override
  String get taskTag_shapesVitalPoint => 'Shape\'s vital point';

  @override
  String get taskTag_side => 'Side';

  @override
  String get taskTag_smallBoardEndgame => 'Small board endgame';

  @override
  String get taskTag_snapback => 'Snapback';

  @override
  String get taskTag_solidConnection => 'Solid connection';

  @override
  String get taskTag_solidExtension => 'Solid extension';

  @override
  String get taskTag_splitInOneMove => 'Split in one move';

  @override
  String get taskTag_splittingMove => 'Splitting move';

  @override
  String get taskTag_squareFour => 'Square four';

  @override
  String get taskTag_squeeze => 'Squeeze';

  @override
  String get taskTag_standardCapturingRaces => 'Standard capturing races';

  @override
  String get taskTag_standardCornerAndSideEndgame =>
      'Standard corner and side endgame';

  @override
  String get taskTag_straightFour => 'Straight four';

  @override
  String get taskTag_straightThree => 'Straight three';

  @override
  String get taskTag_surroundTerritory => 'Surround territory';

  @override
  String get taskTag_symmetricShape => 'Symmetric shape';

  @override
  String get taskTag_techniqueForReinforcingGroups =>
      'Technique for reinforcing groups';

  @override
  String get taskTag_techniqueForSecuringTerritory =>
      'Technique for securing territory';

  @override
  String get taskTag_textbookTasks => 'Textbook tasks';

  @override
  String get taskTag_thirdAndFourthLine => 'Third and fourth line';

  @override
  String get taskTag_threeEyesTwoActions => 'Three eyes, two actions';

  @override
  String get taskTag_threeSpaceExtensionFromTwoStones =>
      'Three-space extension from two stones';

  @override
  String get taskTag_throwIn => 'Throw-in';

  @override
  String get taskTag_tigersMouth => 'Tiger\'s mouth';

  @override
  String get taskTag_tombstoneSqueeze => 'Tombstone squeeze';

  @override
  String get taskTag_tripodGroupWithExtraLegAndSimilar =>
      'Tripod group with extra leg and similar';

  @override
  String get taskTag_twoHaneGainOneLiberty => 'Double hane grows one liberty';

  @override
  String get taskTag_twoHeadedDragon => 'Two-headed dragon';

  @override
  String get taskTag_twoSpaceExtension => 'Two-space extension';

  @override
  String get taskTag_typesOfKo => 'Types of ko';

  @override
  String get taskTag_underTheStones => 'Under the stones';

  @override
  String get taskTag_underneathAttachment => 'Underneath attachment';

  @override
  String get taskTag_urgentPointOfAFight => 'Urgent point of a fight';

  @override
  String get taskTag_urgentPoints => 'Urgent points';

  @override
  String get taskTag_useConnectAndDie => 'Use connect and die';

  @override
  String get taskTag_useCornerSpecialProperties =>
      'Use corner special properties';

  @override
  String get taskTag_useDescentToFirstLine => 'Use descent to first line';

  @override
  String get taskTag_useInfluence => 'Use influence';

  @override
  String get taskTag_useOpponentsLifeAndDeath =>
      'Use opponent\'s life and death';

  @override
  String get taskTag_useShortageOfLiberties => 'Use shortage of liberties';

  @override
  String get taskTag_useSnapback => 'Use snapback';

  @override
  String get taskTag_useSurroundingStones => 'Use surrounding stones';

  @override
  String get taskTag_vitalAndUselessStones => 'Vital and useless stones';

  @override
  String get taskTag_vitalPointForBothSides => 'Vital point for both sides';

  @override
  String get taskTag_vitalPointForCapturingRace =>
      'Vital point for capturing race';

  @override
  String get taskTag_vitalPointForIncreasingLiberties =>
      'Vital point for increasing liberties';

  @override
  String get taskTag_vitalPointForKill => 'Vital point for kill';

  @override
  String get taskTag_vitalPointForLife => 'Vital point for life';

  @override
  String get taskTag_vitalPointForReducingLiberties =>
      'Vital point for reducing liberties';

  @override
  String get taskTag_wedge => 'Wedge';

  @override
  String get taskTag_wedgingCapture => 'Wedging capture';

  @override
  String get taskTimeout => 'Timeout';

  @override
  String get taskTypeAppreciation => 'Appreciation';

  @override
  String get taskTypeCapture => 'Capture stones';

  @override
  String get taskTypeCaptureRace => 'Capture race';

  @override
  String get taskTypeEndgame => 'Endgame';

  @override
  String get taskTypeJoseki => 'Joseki';

  @override
  String get taskTypeLifeAndDeath => 'Life & death';

  @override
  String get taskTypeMiddlegame => 'Middlegame';

  @override
  String get taskTypeOpening => 'Opening';

  @override
  String get taskTypeTesuji => 'Tesuji';

  @override
  String get taskTypeTheory => 'Theory';

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
