// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get settings => 'Settings';

  @override
  String get appearance => 'Appearance';

  @override
  String get theme => 'Theme';

  @override
  String get system => 'System';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get boardTheme => 'Board theme';

  @override
  String get showCoordinates => 'Show coordinates';

  @override
  String get stoneShadows => 'Stone shadows';

  @override
  String get edgeLine => 'Edge line';

  @override
  String get simple => 'Simple';

  @override
  String get thick => 'Thick';

  @override
  String get behaviour => 'Behaviour';

  @override
  String get confirmMoves => 'Confirm moves';

  @override
  String get confirmMovesDesc =>
      'Double-tap to confirm moves on large boards to avoid misclicks';

  @override
  String get confirmBoardSize => 'Confirm board size';

  @override
  String get confirmBoardSizeDesc =>
      'Boards this size or larger require move confirmation';

  @override
  String get responseDelay => 'Response delay';

  @override
  String get responseDelayDesc =>
      'Duration of the delay before the response appears while solving tasks';

  @override
  String get none => 'None';

  @override
  String get short => 'Short';

  @override
  String get medium => 'Medium';

  @override
  String get long => 'Long';

  @override
  String get alwaysBlackToPlay => 'Always black-to-play';

  @override
  String get alwaysBlackToPlayDesc =>
      'Set all tasks as black-to-play to avoid confusion';

  @override
  String get sound => 'Sound';

  @override
  String get stones => 'Stones';

  @override
  String get ui => 'UI';

  @override
  String get voice => 'Voice';

  @override
  String get test => 'Test';

  @override
  String get language => 'Language';

  @override
  String get about => 'About';
}
