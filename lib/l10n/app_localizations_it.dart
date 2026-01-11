// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get about => 'Informazioni';

  @override
  String get acceptDeadStones => 'Accetta pietre catturate';

  @override
  String get accuracy => 'Precisione';

  @override
  String get aiReferee => 'Arbitro AI';

  @override
  String get aiSensei => 'AI Sensei';

  @override
  String get alwaysBlackToPlay => 'Black to play!';

  @override
  String get alwaysBlackToPlayDesc =>
      'Impone la prima mossa al Nero per evitare confusione nei problemi';

  @override
  String get appearance => 'Aspetto';

  @override
  String get autoCounting => 'Conteggio automatico';

  @override
  String get autoMatch => 'Abbinamento automatico';

  @override
  String get avgRank => 'Media liv.';

  @override
  String get behaviour => 'Preferenze';

  @override
  String get bestResult => 'Record';

  @override
  String get black => 'Nero';

  @override
  String get board => 'Goban';

  @override
  String get boardSize => 'Dimensioni';

  @override
  String get boardTheme => 'Stile';

  @override
  String get byRank => 'Per livello';

  @override
  String get byType => 'Per tipo';

  @override
  String get cancel => 'Annulla';

  @override
  String get captures => 'Prigionieri';

  @override
  String get chartTitleCorrectCount => 'Risposte corrette';

  @override
  String get chartTitleExamCompletionTime => 'Tempo d\'esame';

  @override
  String get charts => '';

  @override
  String get clearBoard => 'Svuota';

  @override
  String get collectStats => 'Registra statistiche';

  @override
  String get collections => 'Raccolte';

  @override
  String get confirm => 'Conferma';

  @override
  String get confirmBoardSize => 'Conferma in base alla dimensione del goban';

  @override
  String get confirmBoardSizeDesc =>
      'Per goban di queste dimensioni o maggiori, chiedi di confermare la mossa con un doppio tocco';

  @override
  String get confirmMoves => 'Conferma la mossa';

  @override
  String get confirmMovesDesc =>
      'Richiedi il doppio tocco per confermare la mossa sui goban più grandi (evita misclick)';

  @override
  String get continue_ => 'Continua';

  @override
  String get copySGF => 'Copia SGF';

  @override
  String get copyTaskLink => 'Copia link';

  @override
  String get customExam => 'Esame personalizzato';

  @override
  String get dark => 'Scuro';

  @override
  String get deselectAll => 'Deseleziona tutto';

  @override
  String get dontShowAgain => 'Non mostrare più';

  @override
  String get download => 'Download';

  @override
  String get edgeLine => 'Bordo';

  @override
  String get empty => 'Vuoto';

  @override
  String get endgameExam => 'Esame sul fine gioco';

  @override
  String get enterTaskLink => 'Inserisci il link';

  @override
  String get errCannotBeEmpty => 'Non può essere vuoto';

  @override
  String get errFailedToDownloadGame => 'Scaricamento partita fallito';

  @override
  String get errFailedToLoadGameList =>
      'Impossibile caricare l\'elenco delle partite. Per favore riprova più tardi.';

  @override
  String get errFailedToUploadGameToAISensei =>
      'Impossibile caricare la partita su AI Sensei';

  @override
  String get errIncorrectUsernameOrPassword =>
      'Username o password non corretti';

  @override
  String errLoginFailedWithDetails(String message) {
    return 'Accesso non riuscito: $message';
  }

  @override
  String errMustBeAtLeast(num n) {
    return 'Deve essere almeno $n';
  }

  @override
  String errMustBeAtMost(num n) {
    return 'Deve essere al massimo $n';
  }

  @override
  String get errMustBeInteger => 'Deve essere un numero intero';

  @override
  String get errNetworkError =>
      'Errore di rete. Controlla la tua connessione e riprova.';

  @override
  String get error => 'Errore';

  @override
  String get exit => 'Esci';

  @override
  String get exitTryMode => 'Ritorna';

  @override
  String get find => 'Trova';

  @override
  String get findTask => 'Trova problema';

  @override
  String get findTaskByLink => 'Per link';

  @override
  String get findTaskByPattern => 'Per posizione';

  @override
  String get findTaskResults => 'Risultati';

  @override
  String get findTaskSearching => 'Ricerca in corso...';

  @override
  String get forceCounting => 'Forza conteggio';

  @override
  String get foxwqDesc => 'Il server più popolare in Cina e nel mondo.';

  @override
  String get foxwqName => 'Fox Weiqi';

  @override
  String get gameInfo => 'Info partita';

  @override
  String get gameRecord => 'Risultato partita';

  @override
  String get gradingExam => 'Esame di livello';

  @override
  String get handicap => 'Handicap';

  @override
  String get help => 'Aiuto';

  @override
  String get helpDialogCollections =>
      'Le raccolte sono insiemi classici e curati di problemi di alta qualità che hanno un valore speciale come risorsa formativa. L\'obiettivo principale è risolvere una raccolta con un alto tasso di successo. Un obiettivo secondario è risolverla il più velocemente possibile. Per iniziare o continuare a risolvere una raccolta di problemi, scorri verso sinistra sul riquadro della raccolta in modalità verticale o fai clic sui pulsanti Inizia/Continua in modalità orizzontale.';

  @override
  String get helpDialogEndgameExam =>
      '- L\'esame sul fine gioco contiene 10 problemi di fine gioco. Hai 45 secondi di tempo per risolvere ogni problema.\n\n- Superi la prova se risolvi correttamente almeno 8 problemi (tasso di successo: 80%).\n\n- Superare un livello sblocca l\'esame per il livello successivo.';

  @override
  String get helpDialogGradingExam =>
      '- L\'esame di livello contiene 10 problemi. Hai 45 secondi di tempo per risolvere ogni problema.\n\n- Superi la prova se risolvi correttamente almeno 8 problemi (tasso di successo: 80%).\n\n- Superare un livello sblocca l\'esame per il livello successivo.';

  @override
  String get helpDialogRankedMode =>
      '- Risolvi i problemi senza limiti di tempo.\n\n- La difficoltà aumenta in base alla tua rapidità.\n\n- Impegnati a risolverli correttamente e raggiungi il grado più alto possibile.';

  @override
  String get helpDialogTimeFrenzy =>
      '- Risolvi il maggior numero di problemi possibile in 3 minuti.\n\n- I problemi diventano via via più difficili.\n\n- Se fai 3 errori, sei fuori.';

  @override
  String get home => 'Home';

  @override
  String get komi => 'Komi';

  @override
  String get language => 'Lingua';

  @override
  String get leave => 'Abbandona';

  @override
  String get light => 'Chiaro';

  @override
  String get login => 'Login';

  @override
  String get logout => 'Logout';

  @override
  String get long => 'Lungo';

  @override
  String mMinutes(int m) {
    return '${m}min';
  }

  @override
  String get maxChartPoints => 'Punti max';

  @override
  String get maxNumberOfMistakes => 'Numero massimo di errori';

  @override
  String get maxRank => 'Livello massimo';

  @override
  String get medium => 'Medio';

  @override
  String get minRank => 'Livello minimo';

  @override
  String get minutes => 'Minuti';

  @override
  String get month => 'Mese';

  @override
  String get msgCannotUseAIRefereeYet =>
      'È troppo presto per ricorrere all\'arbitro AI';

  @override
  String get msgCannotUseForcedCountingYet =>
      'È troppo presto per forzare il conteggio';

  @override
  String get msgConfirmDeleteCollectionProgress =>
      'Vuoi davvero cancellare il precedente tentativo?';

  @override
  String get msgConfirmDeletePreset => 'Eliminare questo modello?';

  @override
  String get msgConfirmResignation => 'Vuoi davvero abbandonare?';

  @override
  String msgConfirmStopEvent(String event) {
    return 'Vuoi interrompere la prova?';
  }

  @override
  String get msgDownloadingGame => 'Scaricamento partita';

  @override
  String msgGameSavedTo(String path) {
    return 'Partita salvata in $path';
  }

  @override
  String get msgPleaseWaitForYourTurn => 'Per favore, attendi il tuo turno';

  @override
  String get msgPresetAlreadyExists => 'Esiste già un modello con questo nome.';

  @override
  String get msgSearchingForGame => 'Cerco una partita...';

  @override
  String get msgSgfCopied => 'SGF copiato';

  @override
  String get msgTaskLinkCopied => 'Link copiato';

  @override
  String get msgWaitingForOpponentsDecision =>
      'In attesa che l\'avversario decida...';

  @override
  String get msgYouCannotPass => 'Non puoi passare';

  @override
  String get msgYourOpponentDisagreesWithCountingResult =>
      'L\'avversario non è d\'accordo col risultato';

  @override
  String get msgYourOpponentRefusesToCount =>
      'L\'avversario ha rifiutato il conteggio';

  @override
  String get msgYourOpponentRequestsAutomaticCounting =>
      'L\'avversario ha richiesto il conteggio automatico. Sei d\'accordo?';

  @override
  String get myGames => 'Le mie partite';

  @override
  String get myMistakes => 'I miei errori';

  @override
  String nTasks(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString problemi',
      one: '1 problema',
      zero: 'Nessun problema',
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
      other: '$countString problemi disponibili',
      one: '1 problema disponibile',
      zero: 'Problemi non disponibili',
    );
    return '$_temp0';
  }

  @override
  String get newBestResult => 'Nuovo record!';

  @override
  String get no => 'No';

  @override
  String get none => 'Nessuna';

  @override
  String get numberOfTasks => 'Numero di problemi';

  @override
  String nxnBoardSize(int n) {
    return '$n×$n';
  }

  @override
  String get ogsDesc =>
      'Un server internazionale, più popolare in Europa e nelle Americhe.';

  @override
  String get ogsName => 'Online Go Server';

  @override
  String get ok => 'OK';

  @override
  String get pass => 'Passa';

  @override
  String get password => 'Password';

  @override
  String get perTask => 'per problema';

  @override
  String get play => 'Gioca';

  @override
  String get pleaseMarkDeadStones => 'Indica le pietre catturate.';

  @override
  String get presetName => 'Nome modello';

  @override
  String get presets => 'Modelli';

  @override
  String get promotionRequirements => 'Requisiti per la promozione';

  @override
  String pxsByoyomi(int p, int s) {
    return '$p×${s}s';
  }

  @override
  String get randomizeTaskOrientation => 'Orientamento casuale';

  @override
  String get randomizeTaskOrientationDesc =>
      'Ruota e rifletti casualmente i problemi lungo gli assi orizzontale, verticale e diagonale per prevenire la memorizzazione e migliorare il riconoscimento dei pattern.';

  @override
  String get rank => 'Livello';

  @override
  String get rankedMode => 'Modalità classificata';

  @override
  String get recentRecord => 'Risultato recente';

  @override
  String get register => 'Registrati';

  @override
  String get rejectDeadStones => 'Rifiuta pietre catturate';

  @override
  String get resign => 'Abbandona';

  @override
  String get responseDelay => 'Ritarda la risposta';

  @override
  String get responseDelayDesc =>
      'Imposta un tempo di attesa prima di mostrare la risposta di un problema';

  @override
  String get responseDelayLong => 'Lungo';

  @override
  String get responseDelayMedium => 'Medio';

  @override
  String get responseDelayNone => 'Nessuno';

  @override
  String get responseDelayShort => 'Breve';

  @override
  String get result => 'Risultato';

  @override
  String get resultAccept => 'Accetta';

  @override
  String get resultReject => 'Rifiuta';

  @override
  String get rules => 'Regole';

  @override
  String get rulesChinese => 'Cinesi';

  @override
  String get rulesJapanese => 'Giapponesi';

  @override
  String get rulesKorean => 'Coreane';

  @override
  String sSeconds(int s) {
    return '${s}s';
  }

  @override
  String get save => 'Salva';

  @override
  String get savePreset => 'Salva modello';

  @override
  String get saveSGF => 'Salva SGF';

  @override
  String get seconds => 'Secondi';

  @override
  String get selectAll => 'Seleziona tutto';

  @override
  String get settings => 'Impostazioni';

  @override
  String get short => 'Corta';

  @override
  String get showCoordinates => 'Coordinate';

  @override
  String get showMoveErrorsAsCrosses => 'Usa le croci per le mosse sbagliate';

  @override
  String get showMoveErrorsAsCrossesDesc =>
      'Indica le mosse sbagliate con una X rossa invece di un pallino';

  @override
  String get simple => 'Sottile';

  @override
  String get sortModeDifficult => 'Difficile';

  @override
  String get sortModeRecent => 'Recente';

  @override
  String get sound => 'Suono';

  @override
  String get start => 'Inizia';

  @override
  String get statistics => 'Statistiche';

  @override
  String get statsDateColumn => 'Data';

  @override
  String get statsDurationColumn => 'Durata';

  @override
  String get statsTimeColumn => 'Tempo';

  @override
  String get stoneShadows => 'Ombre';

  @override
  String get stones => 'Pietre';

  @override
  String get subtopic => 'Sottoargomento';

  @override
  String get system => 'Sistema';

  @override
  String get task => 'Problema';

  @override
  String get taskCorrect => 'Corretto';

  @override
  String get taskNext => 'Prossimo';

  @override
  String get taskNotFound => 'Problema non trovato';

  @override
  String get taskRedo => 'Ritenta';

  @override
  String get taskSource => 'Fonte dei problemi';

  @override
  String get taskSourceFromMyMistakes => 'I miei errori';

  @override
  String get taskSourceFromTaskTopic => 'Argomento';

  @override
  String get taskSourceFromTaskTypes => 'Tipologia';

  @override
  String get taskTag_afterJoseki => 'Dopo il joseki';

  @override
  String get taskTag_aiOpening => 'Aperture AI';

  @override
  String get taskTag_aiVariations => 'Varianti AI';

  @override
  String get taskTag_attack => 'Attaccare';

  @override
  String get taskTag_attackAndDefenseInKo => 'Attacco e difesa nel ko';

  @override
  String get taskTag_attackAndDefenseOfCuts => 'Attacco e difesa dei tagli';

  @override
  String get taskTag_attackAndDefenseOfInvadingStones =>
      'Attacco e difesa nelle invasioni';

  @override
  String get taskTag_avoidKo => 'Evita il ko';

  @override
  String get taskTag_avoidMakingDeadShape => 'Evita di creare una forma morta';

  @override
  String get taskTag_avoidTrap => 'Evita le trappole';

  @override
  String get taskTag_basicEndgame => 'Fine gioco: base';

  @override
  String get taskTag_basicLifeAndDeath => 'Vita e morte: base';

  @override
  String get taskTag_basicMoves => 'Movimenti di base';

  @override
  String get taskTag_basicTesuji => 'Tesuji';

  @override
  String get taskTag_beginner => 'Principiante';

  @override
  String get taskTag_bend => 'Piega (bend)';

  @override
  String get taskTag_bentFour => 'Quattro piegato (bent four)';

  @override
  String get taskTag_bentFourInTheCorner => 'Quattro piegato nell\'angolo';

  @override
  String get taskTag_bentThree => 'Tre piegato (bent three)';

  @override
  String get taskTag_bigEyeLiberties => 'Libertà degli occhi grandi';

  @override
  String get taskTag_bigEyeVsSmallEye => 'Occhio grande vs. occhio piccolo';

  @override
  String get taskTag_bigPoints => 'Punti grandi';

  @override
  String get taskTag_blindSpot => 'Punto cieco';

  @override
  String get taskTag_breakEye => 'Distruggi l\'occhio';

  @override
  String get taskTag_breakEyeInOneStep => 'Distruggi l\'occhio in un passo';

  @override
  String get taskTag_breakEyeInSente => 'Distruggi l\'occhio in sente';

  @override
  String get taskTag_breakOut => 'Evadi';

  @override
  String get taskTag_breakPoints => 'Togli punti';

  @override
  String get taskTag_breakShape => 'Rovina la forma';

  @override
  String get taskTag_bridgeUnder => 'Ponte (watari)';

  @override
  String get taskTag_brilliantSequence => 'Sequenze brillanti';

  @override
  String get taskTag_bulkyFive => 'Cinque a manico di coltello (bulky five)';

  @override
  String get taskTag_bump => 'Bump';

  @override
  String get taskTag_captureBySnapback => 'Cattura con snapback';

  @override
  String get taskTag_captureInLadder => 'Cattura in scala';

  @override
  String get taskTag_captureInOneMove => 'Cattura in una mossa';

  @override
  String get taskTag_captureOnTheSide => 'Cattura sul lato';

  @override
  String get taskTag_captureToLive => 'Cattura per vivere';

  @override
  String get taskTag_captureTwoRecaptureOne => 'Cattura due, ricattura una';

  @override
  String get taskTag_capturingRace => 'Semeai (capturing race)';

  @override
  String get taskTag_capturingTechniques => 'Tecniche di cattura';

  @override
  String get taskTag_carpentersSquareAndSimilar =>
      'Quadrato del carpentiere e simili';

  @override
  String get taskTag_chooseTheFight => 'Scegli il combattimento';

  @override
  String get taskTag_clamp => 'Morsa (clamp)';

  @override
  String get taskTag_clampCapture => 'Cattura con la morsa';

  @override
  String get taskTag_closeInCapture => 'Cattura progressiva';

  @override
  String get taskTag_combination => 'Combinazione';

  @override
  String get taskTag_commonLifeAndDeath => 'Vita e morte: forme tipiche';

  @override
  String get taskTag_compareSize => 'Confronta la dimensione';

  @override
  String get taskTag_compareValue => 'Confronta il valore';

  @override
  String get taskTag_completeKoToSecureEndgameAdvantage =>
      'Completa il ko nel fine gioco';

  @override
  String get taskTag_compositeProblems => 'Problemi compositi';

  @override
  String get taskTag_comprehensiveTasks => 'Problemi completi';

  @override
  String get taskTag_connect => 'Connetti';

  @override
  String get taskTag_connectAndDie => 'Connetti e muori (oiotoshi)';

  @override
  String get taskTag_connectInOneMove => 'Connetti in una mossa';

  @override
  String get taskTag_contactFightTesuji => 'Tesuji di combattimento a contatto';

  @override
  String get taskTag_contactPlay => 'Giocare a contatto (tsuke)';

  @override
  String get taskTag_corner => 'Angolo';

  @override
  String get taskTag_cornerIsGoldSideIsSilverCenterIsGrass =>
      'L\'angolo è oro, il lato è argento, il centro è erba';

  @override
  String get taskTag_counter => 'Resisti';

  @override
  String get taskTag_counterAttack => 'Contrattacca';

  @override
  String get taskTag_cranesNest => 'Nido di gru';

  @override
  String get taskTag_crawl => 'Striscia in seconda linea (crawl)';

  @override
  String get taskTag_createShortageOfLiberties => 'Crea mancanza di libertà';

  @override
  String get taskTag_crossedFive => 'Cinque a croce (crossed five)';

  @override
  String get taskTag_cut => 'Taglio';

  @override
  String get taskTag_cut2 => 'Taglio';

  @override
  String get taskTag_cutAcross => 'Taglia attraverso il keima';

  @override
  String get taskTag_defendFromInvasion => 'Difenditi da un\'invasione';

  @override
  String get taskTag_defendPoints => 'Difendi il punteggio';

  @override
  String get taskTag_defendWeakPoint => 'Difendi i punti deboli';

  @override
  String get taskTag_descent => 'Discesa';

  @override
  String get taskTag_diagonal => 'Diagonale';

  @override
  String get taskTag_directionOfCapture => 'Direzione di cattura';

  @override
  String get taskTag_directionOfEscape => 'Direzione di fuga';

  @override
  String get taskTag_directionOfPlay => 'Direzione di gioco';

  @override
  String get taskTag_doNotUnderestimateOpponent =>
      'Non sottostimare l\'avversario';

  @override
  String get taskTag_doubleAtari => 'Doppio atari';

  @override
  String get taskTag_doubleCapture => 'Doppia cattura';

  @override
  String get taskTag_doubleKo => 'Doppio ko';

  @override
  String get taskTag_doubleSenteEndgame => 'Fine gioco in doppio sente';

  @override
  String get taskTag_doubleSnapback => 'Doppio snapback';

  @override
  String get taskTag_endgame => 'Fine gioco: generico';

  @override
  String get taskTag_endgameFundamentals => 'Fondamenti di fine gioco';

  @override
  String get taskTag_endgameIn5x5 => 'Fine gioco sul 5x5';

  @override
  String get taskTag_endgameOn4x4 => 'Fine gioco sul 4x4';

  @override
  String get taskTag_endgameTesuji => 'Tesuji di fine gioco';

  @override
  String get taskTag_engulfingAtari => 'Atari per accerchiamento';

  @override
  String get taskTag_escape => 'Fuggi';

  @override
  String get taskTag_escapeInOneMove => 'Fuggi in una mossa';

  @override
  String get taskTag_exploitShapeWeakness => 'Sfrutta le debolezze';

  @override
  String get taskTag_eyeVsNoEye => 'Meari menashi (eye vs. no-eye)';

  @override
  String get taskTag_fillNeutralPoints => 'Riempi i dame';

  @override
  String get taskTag_findTheRoot => 'Trova la radice';

  @override
  String get taskTag_firstLineBrilliantMove => 'Tesuji in prima linea';

  @override
  String get taskTag_flowerSix => 'Sei a grappolo d\'uva (rabbity six)';

  @override
  String get taskTag_goldenChickenStandingOnOneLeg =>
      'Il gallo d\'oro sta su una zampa';

  @override
  String get taskTag_groupLiberties => 'Libertà dei gruppi';

  @override
  String get taskTag_groupsBase => 'Base del gruppo';

  @override
  String get taskTag_hane => 'Hane';

  @override
  String get taskTag_increaseEyeSpace => 'Aumenta lo spazio vitale';

  @override
  String get taskTag_increaseLiberties => 'Aumenta le libertà';

  @override
  String get taskTag_indirectAttack => 'Attacco indiretto';

  @override
  String get taskTag_influenceKeyPoints => 'Punti chiave dell\'influenza';

  @override
  String get taskTag_insideKill => 'Uccidi dall\'interno';

  @override
  String get taskTag_insideMoves => 'Mosse interne';

  @override
  String get taskTag_interestingTasks => 'Problemi interessanti';

  @override
  String get taskTag_internalLibertyShortage => 'Carenza di libertà interne';

  @override
  String get taskTag_invadingTechnique => 'Tecniche di invasione';

  @override
  String get taskTag_invasion => 'Invasione';

  @override
  String get taskTag_jGroupAndSimilar => 'Gruppo J e simili';

  @override
  String get taskTag_josekiFundamentals => 'Fondamenti di joseki';

  @override
  String get taskTag_jump => 'Salto';

  @override
  String get taskTag_keepSente => 'Mantieni il sente';

  @override
  String get taskTag_killAfterCapture => 'Uccidi dopo la cattura';

  @override
  String get taskTag_killByEyePointPlacement =>
      'Uccidi giocando nel punto vitale';

  @override
  String get taskTag_knightsMove => 'Mossa del cavallo (keima)';

  @override
  String get taskTag_ko => 'Ko';

  @override
  String get taskTag_kosumiWedge => 'Taglia il kosumi (atekomi)';

  @override
  String get taskTag_largeKnightsMove => 'Mossa del cavallo grande (ogeima)';

  @override
  String get taskTag_largeMoyoFight => 'Combattimento nel moyo grande';

  @override
  String get taskTag_lifeAndDeath => 'Vita e morte: generale';

  @override
  String get taskTag_lifeAndDeathOn4x4 => 'Vita e morte sul 4x4';

  @override
  String get taskTag_lookForLeverage => 'Sfrutta le forzanti';

  @override
  String get taskTag_looseLadder => 'Scala lasca';

  @override
  String get taskTag_lovesickCut => 'Taglio degli innamorati';

  @override
  String get taskTag_makeEye => 'Fai un occhio';

  @override
  String get taskTag_makeEyeInOneStep => 'Fai un occhio in un passo';

  @override
  String get taskTag_makeEyeInSente => 'Fai un occhio in sente';

  @override
  String get taskTag_makeKo => 'Fai ko';

  @override
  String get taskTag_makeShape => 'Fai forma';

  @override
  String get taskTag_middlegame => 'Mediogioco (chuban)';

  @override
  String get taskTag_monkeyClimbingMountain => 'La scimmia scala la montagna';

  @override
  String get taskTag_mouseStealingOil => 'Il topo ruba l\'olio';

  @override
  String get taskTag_moveOut => 'Scappa';

  @override
  String get taskTag_moveTowardsEmptySpace => 'Muovi verso lo spazio vuoto';

  @override
  String get taskTag_multipleBrilliantMoves => 'Tesuji multipli';

  @override
  String get taskTag_net => 'Rete (geta)';

  @override
  String get taskTag_netCapture => 'Cattura con rete';

  @override
  String get taskTag_observeSubtleDifference => 'Osserva le piccole differenze';

  @override
  String get taskTag_occupyEncloseAndApproachCorner =>
      'Occupa, circonda e approccia gli angoli';

  @override
  String get taskTag_oneStoneTwoPurposes => 'Una pietra, due scopi';

  @override
  String get taskTag_opening => 'Apertura (fuseki)';

  @override
  String get taskTag_openingChoice => 'Scegli l\'apertura';

  @override
  String get taskTag_openingFundamentals => 'Fondamenti delle aperture';

  @override
  String get taskTag_orderOfEndgameMoves => 'Ordine delle mosse nel fine gioco';

  @override
  String get taskTag_orderOfMoves => 'Ordine delle mosse';

  @override
  String get taskTag_orderOfMovesInKo => 'Ordine delle mosse nel ko';

  @override
  String get taskTag_orioleCapturesButterfly => 'L\'oriolo cattura la farfalla';

  @override
  String get taskTag_pincer => 'Pinza';

  @override
  String get taskTag_placement => 'Oki (placement)';

  @override
  String get taskTag_plunderingTechnique => 'Tecniche di saccheggio';

  @override
  String get taskTag_preventBambooJoint => 'Previeni il bamboo joint';

  @override
  String get taskTag_preventBridgingUnder => 'Impedisci il ponte (watari)';

  @override
  String get taskTag_preventOpponentFromApproaching =>
      'Previeni l\'approccio dell\'avversario';

  @override
  String get taskTag_probe => 'Sonda (probe)';

  @override
  String get taskTag_profitInSente => 'Approfitta del sente';

  @override
  String get taskTag_profitUsingLifeAndDeath => 'Approfitta della vita-e-morte';

  @override
  String get taskTag_push => 'Spinta';

  @override
  String get taskTag_pyramidFour => 'Quattro a forma di T';

  @override
  String get taskTag_realEyeAndFalseEye => 'Occhio vero vs. occhio falso';

  @override
  String get taskTag_rectangularSix => 'Sei a forma di rettangolo';

  @override
  String get taskTag_reduceEyeSpace => 'Riduci lo spazio vitale';

  @override
  String get taskTag_reduceLiberties => 'Riduci le libertà';

  @override
  String get taskTag_reduction => 'Riduzione';

  @override
  String get taskTag_runWeakGroup => 'Gestisci il gruppo debole';

  @override
  String get taskTag_sabakiAndUtilizingInfluence =>
      'Sabaki e utilizzo dell\'influenza';

  @override
  String get taskTag_sacrifice => 'Sacrificio';

  @override
  String get taskTag_sacrificeAndSqueeze => 'Sacrificio e squeeze';

  @override
  String get taskTag_sealIn => 'Sigilla';

  @override
  String get taskTag_secondLine => 'Seconda linea';

  @override
  String get taskTag_seizeTheOpportunity => 'Cogli l\'attimo';

  @override
  String get taskTag_seki => 'Seki';

  @override
  String get taskTag_senteAndGote => 'Sente e gote';

  @override
  String get taskTag_settleShape => 'Stabilizza la forma';

  @override
  String get taskTag_settleShapeInSente => 'Stabilizza la forma in sente';

  @override
  String get taskTag_shape => 'Forma';

  @override
  String get taskTag_shapesVitalPoint => 'Punto vitale della forma';

  @override
  String get taskTag_side => 'Lato';

  @override
  String get taskTag_smallBoardEndgame => 'Fine gioco su goban piccolo';

  @override
  String get taskTag_snapback => 'Snapback';

  @override
  String get taskTag_solidConnection => 'Connessione solida';

  @override
  String get taskTag_solidExtension => 'Estensione solida';

  @override
  String get taskTag_splitInOneMove => 'Separa in una mossa';

  @override
  String get taskTag_splittingMove => 'Mosse per separare';

  @override
  String get taskTag_squareFour => 'Quattro a forma di quadrato';

  @override
  String get taskTag_squeeze => 'Squeeze';

  @override
  String get taskTag_standardCapturingRaces => 'Semeai standard';

  @override
  String get taskTag_standardCornerAndSideEndgame =>
      'Fine gioco standard (angoli e lati)';

  @override
  String get taskTag_straightFour => 'Quattro in fila';

  @override
  String get taskTag_straightThree => 'Tre in fila';

  @override
  String get taskTag_surroundTerritory => 'Circonda il territorio';

  @override
  String get taskTag_symmetricShape => 'Forme simmetriche';

  @override
  String get taskTag_techniqueForReinforcingGroups =>
      'Tecniche per rafforzare i gruppi';

  @override
  String get taskTag_techniqueForSecuringTerritory =>
      'Tecniche per mettere in sicurezza un territorio';

  @override
  String get taskTag_textbookTasks => 'Problemi da libro';

  @override
  String get taskTag_thirdAndFourthLine => 'Terza e quarta linea';

  @override
  String get taskTag_threeEyesTwoActions => 'Tre occhi, due azioni';

  @override
  String get taskTag_threeSpaceExtensionFromTwoStones =>
      'Estensione di tre spazi da due pietre';

  @override
  String get taskTag_throwIn => 'Throw-in';

  @override
  String get taskTag_tigersMouth => 'Bocca di tigre';

  @override
  String get taskTag_tombstoneSqueeze => 'Tombstone squeeze (Pagoda squeeze)';

  @override
  String get taskTag_tripodGroupWithExtraLegAndSimilar =>
      'Tripode con gamba extra e simili';

  @override
  String get taskTag_twoHaneGainOneLiberty =>
      'Il doppio hane aggiunge una libertà';

  @override
  String get taskTag_twoHeadedDragon => 'Drago a due teste';

  @override
  String get taskTag_twoSpaceExtension => 'Estensione a due spazi';

  @override
  String get taskTag_typesOfKo => 'Tipi di ko';

  @override
  String get taskTag_underTheStones => 'Ishi no shita (under the stones)';

  @override
  String get taskTag_underneathAttachment => 'Tsuke da sotto';

  @override
  String get taskTag_urgentPointOfAFight =>
      'Punti urgenti per il combattimento';

  @override
  String get taskTag_urgentPoints => 'Punti urgenti';

  @override
  String get taskTag_useConnectAndDie => 'Sfrutta oiotoshi (connect and die)';

  @override
  String get taskTag_useCornerSpecialProperties =>
      'Usa le peculiarità dell\'angolo';

  @override
  String get taskTag_useDescentToFirstLine => 'Usa la discesa in prima linea';

  @override
  String get taskTag_useInfluence => 'Usa l\'influenza';

  @override
  String get taskTag_useOpponentsLifeAndDeath =>
      'Sfrutta la vita-e-morte dell\'avversario';

  @override
  String get taskTag_useShortageOfLiberties => 'Sfrutta la carenza di libertà';

  @override
  String get taskTag_useSnapback => 'Usa lo snapback';

  @override
  String get taskTag_useSurroundingStones => 'Usa le pietre attorno';

  @override
  String get taskTag_vitalAndUselessStones => 'Pietre vitali e pietre inutili';

  @override
  String get taskTag_vitalPointForBothSides => 'Punti vitali per entrambi';

  @override
  String get taskTag_vitalPointForCapturingRace => 'Punti vitali per il semeai';

  @override
  String get taskTag_vitalPointForIncreasingLiberties =>
      'Punti vitali per aumentare le libertà';

  @override
  String get taskTag_vitalPointForKill => 'Punti vitali per uccidere';

  @override
  String get taskTag_vitalPointForLife => 'Punti vitali per vivere';

  @override
  String get taskTag_vitalPointForReducingLiberties =>
      'Punti vitali per ridurre le libertà';

  @override
  String get taskTag_wedge => 'Wedge';

  @override
  String get taskTag_wedgingCapture => 'Cattura con wedge';

  @override
  String get taskTimeout => 'Timeout';

  @override
  String get taskTypeAppreciation => 'Valutazione';

  @override
  String get taskTypeCapture => 'Cattura';

  @override
  String get taskTypeCaptureRace => 'Semeai (capturing race)';

  @override
  String get taskTypeEndgame => 'Yose (fine gioco)';

  @override
  String get taskTypeJoseki => 'Joseki';

  @override
  String get taskTypeLifeAndDeath => 'Life & death';

  @override
  String get taskTypeMiddlegame => 'Chuban (mediogioco)';

  @override
  String get taskTypeOpening => 'Fuseki (apertura)';

  @override
  String get taskTypeTesuji => 'Tesuji';

  @override
  String get taskTypeTheory => 'Teoria';

  @override
  String get taskWrong => 'Sbagliato';

  @override
  String get tasksSolved => 'Problema risolto';

  @override
  String get test => 'Test';

  @override
  String get theme => 'Tema';

  @override
  String get thick => 'Spesso';

  @override
  String get timeFrenzy => 'Frenesia';

  @override
  String get timeFrenzyMistakes => 'Ricorda gli errori durante la Frenesia';

  @override
  String get timeFrenzyMistakesDesc =>
      'Abilita il salvataggio degli errori commessi durante le sessioni di Frenesia';

  @override
  String get timePerTask => 'Tempo problema';

  @override
  String get today => 'Oggi';

  @override
  String get tooltipAnalyzeWithAISensei => 'Analizza con AI Sensei';

  @override
  String get tooltipDownloadGame => 'Scarica';

  @override
  String get topic => 'Argomento';

  @override
  String get topicExam => 'Argomento del test';

  @override
  String get topics => 'Argomenti';

  @override
  String get train => 'Allenamento';

  @override
  String get trainingAvgTimePerTask => 'Tempo medio problema';

  @override
  String get trainingFailed => 'Fallito';

  @override
  String get trainingMistakes => 'Errori';

  @override
  String get trainingPassed => 'Superato';

  @override
  String get trainingTotalTime => 'Tempo totale';

  @override
  String get tryCustomMoves => 'Prova altre mosse';

  @override
  String get tygemDesc =>
      'Il server più popolare in Corea e uno dei più popolari al mondo.';

  @override
  String get tygemName => 'Tygem Baduk';

  @override
  String get type => 'Tipo';

  @override
  String get ui => 'Interfaccia utente';

  @override
  String get userInfo => 'Info utente';

  @override
  String get username => 'Username';

  @override
  String get voice => 'Voce';

  @override
  String get week => 'Settimana';

  @override
  String get white => 'Bianco';

  @override
  String get yes => 'Si';
}
