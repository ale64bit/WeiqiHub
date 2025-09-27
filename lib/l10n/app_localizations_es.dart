// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get settings => 'Preferencias';

  @override
  String get appearance => 'Apariencia';

  @override
  String get theme => 'Tema';

  @override
  String get system => 'Sistema';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Oscuro';

  @override
  String get boardTheme => 'Tema del tablero';

  @override
  String get showCoordinates => 'Mostrar coordenadas';

  @override
  String get stoneShadows => 'Sombra de las piedras';

  @override
  String get edgeLine => 'Línea de borde';

  @override
  String get simple => 'Simple';

  @override
  String get thick => 'Gruesa';

  @override
  String get behaviour => 'Comportamiento';

  @override
  String get confirmMoves => 'Confirmar jugada';

  @override
  String get confirmMovesDesc =>
      'Doble tap para confirmar jugadas en tableros grandes para evitar accidentes';

  @override
  String get confirmBoardSize => 'Tamaño de confirmación';

  @override
  String get confirmBoardSizeDesc =>
      'Tableros de este tamaño o mayores requieren confirmar jugadas';

  @override
  String get responseDelay => 'Demora de respuesta';

  @override
  String get responseDelayDesc =>
      'Demora de la respuesta del oponente mientras resuelves problemas';

  @override
  String get none => 'Ninguna';

  @override
  String get short => 'Corta';

  @override
  String get medium => 'Media';

  @override
  String get long => 'Larga';

  @override
  String get alwaysBlackToPlay => 'Siempre juegan las negras';

  @override
  String get alwaysBlackToPlayDesc =>
      'Hace que en todos los problemas jueguen las negras para evitar confusión';

  @override
  String get sound => 'Sonido';

  @override
  String get stones => 'Piedras';

  @override
  String get ui => 'Interfaz';

  @override
  String get voice => 'Voz';

  @override
  String get test => 'Prueba';

  @override
  String get language => 'Idioma';

  @override
  String get about => 'Acerca de WeiqiHub';
}
