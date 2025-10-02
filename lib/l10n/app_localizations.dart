import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @foxwqName.
  ///
  /// In en, this message translates to:
  /// **'Fox Weiqi'**
  String get foxwqName;

  /// No description provided for @foxwqDesc.
  ///
  /// In en, this message translates to:
  /// **'The most popular server in China and the world.'**
  String get foxwqDesc;

  /// No description provided for @tygemName.
  ///
  /// In en, this message translates to:
  /// **'Tygem Baduk'**
  String get tygemName;

  /// No description provided for @tygemDesc.
  ///
  /// In en, this message translates to:
  /// **'The most popular server in Korea and one of the most popular in the world.'**
  String get tygemDesc;

  /// No description provided for @ogsName.
  ///
  /// In en, this message translates to:
  /// **'Online Go Server'**
  String get ogsName;

  /// No description provided for @ogsDesc.
  ///
  /// In en, this message translates to:
  /// **'The premier online Go platform with tournaments, AI analysis, and a vibrant community.'**
  String get ogsDesc;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @rules.
  ///
  /// In en, this message translates to:
  /// **'Rules'**
  String get rules;

  /// No description provided for @rulesChinese.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get rulesChinese;

  /// No description provided for @rulesJapanese.
  ///
  /// In en, this message translates to:
  /// **'Japanese'**
  String get rulesJapanese;

  /// No description provided for @rulesKorean.
  ///
  /// In en, this message translates to:
  /// **'Korean'**
  String get rulesKorean;

  /// No description provided for @myGames.
  ///
  /// In en, this message translates to:
  /// **'My games'**
  String get myGames;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @alwaysBlackToPlay.
  ///
  /// In en, this message translates to:
  /// **'Always black-to-play'**
  String get alwaysBlackToPlay;

  /// No description provided for @alwaysBlackToPlayDesc.
  ///
  /// In en, this message translates to:
  /// **'Set all tasks as black-to-play to avoid confusion'**
  String get alwaysBlackToPlayDesc;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @behaviour.
  ///
  /// In en, this message translates to:
  /// **'Behaviour'**
  String get behaviour;

  /// No description provided for @board.
  ///
  /// In en, this message translates to:
  /// **'Board'**
  String get board;

  /// No description provided for @boardSize.
  ///
  /// In en, this message translates to:
  /// **'Board size'**
  String get boardSize;

  /// No description provided for @boardTheme.
  ///
  /// In en, this message translates to:
  /// **'Board theme'**
  String get boardTheme;

  /// No description provided for @handicap.
  ///
  /// In en, this message translates to:
  /// **'Handicap'**
  String get handicap;

  /// No description provided for @komi.
  ///
  /// In en, this message translates to:
  /// **'Komi'**
  String get komi;

  /// No description provided for @saveSGF.
  ///
  /// In en, this message translates to:
  /// **'Save SGF'**
  String get saveSGF;

  /// No description provided for @byRank.
  ///
  /// In en, this message translates to:
  /// **'By rank'**
  String get byRank;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @collections.
  ///
  /// In en, this message translates to:
  /// **'Collections'**
  String get collections;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @confirmBoardSize.
  ///
  /// In en, this message translates to:
  /// **'Confirm board size'**
  String get confirmBoardSize;

  /// No description provided for @confirmBoardSizeDesc.
  ///
  /// In en, this message translates to:
  /// **'Boards this size or larger require move confirmation'**
  String get confirmBoardSizeDesc;

  /// No description provided for @confirmMoves.
  ///
  /// In en, this message translates to:
  /// **'Confirm moves'**
  String get confirmMoves;

  /// No description provided for @confirmMovesDesc.
  ///
  /// In en, this message translates to:
  /// **'Double-tap to confirm moves on large boards to avoid misclicks'**
  String get confirmMovesDesc;

  /// No description provided for @customExam.
  ///
  /// In en, this message translates to:
  /// **'Custom exam'**
  String get customExam;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @edgeLine.
  ///
  /// In en, this message translates to:
  /// **'Edge line'**
  String get edgeLine;

  /// No description provided for @endgameExam.
  ///
  /// In en, this message translates to:
  /// **'Endgame exam'**
  String get endgameExam;

  /// No description provided for @enterTaskLink.
  ///
  /// In en, this message translates to:
  /// **'Enter the task link'**
  String get enterTaskLink;

  /// No description provided for @errIncorrectUsernameOrPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect username or password'**
  String get errIncorrectUsernameOrPassword;

  /// No description provided for @errCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Cannot be empty'**
  String get errCannotBeEmpty;

  /// No description provided for @errMustBeInteger.
  ///
  /// In en, this message translates to:
  /// **'Must be an integer'**
  String get errMustBeInteger;

  /// No description provided for @errMustBeAtLeast.
  ///
  /// In en, this message translates to:
  /// **'Must be at least {n}'**
  String errMustBeAtLeast(num n);

  /// No description provided for @errMustBeAtMost.
  ///
  /// In en, this message translates to:
  /// **'Must be at most {n}'**
  String errMustBeAtMost(num n);

  /// No description provided for @find.
  ///
  /// In en, this message translates to:
  /// **'Find'**
  String get find;

  /// No description provided for @findTask.
  ///
  /// In en, this message translates to:
  /// **'Find task'**
  String get findTask;

  /// No description provided for @gradingExam.
  ///
  /// In en, this message translates to:
  /// **'Grading exam'**
  String get gradingExam;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @long.
  ///
  /// In en, this message translates to:
  /// **'Long'**
  String get long;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @myMistakes.
  ///
  /// In en, this message translates to:
  /// **'My mistakes'**
  String get myMistakes;

  /// No description provided for @nTasksAvailable.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No tasks available} =1{1 task available} other{{count} tasks available}}'**
  String nTasksAvailable(int count);

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// No description provided for @numberOfTasks.
  ///
  /// In en, this message translates to:
  /// **'Number of tasks'**
  String get numberOfTasks;

  /// No description provided for @maxNumberOfMistakes.
  ///
  /// In en, this message translates to:
  /// **'Maximum number of mistakes'**
  String get maxNumberOfMistakes;

  /// No description provided for @timePerTask.
  ///
  /// In en, this message translates to:
  /// **'Time per task'**
  String get timePerTask;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get minutes;

  /// No description provided for @seconds.
  ///
  /// In en, this message translates to:
  /// **'Seconds'**
  String get seconds;

  /// No description provided for @minRank.
  ///
  /// In en, this message translates to:
  /// **'Min rank'**
  String get minRank;

  /// No description provided for @maxRank.
  ///
  /// In en, this message translates to:
  /// **'Max rank'**
  String get maxRank;

  /// No description provided for @taskSource.
  ///
  /// In en, this message translates to:
  /// **'Task source'**
  String get taskSource;

  /// No description provided for @taskSourceFromTaskTypes.
  ///
  /// In en, this message translates to:
  /// **'From task types'**
  String get taskSourceFromTaskTypes;

  /// No description provided for @taskSourceFromTaskTopic.
  ///
  /// In en, this message translates to:
  /// **'From task topic'**
  String get taskSourceFromTaskTopic;

  /// No description provided for @taskSourceFromMyMistakes.
  ///
  /// In en, this message translates to:
  /// **'From my mistakes'**
  String get taskSourceFromMyMistakes;

  /// No description provided for @collectStats.
  ///
  /// In en, this message translates to:
  /// **'Collect statistics'**
  String get collectStats;

  /// No description provided for @play.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get play;

  /// No description provided for @rank.
  ///
  /// In en, this message translates to:
  /// **'Rank'**
  String get rank;

  /// No description provided for @rankedMode.
  ///
  /// In en, this message translates to:
  /// **'Ranked mode'**
  String get rankedMode;

  /// No description provided for @responseDelay.
  ///
  /// In en, this message translates to:
  /// **'Response delay'**
  String get responseDelay;

  /// No description provided for @responseDelayDesc.
  ///
  /// In en, this message translates to:
  /// **'Duration of the delay before the response appears while solving tasks'**
  String get responseDelayDesc;

  /// No description provided for @responseDelayLong.
  ///
  /// In en, this message translates to:
  /// **'Long'**
  String get responseDelayLong;

  /// No description provided for @responseDelayMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get responseDelayMedium;

  /// No description provided for @responseDelayNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get responseDelayNone;

  /// No description provided for @responseDelayShort.
  ///
  /// In en, this message translates to:
  /// **'Short'**
  String get responseDelayShort;

  /// No description provided for @result.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get result;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @short.
  ///
  /// In en, this message translates to:
  /// **'Short'**
  String get short;

  /// No description provided for @showCoordinates.
  ///
  /// In en, this message translates to:
  /// **'Show coordinates'**
  String get showCoordinates;

  /// No description provided for @simple.
  ///
  /// In en, this message translates to:
  /// **'Simple'**
  String get simple;

  /// No description provided for @sortModeDifficult.
  ///
  /// In en, this message translates to:
  /// **'Difficult'**
  String get sortModeDifficult;

  /// No description provided for @sortModeRecent.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get sortModeRecent;

  /// No description provided for @sound.
  ///
  /// In en, this message translates to:
  /// **'Sound'**
  String get sound;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @continue_.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue_;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @statsDateColumn.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get statsDateColumn;

  /// No description provided for @statsDurationColumn.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get statsDurationColumn;

  /// No description provided for @statsTimeColumn.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get statsTimeColumn;

  /// No description provided for @stoneShadows.
  ///
  /// In en, this message translates to:
  /// **'Stone shadows'**
  String get stoneShadows;

  /// No description provided for @stones.
  ///
  /// In en, this message translates to:
  /// **'Stones'**
  String get stones;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @task.
  ///
  /// In en, this message translates to:
  /// **'Task'**
  String get task;

  /// No description provided for @taskTypeLifeAndDeath.
  ///
  /// In en, this message translates to:
  /// **'Life & death'**
  String get taskTypeLifeAndDeath;

  /// No description provided for @taskTypeTesuji.
  ///
  /// In en, this message translates to:
  /// **'Tesuji'**
  String get taskTypeTesuji;

  /// No description provided for @taskTypeCapture.
  ///
  /// In en, this message translates to:
  /// **'Capture stones'**
  String get taskTypeCapture;

  /// No description provided for @taskTypeCaptureRace.
  ///
  /// In en, this message translates to:
  /// **'Capture race'**
  String get taskTypeCaptureRace;

  /// No description provided for @taskTypeOpening.
  ///
  /// In en, this message translates to:
  /// **'Opening'**
  String get taskTypeOpening;

  /// No description provided for @taskTypeJoseki.
  ///
  /// In en, this message translates to:
  /// **'Joseki'**
  String get taskTypeJoseki;

  /// No description provided for @taskTypeMiddlegame.
  ///
  /// In en, this message translates to:
  /// **'Middlegame'**
  String get taskTypeMiddlegame;

  /// No description provided for @taskTypeEndgame.
  ///
  /// In en, this message translates to:
  /// **'Endgame'**
  String get taskTypeEndgame;

  /// No description provided for @taskTypeTheory.
  ///
  /// In en, this message translates to:
  /// **'Theory'**
  String get taskTypeTheory;

  /// No description provided for @taskTypeAppreciation.
  ///
  /// In en, this message translates to:
  /// **'Appreciation'**
  String get taskTypeAppreciation;

  /// No description provided for @test.
  ///
  /// In en, this message translates to:
  /// **'Test'**
  String get test;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @thick.
  ///
  /// In en, this message translates to:
  /// **'Thick'**
  String get thick;

  /// No description provided for @timeFrenzy.
  ///
  /// In en, this message translates to:
  /// **'Time frenzy'**
  String get timeFrenzy;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @topic.
  ///
  /// In en, this message translates to:
  /// **'Topic'**
  String get topic;

  /// No description provided for @topics.
  ///
  /// In en, this message translates to:
  /// **'Topics'**
  String get topics;

  /// No description provided for @subtopic.
  ///
  /// In en, this message translates to:
  /// **'Subtopic'**
  String get subtopic;

  /// No description provided for @train.
  ///
  /// In en, this message translates to:
  /// **'Train'**
  String get train;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @ui.
  ///
  /// In en, this message translates to:
  /// **'UI'**
  String get ui;

  /// No description provided for @voice.
  ///
  /// In en, this message translates to:
  /// **'Voice'**
  String get voice;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
