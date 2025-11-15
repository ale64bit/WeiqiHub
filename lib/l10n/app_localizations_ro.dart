// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get about => 'Despre';

  @override
  String get acceptDeadStones => 'Acceptă pietrele moarte';

  @override
  String get accuracy => 'Precizie';

  @override
  String get aiReferee => 'Arbitru AI';

  @override
  String get aiSensei => 'AI Sensei';

  @override
  String get alwaysBlackToPlay => 'Întotdeauna negru la mutare';

  @override
  String get alwaysBlackToPlayDesc =>
      'Setează toate sarcinile ca fiind negru la mutare pentru a evita confuzia';

  @override
  String get appearance => 'Aspect';

  @override
  String get autoCounting => 'Numărare automată';

  @override
  String get autoMatch => 'Potrivire automată';

  @override
  String get behaviour => 'Comportament';

  @override
  String get bestResult => 'Cel mai bun rezultat';

  @override
  String get black => 'Negru';

  @override
  String get board => 'Tabelă';

  @override
  String get boardSize => 'Dimensiunea tablei';

  @override
  String get boardTheme => 'Temă a tablei';

  @override
  String get byRank => 'După rang';

  @override
  String get cancel => 'Anulează';

  @override
  String get captures => 'Capturi';

  @override
  String get clearBoard => 'Curăță tabla';

  @override
  String get collectStats => 'Colectează statistici';

  @override
  String get collections => 'Colecții';

  @override
  String get confirm => 'Confirmă';

  @override
  String get confirmBoardSize => 'Confirmă dimensiunea tablei';

  @override
  String get confirmBoardSizeDesc =>
      'Tablele de această dimensiune sau mai mari necesită confirmarea mutărilor';

  @override
  String get confirmMoves => 'Confirmă mutările';

  @override
  String get confirmMovesDesc =>
      'Atinge de două ori pentru a confirma mutările pe table mari pentru a evita greșelile';

  @override
  String get continue_ => 'Continuă';

  @override
  String get copySGF => 'Copiază SGF';

  @override
  String get copyTaskLink => 'Copiază linkul sarcinii';

  @override
  String get customExam => 'Examen personalizat';

  @override
  String get dark => 'Întunecat';

  @override
  String get dontShowAgain => 'Nu mai arăta din nou';

  @override
  String get download => 'Descarcă';

  @override
  String get edgeLine => 'Linie de margine';

  @override
  String get empty => 'Gol';

  @override
  String get endgameExam => 'Examen de sfirsitul jocului';

  @override
  String get enterTaskLink => 'Introdu linkul sarcinii';

  @override
  String get errCannotBeEmpty => 'Nu poate fi gol';

  @override
  String get errFailedToDownloadGame => 'Descărcarea jocului a eșuat';

  @override
  String get errFailedToLoadGameList =>
      'Încărcarea listei de jocuri a eșuat. Te rugăm să încerci din nou.';

  @override
  String get errFailedToUploadGameToAISensei =>
      'Încărcarea jocului în AI Sensei a eșuat';

  @override
  String get errIncorrectUsernameOrPassword =>
      'Nume de utilizator sau parolă incorecte';

  @override
  String errMustBeAtLeast(num n) {
    return 'Trebuie să fie cel puțin $n';
  }

  @override
  String errMustBeAtMost(num n) {
    return 'Trebuie să fie cel mult $n';
  }

  @override
  String get errMustBeInteger => 'Trebuie să fie un număr întreg';

  @override
  String get exit => 'Ieșire';

  @override
  String get exitTryMode => 'Ieși din modul de încercare';

  @override
  String get find => 'Caută';

  @override
  String get findTask => 'Caută sarcina';

  @override
  String get findTaskByLink => 'După link';

  @override
  String get findTaskByPattern => 'După tipar';

  @override
  String get findTaskResults => 'Rezultatele căutării';

  @override
  String get findTaskSearching => 'Se caută...';

  @override
  String get forceCounting => 'Forțează numărarea';

  @override
  String get foxwqDesc => 'Cel mai popular server din China și din lume.';

  @override
  String get foxwqName => 'Fox Weiqi';

  @override
  String get gameInfo => 'Informații despre joc';

  @override
  String get gameRecord => 'Înregistrare joc';

  @override
  String get gradingExam => 'Examen de clasificare';

  @override
  String get handicap => 'Handicap';

  @override
  String get help => 'Ajutor';

  @override
  String get helpDialogCollections =>
      'Colecțiile sunt seturi clasice, selectate cu grijă, de sarcini de înaltă calitate care au o valoare specială ca resursă de antrenament.\n\nObiectivul principal este să rezolvi o colecție cu o rată mare de succes. Un obiectiv secundar este să o rezolvi cât mai repede posibil.\n\nPentru a începe sau a continua rezolvarea unei colecții, glisează spre stânga pe elementul colecției în modul portret sau apasă butoanele Start/Continuă în modul peisaj.';

  @override
  String get helpDialogEndgameExam =>
      '- Examenele de final sunt seturi de 10 sarcini de final și ai 45 de secunde pentru fiecare.\n\n- Promovezi examenul dacă rezolvi corect 8 sau mai multe (rata de succes 80%).\n\n- Promovarea examenului pentru un anumit rang deblochează examenul pentru următorul rang.';

  @override
  String get helpDialogGradingExam =>
      '- Examenele de clasificare sunt seturi de 10 sarcini și ai 45 de secunde pentru fiecare.\n\n- Promovezi examenul dacă rezolvi corect 8 sau mai multe (rata de succes 80%).\n\n- Promovarea examenului pentru un anumit rang deblochează examenul pentru următorul rang.';

  @override
  String get helpDialogRankedMode =>
      '- Rezolvă sarcini fără limită de timp.\n\n- Dificultatea sarcinilor crește în funcție de cât de repede le rezolvi.\n\n- Concentrează-te pe a rezolva corect și atinge cel mai înalt rang posibil.';

  @override
  String get helpDialogTimeFrenzy =>
      '- Ai 3 minute pentru a rezolva cât mai multe sarcini posibil.\n\n- Sarcinile devin tot mai dificile pe măsură ce le rezolvi.\n\n- Dacă faci 3 greșeli, ești eliminat.';

  @override
  String get home => 'Acasă';

  @override
  String get komi => 'Komi';

  @override
  String get language => 'Limbă';

  @override
  String get leave => 'Părăsește';

  @override
  String get light => 'Luminos';

  @override
  String get login => 'Autentificare';

  @override
  String get logout => 'Deconectare';

  @override
  String get long => 'Lung';

  @override
  String mMinutes(int m) {
    return '${m}min';
  }

  @override
  String get maxNumberOfMistakes => 'Număr maxim de greșeli';

  @override
  String get maxRank => 'Rang maxim';

  @override
  String get medium => 'Mediu';

  @override
  String get minRank => 'Rang minim';

  @override
  String get minutes => 'Minute';

  @override
  String get month => 'Lună';

  @override
  String get msgCannotUseAIRefereeYet => 'Arbitrul AI nu poate fi folosit încă';

  @override
  String get msgCannotUseForcedCountingYet =>
      'Numărarea forțată nu poate fi folosită încă';

  @override
  String get msgConfirmDeleteCollectionProgress =>
      'Ești sigur că vrei să ștergi încercarea anterioară?';

  @override
  String get msgConfirmResignation => 'Ești sigur că vrei să renunți?';

  @override
  String msgConfirmStopEvent(String event) {
    return 'Ești sigur că vrei să oprești $event?';
  }

  @override
  String get msgDownloadingGame => 'Se descarcă jocul';

  @override
  String msgGameSavedTo(String path) {
    return 'Joc salvat în $path';
  }

  @override
  String get msgPleaseWaitForYourTurn => 'Te rog, așteaptă-ți rândul';

  @override
  String get msgSearchingForGame => 'Se caută un joc...';

  @override
  String get msgSgfCopied => 'SGF copiat în clipboard';

  @override
  String get msgTaskLinkCopied => 'Linkul sarcinii a fost copiat.';

  @override
  String get msgWaitingForOpponentsDecision =>
      'Se așteaptă decizia adversarului...';

  @override
  String get msgYouCannotPass => 'Nu poți pasa';

  @override
  String get msgYourOpponentDisagreesWithCountingResult =>
      'Adversarul tău nu este de acord cu rezultatul numărării';

  @override
  String get msgYourOpponentRefusesToCount => 'Adversarul tău refuză să numere';

  @override
  String get msgYourOpponentRequestsAutomaticCounting =>
      'Adversarul tău solicită numărarea automată. Ești de acord?';

  @override
  String get myGames => 'Jocurile mele';

  @override
  String get myMistakes => 'Greșelile mele';

  @override
  String nTasks(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString sarcini',
      one: '1 sarcină',
      zero: 'Nicio sarcină',
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
      other: '$countString sarcini disponibile',
      one: '1 sarcină disponibilă',
      zero: 'Nicio sarcină disponibilă',
    );
    return '$_temp0';
  }

  @override
  String get newBestResult => 'Cel mai bun rezultat nou!';

  @override
  String get no => 'Nu';

  @override
  String get none => 'Niciuna';

  @override
  String get numberOfTasks => 'Număr de sarcini';

  @override
  String nxnBoardSize(int n) {
    return '$n×$n';
  }

  @override
  String get ogsDesc => 'Suport beta pentru online-go.com';

  @override
  String get ogsName => 'Serverul Online Go';

  @override
  String get ok => 'OK';

  @override
  String get pass => 'Pasează';

  @override
  String get password => 'Parolă';

  @override
  String get play => 'Joacă';

  @override
  String get pleaseMarkDeadStones => 'Te rog marchează pietrele moarte.';

  @override
  String get promotionRequirements => 'Cerințe pentru promovare';

  @override
  String pxsByoyomi(int p, int s) {
    return '$p×${s}s';
  }

  @override
  String get rank => 'Rang';

  @override
  String get rankedMode => 'Mod clasament';

  @override
  String get recentRecord => 'Rezultate recente';

  @override
  String get register => 'Înregistrare';

  @override
  String get rejectDeadStones => 'Respinge pietrele moarte';

  @override
  String get resign => 'Renunță';

  @override
  String get responseDelay => 'Întârziere răspuns';

  @override
  String get responseDelayDesc =>
      'Durata întârzierii înainte ca răspunsul să apară în timpul rezolvării sarcinilor';

  @override
  String get responseDelayLong => 'Lungă';

  @override
  String get responseDelayMedium => 'Medie';

  @override
  String get responseDelayNone => 'Fără';

  @override
  String get responseDelayShort => 'Scurtă';

  @override
  String get result => 'Rezultat';

  @override
  String get resultAccept => 'Acceptă';

  @override
  String get resultReject => 'Respinge';

  @override
  String get rules => 'Reguli';

  @override
  String get rulesChinese => 'Chineze';

  @override
  String get rulesJapanese => 'Japoneze';

  @override
  String get rulesKorean => 'Coreene';

  @override
  String sSeconds(int s) {
    return '${s}s';
  }

  @override
  String get save => 'Salvează';

  @override
  String get saveSGF => 'Salvează SGF';

  @override
  String get seconds => 'Secunde';

  @override
  String get settings => 'Setări';

  @override
  String get short => 'Scurt';

  @override
  String get showCoordinates => 'Afișează coordonatele';

  @override
  String get showMoveErrorsAsCrosses => 'Afișează mutările greșite ca cruci';

  @override
  String get showMoveErrorsAsCrossesDesc =>
      'Afișează mutările greșite ca cruci roșii în loc de puncte roșii';

  @override
  String get simple => 'Simplu';

  @override
  String get sortModeDifficult => 'Dificil';

  @override
  String get sortModeRecent => 'Recent';

  @override
  String get sound => 'Sunet';

  @override
  String get start => 'Start';

  @override
  String get statistics => 'Statistici';

  @override
  String get statsDateColumn => 'Dată';

  @override
  String get statsDurationColumn => 'Durată';

  @override
  String get statsTimeColumn => 'Timp';

  @override
  String get stoneShadows => 'Umbrele pietrelor';

  @override
  String get stones => 'Pietre';

  @override
  String get subtopic => 'Subtemă';

  @override
  String get system => 'Sistem';

  @override
  String get task => 'Sarcină';

  @override
  String get taskCorrect => 'Corect';

  @override
  String get taskNext => 'Următorul';

  @override
  String get taskNotFound => 'Sarcina nu a fost găsită';

  @override
  String get taskRedo => 'Reia';

  @override
  String get taskSource => 'Sursă sarcină';

  @override
  String get taskSourceFromMyMistakes => 'Din greșelile mele';

  @override
  String get taskSourceFromTaskTopic => 'Din subiectul sarcinii';

  @override
  String get taskSourceFromTaskTypes => 'Din tipurile de sarcini';

  @override
  String get taskTag_afterJoseki => 'După joseki';

  @override
  String get taskTag_aiOpening => 'Deschidere AI';

  @override
  String get taskTag_aiVariations => 'Variații AI';

  @override
  String get taskTag_attack => 'Atac';

  @override
  String get taskTag_attackAndDefenseInKo => 'Atac și apărare într-un ko';

  @override
  String get taskTag_attackAndDefenseOfCuts => 'Atac și apărare la tăieturi';

  @override
  String get taskTag_attackAndDefenseOfInvadingStones =>
      'Atac și apărare ale pietrelor invadatoare';

  @override
  String get taskTag_avoidKo => 'Evită ko-ul';

  @override
  String get taskTag_avoidMakingDeadShape => 'Evită formarea unei forme moarte';

  @override
  String get taskTag_avoidTrap => 'Evită capcana';

  @override
  String get taskTag_basicEndgame => 'Final: elementar';

  @override
  String get taskTag_basicLifeAndDeath => 'Viață și moarte: elementar';

  @override
  String get taskTag_basicMoves => 'Mutări de bază';

  @override
  String get taskTag_basicTesuji => 'Tesuji de bază';

  @override
  String get taskTag_beginner => 'Începător';

  @override
  String get taskTag_bend => 'Îndoire';

  @override
  String get taskTag_bentFour => 'Patru îndoite';

  @override
  String get taskTag_bentFourInTheCorner => 'Patru îndoite în colț';

  @override
  String get taskTag_bentThree => 'Trei îndoite';

  @override
  String get taskTag_bigEyeLiberties => 'Libertățile unui ochi mare';

  @override
  String get taskTag_bigEyeVsSmallEye => 'Ochi mare vs ochi mic';

  @override
  String get taskTag_bigPoints => 'Puncte mari';

  @override
  String get taskTag_blindSpot => 'Punct mort';

  @override
  String get taskTag_breakEye => 'Distruge ochiul';

  @override
  String get taskTag_breakEyeInOneStep =>
      'Distruge ochiul dintr-o singură mutare';

  @override
  String get taskTag_breakEyeInSente => 'Distruge ochiul în sente';

  @override
  String get taskTag_breakOut => 'Evadează';

  @override
  String get taskTag_breakPoints => 'Distruge punctele';

  @override
  String get taskTag_breakShape => 'Distruge forma';

  @override
  String get taskTag_bridgeUnder => 'Pod dedesubt';

  @override
  String get taskTag_brilliantSequence => 'Secvență strălucită';

  @override
  String get taskTag_bulkyFive => 'Cinci voluminoase';

  @override
  String get taskTag_bump => 'Împinge';

  @override
  String get taskTag_captureBySnapback => 'Captură prin snapback';

  @override
  String get taskTag_captureInLadder => 'Captură în scară';

  @override
  String get taskTag_captureInOneMove => 'Captură într-o mutare';

  @override
  String get taskTag_captureOnTheSide => 'Captură pe margine';

  @override
  String get taskTag_captureToLive => 'Captură pentru a trăi';

  @override
  String get taskTag_captureTwoRecaptureOne =>
      'Capturează două, recapturează una';

  @override
  String get taskTag_capturingRace => 'Cursă de capturare';

  @override
  String get taskTag_capturingTechniques => 'Tehnici de capturare';

  @override
  String get taskTag_carpentersSquareAndSimilar =>
      'Pătratul tâmplarului și forme similare';

  @override
  String get taskTag_chooseTheFight => 'Alege lupta';

  @override
  String get taskTag_clamp => 'Prindere (clamp)';

  @override
  String get taskTag_clampCapture => 'Captură prin prindere';

  @override
  String get taskTag_closeInCapture => 'Captură prin închidere';

  @override
  String get taskTag_combination => 'Combinație';

  @override
  String get taskTag_commonLifeAndDeath => 'Viață și moarte: forme comune';

  @override
  String get taskTag_compareSize => 'Compară dimensiunea';

  @override
  String get taskTag_compareValue => 'Compară valoarea';

  @override
  String get taskTag_completeKoToSecureEndgameAdvantage =>
      'Finalizează ko-ul pentru a asigura un avantaj în final';

  @override
  String get taskTag_compositeProblems => 'Sarcini compuse';

  @override
  String get taskTag_comprehensiveTasks => 'Sarcini cuprinzătoare';

  @override
  String get taskTag_connect => 'Conectează';

  @override
  String get taskTag_connectAndDie => 'Conectează și mori';

  @override
  String get taskTag_connectInOneMove => 'Conectează dintr-o mutare';

  @override
  String get taskTag_contactFightTesuji => 'Tesuji de luptă prin contact';

  @override
  String get taskTag_contactPlay => 'Mutare de contact';

  @override
  String get taskTag_corner => 'Colț';

  @override
  String get taskTag_cornerIsGoldSideIsSilverCenterIsGrass =>
      'Colțul e aur, marginea e argint, centrul e iarbă';

  @override
  String get taskTag_counter => 'Contra';

  @override
  String get taskTag_counterAttack => 'Contraatac';

  @override
  String get taskTag_cranesNest => 'Cuibul cocorului';

  @override
  String get taskTag_crawl => 'Târâre';

  @override
  String get taskTag_createShortageOfLiberties => 'Creează lipsă de libertăți';

  @override
  String get taskTag_crossedFive => 'Cinci încrucișate';

  @override
  String get taskTag_cut => 'Taie';

  @override
  String get taskTag_cut2 => 'Taie';

  @override
  String get taskTag_cutAcross => 'Taie de-a curmezișul';

  @override
  String get taskTag_defendFromInvasion => 'Apără de invazie';

  @override
  String get taskTag_defendPoints => 'Apără punctele';

  @override
  String get taskTag_defendWeakPoint => 'Apără punctul slab';

  @override
  String get taskTag_descent => 'Coborâre';

  @override
  String get taskTag_diagonal => 'Diagonală';

  @override
  String get taskTag_directionOfCapture => 'Direcția capturii';

  @override
  String get taskTag_directionOfEscape => 'Direcția evadării';

  @override
  String get taskTag_directionOfPlay => 'Direcția jocului';

  @override
  String get taskTag_doNotUnderestimateOpponent => 'Nu-ți subestima adversarul';

  @override
  String get taskTag_doubleAtari => 'Dublu atari';

  @override
  String get taskTag_doubleCapture => 'Captură dublă';

  @override
  String get taskTag_doubleKo => 'Ko dublu';

  @override
  String get taskTag_doubleSenteEndgame => 'Final dublu sente';

  @override
  String get taskTag_doubleSnapback => 'Snapback dublu';

  @override
  String get taskTag_endgame => 'Final: general';

  @override
  String get taskTag_endgameFundamentals => 'Bazele finalului';

  @override
  String get taskTag_endgameIn5x5 => 'Final pe 5x5';

  @override
  String get taskTag_endgameOn4x4 => 'Final pe 4x4';

  @override
  String get taskTag_endgameTesuji => 'Tesuji de final';

  @override
  String get taskTag_engulfingAtari => 'Atari de învăluire';

  @override
  String get taskTag_escape => 'Evadare';

  @override
  String get taskTag_escapeInOneMove => 'Evadare dintr-o mutare';

  @override
  String get taskTag_exploitShapeWeakness => 'Exploatează slăbiciunea formei';

  @override
  String get taskTag_eyeVsNoEye => 'Ochi vs fără ochi';

  @override
  String get taskTag_fillNeutralPoints => 'Umple punctele neutre';

  @override
  String get taskTag_findTheRoot => 'Găsește rădăcina';

  @override
  String get taskTag_firstLineBrilliantMove =>
      'Mutare strălucită pe prima linie';

  @override
  String get taskTag_flowerSix => 'Șase în formă de floare';

  @override
  String get taskTag_goldenChickenStandingOnOneLeg =>
      'Cocoșul de aur stând pe un picior';

  @override
  String get taskTag_groupLiberties => 'Libertățile grupului';

  @override
  String get taskTag_groupsBase => 'Baza grupului';

  @override
  String get taskTag_hane => 'Hane';

  @override
  String get taskTag_increaseEyeSpace => 'Mărește spațiul ochiului';

  @override
  String get taskTag_increaseLiberties => 'Mărește libertățile';

  @override
  String get taskTag_indirectAttack => 'Atac indirect';

  @override
  String get taskTag_influenceKeyPoints => 'Puncte-cheie de influență';

  @override
  String get taskTag_insideKill => 'Ucidere din interior';

  @override
  String get taskTag_insideMoves => 'Mutări interioare';

  @override
  String get taskTag_interestingTasks => 'Sarcini interesante';

  @override
  String get taskTag_internalLibertyShortage => 'Lipsă internă de libertăți';

  @override
  String get taskTag_invadingTechnique => 'Tehnică de invazie';

  @override
  String get taskTag_invasion => 'Invazie';

  @override
  String get taskTag_jGroupAndSimilar => 'Grupul J și forme similare';

  @override
  String get taskTag_josekiFundamentals => 'Bazele joseki';

  @override
  String get taskTag_jump => 'Salt';

  @override
  String get taskTag_keepSente => 'Păstrează sente';

  @override
  String get taskTag_killAfterCapture => 'Ucide după captură';

  @override
  String get taskTag_killByEyePointPlacement =>
      'Ucide prin plasarea pe punctul ochiului';

  @override
  String get taskTag_knightsMove => 'Mutarea calului';

  @override
  String get taskTag_ko => 'Ko';

  @override
  String get taskTag_kosumiWedge => 'Pană kosumi';

  @override
  String get taskTag_largeKnightsMove => 'Mutarea mare a calului';

  @override
  String get taskTag_largeMoyoFight => 'Luptă în moyo mare';

  @override
  String get taskTag_lifeAndDeath => 'Viață și moarte: general';

  @override
  String get taskTag_lifeAndDeathOn4x4 => 'Viață și moarte pe 4x4';

  @override
  String get taskTag_lookForLeverage => 'Caută avantajul (leverage)';

  @override
  String get taskTag_looseLadder => 'Scară lejeră';

  @override
  String get taskTag_lovesickCut => 'Tăietură a îndrăgostitului';

  @override
  String get taskTag_makeEye => 'Creează un ochi';

  @override
  String get taskTag_makeEyeInOneStep => 'Creează un ochi dintr-o mutare';

  @override
  String get taskTag_makeEyeInSente => 'Creează un ochi în sente';

  @override
  String get taskTag_makeKo => 'Creează un ko';

  @override
  String get taskTag_makeShape => 'Creează formă';

  @override
  String get taskTag_middlegame => 'Joc de mijloc';

  @override
  String get taskTag_monkeyClimbingMountain => 'Maimuța urcând muntele';

  @override
  String get taskTag_mouseStealingOil => 'Șoarecele furând ulei';

  @override
  String get taskTag_moveOut => 'Ieși afară';

  @override
  String get taskTag_moveTowardsEmptySpace => 'Mută-te spre spațiul gol';

  @override
  String get taskTag_multipleBrilliantMoves => 'Mai multe mutări strălucite';

  @override
  String get taskTag_net => 'Plasă';

  @override
  String get taskTag_netCapture => 'Captură prin plasă';

  @override
  String get taskTag_observeSubtleDifference => 'Observă diferența subtilă';

  @override
  String get taskTag_occupyEncloseAndApproachCorner =>
      'Ocupă, închide și abordează colțurile';

  @override
  String get taskTag_oneStoneTwoPurposes => 'O piatră, două scopuri';

  @override
  String get taskTag_opening => 'Deschidere';

  @override
  String get taskTag_openingChoice => 'Alegerea deschiderii';

  @override
  String get taskTag_openingFundamentals => 'Bazele deschiderii';

  @override
  String get taskTag_orderOfEndgameMoves => 'Ordinea mutărilor în final';

  @override
  String get taskTag_orderOfMoves => 'Ordinea mutărilor';

  @override
  String get taskTag_orderOfMovesInKo => 'Ordinea mutărilor într-un ko';

  @override
  String get taskTag_orioleCapturesButterfly =>
      'Privighetoarea capturează fluturele';

  @override
  String get taskTag_pincer => 'Clește (pincer)';

  @override
  String get taskTag_placement => 'Plasare';

  @override
  String get taskTag_plunderingTechnique => 'Tehnică de jefuire';

  @override
  String get taskTag_preventBambooJoint => 'Previne îmbinarea de bambus';

  @override
  String get taskTag_preventBridgingUnder => 'Previne podul dedesubt';

  @override
  String get taskTag_preventOpponentFromApproaching =>
      'Împiedică adversarul să se apropie';

  @override
  String get taskTag_probe => 'Sondaj (probe)';

  @override
  String get taskTag_profitInSente => 'Profit în sente';

  @override
  String get taskTag_profitUsingLifeAndDeath =>
      'Profit folosind viață și moarte';

  @override
  String get taskTag_push => 'Împinge';

  @override
  String get taskTag_pyramidFour => 'Piramidă de patru';

  @override
  String get taskTag_realEyeAndFalseEye => 'Ochi real vs ochi fals';

  @override
  String get taskTag_rectangularSix => 'Șase dreptunghiulare';

  @override
  String get taskTag_reduceEyeSpace => 'Reduce spațiul ochiului';

  @override
  String get taskTag_reduceLiberties => 'Reduce libertățile';

  @override
  String get taskTag_reduction => 'Reducere';

  @override
  String get taskTag_runWeakGroup => 'Fă grupul slab să fugă';

  @override
  String get taskTag_sabakiAndUtilizingInfluence =>
      'Sabaki și utilizarea influenței';

  @override
  String get taskTag_sacrifice => 'Sacrificiu';

  @override
  String get taskTag_sacrificeAndSqueeze => 'Sacrificiu și strângere';

  @override
  String get taskTag_sealIn => 'Încercuiește (sigilează înăuntru)';

  @override
  String get taskTag_secondLine => 'A doua linie';

  @override
  String get taskTag_seizeTheOpportunity => 'Prinde oportunitatea';

  @override
  String get taskTag_seki => 'Seki';

  @override
  String get taskTag_senteAndGote => 'Sente și gote';

  @override
  String get taskTag_settleShape => 'Stabilizează forma';

  @override
  String get taskTag_settleShapeInSente => 'Stabilizează forma în sente';

  @override
  String get taskTag_shape => 'Formă';

  @override
  String get taskTag_shapesVitalPoint => 'Punctul vital al formei';

  @override
  String get taskTag_side => 'Margine';

  @override
  String get taskTag_smallBoardEndgame => 'Final pe tablă mică';

  @override
  String get taskTag_snapback => 'Snapback';

  @override
  String get taskTag_solidConnection => 'Conectare solidă';

  @override
  String get taskTag_solidExtension => 'Extensie solidă';

  @override
  String get taskTag_splitInOneMove => 'Desparte dintr-o mutare';

  @override
  String get taskTag_splittingMove => 'Mutare de separare';

  @override
  String get taskTag_squareFour => 'Pătrat de patru';

  @override
  String get taskTag_squeeze => 'Strângere';

  @override
  String get taskTag_standardCapturingRaces => 'Cursă standard de capturare';

  @override
  String get taskTag_standardCornerAndSideEndgame =>
      'Final standard de colț și margine';

  @override
  String get taskTag_straightFour => 'Patru în linie';

  @override
  String get taskTag_straightThree => 'Trei în linie';

  @override
  String get taskTag_surroundTerritory => 'Încercuiește teritoriul';

  @override
  String get taskTag_symmetricShape => 'Formă simetrică';

  @override
  String get taskTag_techniqueForReinforcingGroups =>
      'Tehnică de consolidare a grupurilor';

  @override
  String get taskTag_techniqueForSecuringTerritory =>
      'Tehnică pentru asigurarea teritoriului';

  @override
  String get taskTag_textbookTasks => 'Sarcini din manual';

  @override
  String get taskTag_thirdAndFourthLine => 'Linia a treia și a patra';

  @override
  String get taskTag_threeEyesTwoActions => 'Trei ochi, două acțiuni';

  @override
  String get taskTag_threeSpaceExtensionFromTwoStones =>
      'Extensie de trei spații de la două pietre';

  @override
  String get taskTag_throwIn => 'Aruncare înăuntru (throw-in)';

  @override
  String get taskTag_tigersMouth => 'Gura tigrului';

  @override
  String get taskTag_tombstoneSqueeze => 'Strângerea pietrei funerare';

  @override
  String get taskTag_tripodGroupWithExtraLegAndSimilar =>
      'Grup tripod cu picior suplimentar și forme similare';

  @override
  String get taskTag_twoHaneGainOneLiberty => 'Dublu hane câștigă o libertate';

  @override
  String get taskTag_twoHeadedDragon => 'Dragon cu două capete';

  @override
  String get taskTag_twoSpaceExtension => 'Extensie de două spații';

  @override
  String get taskTag_typesOfKo => 'Tipuri de ko';

  @override
  String get taskTag_underTheStones => 'Sub pietre';

  @override
  String get taskTag_underneathAttachment => 'Atașare dedesubt';

  @override
  String get taskTag_urgentPointOfAFight => 'Punct urgent al luptei';

  @override
  String get taskTag_urgentPoints => 'Puncte urgente';

  @override
  String get taskTag_useConnectAndDie => 'Folosește conectează și mori';

  @override
  String get taskTag_useCornerSpecialProperties =>
      'Folosește proprietățile speciale ale colțului';

  @override
  String get taskTag_useDescentToFirstLine =>
      'Folosește coborârea pe prima linie';

  @override
  String get taskTag_useInfluence => 'Folosește influența';

  @override
  String get taskTag_useOpponentsLifeAndDeath =>
      'Folosește viața și moartea adversarului';

  @override
  String get taskTag_useShortageOfLiberties => 'Folosește lipsa de libertăți';

  @override
  String get taskTag_useSnapback => 'Folosește snapback';

  @override
  String get taskTag_useSurroundingStones => 'Folosește pietrele din jur';

  @override
  String get taskTag_vitalAndUselessStones => 'Pietre vitale și inutile';

  @override
  String get taskTag_vitalPointForBothSides =>
      'Punct vital pentru ambele părți';

  @override
  String get taskTag_vitalPointForCapturingRace =>
      'Punct vital pentru cursa de capturare';

  @override
  String get taskTag_vitalPointForIncreasingLiberties =>
      'Punct vital pentru creșterea libertăților';

  @override
  String get taskTag_vitalPointForKill => 'Punct vital pentru ucidere';

  @override
  String get taskTag_vitalPointForLife => 'Punct vital pentru viață';

  @override
  String get taskTag_vitalPointForReducingLiberties =>
      'Punct vital pentru reducerea libertăților';

  @override
  String get taskTag_wedge => 'Pană';

  @override
  String get taskTag_wedgingCapture => 'Captură prin pană';

  @override
  String get taskTimeout => 'Timp expirat';

  @override
  String get taskTypeAppreciation => 'Apreciere';

  @override
  String get taskTypeCapture => 'Capturare de pietre';

  @override
  String get taskTypeCaptureRace => 'Cursă de capturare';

  @override
  String get taskTypeEndgame => 'Final';

  @override
  String get taskTypeJoseki => 'Joseki';

  @override
  String get taskTypeLifeAndDeath => 'Viață și moarte';

  @override
  String get taskTypeMiddlegame => 'Joc de mijloc';

  @override
  String get taskTypeOpening => 'Deschidere';

  @override
  String get taskTypeTesuji => 'Tesuji';

  @override
  String get taskTypeTheory => 'Teorie';

  @override
  String get taskWrong => 'Greșit';

  @override
  String get tasksSolved => 'Sarcini rezolvate';

  @override
  String get test => 'Test';

  @override
  String get theme => 'Temă';

  @override
  String get thick => 'Gros';

  @override
  String get timeFrenzy => 'Go contra cronometru';

  @override
  String get timeFrenzyMistakes =>
      'Urmărește greșelile din Go contra cronometru';

  @override
  String get timeFrenzyMistakesDesc =>
      'Activează pentru a salva greșelile făcute în Go contra cronometru';

  @override
  String get randomizeTaskOrientation => 'Orientare aleatoare a tzumego';

  @override
  String get randomizeTaskOrientationDesc =>
      'Rotește și reflectă aleator problemele de tsumego de-a lungul axelor orizontale, verticale și diagonale pentru a preveni memorarea și a îmbunătăți recunoașterea modelelor.';

  @override
  String get timePerTask => 'Timp per sarcină';

  @override
  String get today => 'Astăzi';

  @override
  String get tooltipAnalyzeWithAISensei => 'Analizează cu AI Sensei';

  @override
  String get tooltipDownloadGame => 'Descarcă jocul';

  @override
  String get topic => 'Subiect';

  @override
  String get topicExam => 'Examen pe subiect';

  @override
  String get topics => 'Subiecte';

  @override
  String get train => 'Antrenează-te';

  @override
  String get trainingAvgTimePerTask => 'Timp mediu per sarcină';

  @override
  String get trainingFailed => 'Eșuat';

  @override
  String get trainingMistakes => 'Greșeli';

  @override
  String get trainingPassed => 'Promovat';

  @override
  String get trainingTotalTime => 'Timp total';

  @override
  String get tryCustomMoves => 'Încearcă mutări personalizate';

  @override
  String get tygemDesc =>
      'Cel mai popular server din Coreea și unul dintre cele mai populare din lume.';

  @override
  String get tygemName => 'Tygem Baduk';

  @override
  String get type => 'Tip';

  @override
  String get ui => 'Interfață utilizator';

  @override
  String get userInfo => 'Informații utilizator';

  @override
  String get username => 'Nume de utilizator';

  @override
  String get voice => 'Voce';

  @override
  String get week => 'Săptămână';

  @override
  String get white => 'Alb';

  @override
  String get yes => 'Da';
}
