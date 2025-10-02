// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get foxwqName => 'Fox Weiqi';

  @override
  String get foxwqDesc => 'El servidor más popular de China y el mundo.';

  @override
  String get tygemName => 'Tygem Baduk';

  @override
  String get tygemDesc =>
      'El servidor más popular de Corea y uno de los más populares del mundo.';

  @override
  String get ogsName => 'Online Go Server';

  @override
  String get ogsDesc =>
      'La principal plataforma en línea de Go, con torneos, análisis con IA y una vibrante comunidad.';

  @override
  String get username => 'Nombre de usuario';

  @override
  String get password => 'Contraseña';

  @override
  String get login => 'Entrar';

  @override
  String get logout => 'Salir';

  @override
  String get register => 'Registrarse';

  @override
  String get rules => 'Reglas';

  @override
  String get rulesChinese => 'Chinas';

  @override
  String get rulesJapanese => 'Japonesas';

  @override
  String get rulesKorean => 'Coreanas';

  @override
  String get myGames => 'Mis partidas';

  @override
  String get ok => 'OK';

  @override
  String get about => 'Acerca de WeiqiHub';

  @override
  String get alwaysBlackToPlay => 'Siempre juegan las negras';

  @override
  String get alwaysBlackToPlayDesc =>
      'Hace que en todos los problemas jueguen las negras para evitar confusión';

  @override
  String get appearance => 'Apariencia';

  @override
  String get behaviour => 'Comportamiento';

  @override
  String get board => 'Tablero';

  @override
  String get boardSize => 'Tamaño del tablero';

  @override
  String get boardTheme => 'Tema del tablero';

  @override
  String get handicap => 'Handicap';

  @override
  String get komi => 'Komi';

  @override
  String get saveSGF => 'Guardar SGF';

  @override
  String get byRank => 'Por rango';

  @override
  String get cancel => 'Cancelar';

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
  String get customExam => 'Examen personalizado';

  @override
  String get dark => 'Oscuro';

  @override
  String get edgeLine => 'Línea de borde';

  @override
  String get endgameExam => 'Examen de finales';

  @override
  String get enterTaskLink => 'Introduce el enlace al problema';

  @override
  String get errIncorrectUsernameOrPassword =>
      'Nombre de usuario o contraseña incorrectos';

  @override
  String get errCannotBeEmpty => 'No puede estar vacío';

  @override
  String get errMustBeInteger => 'Debe ser un número entero';

  @override
  String errMustBeAtLeast(num n) {
    return 'No puede ser menor que $n';
  }

  @override
  String errMustBeAtMost(num n) {
    return 'No puede ser mayor que $n';
  }

  @override
  String get find => 'Buscar';

  @override
  String get findTask => 'Buscar problema';

  @override
  String get gradingExam => 'Examen de rango';

  @override
  String get home => 'Inicio';

  @override
  String get language => 'Idioma';

  @override
  String get light => 'Claro';

  @override
  String get long => 'Larga';

  @override
  String get medium => 'Media';

  @override
  String get month => 'Mes';

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
  String get none => 'Ninguna';

  @override
  String get numberOfTasks => 'Número de problemas';

  @override
  String get maxNumberOfMistakes => 'Número máximo de errores';

  @override
  String get timePerTask => 'Tiempo por problema';

  @override
  String get minutes => 'Minutos';

  @override
  String get seconds => 'Segundos';

  @override
  String get minRank => 'Rango mínimo';

  @override
  String get maxRank => 'Rango máximo';

  @override
  String get taskSource => 'Origen de problemas';

  @override
  String get taskSourceFromTaskTypes => 'Por tipos de problema';

  @override
  String get taskSourceFromTaskTopic => 'Por tema';

  @override
  String get taskSourceFromMyMistakes => 'Mis errores';

  @override
  String get collectStats => 'Añadir a las estadísticas';

  @override
  String get play => 'Jugar';

  @override
  String get rank => 'Rango';

  @override
  String get rankedMode => 'Clasificatorio';

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
  String get continue_ => 'Continuar';

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
  String get system => 'Sistema';

  @override
  String get task => 'Problema';

  @override
  String get taskTypeLifeAndDeath => 'Vida y muerte';

  @override
  String get taskTypeTesuji => 'Tesuji';

  @override
  String get taskTypeCapture => 'Capturar';

  @override
  String get taskTypeCaptureRace => 'Semeai';

  @override
  String get taskTypeOpening => 'Apertura';

  @override
  String get taskTypeJoseki => 'Joseki';

  @override
  String get taskTypeMiddlegame => 'Medio-juego';

  @override
  String get taskTypeEndgame => 'Finales';

  @override
  String get taskTypeTheory => 'Teoría';

  @override
  String get taskTypeAppreciation => 'Apreciación';

  @override
  String get test => 'Probar';

  @override
  String get theme => 'Tema';

  @override
  String get thick => 'Gruesa';

  @override
  String get timeFrenzy => 'Contrarreloj';

  @override
  String get today => 'Hoy';

  @override
  String get topic => 'Tema';

  @override
  String get topics => 'Temas';

  @override
  String get subtopic => 'Subtema';

  @override
  String get train => 'Entrenar';

  @override
  String get type => 'Tipo';

  @override
  String get ui => 'Interfaz';

  @override
  String get voice => 'Voz';

  @override
  String get week => 'Semana';
}
