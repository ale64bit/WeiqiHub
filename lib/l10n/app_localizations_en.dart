// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get foxwqName => 'Fox Weiqi';

  @override
  String get foxwqDesc => 'The most popular server in China and the world.';

  @override
  String get tygemName => 'Tygem Baduk';

  @override
  String get tygemDesc =>
      'The most popular server in Korea and one of the most popular in the world.';

  @override
  String get ogsName => 'Online Go Server';

  @override
  String get ogsDesc =>
      'The premier online Go platform with tournaments, AI analysis, and a vibrant community.';

  @override
  String get username => 'Username';

  @override
  String get password => 'Password';

  @override
  String get login => 'Login';

  @override
  String get logout => 'Logout';

  @override
  String get register => 'Register';

  @override
  String get rules => 'Rules';

  @override
  String get rulesChinese => 'Chinese';

  @override
  String get rulesJapanese => 'Japanese';

  @override
  String get rulesKorean => 'Korean';

  @override
  String get myGames => 'My games';

  @override
  String get ok => 'OK';

  @override
  String get about => 'About';

  @override
  String get alwaysBlackToPlay => 'Always black-to-play';

  @override
  String get alwaysBlackToPlayDesc =>
      'Set all tasks as black-to-play to avoid confusion';

  @override
  String get appearance => 'Appearance';

  @override
  String get behaviour => 'Behaviour';

  @override
  String get board => 'Board';

  @override
  String get boardSize => 'Board size';

  @override
  String get boardTheme => 'Board theme';

  @override
  String get handicap => 'Handicap';

  @override
  String get komi => 'Komi';

  @override
  String get saveSGF => 'Save SGF';

  @override
  String get byRank => 'By rank';

  @override
  String get cancel => 'Cancel';

  @override
  String get collections => 'Collections';

  @override
  String get confirm => 'Confirm';

  @override
  String get confirmBoardSize => 'Confirm board size';

  @override
  String get confirmBoardSizeDesc =>
      'Boards this size or larger require move confirmation';

  @override
  String get confirmMoves => 'Confirm moves';

  @override
  String get confirmMovesDesc =>
      'Double-tap to confirm moves on large boards to avoid misclicks';

  @override
  String get customExam => 'Custom exam';

  @override
  String get dark => 'Dark';

  @override
  String get edgeLine => 'Edge line';

  @override
  String get endgameExam => 'Endgame exam';

  @override
  String get enterTaskLink => 'Enter the task link';

  @override
  String get errIncorrectUsernameOrPassword => 'Incorrect username or password';

  @override
  String get errCannotBeEmpty => 'Cannot be empty';

  @override
  String get errMustBeInteger => 'Must be an integer';

  @override
  String errMustBeAtLeast(num n) {
    return 'Must be at least $n';
  }

  @override
  String errMustBeAtMost(num n) {
    return 'Must be at most $n';
  }

  @override
  String get find => 'Find';

  @override
  String get findTask => 'Find task';

  @override
  String get gradingExam => 'Grading exam';

  @override
  String get home => 'Home';

  @override
  String get language => 'Language';

  @override
  String get light => 'Light';

  @override
  String get long => 'Long';

  @override
  String get medium => 'Medium';

  @override
  String get month => 'Month';

  @override
  String get myMistakes => 'My mistakes';

  @override
  String nTasksAvailable(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString tasks available',
      one: '1 task available',
      zero: 'No tasks available',
    );
    return '$_temp0';
  }

  @override
  String get none => 'None';

  @override
  String get numberOfTasks => 'Number of tasks';

  @override
  String get maxNumberOfMistakes => 'Maximum number of mistakes';

  @override
  String get timePerTask => 'Time per task';

  @override
  String get minutes => 'Minutes';

  @override
  String get seconds => 'Seconds';

  @override
  String get minRank => 'Min rank';

  @override
  String get maxRank => 'Max rank';

  @override
  String get taskSource => 'Task source';

  @override
  String get taskSourceFromTaskTypes => 'From task types';

  @override
  String get taskSourceFromTaskTopic => 'From task topic';

  @override
  String get taskSourceFromMyMistakes => 'From my mistakes';

  @override
  String get collectStats => 'Collect statistics';

  @override
  String get play => 'Play';

  @override
  String get rank => 'Rank';

  @override
  String get rankedMode => 'Ranked mode';

  @override
  String get responseDelay => 'Response delay';

  @override
  String get responseDelayDesc =>
      'Duration of the delay before the response appears while solving tasks';

  @override
  String get responseDelayLong => 'Long';

  @override
  String get responseDelayMedium => 'Medium';

  @override
  String get responseDelayNone => 'None';

  @override
  String get responseDelayShort => 'Short';

  @override
  String get result => 'Result';

  @override
  String get settings => 'Settings';

  @override
  String get short => 'Short';

  @override
  String get showCoordinates => 'Show coordinates';

  @override
  String get simple => 'Simple';

  @override
  String get sortModeDifficult => 'Difficult';

  @override
  String get sortModeRecent => 'Recent';

  @override
  String get sound => 'Sound';

  @override
  String get start => 'Start';

  @override
  String get continue_ => 'Continue';

  @override
  String get statistics => 'Statistics';

  @override
  String get statsDateColumn => 'Date';

  @override
  String get statsDurationColumn => 'Time';

  @override
  String get statsTimeColumn => 'Time';

  @override
  String get stoneShadows => 'Stone shadows';

  @override
  String get stones => 'Stones';

  @override
  String get system => 'System';

  @override
  String get task => 'Task';

  @override
  String get taskTypeLifeAndDeath => 'Life & death';

  @override
  String get taskTypeTesuji => 'Tesuji';

  @override
  String get taskTypeCapture => 'Capture stones';

  @override
  String get taskTypeCaptureRace => 'Capture race';

  @override
  String get taskTypeOpening => 'Opening';

  @override
  String get taskTypeJoseki => 'Joseki';

  @override
  String get taskTypeMiddlegame => 'Middlegame';

  @override
  String get taskTypeEndgame => 'Endgame';

  @override
  String get taskTypeTheory => 'Theory';

  @override
  String get taskTypeAppreciation => 'Appreciation';

  @override
  String get test => 'Test';

  @override
  String get theme => 'Theme';

  @override
  String get thick => 'Thick';

  @override
  String get timeFrenzy => 'Time frenzy';

  @override
  String get today => 'Today';

  @override
  String get topic => 'Topic';

  @override
  String get topics => 'Topics';

  @override
  String get subtopic => 'Subtopic';

  @override
  String get train => 'Train';

  @override
  String get type => 'Type';

  @override
  String get ui => 'UI';

  @override
  String get voice => 'Voice';

  @override
  String get week => 'Week';
}
