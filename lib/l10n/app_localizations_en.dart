// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get about => 'About';

  @override
  String get accuracy => 'Accuracy';

  @override
  String get aiReferee => 'AI referee';

  @override
  String get aiSensei => 'AI Sensei';

  @override
  String get alwaysBlackToPlay => 'Always black-to-play';

  @override
  String get alwaysBlackToPlayDesc =>
      'Set all tasks as black-to-play to avoid confusion';

  @override
  String get appearance => 'Appearance';

  @override
  String get autoCounting => 'Auto counting';

  @override
  String get autoMatch => 'Auto-Match';

  @override
  String get behaviour => 'Behaviour';

  @override
  String get bestResult => 'Best result';

  @override
  String get board => 'Board';

  @override
  String get boardSize => 'Board size';

  @override
  String get boardTheme => 'Board theme';

  @override
  String get byRank => 'By rank';

  @override
  String get cancel => 'Cancel';

  @override
  String get captures => 'Captures';

  @override
  String get collectStats => 'Collect statistics';

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
  String get continue_ => 'Continue';

  @override
  String get copyTaskLink => 'Copy task link';

  @override
  String get customExam => 'Custom exam';

  @override
  String get dark => 'Dark';

  @override
  String get download => 'Download';

  @override
  String get edgeLine => 'Edge line';

  @override
  String get endgameExam => 'Endgame exam';

  @override
  String get enterTaskLink => 'Enter the task link';

  @override
  String get errCannotBeEmpty => 'Cannot be empty';

  @override
  String get errFailedToDownloadGame => 'Failed to download game';

  @override
  String get errFailedToLoadGameList =>
      'Failed to load game list. Please try again.';

  @override
  String get errFailedToUploadGameToAISensei =>
      'Failed to upload game to AI Sensei';

  @override
  String get errIncorrectUsernameOrPassword => 'Incorrect username or password';

  @override
  String errMustBeAtLeast(num n) {
    return 'Must be at least $n';
  }

  @override
  String errMustBeAtMost(num n) {
    return 'Must be at most $n';
  }

  @override
  String get errMustBeInteger => 'Must be an integer';

  @override
  String get exit => 'Exit';

  @override
  String get exitTryMode => 'Exit try mode';

  @override
  String get find => 'Find';

  @override
  String get findTask => 'Find task';

  @override
  String get forceCounting => 'Force counting';

  @override
  String get foxwqDesc => 'The most popular server in China and the world.';

  @override
  String get foxwqName => 'Fox Weiqi';

  @override
  String get gameInfo => 'Game info';

  @override
  String get gameRecord => 'Game record';

  @override
  String get gradingExam => 'Grading exam';

  @override
  String get handicap => 'Handicap';

  @override
  String get home => 'Home';

  @override
  String get komi => 'Komi';

  @override
  String get language => 'Language';

  @override
  String get leave => 'Leave';

  @override
  String get light => 'Light';

  @override
  String get login => 'Login';

  @override
  String get logout => 'Logout';

  @override
  String get long => 'Long';

  @override
  String mMinutes(int m) {
    return '${m}min';
  }

  @override
  String get maxNumberOfMistakes => 'Maximum number of mistakes';

  @override
  String get maxRank => 'Max rank';

  @override
  String get medium => 'Medium';

  @override
  String get minRank => 'Min rank';

  @override
  String get minutes => 'Minutes';

  @override
  String get month => 'Month';

  @override
  String get msgCannotUseAIRefereeYet => 'AI referee cannot be used yet';

  @override
  String get msgCannotUseForcedCountingYet =>
      'Forced counting cannot be used yet';

  @override
  String get msgConfirmDeleteCollectionProgress =>
      'Are you sure that you want to delete the previous attempt?';

  @override
  String get msgConfirmResignation => 'Are you sure that you want to resign?';

  @override
  String msgConfirmStopEvent(String event) {
    return 'Are you sure that you want to stop the $event?';
  }

  @override
  String get msgDownloadingGame => 'Downloading game';

  @override
  String msgGameSavedTo(String path) {
    return 'Game saved to $path';
  }

  @override
  String get msgPleaseWaitForYourTurn => 'Please, wait for your turn';

  @override
  String get msgSearchingForGame => 'Searching for a game...';

  @override
  String get msgTaskLinkCopied => 'Task link copied.';

  @override
  String get msgWaitingForOpponentsDecision =>
      'Waiting for your opponent\'s decision...';

  @override
  String get msgYouCannotPass => 'You cannot pass';

  @override
  String get msgYourOpponentDisagreesWithCountingResult =>
      'Your opponent disagrees with the counting result';

  @override
  String get msgYourOpponentRefusesToCount => 'Your opponent refuses to count';

  @override
  String get msgYourOpponentRequestsAutomaticCounting =>
      'Your opponent requests automatic counting. Do you agree?';

  @override
  String get myGames => 'My games';

  @override
  String get myMistakes => 'My mistakes';

  @override
  String nTasks(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString tasks',
      one: '1 task',
      zero: 'No tasks',
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
      other: '$countString tasks available',
      one: '1 task available',
      zero: 'No tasks available',
    );
    return '$_temp0';
  }

  @override
  String get newBestResult => 'New best!';

  @override
  String get no => 'No';

  @override
  String get none => 'None';

  @override
  String get numberOfTasks => 'Number of tasks';

  @override
  String nxnBoardSize(int n) {
    return '$n×$n';
  }

  @override
  String get ogsDesc =>
      'The premier online Go platform with tournaments, AI analysis, and a vibrant community.';

  @override
  String get ogsName => 'Online Go Server';

  @override
  String get ok => 'OK';

  @override
  String get pass => 'Pass';

  @override
  String get password => 'Password';

  @override
  String get play => 'Play';

  @override
  String get promotionRequirements => 'Promotion requirements';

  @override
  String pxsByoyomi(int p, int s) {
    return '$p×${s}s';
  }

  @override
  String get rank => 'Rank';

  @override
  String get rankedMode => 'Ranked mode';

  @override
  String get recentRecord => 'Recent record';

  @override
  String get register => 'Register';

  @override
  String get resign => 'Resign';

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
  String get rules => 'Rules';

  @override
  String get rulesChinese => 'Chinese';

  @override
  String get rulesJapanese => 'Japanese';

  @override
  String get rulesKorean => 'Korean';

  @override
  String get saveSGF => 'Save SGF';

  @override
  String get seconds => 'Seconds';

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
  String get subtopic => 'Subtopic';

  @override
  String get system => 'System';

  @override
  String get task => 'Task';

  @override
  String get taskCorrect => 'Correct';

  @override
  String get taskNext => 'Next';

  @override
  String get taskRedo => 'Redo';

  @override
  String get taskSource => 'Task source';

  @override
  String get taskSourceFromMyMistakes => 'From my mistakes';

  @override
  String get taskSourceFromTaskTopic => 'From task topic';

  @override
  String get taskSourceFromTaskTypes => 'From task types';

  @override
  String get taskTag_afterJoseki => 'After joseki';

  @override
  String get taskTag_aiOpening => 'AI opening';

  @override
  String get taskTag_aiVariations => 'AI variations';

  @override
  String get taskTag_attack => 'Attack';

  @override
  String get taskTag_attackAndDefenseInKo => 'Attack and defense in a ko';

  @override
  String get taskTag_attackAndDefenseOfCuts => 'Attack and defense of cuts';

  @override
  String get taskTag_attackAndDefenseOfInvadingStones =>
      'Attack and defense of invading stones';

  @override
  String get taskTag_avoidKo => 'Avoid ko';

  @override
  String get taskTag_avoidMakingDeadShape => 'Avoid making dead shape';

  @override
  String get taskTag_avoidTrap => 'Avoid trap';

  @override
  String get taskTag_basicEndgame => 'Endgame: basic';

  @override
  String get taskTag_basicLifeAndDeath => 'Life & death: basic';

  @override
  String get taskTag_basicMoves => 'Basic moves';

  @override
  String get taskTag_basicTesuji => 'Tesuji';

  @override
  String get taskTag_beginner => 'Beginner';

  @override
  String get taskTag_bend => 'Bend';

  @override
  String get taskTag_bentFour => 'Bent four';

  @override
  String get taskTag_bentFourInTheCorner => 'Bent four in the corner';

  @override
  String get taskTag_bentThree => 'Bent three';

  @override
  String get taskTag_bigEyeLiberties => 'Big eye\'s liberties';

  @override
  String get taskTag_bigEyeVsSmallEye => 'Big eye vs small eye';

  @override
  String get taskTag_bigPoints => 'Big points';

  @override
  String get taskTag_blindSpot => 'Blind spot';

  @override
  String get taskTag_breakEye => 'Break eye';

  @override
  String get taskTag_breakEyeInOneStep => 'Break eye in one step';

  @override
  String get taskTag_breakEyeInSente => 'Break eye in sente';

  @override
  String get taskTag_breakOut => 'Break out';

  @override
  String get taskTag_breakPoints => 'Break points';

  @override
  String get taskTag_breakShape => 'Break shape';

  @override
  String get taskTag_bridgeUnder => 'Bridge under';

  @override
  String get taskTag_brilliantSequence => 'Brilliant sequence';

  @override
  String get taskTag_bulkyFive => 'Bulky five';

  @override
  String get taskTag_bump => 'Bump';

  @override
  String get taskTag_captureBySnapback => 'Capture by snapback';

  @override
  String get taskTag_captureInLadder => 'Capture in ladder';

  @override
  String get taskTag_captureInOneMove => 'Capture in one move';

  @override
  String get taskTag_captureOnTheSide => 'Capture on the side';

  @override
  String get taskTag_captureToLive => 'Capture to live';

  @override
  String get taskTag_captureTwoRecaptureOne => 'Capture two, recapture one';

  @override
  String get taskTag_capturingRace => 'Capturing race';

  @override
  String get taskTag_capturingTechniques => 'Capturing techniques';

  @override
  String get taskTag_carpentersSquareAndSimilar =>
      'Carpenter\'s square and similar';

  @override
  String get taskTag_chooseTheFight => 'Choose the fight';

  @override
  String get taskTag_clamp => 'Clamp';

  @override
  String get taskTag_clampCapture => 'Clamp capture';

  @override
  String get taskTag_closeInCapture => 'Closing-in capture';

  @override
  String get taskTag_combination => 'Combination';

  @override
  String get taskTag_commonLifeAndDeath => 'Life & death: common shapes';

  @override
  String get taskTag_compareSize => 'Compare size';

  @override
  String get taskTag_compareValue => 'Compare value';

  @override
  String get taskTag_completeKoToSecureEndgameAdvantage =>
      'Complete ko to secure endgame advantage';

  @override
  String get taskTag_compositeProblems => 'Composite tasks';

  @override
  String get taskTag_comprehensiveTasks => 'Comprehensive tasks';

  @override
  String get taskTag_connect => 'Connect';

  @override
  String get taskTag_connectAndDie => 'Connect and die';

  @override
  String get taskTag_connectInOneMove => 'Connect in one move';

  @override
  String get taskTag_contactFightTesuji => 'Contact fight tesuji';

  @override
  String get taskTag_contactPlay => 'Contact play';

  @override
  String get taskTag_corner => 'Corner';

  @override
  String get taskTag_cornerIsGoldSideIsSilverCenterIsGrass =>
      'Corner is gold, side is silver, center is grass';

  @override
  String get taskTag_counter => 'Counter';

  @override
  String get taskTag_counterAttack => 'Counter-attack';

  @override
  String get taskTag_cranesNest => 'Crane\'s nest';

  @override
  String get taskTag_crawl => 'Crawl';

  @override
  String get taskTag_createShortageOfLiberties =>
      'Create shortage of liberties';

  @override
  String get taskTag_crossedFive => 'Crossed five';

  @override
  String get taskTag_cut => 'Cut';

  @override
  String get taskTag_cut2 => 'Cut';

  @override
  String get taskTag_cutAcross => 'Cut across';

  @override
  String get taskTag_defendFromInvasion => 'Defend from invasion';

  @override
  String get taskTag_defendPoints => 'Defend points';

  @override
  String get taskTag_defendWeakPoint => 'Defend weak point';

  @override
  String get taskTag_descent => 'Descent';

  @override
  String get taskTag_diagonal => 'Diagonal';

  @override
  String get taskTag_directionOfCapture => 'Direction of capture';

  @override
  String get taskTag_directionOfEscape => 'Direction of escape';

  @override
  String get taskTag_directionOfPlay => 'Direction of play';

  @override
  String get taskTag_doNotUnderestimateOpponent =>
      'Do not underestimate opponent';

  @override
  String get taskTag_doubleAtari => 'Double atari';

  @override
  String get taskTag_doubleCapture => 'Double capture';

  @override
  String get taskTag_doubleKo => 'Double ko';

  @override
  String get taskTag_doubleSenteEndgame => 'Double sente endgame';

  @override
  String get taskTag_doubleSnapback => 'Double snapback';

  @override
  String get taskTag_endgame => 'Endgame: general';

  @override
  String get taskTag_endgameFundamentals => 'Endgame fundamentals';

  @override
  String get taskTag_endgameIn5x5 => 'Endgame on 5x5';

  @override
  String get taskTag_endgameOn4x4 => 'Endgame on 4x4';

  @override
  String get taskTag_endgameTesuji => 'Endgame tesuji';

  @override
  String get taskTag_engulfingAtari => 'Engulfing atari';

  @override
  String get taskTag_escape => 'Escape';

  @override
  String get taskTag_escapeInOneMove => 'Escape in one move';

  @override
  String get taskTag_exploitShapeWeakness => 'Exploit shape weakness';

  @override
  String get taskTag_eyeVsNoEye => 'Eye vs no-eye';

  @override
  String get taskTag_fillNeutralPoints => 'Fill neutral points';

  @override
  String get taskTag_findTheRoot => 'Find the root';

  @override
  String get taskTag_firstLineBrilliantMove => 'First line brilliant move';

  @override
  String get taskTag_flowerSix => 'Flower six';

  @override
  String get taskTag_goldenChickenStandingOnOneLeg =>
      'Golden rooster standing on one leg';

  @override
  String get taskTag_groupLiberties => 'Group liberties';

  @override
  String get taskTag_groupsBase => 'Group\'s base';

  @override
  String get taskTag_hane => 'Hane';

  @override
  String get taskTag_increaseEyeSpace => 'Increase eye space';

  @override
  String get taskTag_increaseLiberties => 'Increase liberties';

  @override
  String get taskTag_indirectAttack => 'Indirect attack';

  @override
  String get taskTag_influenceKeyPoints => 'Influence key points';

  @override
  String get taskTag_insideKill => 'Inside kill';

  @override
  String get taskTag_insideMoves => 'Inside moves';

  @override
  String get taskTag_interestingTasks => 'Interesting tasks';

  @override
  String get taskTag_internalLibertyShortage => 'Internal liberty shortage';

  @override
  String get taskTag_invadingTechnique => 'Invading technique';

  @override
  String get taskTag_invasion => 'Invasion';

  @override
  String get taskTag_jGroupAndSimilar => 'J-group and similar';

  @override
  String get taskTag_josekiFundamentals => 'Joseki fundamentals';

  @override
  String get taskTag_jump => 'Jump';

  @override
  String get taskTag_keepSente => 'Keep sente';

  @override
  String get taskTag_killAfterCapture => 'Kill after capture';

  @override
  String get taskTag_killByEyePointPlacement => 'Kill by eye point placement';

  @override
  String get taskTag_knightsMove => 'Knight\'s move';

  @override
  String get taskTag_ko => 'Ko';

  @override
  String get taskTag_kosumiWedge => 'Kosumi wedge';

  @override
  String get taskTag_largeKnightsMove => 'Large knight move';

  @override
  String get taskTag_largeMoyoFight => 'Large moyo fight';

  @override
  String get taskTag_lifeAndDeath => 'Life & death: general';

  @override
  String get taskTag_lifeAndDeathOn4x4 => 'Life and death on 4x4';

  @override
  String get taskTag_lookForLeverage => 'Look for leverage';

  @override
  String get taskTag_looseLadder => 'Loose ladder';

  @override
  String get taskTag_lovesickCut => 'Lovesick cut';

  @override
  String get taskTag_makeEye => 'Make eye';

  @override
  String get taskTag_makeEyeInOneStep => 'Make eye in one step';

  @override
  String get taskTag_makeEyeInSente => 'Make eye in sente';

  @override
  String get taskTag_makeKo => 'Make ko';

  @override
  String get taskTag_makeShape => 'Make shape';

  @override
  String get taskTag_middlegame => 'Middlegame';

  @override
  String get taskTag_monkeyClimbingMountain => 'Monkey climbing the mountain';

  @override
  String get taskTag_mouseStealingOil => 'Mouse stealing oil';

  @override
  String get taskTag_moveOut => 'Move out';

  @override
  String get taskTag_moveTowardsEmptySpace => 'Move towards empty space';

  @override
  String get taskTag_multipleBrilliantMoves => 'Multiple brilliant moves';

  @override
  String get taskTag_net => 'Net';

  @override
  String get taskTag_netCapture => 'Net capture';

  @override
  String get taskTag_observeSubtleDifference => 'Observe subtle difference';

  @override
  String get taskTag_occupyEncloseAndApproachCorner =>
      'Occupy, enclose and approach corners';

  @override
  String get taskTag_oneStoneTwoPurposes => 'One stone, two purposes';

  @override
  String get taskTag_opening => 'Opening';

  @override
  String get taskTag_openingChoice => 'Opening choice';

  @override
  String get taskTag_openingFundamentals => 'Opening fundamentals';

  @override
  String get taskTag_orderOfEndgameMoves => 'Order of endgame moves';

  @override
  String get taskTag_orderOfMoves => 'Order of moves';

  @override
  String get taskTag_orderOfMovesInKo => 'Order of moves in a ko';

  @override
  String get taskTag_orioleCapturesButterfly => 'Oriole captures the butterfly';

  @override
  String get taskTag_pincer => 'Pincer';

  @override
  String get taskTag_placement => 'Placement';

  @override
  String get taskTag_plunderingTechnique => 'Plundering technique';

  @override
  String get taskTag_preventBambooJoint => 'Prevent the bamboo joint';

  @override
  String get taskTag_preventBridgingUnder => 'Prevent bridging under';

  @override
  String get taskTag_preventOpponentFromApproaching =>
      'Prevent opponent from approaching';

  @override
  String get taskTag_probe => 'Probe';

  @override
  String get taskTag_profitInSente => 'Profit in sente';

  @override
  String get taskTag_profitUsingLifeAndDeath => 'Profit using life and death';

  @override
  String get taskTag_push => 'Push';

  @override
  String get taskTag_pyramidFour => 'Pyramid four';

  @override
  String get taskTag_realEyeAndFalseEye => 'Real eye vs false eye';

  @override
  String get taskTag_rectangularSix => 'Rectangular six';

  @override
  String get taskTag_reduceEyeSpace => 'Reduce eye space';

  @override
  String get taskTag_reduceLiberties => 'Reduce liberties';

  @override
  String get taskTag_reduction => 'Reduction';

  @override
  String get taskTag_runWeakGroup => 'Run weak group';

  @override
  String get taskTag_sabakiAndUtilizingInfluence =>
      'Sabaki and utilizing influence';

  @override
  String get taskTag_sacrifice => 'Sacrifice';

  @override
  String get taskTag_sacrificeAndSqueeze => 'Sacrifice and squeeze';

  @override
  String get taskTag_sealIn => 'Seal in';

  @override
  String get taskTag_secondLine => 'Second line';

  @override
  String get taskTag_seizeTheOpportunity => 'Seize the opportunity';

  @override
  String get taskTag_seki => 'Seki';

  @override
  String get taskTag_senteAndGote => 'Sente and gote';

  @override
  String get taskTag_settleShape => 'Settle shape';

  @override
  String get taskTag_settleShapeInSente => 'Settle shape in sente';

  @override
  String get taskTag_shape => 'Shape';

  @override
  String get taskTag_shapesVitalPoint => 'Shape\'s vital point';

  @override
  String get taskTag_side => 'Side';

  @override
  String get taskTag_smallBoardEndgame => 'Small board endgame';

  @override
  String get taskTag_snapback => 'Snapback';

  @override
  String get taskTag_solidConnection => 'Solid connection';

  @override
  String get taskTag_solidExtension => 'Solid extension';

  @override
  String get taskTag_splitInOneMove => 'Split in one move';

  @override
  String get taskTag_splittingMove => 'Splitting move';

  @override
  String get taskTag_squareFour => 'Square four';

  @override
  String get taskTag_squeeze => 'Squeeze';

  @override
  String get taskTag_standardCapturingRaces => 'Standard capturing races';

  @override
  String get taskTag_standardCornerAndSideEndgame =>
      'Standard corner and side endgame';

  @override
  String get taskTag_straightFour => 'Straight four';

  @override
  String get taskTag_straightThree => 'Straight three';

  @override
  String get taskTag_surroundTerritory => 'Surround territory';

  @override
  String get taskTag_symmetricShape => 'Symmetric shape';

  @override
  String get taskTag_techniqueForReinforcingGroups =>
      'Technique for reinforcing groups';

  @override
  String get taskTag_techniqueForSecuringTerritory =>
      'Technique for securing territory';

  @override
  String get taskTag_textbookTasks => 'Textbook tasks';

  @override
  String get taskTag_thirdAndFourthLine => 'Third and fourth line';

  @override
  String get taskTag_threeEyesTwoActions => 'Three eyes, two actions';

  @override
  String get taskTag_threeSpaceExtensionFromTwoStones =>
      'Three-space extension from two stones';

  @override
  String get taskTag_throwIn => 'Throw-in';

  @override
  String get taskTag_tigersMouth => 'Tiger\'s mouth';

  @override
  String get taskTag_tombstoneSqueeze => 'Tombstone squeeze';

  @override
  String get taskTag_tripodGroupWithExtraLegAndSimilar =>
      'Tripod group with extra leg and similar';

  @override
  String get taskTag_twoHaneGainOneLiberty => 'Double hane grows one liberty';

  @override
  String get taskTag_twoHeadedDragon => 'Two-headed dragon';

  @override
  String get taskTag_twoSpaceExtension => 'Two-space extension';

  @override
  String get taskTag_typesOfKo => 'Types of ko';

  @override
  String get taskTag_underTheStones => 'Under the stones';

  @override
  String get taskTag_underneathAttachment => 'Underneath attachment';

  @override
  String get taskTag_urgentPointOfAFight => 'Urgent point of a fight';

  @override
  String get taskTag_urgentPoints => 'Urgent points';

  @override
  String get taskTag_useConnectAndDie => 'Use connect and die';

  @override
  String get taskTag_useCornerSpecialProperties =>
      'Use corner special properties';

  @override
  String get taskTag_useDescentToFirstLine => 'Use descent to first line';

  @override
  String get taskTag_useInfluence => 'Use influence';

  @override
  String get taskTag_useOpponentsLifeAndDeath =>
      'Use opponent\'s life and death';

  @override
  String get taskTag_useShortageOfLiberties => 'Use shortage of liberties';

  @override
  String get taskTag_useSnapback => 'Use snapback';

  @override
  String get taskTag_useSurroundingStones => 'Use surrounding stones';

  @override
  String get taskTag_vitalAndUselessStones => 'Vital and useless stones';

  @override
  String get taskTag_vitalPointForBothSides => 'Vital point for both sides';

  @override
  String get taskTag_vitalPointForCapturingRace =>
      'Vital point for capturing race';

  @override
  String get taskTag_vitalPointForIncreasingLiberties =>
      'Vital point for increasing liberties';

  @override
  String get taskTag_vitalPointForKill => 'Vital point for kill';

  @override
  String get taskTag_vitalPointForLife => 'Vital point for life';

  @override
  String get taskTag_vitalPointForReducingLiberties =>
      'Vital point for reducing liberties';

  @override
  String get taskTag_wedge => 'Wedge';

  @override
  String get taskTag_wedgingCapture => 'Wedging capture';

  @override
  String get taskTimeout => 'Timeout';

  @override
  String get taskTypeAppreciation => 'Appreciation';

  @override
  String get taskTypeCapture => 'Capture stones';

  @override
  String get taskTypeCaptureRace => 'Capture race';

  @override
  String get taskTypeEndgame => 'Endgame';

  @override
  String get taskTypeJoseki => 'Joseki';

  @override
  String get taskTypeLifeAndDeath => 'Life & death';

  @override
  String get taskTypeMiddlegame => 'Middlegame';

  @override
  String get taskTypeOpening => 'Opening';

  @override
  String get taskTypeTesuji => 'Tesuji';

  @override
  String get taskTypeTheory => 'Theory';

  @override
  String get taskWrong => 'Wrong';

  @override
  String get tasksSolved => 'Tasks solved';

  @override
  String get test => 'Test';

  @override
  String get theme => 'Theme';

  @override
  String get thick => 'Thick';

  @override
  String get timeFrenzy => 'Time frenzy';

  @override
  String get timePerTask => 'Time per task';

  @override
  String get today => 'Today';

  @override
  String get tooltipAnalyzeWithAISensei => 'Analyze with AI Sensei';

  @override
  String get tooltipDownloadGame => 'Download game';

  @override
  String get topic => 'Topic';

  @override
  String get topics => 'Topics';

  @override
  String get train => 'Train';

  @override
  String get trainingAvgTimePerTask => 'Avg time per task';

  @override
  String get trainingFailed => 'Failed';

  @override
  String get trainingMistakes => 'Mistakes';

  @override
  String get trainingPassed => 'Passed';

  @override
  String get trainingTotalTime => 'Total time';

  @override
  String get tryCustomMoves => 'Try custom moves';

  @override
  String get tygemDesc =>
      'The most popular server in Korea and one of the most popular in the world.';

  @override
  String get tygemName => 'Tygem Baduk';

  @override
  String get type => 'Type';

  @override
  String get ui => 'UI';

  @override
  String get userInfo => 'User info';

  @override
  String get username => 'Username';

  @override
  String get voice => 'Voice';

  @override
  String get week => 'Week';

  @override
  String get yes => 'Yes';
}
