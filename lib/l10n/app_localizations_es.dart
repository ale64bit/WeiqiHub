// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get analysis => 'Análisis';

  @override
  String get winrate => 'Probabilidad de victoria';

  @override
  String get scoreLead => 'Ventaja en puntos';

  @override
  String get about => 'Acerca de WeiqiHub';

  @override
  String get acceptDeadStones => 'Aceptar piedras muertas';

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
  String get avgRank => 'Rango prom.';

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
  String get byType => 'Por tipo';

  @override
  String get cancel => 'Cancelar';

  @override
  String get captures => 'Capturas';

  @override
  String get chartTitleCorrectCount => 'Respuestas correctas';

  @override
  String get chartTitleExamCompletionTime => 'Tiempo de examen';

  @override
  String get charts => 'Gráficos';

  @override
  String get clearBoard => 'Limpiar';

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
  String get copySGF => 'Copiar SGF';

  @override
  String get copyTaskLink => 'Copiar enlace al problema';

  @override
  String get customExam => 'Examen personalizado';

  @override
  String get dark => 'Oscuro';

  @override
  String get deselectAll => 'Deseleccionar todo';

  @override
  String get dontShowAgain => 'No volver a mostrar';

  @override
  String get download => 'Descargar';

  @override
  String get edgeLine => 'Línea de borde';

  @override
  String get empty => 'Vacío';

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
  String errLoginFailedWithDetails(String message) {
    return 'Error al iniciar sesión: $message';
  }

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
  String get errNetworkError =>
      'Error de red. Por favor, verifica tu conexión e inténtalo de nuevo.';

  @override
  String get error => 'Error';

  @override
  String get exit => 'Salir';

  @override
  String get exitTryMode => 'Regresar';

  @override
  String get find => 'Buscar';

  @override
  String get findTask => 'Buscar problema';

  @override
  String get findTaskByLink => 'Con enlace';

  @override
  String get findTaskByPattern => 'Con patrón';

  @override
  String get findTaskResults => 'Resultados de búsqueda';

  @override
  String get findTaskSearching => 'Buscando...';

  @override
  String get forceCounting => 'Forzar conteo';

  @override
  String get foxwqDesc => 'El servidor más popular de China y el mundo.';

  @override
  String get foxwqName => 'Fox Weiqi';

  @override
  String get fullscreen => 'Pantalla completa';

  @override
  String get fullscreenDesc =>
      'Mostrar la aplicación en modo pantalla completa. Debe reiniciar la aplicación para que esta configuración surta efecto.';

  @override
  String get gameInfo => 'Información de la partida';

  @override
  String get gameRecord => 'Partida';

  @override
  String get gradingExam => 'Examen de rango';

  @override
  String get handicap => 'Handicap';

  @override
  String get help => 'Ayuda';

  @override
  String get hidePlayerRanks => 'Ocultar rangos de jugadores';

  @override
  String get hidePlayerRanksDesc =>
      'Ocultar rangos en el lobby del servidor y durante las partidas';

  @override
  String get helpDialogCollections =>
      'Las colecciones son libros clásicos de problemas de alta calidad que tienen un valor especial para el entrenamiento.\n\nEl objectivo principal es resolver una colección con un alto porcentaje de éxito. El objetivo secundario es resolver una colección lo más rápido posible.';

  @override
  String get helpDialogEndgameExam =>
      '- El examen de finales consiste de 10 problemas de finales y tienes 45 segundos para cada problema.\n\n- Apruebas el examen si resuelves 8 o más problemas correctamente (porcentaje de éxito de 80%).\n\n- Si apruebas el examen de un rango, desbloqueas el examen del rango siguiente.';

  @override
  String get helpDialogGradingExam =>
      '- El examen de rango consiste de 10 problemas y tienes 45 segundos para cada problema.\n\n- Apruebas el examen si resuelves 8 o más problemas correctamente (porcentaje de éxito de 80%).\n\n- Si apruebas el examen de un rango, desbloqueas el examen del rango siguiente.';

  @override
  String get helpDialogRankedMode =>
      '- Resuelve problemas sin límite de tiempo.\n\n- La dificultad de los problemas aumenta de acuerdo a qué tan rápido los resuelves.\n\n- Concéntrate en resolver problemas correctamente y alcanzar el rango más alto posible.';

  @override
  String get helpDialogTimeFrenzy =>
      '- Tienes 3 minutos para resolver tantos problemas como sea posible.\n\n- La dificultad de los problemas aumenta a medida que los resuelves.\n\n- Si fallas 3 problemas, el contrarreloj termina.';

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
  String get maxChartPoints => 'Puntos máx.';

  @override
  String get maxNumberOfMistakes => 'Número máximo de errores';

  @override
  String get maxRank => 'Rango máx.';

  @override
  String get medium => 'Media';

  @override
  String get minRank => 'Rango mín.';

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
  String get msgConfirmDeletePreset =>
      '¿Está seguro de que quiere eliminar esta plantilla?';

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
  String get msgPresetAlreadyExists =>
      'Ya existe una plantilla con ese nombre.';

  @override
  String get msgSearchingForGame => 'Buscando partida...';

  @override
  String get msgSgfCopied => 'SGF copiado al portapapeles';

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
  String get newBestResult => '¡Nuevo record!';

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
      'Un servidor internacional, más popular en Europa y las Américas.';

  @override
  String get ogsName => 'Online Go Server';

  @override
  String get ok => 'OK';

  @override
  String get pass => 'Pasar';

  @override
  String get password => 'Contraseña';

  @override
  String get perTask => 'por problema';

  @override
  String get play => 'Jugar';

  @override
  String get pleaseMarkDeadStones => 'Por favor, marca las piedras muertas.';

  @override
  String get presetName => 'Nombre de plantilla';

  @override
  String get presets => 'Plantillas';

  @override
  String get promotionRequirements => 'Requisitos de promoción';

  @override
  String pxsByoyomi(int p, int s) {
    return '$p×${s}s';
  }

  @override
  String get randomizeTaskOrientation => 'Orientación aleatoria de problemas';

  @override
  String get randomizeTaskOrientationDesc =>
      'Rota y refleja aleatoriamente los problemas a lo largo de los ejes horizontal, vertical y diagonal para evitar la memorización y mejorar el reconocimiento de patrones.';

  @override
  String get rank => 'Rango';

  @override
  String get rankedMode => 'Clasificatorio';

  @override
  String get recentRecord => 'Resultados recientes';

  @override
  String get register => 'Registrarse';

  @override
  String get rejectDeadStones => 'Rechazar piedras muertas';

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
  String get resultAccept => 'Aceptar';

  @override
  String get resultReject => 'Rechazar';

  @override
  String get rules => 'Reglas';

  @override
  String get rulesChinese => 'Chinas';

  @override
  String get rulesJapanese => 'Japonesas';

  @override
  String get rulesKorean => 'Coreanas';

  @override
  String sSeconds(int s) {
    return '${s}s';
  }

  @override
  String get save => 'Guardar';

  @override
  String get savePreset => 'Guardar plantilla';

  @override
  String get saveSGF => 'Guardar SGF';

  @override
  String get seconds => 'Segundos';

  @override
  String get selectAll => 'Seleccionar todo';

  @override
  String get settings => 'Preferencias';

  @override
  String get short => 'Corta';

  @override
  String get showCoordinates => 'Mostrar coordenadas';

  @override
  String get showMoveErrorsAsCrosses =>
      'Mostrar jugadas incorrectas como cruces';

  @override
  String get showMoveErrorsAsCrossesDesc =>
      'Mostrar jugadas incorrectas como cruces rojas en lugar de puntos rojos';

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
  String get taskNotFound => 'No se encontró el problema';

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
  String get timeFrenzyMistakes => 'Rastrear errores en Contrarreloj';

  @override
  String get timeFrenzyMistakesDesc =>
      'Habilitar para guardar errores cometidos en Contrarreloj';

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
