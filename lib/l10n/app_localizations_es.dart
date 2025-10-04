// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get about => 'Acerca de WeiqiHub';

  @override
  String get accuracy => 'Precisión';

  @override
  String get aiReferee => 'Árbitro IA';

  @override
  String get aiSensei => 'AI Sensei';

  @override
  String get alwaysBlackToPlay => 'Siempre juegan las negras';

  @override
  String get alwaysBlackToPlayDesc =>
      'Hace que en todos los problemas jueguen las negras para evitar confusión';

  @override
  String get appearance => 'Apariencia';

  @override
  String get autoCounting => 'Conteo automático';

  @override
  String get autoMatch => 'Buscar partida';

  @override
  String get behaviour => 'Comportamiento';

  @override
  String get bestResult => 'Mejor resultado';

  @override
  String get black => 'Negras';

  @override
  String get board => 'Tablero';

  @override
  String get boardSize => 'Tamaño del tablero';

  @override
  String get boardTheme => 'Tema del tablero';

  @override
  String get byRank => 'Por rango';

  @override
  String get cancel => 'Cancelar';

  @override
  String get captures => 'Capturas';

  @override
  String get collectStats => 'Añadir a las estadísticas';

  @override
  String get collections => 'Colecciones';

  @override
  String get confirm => 'Confirmar';

  @override
  String get confirmBoardSize => 'Tamaño de confirmación';

  @override
  String get confirmBoardSizeDesc =>
      'Tableros de este tamaño o mayores requieren confirmar jugadas';

  @override
  String get confirmMoves => 'Confirmar jugada';

  @override
  String get confirmMovesDesc =>
      'Doble tap para confirmar jugadas en tableros grandes para evitar accidentes';

  @override
  String get continue_ => 'Continuar';

  @override
  String get copyTaskLink => 'Copiar enlace al problema';

  @override
  String get customExam => 'Examen personalizado';

  @override
  String get dark => 'Oscuro';

  @override
  String get download => 'Descargar';

  @override
  String get edgeLine => 'Línea de borde';

  @override
  String get endgameExam => 'Examen de finales';

  @override
  String get enterTaskLink => 'Introduce el enlace al problema';

  @override
  String get errCannotBeEmpty => 'No puede estar vacío';

  @override
  String get errFailedToDownloadGame => 'Error descargando partida.';

  @override
  String get errFailedToLoadGameList =>
      'Error cargando lista de partidas. Por favor, prueba de nuevo.';

  @override
  String get errFailedToUploadGameToAISensei =>
      'Error enviando partida a AI Sensei';

  @override
  String get errIncorrectUsernameOrPassword =>
      'Nombre de usuario o contraseña incorrectos';

  @override
  String errMustBeAtLeast(num n) {
    return 'No puede ser menor que $n';
  }

  @override
  String errMustBeAtMost(num n) {
    return 'No puede ser mayor que $n';
  }

  @override
  String get errMustBeInteger => 'Debe ser un número entero';

  @override
  String get exit => 'Salir';

  @override
  String get exitTryMode => 'Regresar';

  @override
  String get find => 'Buscar';

  @override
  String get findTask => 'Buscar problema';

  @override
  String get forceCounting => 'Forzar conteo';

  @override
  String get foxwqDesc => 'El servidor más popular de China y el mundo.';

  @override
  String get foxwqName => 'Fox Weiqi';

  @override
  String get gameInfo => 'Información de la partida';

  @override
  String get gameRecord => 'Partida';

  @override
  String get gradingExam => 'Examen de rango';

  @override
  String get handicap => 'Handicap';

  @override
  String get home => 'Inicio';

  @override
  String get komi => 'Komi';

  @override
  String get language => 'Idioma';

  @override
  String get leave => 'Salir';

  @override
  String get light => 'Claro';

  @override
  String get login => 'Entrar';

  @override
  String get logout => 'Salir';

  @override
  String get long => 'Larga';

  @override
  String mMinutes(int m) {
    return '${m}min';
  }

  @override
  String get maxNumberOfMistakes => 'Número máximo de errores';

  @override
  String get maxRank => 'Rango máximo';

  @override
  String get medium => 'Media';

  @override
  String get minRank => 'Rango mínimo';

  @override
  String get minutes => 'Minutos';

  @override
  String get month => 'Mes';

  @override
  String get msgCannotUseAIRefereeYet =>
      'El árbitro IA no está disponible todavía';

  @override
  String get msgCannotUseForcedCountingYet =>
      'No es posible forzar el conteo automático todavía';

  @override
  String get msgConfirmDeleteCollectionProgress =>
      '¿Estás seguro(a) de que quieres abandonar el intento anterior?';

  @override
  String get msgConfirmResignation =>
      '¿Estás seguro(a) de que quieres abandonar?';

  @override
  String msgConfirmStopEvent(String event) {
    return '¿Estás seguro(a) de que quieres abandonar el $event?';
  }

  @override
  String get msgDownloadingGame => 'Descargando partida';

  @override
  String msgGameSavedTo(String path) {
    return 'Partida guardada en $path';
  }

  @override
  String get msgPleaseWaitForYourTurn => 'Por favor, espera tu turno';

  @override
  String get msgSearchingForGame => 'Buscando partida...';

  @override
  String get msgTaskLinkCopied => 'Enlace al problema copiado.';

  @override
  String get msgWaitingForOpponentsDecision =>
      'Esperando la decisión de tu oponente...';

  @override
  String get msgYouCannotPass => 'No puedes pasar';

  @override
  String get msgYourOpponentDisagreesWithCountingResult =>
      'Tu oponente no está de acuerdo con el resultado del conteo';

  @override
  String get msgYourOpponentRefusesToCount =>
      'Tu oponente no acepta el conteo automático.';

  @override
  String get msgYourOpponentRequestsAutomaticCounting =>
      'Tu oponente pide conteo automático. ¿Aceptas?';

  @override
  String get myGames => 'Mis partidas';

  @override
  String get myMistakes => 'Mis errores';

  @override
  String nTasks(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString problemas',
      one: '1 problema',
      zero: 'No hay problemas',
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
      other: '$countString problemas disponibles',
      one: '1 problema disponible',
      zero: 'No hay problems disponibles',
    );
    return '$_temp0';
  }

  @override
  String get newBestResult => 'Nuevo record!';

  @override
  String get no => 'No';

  @override
  String get none => 'Ninguna';

  @override
  String get numberOfTasks => 'Número de problemas';

  @override
  String nxnBoardSize(int n) {
    return '$n×$n';
  }

  @override
  String get ogsDesc =>
      'La principal plataforma en línea de Go, con torneos, análisis con IA y una vibrante comunidad.';

  @override
  String get ogsName => 'Online Go Server';

  @override
  String get ok => 'OK';

  @override
  String get pass => 'Pasar';

  @override
  String get password => 'Contraseña';

  @override
  String get play => 'Jugar';

  @override
  String get promotionRequirements => 'Requisitos de promoción';

  @override
  String pxsByoyomi(int p, int s) {
    return '$p×${s}s';
  }

  @override
  String get rank => 'Rango';

  @override
  String get rankedMode => 'Clasificatorio';

  @override
  String get recentRecord => 'Resultados recientes';

  @override
  String get register => 'Registrarse';

  @override
  String get resign => 'Abandonar';

  @override
  String get responseDelay => 'Demora de respuesta';

  @override
  String get responseDelayDesc =>
      'Demora de la respuesta del oponente mientras resuelves problemas';

  @override
  String get responseDelayLong => 'Larga';

  @override
  String get responseDelayMedium => 'Media';

  @override
  String get responseDelayNone => 'Sin demora';

  @override
  String get responseDelayShort => 'Corta';

  @override
  String get result => 'Resultado';

  @override
  String get rules => 'Reglas';

  @override
  String get rulesChinese => 'Chinas';

  @override
  String get rulesJapanese => 'Japonesas';

  @override
  String get rulesKorean => 'Coreanas';

  @override
  String get save => 'Guardar';

  @override
  String get saveSGF => 'Guardar SGF';

  @override
  String get seconds => 'Segundos';

  @override
  String get settings => 'Preferencias';

  @override
  String get short => 'Corta';

  @override
  String get showCoordinates => 'Mostrar coordenadas';

  @override
  String get simple => 'Simple';

  @override
  String get sortModeDifficult => 'Difíciles';

  @override
  String get sortModeRecent => 'Recientes';

  @override
  String get sound => 'Sonido';

  @override
  String get start => 'Comenzar';

  @override
  String get statistics => 'Estadísticas';

  @override
  String get statsDateColumn => 'Fecha';

  @override
  String get statsDurationColumn => 'Tiempo';

  @override
  String get statsTimeColumn => 'Hora';

  @override
  String get stoneShadows => 'Sombra de las piedras';

  @override
  String get stones => 'Piedras';

  @override
  String get subtopic => 'Subtema';

  @override
  String get system => 'Sistema';

  @override
  String get task => 'Problema';

  @override
  String get taskCorrect => 'Correcto';

  @override
  String get taskNext => 'Siguiente';

  @override
  String get taskRedo => 'Reintentar';

  @override
  String get taskSource => 'Origen de problemas';

  @override
  String get taskSourceFromMyMistakes => 'Mis errores';

  @override
  String get taskSourceFromTaskTopic => 'Por tema';

  @override
  String get taskSourceFromTaskTypes => 'Por tipos de problema';

  @override
  String get taskTag_afterJoseki => 'Continuaciones de joseki';

  @override
  String get taskTag_aiOpening => 'Apertura de IA';

  @override
  String get taskTag_aiVariations => 'Variaciones de IA';

  @override
  String get taskTag_attack => 'Ataque';

  @override
  String get taskTag_attackAndDefenseInKo => 'Ataque y defensa en ko';

  @override
  String get taskTag_attackAndDefenseOfCuts => 'Ataque y defensa de cortes';

  @override
  String get taskTag_attackAndDefenseOfInvadingStones =>
      'Ataque y defensa de piedras de invasión';

  @override
  String get taskTag_avoidKo => 'Evitar ko';

  @override
  String get taskTag_avoidMakingDeadShape => 'Evitar forma muerta';

  @override
  String get taskTag_avoidTrap => 'Evitar trampas';

  @override
  String get taskTag_basicEndgame => 'Finales: básico';

  @override
  String get taskTag_basicLifeAndDeath => 'Vida y muerte: básico';

  @override
  String get taskTag_basicMoves => 'Jugadas básicas';

  @override
  String get taskTag_basicTesuji => 'Tesuji';

  @override
  String get taskTag_beginner => 'Principiante';

  @override
  String get taskTag_bend => 'Doblar';

  @override
  String get taskTag_bentFour => 'Cuatro dobladas';

  @override
  String get taskTag_bentFourInTheCorner => 'Cuatro dobladas en la esquina';

  @override
  String get taskTag_bentThree => 'Tres dobladas';

  @override
  String get taskTag_bigEyeLiberties => 'Libertades de ojos grandes';

  @override
  String get taskTag_bigEyeVsSmallEye => 'Ojo grande contra ojo pequeño';

  @override
  String get taskTag_bigPoints => 'Puntos grandes';

  @override
  String get taskTag_blindSpot => 'Punto ciego';

  @override
  String get taskTag_breakEye => 'Destruir ojo';

  @override
  String get taskTag_breakEyeInOneStep => 'Destruir ojo en una jugada';

  @override
  String get taskTag_breakEyeInSente => 'Destruir ojo en sente';

  @override
  String get taskTag_breakOut => 'Break out';

  @override
  String get taskTag_breakPoints => 'Destruir puntos';

  @override
  String get taskTag_breakShape => 'Destruir forma';

  @override
  String get taskTag_bridgeUnder => 'Bridge under';

  @override
  String get taskTag_brilliantSequence => 'Secuencia brillante';

  @override
  String get taskTag_bulkyFive => 'Maquinita';

  @override
  String get taskTag_bump => 'Bump';

  @override
  String get taskTag_captureBySnapback => 'Captura mediante contracaptura';

  @override
  String get taskTag_captureInLadder => 'Captura en escalera';

  @override
  String get taskTag_captureInOneMove => 'Captura en una jugada';

  @override
  String get taskTag_captureOnTheSide => 'Captura en el lado';

  @override
  String get taskTag_captureToLive => 'Captura para vivir';

  @override
  String get taskTag_captureTwoRecaptureOne => 'Captura dos, recaptura una';

  @override
  String get taskTag_capturingRace => 'Semeai';

  @override
  String get taskTag_capturingTechniques => 'Técnicas de captura';

  @override
  String get taskTag_carpentersSquareAndSimilar =>
      'Escuadra de carpintero y similares';

  @override
  String get taskTag_chooseTheFight => 'Elige la pelea';

  @override
  String get taskTag_clamp => 'Pinza';

  @override
  String get taskTag_clampCapture => 'Captura con pinza';

  @override
  String get taskTag_closeInCapture => 'Closing-in capture';

  @override
  String get taskTag_combination => 'Combinación';

  @override
  String get taskTag_commonLifeAndDeath => 'Vida y muerte: formas comunes';

  @override
  String get taskTag_compareSize => 'Comparar tamaño';

  @override
  String get taskTag_compareValue => 'Comparar valor';

  @override
  String get taskTag_completeKoToSecureEndgameAdvantage =>
      'Toma el ko para asegurar la ventaja de final';

  @override
  String get taskTag_compositeProblems => 'Problemas compuestos';

  @override
  String get taskTag_comprehensiveTasks => 'Problemas integrales';

  @override
  String get taskTag_connect => 'Conecta';

  @override
  String get taskTag_connectAndDie => 'Conecta y muere';

  @override
  String get taskTag_connectInOneMove => 'Conecta en una jugada';

  @override
  String get taskTag_contactFightTesuji => 'Tesuji para peleas de contacto';

  @override
  String get taskTag_contactPlay => 'Jugadas de contacto';

  @override
  String get taskTag_corner => 'Esquina';

  @override
  String get taskTag_cornerIsGoldSideIsSilverCenterIsGrass =>
      'La esquina es oro, el lado es plata, el centro es hierba';

  @override
  String get taskTag_counter => 'Contraataque';

  @override
  String get taskTag_counterAttack => 'Contraataque';

  @override
  String get taskTag_cranesNest => 'Nido de grulla';

  @override
  String get taskTag_crawl => 'Crawl';

  @override
  String get taskTag_createShortageOfLiberties => 'Crear falta de libertades';

  @override
  String get taskTag_crossedFive => 'Cruz';

  @override
  String get taskTag_cut => 'Corte';

  @override
  String get taskTag_cut2 => 'Corte';

  @override
  String get taskTag_cutAcross => 'Atravesar';

  @override
  String get taskTag_defendFromInvasion => 'Defensa contra invasiones';

  @override
  String get taskTag_defendPoints => 'Defender puntos';

  @override
  String get taskTag_defendWeakPoint => 'Defender punto débil';

  @override
  String get taskTag_descent => 'Descenso';

  @override
  String get taskTag_diagonal => 'Diagonal';

  @override
  String get taskTag_directionOfCapture => 'Dirección de captura';

  @override
  String get taskTag_directionOfEscape => 'Dirección de escape';

  @override
  String get taskTag_directionOfPlay => 'Dirección de juego';

  @override
  String get taskTag_doNotUnderestimateOpponent => 'No subestimes al oponente';

  @override
  String get taskTag_doubleAtari => 'Atari doble';

  @override
  String get taskTag_doubleCapture => 'Captura doble';

  @override
  String get taskTag_doubleKo => 'Ko doble';

  @override
  String get taskTag_doubleSenteEndgame => 'Final sente doble';

  @override
  String get taskTag_doubleSnapback => 'Contracaptura doble';

  @override
  String get taskTag_endgame => 'Finales: general';

  @override
  String get taskTag_endgameFundamentals => 'Fundamentos de finales';

  @override
  String get taskTag_endgameIn5x5 => 'Finales en 5x5';

  @override
  String get taskTag_endgameOn4x4 => 'Finales en 4x4';

  @override
  String get taskTag_endgameTesuji => 'Tesuji de finales';

  @override
  String get taskTag_engulfingAtari => 'Engulfing atari';

  @override
  String get taskTag_escape => 'Escape';

  @override
  String get taskTag_escapeInOneMove => 'Escape en una jugada';

  @override
  String get taskTag_exploitShapeWeakness => 'Explota la debilidad de la forma';

  @override
  String get taskTag_eyeVsNoEye => 'Ojo contra sin-ojo';

  @override
  String get taskTag_fillNeutralPoints => 'Jugar puntos neutrales';

  @override
  String get taskTag_findTheRoot => 'Find the root';

  @override
  String get taskTag_firstLineBrilliantMove =>
      'Jugada brillante en la primera línea';

  @override
  String get taskTag_flowerSix => 'Pececito';

  @override
  String get taskTag_goldenChickenStandingOnOneLeg => 'Posición del flamenco';

  @override
  String get taskTag_groupLiberties => 'Libertades de grupo';

  @override
  String get taskTag_groupsBase => 'Base de grupo';

  @override
  String get taskTag_hane => 'Hane';

  @override
  String get taskTag_increaseEyeSpace => 'Aumentar espacio vital';

  @override
  String get taskTag_increaseLiberties => 'Ganar libertades';

  @override
  String get taskTag_indirectAttack => 'Ataque indirecto';

  @override
  String get taskTag_influenceKeyPoints => 'Puntos clave de la influencia';

  @override
  String get taskTag_insideKill => 'Inside kill';

  @override
  String get taskTag_insideMoves => 'Inside moves';

  @override
  String get taskTag_interestingTasks => 'Problemas de interés especial';

  @override
  String get taskTag_internalLibertyShortage => 'Falta de libertades internas';

  @override
  String get taskTag_invadingTechnique => 'Técnicas de invasión';

  @override
  String get taskTag_invasion => 'Invasión';

  @override
  String get taskTag_jGroupAndSimilar => 'Grupo-J y similares';

  @override
  String get taskTag_josekiFundamentals => 'Fundamentos de joseki';

  @override
  String get taskTag_jump => 'Salto';

  @override
  String get taskTag_keepSente => 'Mantener sente';

  @override
  String get taskTag_killAfterCapture => 'Matar mediante captura';

  @override
  String get taskTag_killByEyePointPlacement => 'Kill by eye point placement';

  @override
  String get taskTag_knightsMove => 'Salto de caballo';

  @override
  String get taskTag_ko => 'Ko';

  @override
  String get taskTag_kosumiWedge => 'Cuña diagonal';

  @override
  String get taskTag_largeKnightsMove => 'Salto grande de caballo';

  @override
  String get taskTag_largeMoyoFight => 'Large moyo fight';

  @override
  String get taskTag_lifeAndDeath => 'Vida y muerte: general';

  @override
  String get taskTag_lifeAndDeathOn4x4 => 'Vida y muerte en 4x4';

  @override
  String get taskTag_lookForLeverage => 'Look for leverage';

  @override
  String get taskTag_looseLadder => 'Escalera larga';

  @override
  String get taskTag_lovesickCut => 'Lovesick cut';

  @override
  String get taskTag_makeEye => 'Hacer ojo';

  @override
  String get taskTag_makeEyeInOneStep => 'Hacer ojo en una jugada';

  @override
  String get taskTag_makeEyeInSente => 'Hacer ojo en sente';

  @override
  String get taskTag_makeKo => 'Hacer ko';

  @override
  String get taskTag_makeShape => 'Hacer forma';

  @override
  String get taskTag_middlegame => 'Medio-juego';

  @override
  String get taskTag_monkeyClimbingMountain => 'Monkey climbing the mountain';

  @override
  String get taskTag_mouseStealingOil => 'Mouse stealing oil';

  @override
  String get taskTag_moveOut => 'Move out';

  @override
  String get taskTag_moveTowardsEmptySpace => 'Move towards empty space';

  @override
  String get taskTag_multipleBrilliantMoves => 'Múltiples jugadas brillantes';

  @override
  String get taskTag_net => 'Red';

  @override
  String get taskTag_netCapture => 'Captura en red';

  @override
  String get taskTag_observeSubtleDifference => 'Observa la diferencia sutil';

  @override
  String get taskTag_occupyEncloseAndApproachCorner =>
      'Ocupar, rodear y acercarse a las esquinas';

  @override
  String get taskTag_oneStoneTwoPurposes => 'Una jugada, dos objetivos';

  @override
  String get taskTag_opening => 'Apertura';

  @override
  String get taskTag_openingChoice => 'Elección de apertura';

  @override
  String get taskTag_openingFundamentals => 'Fundamentos de apertura';

  @override
  String get taskTag_orderOfEndgameMoves => 'Orden de jugadas de final';

  @override
  String get taskTag_orderOfMoves => 'Orden de jugadas';

  @override
  String get taskTag_orderOfMovesInKo => 'Orden de jugadas en un ko';

  @override
  String get taskTag_orioleCapturesButterfly => 'Oriole captures the butterfly';

  @override
  String get taskTag_pincer => 'Pinza';

  @override
  String get taskTag_placement => 'Placement';

  @override
  String get taskTag_plunderingTechnique => 'Plundering technique';

  @override
  String get taskTag_preventBambooJoint => 'Prevén la conección de bambú';

  @override
  String get taskTag_preventBridgingUnder => 'Prevent bridging under';

  @override
  String get taskTag_preventOpponentFromApproaching =>
      'Prevent opponent from approaching';

  @override
  String get taskTag_probe => 'Jugada de prueba';

  @override
  String get taskTag_profitInSente => 'Ganancia en sente';

  @override
  String get taskTag_profitUsingLifeAndDeath =>
      'Ganancia utilizando vida y muerte';

  @override
  String get taskTag_push => 'Push';

  @override
  String get taskTag_pyramidFour => 'Pirámide';

  @override
  String get taskTag_realEyeAndFalseEye => 'Ojo real contra ojo falso';

  @override
  String get taskTag_rectangularSix => 'Seis rectangulares';

  @override
  String get taskTag_reduceEyeSpace => 'Reducir espacio vital';

  @override
  String get taskTag_reduceLiberties => 'Reducir libertades';

  @override
  String get taskTag_reduction => 'Reducción';

  @override
  String get taskTag_runWeakGroup => 'Huída de grupo débil';

  @override
  String get taskTag_sabakiAndUtilizingInfluence =>
      'Sabaki y el uso de influencia';

  @override
  String get taskTag_sacrifice => 'Sacrificio';

  @override
  String get taskTag_sacrificeAndSqueeze => 'Sacrifica y exprime';

  @override
  String get taskTag_sealIn => 'Sellar';

  @override
  String get taskTag_secondLine => 'Segunda línea';

  @override
  String get taskTag_seizeTheOpportunity => 'Aprovecha la oportunidad';

  @override
  String get taskTag_seki => 'Seki';

  @override
  String get taskTag_senteAndGote => 'Sente y gote';

  @override
  String get taskTag_settleShape => 'Asienta la forma';

  @override
  String get taskTag_settleShapeInSente => 'Asienta la forma en sente';

  @override
  String get taskTag_shape => 'Forma';

  @override
  String get taskTag_shapesVitalPoint => 'Punto vital de la forma';

  @override
  String get taskTag_side => 'Lado';

  @override
  String get taskTag_smallBoardEndgame => 'Finales en tableros pequeños';

  @override
  String get taskTag_snapback => 'Contracaptura';

  @override
  String get taskTag_solidConnection => 'Conección sólida';

  @override
  String get taskTag_solidExtension => 'Extensión sólida';

  @override
  String get taskTag_splitInOneMove => 'Separar en una jugada';

  @override
  String get taskTag_splittingMove => 'Jugada de separación';

  @override
  String get taskTag_squareFour => 'Cuatro cuadradas';

  @override
  String get taskTag_squeeze => 'Exprime';

  @override
  String get taskTag_standardCapturingRaces => 'Semeais estándares';

  @override
  String get taskTag_standardCornerAndSideEndgame =>
      'Finales estándares en la esquina y el lado';

  @override
  String get taskTag_straightFour => 'Cuatro en línea';

  @override
  String get taskTag_straightThree => 'Tres en línea';

  @override
  String get taskTag_surroundTerritory => 'Rodear territorio';

  @override
  String get taskTag_symmetricShape => 'Forma simétrica';

  @override
  String get taskTag_techniqueForReinforcingGroups =>
      'Técnicas para reforzar grupos';

  @override
  String get taskTag_techniqueForSecuringTerritory =>
      'Técnicas para asegurar territorio';

  @override
  String get taskTag_textbookTasks => 'Problemas de libro';

  @override
  String get taskTag_thirdAndFourthLine => 'Tercera y cuarta línea';

  @override
  String get taskTag_threeEyesTwoActions => 'Tres ojos, dos jugadas';

  @override
  String get taskTag_threeSpaceExtensionFromTwoStones =>
      'Three-space extension from two stones';

  @override
  String get taskTag_throwIn => 'Throw-in';

  @override
  String get taskTag_tigersMouth => 'Boca de tigre';

  @override
  String get taskTag_tombstoneSqueeze => 'Fantasma cabezón';

  @override
  String get taskTag_tripodGroupWithExtraLegAndSimilar =>
      'Tripod group with extra leg and similar';

  @override
  String get taskTag_twoHaneGainOneLiberty => 'Double hane grows one liberty';

  @override
  String get taskTag_twoHeadedDragon => 'Dragón de dos cabezas';

  @override
  String get taskTag_twoSpaceExtension => 'Extensión de dos puntos';

  @override
  String get taskTag_typesOfKo => 'Tipos de ko';

  @override
  String get taskTag_underTheStones => 'Under the stones';

  @override
  String get taskTag_underneathAttachment => 'Underneath attachment';

  @override
  String get taskTag_urgentPointOfAFight => 'Punto urgente de una pelea';

  @override
  String get taskTag_urgentPoints => 'Puntos urgentes';

  @override
  String get taskTag_useConnectAndDie => 'Usa conecta y muere';

  @override
  String get taskTag_useCornerSpecialProperties =>
      'Usa las propiedades especiales de la esquina';

  @override
  String get taskTag_useDescentToFirstLine =>
      'Usa el descenso a la primera línea';

  @override
  String get taskTag_useInfluence => 'Usa la influencia';

  @override
  String get taskTag_useOpponentsLifeAndDeath =>
      'Usa la vida y muerte del oponente';

  @override
  String get taskTag_useShortageOfLiberties => 'Usa la falta de libertades';

  @override
  String get taskTag_useSnapback => 'Usar contracaptura';

  @override
  String get taskTag_useSurroundingStones => 'Usar piedras alrededor';

  @override
  String get taskTag_vitalAndUselessStones => 'Piedras vitales e inútiles';

  @override
  String get taskTag_vitalPointForBothSides => 'Punto vital para ambos';

  @override
  String get taskTag_vitalPointForCapturingRace => 'Punto vital para semeais';

  @override
  String get taskTag_vitalPointForIncreasingLiberties =>
      'Punto vital para aumentar libertades';

  @override
  String get taskTag_vitalPointForKill => 'Punto vital para matar';

  @override
  String get taskTag_vitalPointForLife => 'Punto vital para vivir';

  @override
  String get taskTag_vitalPointForReducingLiberties =>
      'Punto vital para reducir libertades';

  @override
  String get taskTag_wedge => 'Cuña';

  @override
  String get taskTag_wedgingCapture => 'Captura usando la cuña';

  @override
  String get taskTimeout => 'Se acabó el tiempo';

  @override
  String get taskTypeAppreciation => 'Apreciación';

  @override
  String get taskTypeCapture => 'Capturar';

  @override
  String get taskTypeCaptureRace => 'Semeai';

  @override
  String get taskTypeEndgame => 'Finales';

  @override
  String get taskTypeJoseki => 'Joseki';

  @override
  String get taskTypeLifeAndDeath => 'Vida y muerte';

  @override
  String get taskTypeMiddlegame => 'Medio-juego';

  @override
  String get taskTypeOpening => 'Apertura';

  @override
  String get taskTypeTesuji => 'Tesuji';

  @override
  String get taskTypeTheory => 'Teoría';

  @override
  String get taskWrong => 'Incorrecto';

  @override
  String get tasksSolved => 'Problemas resueltos';

  @override
  String get test => 'Probar';

  @override
  String get theme => 'Tema';

  @override
  String get thick => 'Gruesa';

  @override
  String get timeFrenzy => 'Contrarreloj';

  @override
  String get timePerTask => 'Tiempo por problema';

  @override
  String get today => 'Hoy';

  @override
  String get tooltipAnalyzeWithAISensei => 'Analizar con AI Sensei';

  @override
  String get tooltipDownloadGame => 'Descargar partida';

  @override
  String get topic => 'Tema';

  @override
  String get topicExam => 'Examen temático';

  @override
  String get topics => 'Temas';

  @override
  String get train => 'Entrenar';

  @override
  String get trainingAvgTimePerTask => 'Tiempo promedio por problema';

  @override
  String get trainingFailed => 'No aprobado';

  @override
  String get trainingMistakes => 'Errores';

  @override
  String get trainingPassed => 'Aprobado';

  @override
  String get trainingTotalTime => 'Tiempo total';

  @override
  String get tryCustomMoves => 'Probar otras jugadas';

  @override
  String get tygemDesc =>
      'El servidor más popular de Corea y uno de los más populares del mundo.';

  @override
  String get tygemName => 'Tygem Baduk';

  @override
  String get type => 'Tipo';

  @override
  String get ui => 'Interfaz';

  @override
  String get userInfo => 'Perfil de usuario';

  @override
  String get username => 'Nombre de usuario';

  @override
  String get voice => 'Voz';

  @override
  String get week => 'Semana';

  @override
  String get white => 'Blancas';

  @override
  String get yes => 'Sí';
}
