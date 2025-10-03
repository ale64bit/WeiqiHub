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
  String get promotionRequirements => 'Requisitos para promoción';

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
  String get yes => 'Sí';
}
