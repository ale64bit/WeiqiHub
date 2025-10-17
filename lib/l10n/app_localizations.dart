import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

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
    Locale('es'),
    Locale('ru'),
    Locale('zh')
  ];

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @accuracy.
  ///
  /// In en, this message translates to:
  /// **'Accuracy'**
  String get accuracy;

  /// No description provided for @aiReferee.
  ///
  /// In en, this message translates to:
  /// **'AI referee'**
  String get aiReferee;

  /// No description provided for @aiSensei.
  ///
  /// In en, this message translates to:
  /// **'AI Sensei'**
  String get aiSensei;

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

  /// No description provided for @autoCounting.
  ///
  /// In en, this message translates to:
  /// **'Auto counting'**
  String get autoCounting;

  /// No description provided for @autoMatch.
  ///
  /// In en, this message translates to:
  /// **'Auto-Match'**
  String get autoMatch;

  /// No description provided for @behaviour.
  ///
  /// In en, this message translates to:
  /// **'Behaviour'**
  String get behaviour;

  /// No description provided for @bestResult.
  ///
  /// In en, this message translates to:
  /// **'Best result'**
  String get bestResult;

  /// No description provided for @black.
  ///
  /// In en, this message translates to:
  /// **'Black'**
  String get black;

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

  /// No description provided for @captures.
  ///
  /// In en, this message translates to:
  /// **'Captures'**
  String get captures;

  /// No description provided for @clearBoard.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clearBoard;

  /// No description provided for @collectStats.
  ///
  /// In en, this message translates to:
  /// **'Collect statistics'**
  String get collectStats;

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

  /// No description provided for @continue_.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue_;

  /// No description provided for @copyTaskLink.
  ///
  /// In en, this message translates to:
  /// **'Copy task link'**
  String get copyTaskLink;

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

  /// No description provided for @dontShowAgain.
  ///
  /// In en, this message translates to:
  /// **'Don\'t show again'**
  String get dontShowAgain;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @edgeLine.
  ///
  /// In en, this message translates to:
  /// **'Edge line'**
  String get edgeLine;

  /// No description provided for @empty.
  ///
  /// In en, this message translates to:
  /// **'Empty'**
  String get empty;

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

  /// No description provided for @errCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Cannot be empty'**
  String get errCannotBeEmpty;

  /// No description provided for @errFailedToDownloadGame.
  ///
  /// In en, this message translates to:
  /// **'Failed to download game'**
  String get errFailedToDownloadGame;

  /// No description provided for @errFailedToLoadGameList.
  ///
  /// In en, this message translates to:
  /// **'Failed to load game list. Please try again.'**
  String get errFailedToLoadGameList;

  /// No description provided for @errFailedToUploadGameToAISensei.
  ///
  /// In en, this message translates to:
  /// **'Failed to upload game to AI Sensei'**
  String get errFailedToUploadGameToAISensei;

  /// No description provided for @errIncorrectUsernameOrPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect username or password'**
  String get errIncorrectUsernameOrPassword;

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

  /// No description provided for @errMustBeInteger.
  ///
  /// In en, this message translates to:
  /// **'Must be an integer'**
  String get errMustBeInteger;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// No description provided for @exitTryMode.
  ///
  /// In en, this message translates to:
  /// **'Exit try mode'**
  String get exitTryMode;

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

  /// No description provided for @findTaskByLink.
  ///
  /// In en, this message translates to:
  /// **'By link'**
  String get findTaskByLink;

  /// No description provided for @findTaskByPattern.
  ///
  /// In en, this message translates to:
  /// **'By pattern'**
  String get findTaskByPattern;

  /// No description provided for @findTaskResults.
  ///
  /// In en, this message translates to:
  /// **'Search results'**
  String get findTaskResults;

  /// No description provided for @findTaskSearching.
  ///
  /// In en, this message translates to:
  /// **'Searching...'**
  String get findTaskSearching;

  /// No description provided for @forceCounting.
  ///
  /// In en, this message translates to:
  /// **'Force counting'**
  String get forceCounting;

  /// No description provided for @foxwqDesc.
  ///
  /// In en, this message translates to:
  /// **'The most popular server in China and the world.'**
  String get foxwqDesc;

  /// No description provided for @foxwqName.
  ///
  /// In en, this message translates to:
  /// **'Fox Weiqi'**
  String get foxwqName;

  /// No description provided for @gameInfo.
  ///
  /// In en, this message translates to:
  /// **'Game info'**
  String get gameInfo;

  /// No description provided for @gameRecord.
  ///
  /// In en, this message translates to:
  /// **'Game record'**
  String get gameRecord;

  /// No description provided for @gradingExam.
  ///
  /// In en, this message translates to:
  /// **'Grading exam'**
  String get gradingExam;

  /// No description provided for @handicap.
  ///
  /// In en, this message translates to:
  /// **'Handicap'**
  String get handicap;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @helpDialogCollections.
  ///
  /// In en, this message translates to:
  /// **'Collections are classic, curated sets of high-quality tasks which hold special value together as a training resource.\n\nThe main goal is to solve a collection with a high success rate. A secondary goal is to solve it as fast as possible.\n\nTo start or continue solving a collection, slide left on the collection tile while in portrait mode or click the Start/Continue buttons while in landscape mode.'**
  String get helpDialogCollections;

  /// No description provided for @helpDialogEndgameExam.
  ///
  /// In en, this message translates to:
  /// **'- Endgame exams are sets of 10 endgame tasks and you have 45 seconds per task.\n\n- You pass the exam if you solve 8 or more correctly (80% success rate).\n\n- Passing the exam for a given rank unlocks the exam for the next rank.'**
  String get helpDialogEndgameExam;

  /// No description provided for @helpDialogGradingExam.
  ///
  /// In en, this message translates to:
  /// **'- Grading exams are sets of 10 tasks and you have 45 seconds per task.\n\n- You pass the exam if you solve 8 or more correctly (80% success rate).\n\n- Passing the exam for a given rank unlocks the exam for the next rank.'**
  String get helpDialogGradingExam;

  /// No description provided for @helpDialogRankedMode.
  ///
  /// In en, this message translates to:
  /// **'- Solve tasks without a time limit.\n\n- Task difficulty increases according to how fast you solve them.\n\n- Focus on solving correctly and reach the highest rank possible.'**
  String get helpDialogRankedMode;

  /// No description provided for @helpDialogTimeFrenzy.
  ///
  /// In en, this message translates to:
  /// **'- You have 3 minutes to solve as many tasks as possible.\n\n- Tasks get increasingly difficult as you solve them.\n\n- If you make 3 mistakes, you are out.'**
  String get helpDialogTimeFrenzy;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @komi.
  ///
  /// In en, this message translates to:
  /// **'Komi'**
  String get komi;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @leave.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get leave;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

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

  /// No description provided for @long.
  ///
  /// In en, this message translates to:
  /// **'Long'**
  String get long;

  /// No description provided for @mMinutes.
  ///
  /// In en, this message translates to:
  /// **'{m}min'**
  String mMinutes(int m);

  /// No description provided for @maxNumberOfMistakes.
  ///
  /// In en, this message translates to:
  /// **'Maximum number of mistakes'**
  String get maxNumberOfMistakes;

  /// No description provided for @maxRank.
  ///
  /// In en, this message translates to:
  /// **'Max rank'**
  String get maxRank;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @minRank.
  ///
  /// In en, this message translates to:
  /// **'Min rank'**
  String get minRank;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get minutes;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @msgCannotUseAIRefereeYet.
  ///
  /// In en, this message translates to:
  /// **'AI referee cannot be used yet'**
  String get msgCannotUseAIRefereeYet;

  /// No description provided for @msgCannotUseForcedCountingYet.
  ///
  /// In en, this message translates to:
  /// **'Forced counting cannot be used yet'**
  String get msgCannotUseForcedCountingYet;

  /// No description provided for @msgConfirmDeleteCollectionProgress.
  ///
  /// In en, this message translates to:
  /// **'Are you sure that you want to delete the previous attempt?'**
  String get msgConfirmDeleteCollectionProgress;

  /// No description provided for @msgConfirmResignation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure that you want to resign?'**
  String get msgConfirmResignation;

  /// No description provided for @msgConfirmStopEvent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure that you want to stop the {event}?'**
  String msgConfirmStopEvent(String event);

  /// No description provided for @msgDownloadingGame.
  ///
  /// In en, this message translates to:
  /// **'Downloading game'**
  String get msgDownloadingGame;

  /// No description provided for @msgGameSavedTo.
  ///
  /// In en, this message translates to:
  /// **'Game saved to {path}'**
  String msgGameSavedTo(String path);

  /// No description provided for @msgPleaseWaitForYourTurn.
  ///
  /// In en, this message translates to:
  /// **'Please, wait for your turn'**
  String get msgPleaseWaitForYourTurn;

  /// No description provided for @msgSearchingForGame.
  ///
  /// In en, this message translates to:
  /// **'Searching for a game...'**
  String get msgSearchingForGame;

  /// No description provided for @msgTaskLinkCopied.
  ///
  /// In en, this message translates to:
  /// **'Task link copied.'**
  String get msgTaskLinkCopied;

  /// No description provided for @msgWaitingForOpponentsDecision.
  ///
  /// In en, this message translates to:
  /// **'Waiting for your opponent\'s decision...'**
  String get msgWaitingForOpponentsDecision;

  /// No description provided for @msgYouCannotPass.
  ///
  /// In en, this message translates to:
  /// **'You cannot pass'**
  String get msgYouCannotPass;

  /// No description provided for @msgYourOpponentDisagreesWithCountingResult.
  ///
  /// In en, this message translates to:
  /// **'Your opponent disagrees with the counting result'**
  String get msgYourOpponentDisagreesWithCountingResult;

  /// No description provided for @msgYourOpponentRefusesToCount.
  ///
  /// In en, this message translates to:
  /// **'Your opponent refuses to count'**
  String get msgYourOpponentRefusesToCount;

  /// No description provided for @msgYourOpponentRequestsAutomaticCounting.
  ///
  /// In en, this message translates to:
  /// **'Your opponent requests automatic counting. Do you agree?'**
  String get msgYourOpponentRequestsAutomaticCounting;

  /// No description provided for @myGames.
  ///
  /// In en, this message translates to:
  /// **'My games'**
  String get myGames;

  /// No description provided for @myMistakes.
  ///
  /// In en, this message translates to:
  /// **'My mistakes'**
  String get myMistakes;

  /// No description provided for @nTasks.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No tasks} =1{1 task} other{{count} tasks}}'**
  String nTasks(int count);

  /// No description provided for @nTasksAvailable.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No tasks available} =1{1 task available} other{{count} tasks available}}'**
  String nTasksAvailable(int count);

  /// No description provided for @newBestResult.
  ///
  /// In en, this message translates to:
  /// **'New best!'**
  String get newBestResult;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

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

  /// No description provided for @nxnBoardSize.
  ///
  /// In en, this message translates to:
  /// **'{n}×{n}'**
  String nxnBoardSize(int n);

  /// No description provided for @ogsDesc.
  ///
  /// In en, this message translates to:
  /// **'The premier online Go platform with tournaments, AI analysis, and a vibrant community.'**
  String get ogsDesc;

  /// No description provided for @ogsName.
  ///
  /// In en, this message translates to:
  /// **'Online Go Server'**
  String get ogsName;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @pass.
  ///
  /// In en, this message translates to:
  /// **'Pass'**
  String get pass;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @play.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get play;

  /// No description provided for @promotionRequirements.
  ///
  /// In en, this message translates to:
  /// **'Promotion requirements'**
  String get promotionRequirements;

  /// No description provided for @pxsByoyomi.
  ///
  /// In en, this message translates to:
  /// **'{p}×{s}s'**
  String pxsByoyomi(int p, int s);

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

  /// No description provided for @recentRecord.
  ///
  /// In en, this message translates to:
  /// **'Recent record'**
  String get recentRecord;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @resign.
  ///
  /// In en, this message translates to:
  /// **'Resign'**
  String get resign;

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

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @saveSGF.
  ///
  /// In en, this message translates to:
  /// **'Save SGF'**
  String get saveSGF;

  /// No description provided for @seconds.
  ///
  /// In en, this message translates to:
  /// **'Seconds'**
  String get seconds;

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

  /// No description provided for @subtopic.
  ///
  /// In en, this message translates to:
  /// **'Subtopic'**
  String get subtopic;

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

  /// No description provided for @taskCorrect.
  ///
  /// In en, this message translates to:
  /// **'Correct'**
  String get taskCorrect;

  /// No description provided for @taskNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get taskNext;

  /// No description provided for @taskNotFound.
  ///
  /// In en, this message translates to:
  /// **'Task not found'**
  String get taskNotFound;

  /// No description provided for @taskRedo.
  ///
  /// In en, this message translates to:
  /// **'Redo'**
  String get taskRedo;

  /// No description provided for @taskSource.
  ///
  /// In en, this message translates to:
  /// **'Task source'**
  String get taskSource;

  /// No description provided for @taskSourceFromMyMistakes.
  ///
  /// In en, this message translates to:
  /// **'From my mistakes'**
  String get taskSourceFromMyMistakes;

  /// No description provided for @taskSourceFromTaskTopic.
  ///
  /// In en, this message translates to:
  /// **'From task topic'**
  String get taskSourceFromTaskTopic;

  /// No description provided for @taskSourceFromTaskTypes.
  ///
  /// In en, this message translates to:
  /// **'From task types'**
  String get taskSourceFromTaskTypes;

  /// No description provided for @taskTag_afterJoseki.
  ///
  /// In en, this message translates to:
  /// **'After joseki'**
  String get taskTag_afterJoseki;

  /// No description provided for @taskTag_aiOpening.
  ///
  /// In en, this message translates to:
  /// **'AI opening'**
  String get taskTag_aiOpening;

  /// No description provided for @taskTag_aiVariations.
  ///
  /// In en, this message translates to:
  /// **'AI variations'**
  String get taskTag_aiVariations;

  /// No description provided for @taskTag_attack.
  ///
  /// In en, this message translates to:
  /// **'Attack'**
  String get taskTag_attack;

  /// No description provided for @taskTag_attackAndDefenseInKo.
  ///
  /// In en, this message translates to:
  /// **'Attack and defense in a ko'**
  String get taskTag_attackAndDefenseInKo;

  /// No description provided for @taskTag_attackAndDefenseOfCuts.
  ///
  /// In en, this message translates to:
  /// **'Attack and defense of cuts'**
  String get taskTag_attackAndDefenseOfCuts;

  /// No description provided for @taskTag_attackAndDefenseOfInvadingStones.
  ///
  /// In en, this message translates to:
  /// **'Attack and defense of invading stones'**
  String get taskTag_attackAndDefenseOfInvadingStones;

  /// No description provided for @taskTag_avoidKo.
  ///
  /// In en, this message translates to:
  /// **'Avoid ko'**
  String get taskTag_avoidKo;

  /// No description provided for @taskTag_avoidMakingDeadShape.
  ///
  /// In en, this message translates to:
  /// **'Avoid making dead shape'**
  String get taskTag_avoidMakingDeadShape;

  /// No description provided for @taskTag_avoidTrap.
  ///
  /// In en, this message translates to:
  /// **'Avoid trap'**
  String get taskTag_avoidTrap;

  /// No description provided for @taskTag_basicEndgame.
  ///
  /// In en, this message translates to:
  /// **'Endgame: basic'**
  String get taskTag_basicEndgame;

  /// No description provided for @taskTag_basicLifeAndDeath.
  ///
  /// In en, this message translates to:
  /// **'Life & death: basic'**
  String get taskTag_basicLifeAndDeath;

  /// No description provided for @taskTag_basicMoves.
  ///
  /// In en, this message translates to:
  /// **'Basic moves'**
  String get taskTag_basicMoves;

  /// No description provided for @taskTag_basicTesuji.
  ///
  /// In en, this message translates to:
  /// **'Tesuji'**
  String get taskTag_basicTesuji;

  /// No description provided for @taskTag_beginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get taskTag_beginner;

  /// No description provided for @taskTag_bend.
  ///
  /// In en, this message translates to:
  /// **'Bend'**
  String get taskTag_bend;

  /// No description provided for @taskTag_bentFour.
  ///
  /// In en, this message translates to:
  /// **'Bent four'**
  String get taskTag_bentFour;

  /// No description provided for @taskTag_bentFourInTheCorner.
  ///
  /// In en, this message translates to:
  /// **'Bent four in the corner'**
  String get taskTag_bentFourInTheCorner;

  /// No description provided for @taskTag_bentThree.
  ///
  /// In en, this message translates to:
  /// **'Bent three'**
  String get taskTag_bentThree;

  /// No description provided for @taskTag_bigEyeLiberties.
  ///
  /// In en, this message translates to:
  /// **'Big eye\'s liberties'**
  String get taskTag_bigEyeLiberties;

  /// No description provided for @taskTag_bigEyeVsSmallEye.
  ///
  /// In en, this message translates to:
  /// **'Big eye vs small eye'**
  String get taskTag_bigEyeVsSmallEye;

  /// No description provided for @taskTag_bigPoints.
  ///
  /// In en, this message translates to:
  /// **'Big points'**
  String get taskTag_bigPoints;

  /// No description provided for @taskTag_blindSpot.
  ///
  /// In en, this message translates to:
  /// **'Blind spot'**
  String get taskTag_blindSpot;

  /// No description provided for @taskTag_breakEye.
  ///
  /// In en, this message translates to:
  /// **'Break eye'**
  String get taskTag_breakEye;

  /// No description provided for @taskTag_breakEyeInOneStep.
  ///
  /// In en, this message translates to:
  /// **'Break eye in one step'**
  String get taskTag_breakEyeInOneStep;

  /// No description provided for @taskTag_breakEyeInSente.
  ///
  /// In en, this message translates to:
  /// **'Break eye in sente'**
  String get taskTag_breakEyeInSente;

  /// No description provided for @taskTag_breakOut.
  ///
  /// In en, this message translates to:
  /// **'Break out'**
  String get taskTag_breakOut;

  /// No description provided for @taskTag_breakPoints.
  ///
  /// In en, this message translates to:
  /// **'Break points'**
  String get taskTag_breakPoints;

  /// No description provided for @taskTag_breakShape.
  ///
  /// In en, this message translates to:
  /// **'Break shape'**
  String get taskTag_breakShape;

  /// No description provided for @taskTag_bridgeUnder.
  ///
  /// In en, this message translates to:
  /// **'Bridge under'**
  String get taskTag_bridgeUnder;

  /// No description provided for @taskTag_brilliantSequence.
  ///
  /// In en, this message translates to:
  /// **'Brilliant sequence'**
  String get taskTag_brilliantSequence;

  /// No description provided for @taskTag_bulkyFive.
  ///
  /// In en, this message translates to:
  /// **'Bulky five'**
  String get taskTag_bulkyFive;

  /// No description provided for @taskTag_bump.
  ///
  /// In en, this message translates to:
  /// **'Bump'**
  String get taskTag_bump;

  /// No description provided for @taskTag_captureBySnapback.
  ///
  /// In en, this message translates to:
  /// **'Capture by snapback'**
  String get taskTag_captureBySnapback;

  /// No description provided for @taskTag_captureInLadder.
  ///
  /// In en, this message translates to:
  /// **'Capture in ladder'**
  String get taskTag_captureInLadder;

  /// No description provided for @taskTag_captureInOneMove.
  ///
  /// In en, this message translates to:
  /// **'Capture in one move'**
  String get taskTag_captureInOneMove;

  /// No description provided for @taskTag_captureOnTheSide.
  ///
  /// In en, this message translates to:
  /// **'Capture on the side'**
  String get taskTag_captureOnTheSide;

  /// No description provided for @taskTag_captureToLive.
  ///
  /// In en, this message translates to:
  /// **'Capture to live'**
  String get taskTag_captureToLive;

  /// No description provided for @taskTag_captureTwoRecaptureOne.
  ///
  /// In en, this message translates to:
  /// **'Capture two, recapture one'**
  String get taskTag_captureTwoRecaptureOne;

  /// No description provided for @taskTag_capturingRace.
  ///
  /// In en, this message translates to:
  /// **'Capturing race'**
  String get taskTag_capturingRace;

  /// No description provided for @taskTag_capturingTechniques.
  ///
  /// In en, this message translates to:
  /// **'Capturing techniques'**
  String get taskTag_capturingTechniques;

  /// No description provided for @taskTag_carpentersSquareAndSimilar.
  ///
  /// In en, this message translates to:
  /// **'Carpenter\'s square and similar'**
  String get taskTag_carpentersSquareAndSimilar;

  /// No description provided for @taskTag_chooseTheFight.
  ///
  /// In en, this message translates to:
  /// **'Choose the fight'**
  String get taskTag_chooseTheFight;

  /// No description provided for @taskTag_clamp.
  ///
  /// In en, this message translates to:
  /// **'Clamp'**
  String get taskTag_clamp;

  /// No description provided for @taskTag_clampCapture.
  ///
  /// In en, this message translates to:
  /// **'Clamp capture'**
  String get taskTag_clampCapture;

  /// No description provided for @taskTag_closeInCapture.
  ///
  /// In en, this message translates to:
  /// **'Closing-in capture'**
  String get taskTag_closeInCapture;

  /// No description provided for @taskTag_combination.
  ///
  /// In en, this message translates to:
  /// **'Combination'**
  String get taskTag_combination;

  /// No description provided for @taskTag_commonLifeAndDeath.
  ///
  /// In en, this message translates to:
  /// **'Life & death: common shapes'**
  String get taskTag_commonLifeAndDeath;

  /// No description provided for @taskTag_compareSize.
  ///
  /// In en, this message translates to:
  /// **'Compare size'**
  String get taskTag_compareSize;

  /// No description provided for @taskTag_compareValue.
  ///
  /// In en, this message translates to:
  /// **'Compare value'**
  String get taskTag_compareValue;

  /// No description provided for @taskTag_completeKoToSecureEndgameAdvantage.
  ///
  /// In en, this message translates to:
  /// **'Complete ko to secure endgame advantage'**
  String get taskTag_completeKoToSecureEndgameAdvantage;

  /// No description provided for @taskTag_compositeProblems.
  ///
  /// In en, this message translates to:
  /// **'Composite tasks'**
  String get taskTag_compositeProblems;

  /// No description provided for @taskTag_comprehensiveTasks.
  ///
  /// In en, this message translates to:
  /// **'Comprehensive tasks'**
  String get taskTag_comprehensiveTasks;

  /// No description provided for @taskTag_connect.
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get taskTag_connect;

  /// No description provided for @taskTag_connectAndDie.
  ///
  /// In en, this message translates to:
  /// **'Connect and die'**
  String get taskTag_connectAndDie;

  /// No description provided for @taskTag_connectInOneMove.
  ///
  /// In en, this message translates to:
  /// **'Connect in one move'**
  String get taskTag_connectInOneMove;

  /// No description provided for @taskTag_contactFightTesuji.
  ///
  /// In en, this message translates to:
  /// **'Contact fight tesuji'**
  String get taskTag_contactFightTesuji;

  /// No description provided for @taskTag_contactPlay.
  ///
  /// In en, this message translates to:
  /// **'Contact play'**
  String get taskTag_contactPlay;

  /// No description provided for @taskTag_corner.
  ///
  /// In en, this message translates to:
  /// **'Corner'**
  String get taskTag_corner;

  /// No description provided for @taskTag_cornerIsGoldSideIsSilverCenterIsGrass.
  ///
  /// In en, this message translates to:
  /// **'Corner is gold, side is silver, center is grass'**
  String get taskTag_cornerIsGoldSideIsSilverCenterIsGrass;

  /// No description provided for @taskTag_counter.
  ///
  /// In en, this message translates to:
  /// **'Counter'**
  String get taskTag_counter;

  /// No description provided for @taskTag_counterAttack.
  ///
  /// In en, this message translates to:
  /// **'Counter-attack'**
  String get taskTag_counterAttack;

  /// No description provided for @taskTag_cranesNest.
  ///
  /// In en, this message translates to:
  /// **'Crane\'s nest'**
  String get taskTag_cranesNest;

  /// No description provided for @taskTag_crawl.
  ///
  /// In en, this message translates to:
  /// **'Crawl'**
  String get taskTag_crawl;

  /// No description provided for @taskTag_createShortageOfLiberties.
  ///
  /// In en, this message translates to:
  /// **'Create shortage of liberties'**
  String get taskTag_createShortageOfLiberties;

  /// No description provided for @taskTag_crossedFive.
  ///
  /// In en, this message translates to:
  /// **'Crossed five'**
  String get taskTag_crossedFive;

  /// No description provided for @taskTag_cut.
  ///
  /// In en, this message translates to:
  /// **'Cut'**
  String get taskTag_cut;

  /// No description provided for @taskTag_cut2.
  ///
  /// In en, this message translates to:
  /// **'Cut'**
  String get taskTag_cut2;

  /// No description provided for @taskTag_cutAcross.
  ///
  /// In en, this message translates to:
  /// **'Cut across'**
  String get taskTag_cutAcross;

  /// No description provided for @taskTag_defendFromInvasion.
  ///
  /// In en, this message translates to:
  /// **'Defend from invasion'**
  String get taskTag_defendFromInvasion;

  /// No description provided for @taskTag_defendPoints.
  ///
  /// In en, this message translates to:
  /// **'Defend points'**
  String get taskTag_defendPoints;

  /// No description provided for @taskTag_defendWeakPoint.
  ///
  /// In en, this message translates to:
  /// **'Defend weak point'**
  String get taskTag_defendWeakPoint;

  /// No description provided for @taskTag_descent.
  ///
  /// In en, this message translates to:
  /// **'Descent'**
  String get taskTag_descent;

  /// No description provided for @taskTag_diagonal.
  ///
  /// In en, this message translates to:
  /// **'Diagonal'**
  String get taskTag_diagonal;

  /// No description provided for @taskTag_directionOfCapture.
  ///
  /// In en, this message translates to:
  /// **'Direction of capture'**
  String get taskTag_directionOfCapture;

  /// No description provided for @taskTag_directionOfEscape.
  ///
  /// In en, this message translates to:
  /// **'Direction of escape'**
  String get taskTag_directionOfEscape;

  /// No description provided for @taskTag_directionOfPlay.
  ///
  /// In en, this message translates to:
  /// **'Direction of play'**
  String get taskTag_directionOfPlay;

  /// No description provided for @taskTag_doNotUnderestimateOpponent.
  ///
  /// In en, this message translates to:
  /// **'Do not underestimate opponent'**
  String get taskTag_doNotUnderestimateOpponent;

  /// No description provided for @taskTag_doubleAtari.
  ///
  /// In en, this message translates to:
  /// **'Double atari'**
  String get taskTag_doubleAtari;

  /// No description provided for @taskTag_doubleCapture.
  ///
  /// In en, this message translates to:
  /// **'Double capture'**
  String get taskTag_doubleCapture;

  /// No description provided for @taskTag_doubleKo.
  ///
  /// In en, this message translates to:
  /// **'Double ko'**
  String get taskTag_doubleKo;

  /// No description provided for @taskTag_doubleSenteEndgame.
  ///
  /// In en, this message translates to:
  /// **'Double sente endgame'**
  String get taskTag_doubleSenteEndgame;

  /// No description provided for @taskTag_doubleSnapback.
  ///
  /// In en, this message translates to:
  /// **'Double snapback'**
  String get taskTag_doubleSnapback;

  /// No description provided for @taskTag_endgame.
  ///
  /// In en, this message translates to:
  /// **'Endgame: general'**
  String get taskTag_endgame;

  /// No description provided for @taskTag_endgameFundamentals.
  ///
  /// In en, this message translates to:
  /// **'Endgame fundamentals'**
  String get taskTag_endgameFundamentals;

  /// No description provided for @taskTag_endgameIn5x5.
  ///
  /// In en, this message translates to:
  /// **'Endgame on 5x5'**
  String get taskTag_endgameIn5x5;

  /// No description provided for @taskTag_endgameOn4x4.
  ///
  /// In en, this message translates to:
  /// **'Endgame on 4x4'**
  String get taskTag_endgameOn4x4;

  /// No description provided for @taskTag_endgameTesuji.
  ///
  /// In en, this message translates to:
  /// **'Endgame tesuji'**
  String get taskTag_endgameTesuji;

  /// No description provided for @taskTag_engulfingAtari.
  ///
  /// In en, this message translates to:
  /// **'Engulfing atari'**
  String get taskTag_engulfingAtari;

  /// No description provided for @taskTag_escape.
  ///
  /// In en, this message translates to:
  /// **'Escape'**
  String get taskTag_escape;

  /// No description provided for @taskTag_escapeInOneMove.
  ///
  /// In en, this message translates to:
  /// **'Escape in one move'**
  String get taskTag_escapeInOneMove;

  /// No description provided for @taskTag_exploitShapeWeakness.
  ///
  /// In en, this message translates to:
  /// **'Exploit shape weakness'**
  String get taskTag_exploitShapeWeakness;

  /// No description provided for @taskTag_eyeVsNoEye.
  ///
  /// In en, this message translates to:
  /// **'Eye vs no-eye'**
  String get taskTag_eyeVsNoEye;

  /// No description provided for @taskTag_fillNeutralPoints.
  ///
  /// In en, this message translates to:
  /// **'Fill neutral points'**
  String get taskTag_fillNeutralPoints;

  /// No description provided for @taskTag_findTheRoot.
  ///
  /// In en, this message translates to:
  /// **'Find the root'**
  String get taskTag_findTheRoot;

  /// No description provided for @taskTag_firstLineBrilliantMove.
  ///
  /// In en, this message translates to:
  /// **'First line brilliant move'**
  String get taskTag_firstLineBrilliantMove;

  /// No description provided for @taskTag_flowerSix.
  ///
  /// In en, this message translates to:
  /// **'Flower six'**
  String get taskTag_flowerSix;

  /// No description provided for @taskTag_goldenChickenStandingOnOneLeg.
  ///
  /// In en, this message translates to:
  /// **'Golden rooster standing on one leg'**
  String get taskTag_goldenChickenStandingOnOneLeg;

  /// No description provided for @taskTag_groupLiberties.
  ///
  /// In en, this message translates to:
  /// **'Group liberties'**
  String get taskTag_groupLiberties;

  /// No description provided for @taskTag_groupsBase.
  ///
  /// In en, this message translates to:
  /// **'Group\'s base'**
  String get taskTag_groupsBase;

  /// No description provided for @taskTag_hane.
  ///
  /// In en, this message translates to:
  /// **'Hane'**
  String get taskTag_hane;

  /// No description provided for @taskTag_increaseEyeSpace.
  ///
  /// In en, this message translates to:
  /// **'Increase eye space'**
  String get taskTag_increaseEyeSpace;

  /// No description provided for @taskTag_increaseLiberties.
  ///
  /// In en, this message translates to:
  /// **'Increase liberties'**
  String get taskTag_increaseLiberties;

  /// No description provided for @taskTag_indirectAttack.
  ///
  /// In en, this message translates to:
  /// **'Indirect attack'**
  String get taskTag_indirectAttack;

  /// No description provided for @taskTag_influenceKeyPoints.
  ///
  /// In en, this message translates to:
  /// **'Influence key points'**
  String get taskTag_influenceKeyPoints;

  /// No description provided for @taskTag_insideKill.
  ///
  /// In en, this message translates to:
  /// **'Inside kill'**
  String get taskTag_insideKill;

  /// No description provided for @taskTag_insideMoves.
  ///
  /// In en, this message translates to:
  /// **'Inside moves'**
  String get taskTag_insideMoves;

  /// No description provided for @taskTag_interestingTasks.
  ///
  /// In en, this message translates to:
  /// **'Interesting tasks'**
  String get taskTag_interestingTasks;

  /// No description provided for @taskTag_internalLibertyShortage.
  ///
  /// In en, this message translates to:
  /// **'Internal liberty shortage'**
  String get taskTag_internalLibertyShortage;

  /// No description provided for @taskTag_invadingTechnique.
  ///
  /// In en, this message translates to:
  /// **'Invading technique'**
  String get taskTag_invadingTechnique;

  /// No description provided for @taskTag_invasion.
  ///
  /// In en, this message translates to:
  /// **'Invasion'**
  String get taskTag_invasion;

  /// No description provided for @taskTag_jGroupAndSimilar.
  ///
  /// In en, this message translates to:
  /// **'J-group and similar'**
  String get taskTag_jGroupAndSimilar;

  /// No description provided for @taskTag_josekiFundamentals.
  ///
  /// In en, this message translates to:
  /// **'Joseki fundamentals'**
  String get taskTag_josekiFundamentals;

  /// No description provided for @taskTag_jump.
  ///
  /// In en, this message translates to:
  /// **'Jump'**
  String get taskTag_jump;

  /// No description provided for @taskTag_keepSente.
  ///
  /// In en, this message translates to:
  /// **'Keep sente'**
  String get taskTag_keepSente;

  /// No description provided for @taskTag_killAfterCapture.
  ///
  /// In en, this message translates to:
  /// **'Kill after capture'**
  String get taskTag_killAfterCapture;

  /// No description provided for @taskTag_killByEyePointPlacement.
  ///
  /// In en, this message translates to:
  /// **'Kill by eye point placement'**
  String get taskTag_killByEyePointPlacement;

  /// No description provided for @taskTag_knightsMove.
  ///
  /// In en, this message translates to:
  /// **'Knight\'s move'**
  String get taskTag_knightsMove;

  /// No description provided for @taskTag_ko.
  ///
  /// In en, this message translates to:
  /// **'Ko'**
  String get taskTag_ko;

  /// No description provided for @taskTag_kosumiWedge.
  ///
  /// In en, this message translates to:
  /// **'Kosumi wedge'**
  String get taskTag_kosumiWedge;

  /// No description provided for @taskTag_largeKnightsMove.
  ///
  /// In en, this message translates to:
  /// **'Large knight move'**
  String get taskTag_largeKnightsMove;

  /// No description provided for @taskTag_largeMoyoFight.
  ///
  /// In en, this message translates to:
  /// **'Large moyo fight'**
  String get taskTag_largeMoyoFight;

  /// No description provided for @taskTag_lifeAndDeath.
  ///
  /// In en, this message translates to:
  /// **'Life & death: general'**
  String get taskTag_lifeAndDeath;

  /// No description provided for @taskTag_lifeAndDeathOn4x4.
  ///
  /// In en, this message translates to:
  /// **'Life and death on 4x4'**
  String get taskTag_lifeAndDeathOn4x4;

  /// No description provided for @taskTag_lookForLeverage.
  ///
  /// In en, this message translates to:
  /// **'Look for leverage'**
  String get taskTag_lookForLeverage;

  /// No description provided for @taskTag_looseLadder.
  ///
  /// In en, this message translates to:
  /// **'Loose ladder'**
  String get taskTag_looseLadder;

  /// No description provided for @taskTag_lovesickCut.
  ///
  /// In en, this message translates to:
  /// **'Lovesick cut'**
  String get taskTag_lovesickCut;

  /// No description provided for @taskTag_makeEye.
  ///
  /// In en, this message translates to:
  /// **'Make eye'**
  String get taskTag_makeEye;

  /// No description provided for @taskTag_makeEyeInOneStep.
  ///
  /// In en, this message translates to:
  /// **'Make eye in one step'**
  String get taskTag_makeEyeInOneStep;

  /// No description provided for @taskTag_makeEyeInSente.
  ///
  /// In en, this message translates to:
  /// **'Make eye in sente'**
  String get taskTag_makeEyeInSente;

  /// No description provided for @taskTag_makeKo.
  ///
  /// In en, this message translates to:
  /// **'Make ko'**
  String get taskTag_makeKo;

  /// No description provided for @taskTag_makeShape.
  ///
  /// In en, this message translates to:
  /// **'Make shape'**
  String get taskTag_makeShape;

  /// No description provided for @taskTag_middlegame.
  ///
  /// In en, this message translates to:
  /// **'Middlegame'**
  String get taskTag_middlegame;

  /// No description provided for @taskTag_monkeyClimbingMountain.
  ///
  /// In en, this message translates to:
  /// **'Monkey climbing the mountain'**
  String get taskTag_monkeyClimbingMountain;

  /// No description provided for @taskTag_mouseStealingOil.
  ///
  /// In en, this message translates to:
  /// **'Mouse stealing oil'**
  String get taskTag_mouseStealingOil;

  /// No description provided for @taskTag_moveOut.
  ///
  /// In en, this message translates to:
  /// **'Move out'**
  String get taskTag_moveOut;

  /// No description provided for @taskTag_moveTowardsEmptySpace.
  ///
  /// In en, this message translates to:
  /// **'Move towards empty space'**
  String get taskTag_moveTowardsEmptySpace;

  /// No description provided for @taskTag_multipleBrilliantMoves.
  ///
  /// In en, this message translates to:
  /// **'Multiple brilliant moves'**
  String get taskTag_multipleBrilliantMoves;

  /// No description provided for @taskTag_net.
  ///
  /// In en, this message translates to:
  /// **'Net'**
  String get taskTag_net;

  /// No description provided for @taskTag_netCapture.
  ///
  /// In en, this message translates to:
  /// **'Net capture'**
  String get taskTag_netCapture;

  /// No description provided for @taskTag_observeSubtleDifference.
  ///
  /// In en, this message translates to:
  /// **'Observe subtle difference'**
  String get taskTag_observeSubtleDifference;

  /// No description provided for @taskTag_occupyEncloseAndApproachCorner.
  ///
  /// In en, this message translates to:
  /// **'Occupy, enclose and approach corners'**
  String get taskTag_occupyEncloseAndApproachCorner;

  /// No description provided for @taskTag_oneStoneTwoPurposes.
  ///
  /// In en, this message translates to:
  /// **'One stone, two purposes'**
  String get taskTag_oneStoneTwoPurposes;

  /// No description provided for @taskTag_opening.
  ///
  /// In en, this message translates to:
  /// **'Opening'**
  String get taskTag_opening;

  /// No description provided for @taskTag_openingChoice.
  ///
  /// In en, this message translates to:
  /// **'Opening choice'**
  String get taskTag_openingChoice;

  /// No description provided for @taskTag_openingFundamentals.
  ///
  /// In en, this message translates to:
  /// **'Opening fundamentals'**
  String get taskTag_openingFundamentals;

  /// No description provided for @taskTag_orderOfEndgameMoves.
  ///
  /// In en, this message translates to:
  /// **'Order of endgame moves'**
  String get taskTag_orderOfEndgameMoves;

  /// No description provided for @taskTag_orderOfMoves.
  ///
  /// In en, this message translates to:
  /// **'Order of moves'**
  String get taskTag_orderOfMoves;

  /// No description provided for @taskTag_orderOfMovesInKo.
  ///
  /// In en, this message translates to:
  /// **'Order of moves in a ko'**
  String get taskTag_orderOfMovesInKo;

  /// No description provided for @taskTag_orioleCapturesButterfly.
  ///
  /// In en, this message translates to:
  /// **'Oriole captures the butterfly'**
  String get taskTag_orioleCapturesButterfly;

  /// No description provided for @taskTag_pincer.
  ///
  /// In en, this message translates to:
  /// **'Pincer'**
  String get taskTag_pincer;

  /// No description provided for @taskTag_placement.
  ///
  /// In en, this message translates to:
  /// **'Placement'**
  String get taskTag_placement;

  /// No description provided for @taskTag_plunderingTechnique.
  ///
  /// In en, this message translates to:
  /// **'Plundering technique'**
  String get taskTag_plunderingTechnique;

  /// No description provided for @taskTag_preventBambooJoint.
  ///
  /// In en, this message translates to:
  /// **'Prevent the bamboo joint'**
  String get taskTag_preventBambooJoint;

  /// No description provided for @taskTag_preventBridgingUnder.
  ///
  /// In en, this message translates to:
  /// **'Prevent bridging under'**
  String get taskTag_preventBridgingUnder;

  /// No description provided for @taskTag_preventOpponentFromApproaching.
  ///
  /// In en, this message translates to:
  /// **'Prevent opponent from approaching'**
  String get taskTag_preventOpponentFromApproaching;

  /// No description provided for @taskTag_probe.
  ///
  /// In en, this message translates to:
  /// **'Probe'**
  String get taskTag_probe;

  /// No description provided for @taskTag_profitInSente.
  ///
  /// In en, this message translates to:
  /// **'Profit in sente'**
  String get taskTag_profitInSente;

  /// No description provided for @taskTag_profitUsingLifeAndDeath.
  ///
  /// In en, this message translates to:
  /// **'Profit using life and death'**
  String get taskTag_profitUsingLifeAndDeath;

  /// No description provided for @taskTag_push.
  ///
  /// In en, this message translates to:
  /// **'Push'**
  String get taskTag_push;

  /// No description provided for @taskTag_pyramidFour.
  ///
  /// In en, this message translates to:
  /// **'Pyramid four'**
  String get taskTag_pyramidFour;

  /// No description provided for @taskTag_realEyeAndFalseEye.
  ///
  /// In en, this message translates to:
  /// **'Real eye vs false eye'**
  String get taskTag_realEyeAndFalseEye;

  /// No description provided for @taskTag_rectangularSix.
  ///
  /// In en, this message translates to:
  /// **'Rectangular six'**
  String get taskTag_rectangularSix;

  /// No description provided for @taskTag_reduceEyeSpace.
  ///
  /// In en, this message translates to:
  /// **'Reduce eye space'**
  String get taskTag_reduceEyeSpace;

  /// No description provided for @taskTag_reduceLiberties.
  ///
  /// In en, this message translates to:
  /// **'Reduce liberties'**
  String get taskTag_reduceLiberties;

  /// No description provided for @taskTag_reduction.
  ///
  /// In en, this message translates to:
  /// **'Reduction'**
  String get taskTag_reduction;

  /// No description provided for @taskTag_runWeakGroup.
  ///
  /// In en, this message translates to:
  /// **'Run weak group'**
  String get taskTag_runWeakGroup;

  /// No description provided for @taskTag_sabakiAndUtilizingInfluence.
  ///
  /// In en, this message translates to:
  /// **'Sabaki and utilizing influence'**
  String get taskTag_sabakiAndUtilizingInfluence;

  /// No description provided for @taskTag_sacrifice.
  ///
  /// In en, this message translates to:
  /// **'Sacrifice'**
  String get taskTag_sacrifice;

  /// No description provided for @taskTag_sacrificeAndSqueeze.
  ///
  /// In en, this message translates to:
  /// **'Sacrifice and squeeze'**
  String get taskTag_sacrificeAndSqueeze;

  /// No description provided for @taskTag_sealIn.
  ///
  /// In en, this message translates to:
  /// **'Seal in'**
  String get taskTag_sealIn;

  /// No description provided for @taskTag_secondLine.
  ///
  /// In en, this message translates to:
  /// **'Second line'**
  String get taskTag_secondLine;

  /// No description provided for @taskTag_seizeTheOpportunity.
  ///
  /// In en, this message translates to:
  /// **'Seize the opportunity'**
  String get taskTag_seizeTheOpportunity;

  /// No description provided for @taskTag_seki.
  ///
  /// In en, this message translates to:
  /// **'Seki'**
  String get taskTag_seki;

  /// No description provided for @taskTag_senteAndGote.
  ///
  /// In en, this message translates to:
  /// **'Sente and gote'**
  String get taskTag_senteAndGote;

  /// No description provided for @taskTag_settleShape.
  ///
  /// In en, this message translates to:
  /// **'Settle shape'**
  String get taskTag_settleShape;

  /// No description provided for @taskTag_settleShapeInSente.
  ///
  /// In en, this message translates to:
  /// **'Settle shape in sente'**
  String get taskTag_settleShapeInSente;

  /// No description provided for @taskTag_shape.
  ///
  /// In en, this message translates to:
  /// **'Shape'**
  String get taskTag_shape;

  /// No description provided for @taskTag_shapesVitalPoint.
  ///
  /// In en, this message translates to:
  /// **'Shape\'s vital point'**
  String get taskTag_shapesVitalPoint;

  /// No description provided for @taskTag_side.
  ///
  /// In en, this message translates to:
  /// **'Side'**
  String get taskTag_side;

  /// No description provided for @taskTag_smallBoardEndgame.
  ///
  /// In en, this message translates to:
  /// **'Small board endgame'**
  String get taskTag_smallBoardEndgame;

  /// No description provided for @taskTag_snapback.
  ///
  /// In en, this message translates to:
  /// **'Snapback'**
  String get taskTag_snapback;

  /// No description provided for @taskTag_solidConnection.
  ///
  /// In en, this message translates to:
  /// **'Solid connection'**
  String get taskTag_solidConnection;

  /// No description provided for @taskTag_solidExtension.
  ///
  /// In en, this message translates to:
  /// **'Solid extension'**
  String get taskTag_solidExtension;

  /// No description provided for @taskTag_splitInOneMove.
  ///
  /// In en, this message translates to:
  /// **'Split in one move'**
  String get taskTag_splitInOneMove;

  /// No description provided for @taskTag_splittingMove.
  ///
  /// In en, this message translates to:
  /// **'Splitting move'**
  String get taskTag_splittingMove;

  /// No description provided for @taskTag_squareFour.
  ///
  /// In en, this message translates to:
  /// **'Square four'**
  String get taskTag_squareFour;

  /// No description provided for @taskTag_squeeze.
  ///
  /// In en, this message translates to:
  /// **'Squeeze'**
  String get taskTag_squeeze;

  /// No description provided for @taskTag_standardCapturingRaces.
  ///
  /// In en, this message translates to:
  /// **'Standard capturing races'**
  String get taskTag_standardCapturingRaces;

  /// No description provided for @taskTag_standardCornerAndSideEndgame.
  ///
  /// In en, this message translates to:
  /// **'Standard corner and side endgame'**
  String get taskTag_standardCornerAndSideEndgame;

  /// No description provided for @taskTag_straightFour.
  ///
  /// In en, this message translates to:
  /// **'Straight four'**
  String get taskTag_straightFour;

  /// No description provided for @taskTag_straightThree.
  ///
  /// In en, this message translates to:
  /// **'Straight three'**
  String get taskTag_straightThree;

  /// No description provided for @taskTag_surroundTerritory.
  ///
  /// In en, this message translates to:
  /// **'Surround territory'**
  String get taskTag_surroundTerritory;

  /// No description provided for @taskTag_symmetricShape.
  ///
  /// In en, this message translates to:
  /// **'Symmetric shape'**
  String get taskTag_symmetricShape;

  /// No description provided for @taskTag_techniqueForReinforcingGroups.
  ///
  /// In en, this message translates to:
  /// **'Technique for reinforcing groups'**
  String get taskTag_techniqueForReinforcingGroups;

  /// No description provided for @taskTag_techniqueForSecuringTerritory.
  ///
  /// In en, this message translates to:
  /// **'Technique for securing territory'**
  String get taskTag_techniqueForSecuringTerritory;

  /// No description provided for @taskTag_textbookTasks.
  ///
  /// In en, this message translates to:
  /// **'Textbook tasks'**
  String get taskTag_textbookTasks;

  /// No description provided for @taskTag_thirdAndFourthLine.
  ///
  /// In en, this message translates to:
  /// **'Third and fourth line'**
  String get taskTag_thirdAndFourthLine;

  /// No description provided for @taskTag_threeEyesTwoActions.
  ///
  /// In en, this message translates to:
  /// **'Three eyes, two actions'**
  String get taskTag_threeEyesTwoActions;

  /// No description provided for @taskTag_threeSpaceExtensionFromTwoStones.
  ///
  /// In en, this message translates to:
  /// **'Three-space extension from two stones'**
  String get taskTag_threeSpaceExtensionFromTwoStones;

  /// No description provided for @taskTag_throwIn.
  ///
  /// In en, this message translates to:
  /// **'Throw-in'**
  String get taskTag_throwIn;

  /// No description provided for @taskTag_tigersMouth.
  ///
  /// In en, this message translates to:
  /// **'Tiger\'s mouth'**
  String get taskTag_tigersMouth;

  /// No description provided for @taskTag_tombstoneSqueeze.
  ///
  /// In en, this message translates to:
  /// **'Tombstone squeeze'**
  String get taskTag_tombstoneSqueeze;

  /// No description provided for @taskTag_tripodGroupWithExtraLegAndSimilar.
  ///
  /// In en, this message translates to:
  /// **'Tripod group with extra leg and similar'**
  String get taskTag_tripodGroupWithExtraLegAndSimilar;

  /// No description provided for @taskTag_twoHaneGainOneLiberty.
  ///
  /// In en, this message translates to:
  /// **'Double hane grows one liberty'**
  String get taskTag_twoHaneGainOneLiberty;

  /// No description provided for @taskTag_twoHeadedDragon.
  ///
  /// In en, this message translates to:
  /// **'Two-headed dragon'**
  String get taskTag_twoHeadedDragon;

  /// No description provided for @taskTag_twoSpaceExtension.
  ///
  /// In en, this message translates to:
  /// **'Two-space extension'**
  String get taskTag_twoSpaceExtension;

  /// No description provided for @taskTag_typesOfKo.
  ///
  /// In en, this message translates to:
  /// **'Types of ko'**
  String get taskTag_typesOfKo;

  /// No description provided for @taskTag_underTheStones.
  ///
  /// In en, this message translates to:
  /// **'Under the stones'**
  String get taskTag_underTheStones;

  /// No description provided for @taskTag_underneathAttachment.
  ///
  /// In en, this message translates to:
  /// **'Underneath attachment'**
  String get taskTag_underneathAttachment;

  /// No description provided for @taskTag_urgentPointOfAFight.
  ///
  /// In en, this message translates to:
  /// **'Urgent point of a fight'**
  String get taskTag_urgentPointOfAFight;

  /// No description provided for @taskTag_urgentPoints.
  ///
  /// In en, this message translates to:
  /// **'Urgent points'**
  String get taskTag_urgentPoints;

  /// No description provided for @taskTag_useConnectAndDie.
  ///
  /// In en, this message translates to:
  /// **'Use connect and die'**
  String get taskTag_useConnectAndDie;

  /// No description provided for @taskTag_useCornerSpecialProperties.
  ///
  /// In en, this message translates to:
  /// **'Use corner special properties'**
  String get taskTag_useCornerSpecialProperties;

  /// No description provided for @taskTag_useDescentToFirstLine.
  ///
  /// In en, this message translates to:
  /// **'Use descent to first line'**
  String get taskTag_useDescentToFirstLine;

  /// No description provided for @taskTag_useInfluence.
  ///
  /// In en, this message translates to:
  /// **'Use influence'**
  String get taskTag_useInfluence;

  /// No description provided for @taskTag_useOpponentsLifeAndDeath.
  ///
  /// In en, this message translates to:
  /// **'Use opponent\'s life and death'**
  String get taskTag_useOpponentsLifeAndDeath;

  /// No description provided for @taskTag_useShortageOfLiberties.
  ///
  /// In en, this message translates to:
  /// **'Use shortage of liberties'**
  String get taskTag_useShortageOfLiberties;

  /// No description provided for @taskTag_useSnapback.
  ///
  /// In en, this message translates to:
  /// **'Use snapback'**
  String get taskTag_useSnapback;

  /// No description provided for @taskTag_useSurroundingStones.
  ///
  /// In en, this message translates to:
  /// **'Use surrounding stones'**
  String get taskTag_useSurroundingStones;

  /// No description provided for @taskTag_vitalAndUselessStones.
  ///
  /// In en, this message translates to:
  /// **'Vital and useless stones'**
  String get taskTag_vitalAndUselessStones;

  /// No description provided for @taskTag_vitalPointForBothSides.
  ///
  /// In en, this message translates to:
  /// **'Vital point for both sides'**
  String get taskTag_vitalPointForBothSides;

  /// No description provided for @taskTag_vitalPointForCapturingRace.
  ///
  /// In en, this message translates to:
  /// **'Vital point for capturing race'**
  String get taskTag_vitalPointForCapturingRace;

  /// No description provided for @taskTag_vitalPointForIncreasingLiberties.
  ///
  /// In en, this message translates to:
  /// **'Vital point for increasing liberties'**
  String get taskTag_vitalPointForIncreasingLiberties;

  /// No description provided for @taskTag_vitalPointForKill.
  ///
  /// In en, this message translates to:
  /// **'Vital point for kill'**
  String get taskTag_vitalPointForKill;

  /// No description provided for @taskTag_vitalPointForLife.
  ///
  /// In en, this message translates to:
  /// **'Vital point for life'**
  String get taskTag_vitalPointForLife;

  /// No description provided for @taskTag_vitalPointForReducingLiberties.
  ///
  /// In en, this message translates to:
  /// **'Vital point for reducing liberties'**
  String get taskTag_vitalPointForReducingLiberties;

  /// No description provided for @taskTag_wedge.
  ///
  /// In en, this message translates to:
  /// **'Wedge'**
  String get taskTag_wedge;

  /// No description provided for @taskTag_wedgingCapture.
  ///
  /// In en, this message translates to:
  /// **'Wedging capture'**
  String get taskTag_wedgingCapture;

  /// No description provided for @taskTimeout.
  ///
  /// In en, this message translates to:
  /// **'Timeout'**
  String get taskTimeout;

  /// No description provided for @taskTypeAppreciation.
  ///
  /// In en, this message translates to:
  /// **'Appreciation'**
  String get taskTypeAppreciation;

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

  /// No description provided for @taskTypeEndgame.
  ///
  /// In en, this message translates to:
  /// **'Endgame'**
  String get taskTypeEndgame;

  /// No description provided for @taskTypeJoseki.
  ///
  /// In en, this message translates to:
  /// **'Joseki'**
  String get taskTypeJoseki;

  /// No description provided for @taskTypeLifeAndDeath.
  ///
  /// In en, this message translates to:
  /// **'Life & death'**
  String get taskTypeLifeAndDeath;

  /// No description provided for @taskTypeMiddlegame.
  ///
  /// In en, this message translates to:
  /// **'Middlegame'**
  String get taskTypeMiddlegame;

  /// No description provided for @taskTypeOpening.
  ///
  /// In en, this message translates to:
  /// **'Opening'**
  String get taskTypeOpening;

  /// No description provided for @taskTypeTesuji.
  ///
  /// In en, this message translates to:
  /// **'Tesuji'**
  String get taskTypeTesuji;

  /// No description provided for @taskTypeTheory.
  ///
  /// In en, this message translates to:
  /// **'Theory'**
  String get taskTypeTheory;

  /// No description provided for @taskWrong.
  ///
  /// In en, this message translates to:
  /// **'Wrong'**
  String get taskWrong;

  /// No description provided for @tasksSolved.
  ///
  /// In en, this message translates to:
  /// **'Tasks solved'**
  String get tasksSolved;

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

  /// No description provided for @timePerTask.
  ///
  /// In en, this message translates to:
  /// **'Time per task'**
  String get timePerTask;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @tooltipAnalyzeWithAISensei.
  ///
  /// In en, this message translates to:
  /// **'Analyze with AI Sensei'**
  String get tooltipAnalyzeWithAISensei;

  /// No description provided for @tooltipDownloadGame.
  ///
  /// In en, this message translates to:
  /// **'Download game'**
  String get tooltipDownloadGame;

  /// No description provided for @topic.
  ///
  /// In en, this message translates to:
  /// **'Topic'**
  String get topic;

  /// No description provided for @topicExam.
  ///
  /// In en, this message translates to:
  /// **'Topic exam'**
  String get topicExam;

  /// No description provided for @topics.
  ///
  /// In en, this message translates to:
  /// **'Topics'**
  String get topics;

  /// No description provided for @train.
  ///
  /// In en, this message translates to:
  /// **'Train'**
  String get train;

  /// No description provided for @trainingAvgTimePerTask.
  ///
  /// In en, this message translates to:
  /// **'Avg time per task'**
  String get trainingAvgTimePerTask;

  /// No description provided for @trainingFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get trainingFailed;

  /// No description provided for @trainingMistakes.
  ///
  /// In en, this message translates to:
  /// **'Mistakes'**
  String get trainingMistakes;

  /// No description provided for @trainingPassed.
  ///
  /// In en, this message translates to:
  /// **'Passed'**
  String get trainingPassed;

  /// No description provided for @trainingTotalTime.
  ///
  /// In en, this message translates to:
  /// **'Total time'**
  String get trainingTotalTime;

  /// No description provided for @tryCustomMoves.
  ///
  /// In en, this message translates to:
  /// **'Try custom moves'**
  String get tryCustomMoves;

  /// No description provided for @tygemDesc.
  ///
  /// In en, this message translates to:
  /// **'The most popular server in Korea and one of the most popular in the world.'**
  String get tygemDesc;

  /// No description provided for @tygemName.
  ///
  /// In en, this message translates to:
  /// **'Tygem Baduk'**
  String get tygemName;

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

  /// No description provided for @userInfo.
  ///
  /// In en, this message translates to:
  /// **'User info'**
  String get userInfo;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

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

  /// No description provided for @white.
  ///
  /// In en, this message translates to:
  /// **'White'**
  String get white;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;
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
      <String>['en', 'es', 'ru', 'zh'].contains(locale.languageCode);

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
    case 'ru':
      return AppLocalizationsRu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
