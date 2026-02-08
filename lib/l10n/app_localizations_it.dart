// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get analysis => 'Analisi';

  @override
  String get winrate => 'Probabilità di vittoria';

  @override
  String get scoreLead => 'Vantaggio nel punteggio';

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
  String get fullscreen => 'Schermo intero';

  @override
  String get fullscreenDesc =>
      'Mostra l\'app in modalità schermo intero. È necessario riavviare l\'app affinché questa impostazione abbia effetto.';

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
  String get hidePlayerRanks => 'Nascondi gradi giocatori';

  @override
  String get hidePlayerRanksDesc =>
      'Nascondi i gradi nella lobby del server e durante la partita';

  @override
  String get helpDialogCollections =>
      'Le raccolte sono insiemi classici e curati di problemi di alta qualità che hanno un valore speciale come risorsa formativa. L\'obiettivo principale è risolvere una raccolta con un alto tasso di successo. Un obiettivo secondario è risolverla il più velocemente possibile.';

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
