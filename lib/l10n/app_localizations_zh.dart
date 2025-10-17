// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get about => '关于';

  @override
  String get accuracy => 'Accuracy';

  @override
  String get aiReferee => 'AI referee';

  @override
  String get aiSensei => 'AI Sensei';

  @override
  String get alwaysBlackToPlay => '总是执黑先行';

  @override
  String get alwaysBlackToPlayDesc => '永远执黑先行，防止混淆';

  @override
  String get appearance => '外观';

  @override
  String get autoCounting => 'Auto counting';

  @override
  String get autoMatch => 'Auto-Match';

  @override
  String get behaviour => '操作';

  @override
  String get bestResult => '最优结果';

  @override
  String get black => 'Black';

  @override
  String get board => '棋盘';

  @override
  String get boardSize => '棋盘颜色';

  @override
  String get boardTheme => '棋盘主题';

  @override
  String get byRank => 'By rank';

  @override
  String get cancel => '取消';

  @override
  String get captures => 'Captures';

  @override
  String get clearBoard => 'Clear';

  @override
  String get collectStats => 'Collect statistics';

  @override
  String get collections => 'Collections';

  @override
  String get confirm => '确认';

  @override
  String get confirmBoardSize => '确认棋盘大小';

  @override
  String get confirmBoardSizeDesc =>
      'Boards this size or larger require move confirmation';

  @override
  String get confirmMoves => '确定落子';

  @override
  String get confirmMovesDesc => '在较大的棋盘上双击以确认落子，避免误操作';

  @override
  String get continue_ => '继续';

  @override
  String get copyTaskLink => 'Copy task link';

  @override
  String get customExam => 'Custom exam';

  @override
  String get dark => 'Dark';

  @override
  String get dontShowAgain => '不再显示';

  @override
  String get download => '下载';

  @override
  String get edgeLine => '棋盘边缘';

  @override
  String get empty => 'Empty';

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
  String get exit => '退出';

  @override
  String get exitTryMode => 'Exit try mode';

  @override
  String get find => '查找';

  @override
  String get findTask => 'Find task';

  @override
  String get findTaskByLink => 'By link';

  @override
  String get findTaskByPattern => 'By pattern';

  @override
  String get findTaskResults => 'Search results';

  @override
  String get findTaskSearching => 'Searching...';

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
  String get handicap => '让子数';

  @override
  String get help => '帮助';

  @override
  String get helpDialogCollections =>
      'Collections are classic, curated sets of high-quality tasks which hold special value together as a training resource.\n\nThe main goal is to solve a collection with a high success rate. A secondary goal is to solve it as fast as possible.\n\nTo start or continue solving a collection, slide left on the collection tile while in portrait mode or click the Start/Continue buttons while in landscape mode.';

  @override
  String get helpDialogEndgameExam =>
      '- Endgame exams are sets of 10 endgame tasks and you have 45 seconds per task.\n\n- You pass the exam if you solve 8 or more correctly (80% success rate).\n\n- Passing the exam for a given rank unlocks the exam for the next rank.';

  @override
  String get helpDialogGradingExam =>
      '- Grading exams are sets of 10 tasks and you have 45 seconds per task.\n\n- You pass the exam if you solve 8 or more correctly (80% success rate).\n\n- Passing the exam for a given rank unlocks the exam for the next rank.';

  @override
  String get helpDialogRankedMode =>
      '- Solve tasks without a time limit.\n\n- Task difficulty increases according to how fast you solve them.\n\n- Focus on solving correctly and reach the highest rank possible.';

  @override
  String get helpDialogTimeFrenzy =>
      '- You have 3 minutes to solve as many tasks as possible.\n\n- Tasks get increasingly difficult as you solve them.\n\n- If you make 3 mistakes, you are out.';

  @override
  String get home => '主界面';

  @override
  String get komi => 'Komi';

  @override
  String get language => '语言';

  @override
  String get leave => 'Leave';

  @override
  String get light => '浅色';

  @override
  String get login => '登录';

  @override
  String get logout => '退出';

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
  String get password => '密码';

  @override
  String get play => '对局';

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
  String get register => '注册';

  @override
  String get resign => 'Resign';

  @override
  String get responseDelay => '响应延迟';

  @override
  String get responseDelayDesc => '解题时响应前的延迟时长';

  @override
  String get responseDelayLong => '长';

  @override
  String get responseDelayMedium => '中';

  @override
  String get responseDelayNone => '无';

  @override
  String get responseDelayShort => '短';

  @override
  String get result => '结果';

  @override
  String get rules => '规则';

  @override
  String get rulesChinese => '中国规则';

  @override
  String get rulesJapanese => '日本规则';

  @override
  String get rulesKorean => '韩国规则';

  @override
  String get save => '保存';

  @override
  String get saveSGF => '保存SGF';

  @override
  String get seconds => '秒';

  @override
  String get settings => '设置';

  @override
  String get short => 'Short';

  @override
  String get showCoordinates => '显示坐标';

  @override
  String get simple => '普通';

  @override
  String get sortModeDifficult => 'Difficult';

  @override
  String get sortModeRecent => 'Recent';

  @override
  String get sound => '声音';

  @override
  String get start => '开始';

  @override
  String get statistics => 'Statistics';

  @override
  String get statsDateColumn => 'Date';

  @override
  String get statsDurationColumn => 'Time';

  @override
  String get statsTimeColumn => 'Time';

  @override
  String get stoneShadows => '棋子阴影';

  @override
  String get stones => 'Stones';

  @override
  String get subtopic => 'Subtopic';

  @override
  String get system => '系统';

  @override
  String get task => '任务';

  @override
  String get taskCorrect => 'Correct';

  @override
  String get taskNext => 'Next';

  @override
  String get taskNotFound => 'Task not found';

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
  String get taskTag_afterJoseki => '定式之后';

  @override
  String get taskTag_aiOpening => 'AI布局';

  @override
  String get taskTag_aiVariations => 'AI变化';

  @override
  String get taskTag_attack => '攻击';

  @override
  String get taskTag_attackAndDefenseInKo => '劫的攻防';

  @override
  String get taskTag_attackAndDefenseOfCuts => '切断的处理';

  @override
  String get taskTag_attackAndDefenseOfInvadingStones => '征子的攻防';

  @override
  String get taskTag_avoidKo => '避劫';

  @override
  String get taskTag_avoidMakingDeadShape => '避免被聚杀';

  @override
  String get taskTag_avoidTrap => '避开陷阱';

  @override
  String get taskTag_basicEndgame => '基础官子';

  @override
  String get taskTag_basicLifeAndDeath => '基本死活';

  @override
  String get taskTag_basicMoves => '基本行棋';

  @override
  String get taskTag_basicTesuji => '基本手筋';

  @override
  String get taskTag_beginner => '启蒙';

  @override
  String get taskTag_bend => '弯';

  @override
  String get taskTag_bentFour => '弯四';

  @override
  String get taskTag_bentFourInTheCorner => '盘角曲四';

  @override
  String get taskTag_bentThree => '弯三';

  @override
  String get taskTag_bigEyeLiberties => '大眼的气';

  @override
  String get taskTag_bigEyeVsSmallEye => '大眼杀小眼';

  @override
  String get taskTag_bigPoints => '大场';

  @override
  String get taskTag_blindSpot => '盲点';

  @override
  String get taskTag_breakEye => '破眼';

  @override
  String get taskTag_breakEyeInOneStep => '一步破眼';

  @override
  String get taskTag_breakEyeInSente => '先手破眼';

  @override
  String get taskTag_breakOut => '突围';

  @override
  String get taskTag_breakPoints => '破目';

  @override
  String get taskTag_breakShape => '破坏棋形';

  @override
  String get taskTag_bridgeUnder => '渡';

  @override
  String get taskTag_brilliantSequence => '一一妙手';

  @override
  String get taskTag_bulkyFive => '刀把五';

  @override
  String get taskTag_bump => '顶';

  @override
  String get taskTag_captureBySnapback => '扑吃';

  @override
  String get taskTag_captureInLadder => '征吃';

  @override
  String get taskTag_captureInOneMove => '一步吃子';

  @override
  String get taskTag_captureOnTheSide => '边线吃子';

  @override
  String get taskTag_captureToLive => '吃子做活';

  @override
  String get taskTag_captureTwoRecaptureOne => '打二还一';

  @override
  String get taskTag_capturingRace => '对杀';

  @override
  String get taskTag_capturingTechniques => '吃子技巧';

  @override
  String get taskTag_carpentersSquareAndSimilar => '金柜角及类似型';

  @override
  String get taskTag_chooseTheFight => '战斗的选择';

  @override
  String get taskTag_clamp => '夹';

  @override
  String get taskTag_clampCapture => '夹吃';

  @override
  String get taskTag_closeInCapture => '门吃';

  @override
  String get taskTag_combination => '组合手段';

  @override
  String get taskTag_commonLifeAndDeath => '常型死活';

  @override
  String get taskTag_compareSize => '比较大小';

  @override
  String get taskTag_compareValue => '价值比较';

  @override
  String get taskTag_completeKoToSecureEndgameAdvantage => '粘劫收后';

  @override
  String get taskTag_compositeProblems => '复合问题';

  @override
  String get taskTag_comprehensiveTasks => '综合';

  @override
  String get taskTag_connect => '连络';

  @override
  String get taskTag_connectAndDie => '接不归';

  @override
  String get taskTag_connectInOneMove => '一步连接';

  @override
  String get taskTag_contactFightTesuji => '接触战的手筋';

  @override
  String get taskTag_contactPlay => '靠';

  @override
  String get taskTag_corner => '角部常型';

  @override
  String get taskTag_cornerIsGoldSideIsSilverCenterIsGrass => '金角银边草肚皮';

  @override
  String get taskTag_counter => '应对';

  @override
  String get taskTag_counterAttack => '反击';

  @override
  String get taskTag_cranesNest => '乌龟不出头';

  @override
  String get taskTag_crawl => '爬';

  @override
  String get taskTag_createShortageOfLiberties => '导致气紧';

  @override
  String get taskTag_crossedFive => '梅花五';

  @override
  String get taskTag_cut => '断';

  @override
  String get taskTag_cut2 => '分断';

  @override
  String get taskTag_cutAcross => '跨';

  @override
  String get taskTag_defendFromInvasion => '防守入侵';

  @override
  String get taskTag_defendPoints => '守目';

  @override
  String get taskTag_defendWeakPoint => '防范弱点';

  @override
  String get taskTag_descent => '立';

  @override
  String get taskTag_diagonal => '尖';

  @override
  String get taskTag_directionOfCapture => '吃子方向';

  @override
  String get taskTag_directionOfEscape => '逃子方向';

  @override
  String get taskTag_directionOfPlay => '方向选择';

  @override
  String get taskTag_doNotUnderestimateOpponent => '不要忽略对方的抵抗';

  @override
  String get taskTag_doubleAtari => '双吃';

  @override
  String get taskTag_doubleCapture => '双提';

  @override
  String get taskTag_doubleKo => '连环劫';

  @override
  String get taskTag_doubleSenteEndgame => '双先官子';

  @override
  String get taskTag_doubleSnapback => '双倒扑';

  @override
  String get taskTag_endgame => '官子';

  @override
  String get taskTag_endgameFundamentals => '基本收官';

  @override
  String get taskTag_endgameIn5x5 => '5路官子';

  @override
  String get taskTag_endgameOn4x4 => '4路官子';

  @override
  String get taskTag_endgameTesuji => '官子手筋';

  @override
  String get taskTag_engulfingAtari => '抱吃';

  @override
  String get taskTag_escape => '逃子';

  @override
  String get taskTag_escapeInOneMove => '一步逃子';

  @override
  String get taskTag_exploitShapeWeakness => '利用棋形弱点';

  @override
  String get taskTag_eyeVsNoEye => '有眼杀无眼';

  @override
  String get taskTag_fillNeutralPoints => '目与单官';

  @override
  String get taskTag_findTheRoot => '搜根';

  @override
  String get taskTag_firstLineBrilliantMove => '一路妙手';

  @override
  String get taskTag_flowerSix => '葡萄六';

  @override
  String get taskTag_goldenChickenStandingOnOneLeg => '金鸡独立';

  @override
  String get taskTag_groupLiberties => '棋子的气';

  @override
  String get taskTag_groupsBase => '棋子的根据地';

  @override
  String get taskTag_hane => '扳';

  @override
  String get taskTag_increaseEyeSpace => '扩大眼位';

  @override
  String get taskTag_increaseLiberties => '延气';

  @override
  String get taskTag_indirectAttack => '间接进攻';

  @override
  String get taskTag_influenceKeyPoints => '势力消长的要点';

  @override
  String get taskTag_insideKill => '聚杀';

  @override
  String get taskTag_insideMoves => '内部动手';

  @override
  String get taskTag_interestingTasks => '趣题';

  @override
  String get taskTag_internalLibertyShortage => '胀牯牛';

  @override
  String get taskTag_invadingTechnique => '入侵的手段';

  @override
  String get taskTag_invasion => '打入';

  @override
  String get taskTag_jGroupAndSimilar => '大猪嘴及类似型';

  @override
  String get taskTag_josekiFundamentals => '基本定式';

  @override
  String get taskTag_jump => '跳';

  @override
  String get taskTag_keepSente => '保留先手';

  @override
  String get taskTag_killAfterCapture => '提子后的杀着';

  @override
  String get taskTag_killByEyePointPlacement => '点杀';

  @override
  String get taskTag_knightsMove => '飞';

  @override
  String get taskTag_ko => '打劫';

  @override
  String get taskTag_kosumiWedge => '挤';

  @override
  String get taskTag_largeKnightsMove => '大飞';

  @override
  String get taskTag_largeMoyoFight => '大模样作战';

  @override
  String get taskTag_lifeAndDeath => '死活';

  @override
  String get taskTag_lifeAndDeathOn4x4 => '4路死活';

  @override
  String get taskTag_lookForLeverage => '寻求借用';

  @override
  String get taskTag_looseLadder => '宽征';

  @override
  String get taskTag_lovesickCut => '相思断';

  @override
  String get taskTag_makeEye => '做眼';

  @override
  String get taskTag_makeEyeInOneStep => '一步做眼';

  @override
  String get taskTag_makeEyeInSente => '先手做眼';

  @override
  String get taskTag_makeKo => '做劫';

  @override
  String get taskTag_makeShape => '定形技巧';

  @override
  String get taskTag_middlegame => '中盘';

  @override
  String get taskTag_monkeyClimbingMountain => '猴子翻山';

  @override
  String get taskTag_mouseStealingOil => '老鼠偷油';

  @override
  String get taskTag_moveOut => '出头';

  @override
  String get taskTag_moveTowardsEmptySpace => '棋往宽处走';

  @override
  String get taskTag_multipleBrilliantMoves => '一二妙手';

  @override
  String get taskTag_net => '枷';

  @override
  String get taskTag_netCapture => '枷吃';

  @override
  String get taskTag_observeSubtleDifference => '注意细微差别';

  @override
  String get taskTag_occupyEncloseAndApproachCorner => '占角、守角和挂角';

  @override
  String get taskTag_oneStoneTwoPurposes => '一子两用';

  @override
  String get taskTag_opening => '布局';

  @override
  String get taskTag_openingChoice => '定式选择';

  @override
  String get taskTag_openingFundamentals => '布局基本下法';

  @override
  String get taskTag_orderOfEndgameMoves => '收束次序';

  @override
  String get taskTag_orderOfMoves => '行棋次序';

  @override
  String get taskTag_orderOfMovesInKo => '区分劫的先后手';

  @override
  String get taskTag_orioleCapturesButterfly => '黄莺扑蝶';

  @override
  String get taskTag_pincer => '夹击';

  @override
  String get taskTag_placement => '点';

  @override
  String get taskTag_plunderingTechnique => '搜刮的手段';

  @override
  String get taskTag_preventBambooJoint => '靠单';

  @override
  String get taskTag_preventBridgingUnder => '阻渡';

  @override
  String get taskTag_preventOpponentFromApproaching => '使对方不入';

  @override
  String get taskTag_probe => '试探应手';

  @override
  String get taskTag_profitInSente => '先手获利';

  @override
  String get taskTag_profitUsingLifeAndDeath => '利用死活问题获利';

  @override
  String get taskTag_push => '冲';

  @override
  String get taskTag_pyramidFour => '丁四';

  @override
  String get taskTag_realEyeAndFalseEye => '真眼和假眼';

  @override
  String get taskTag_rectangularSix => '板六';

  @override
  String get taskTag_reduceEyeSpace => '缩小眼位';

  @override
  String get taskTag_reduceLiberties => '紧气';

  @override
  String get taskTag_reduction => '侵消';

  @override
  String get taskTag_runWeakGroup => '出动残子';

  @override
  String get taskTag_sabakiAndUtilizingInfluence => '腾挪与借用';

  @override
  String get taskTag_sacrifice => '弃子';

  @override
  String get taskTag_sacrificeAndSqueeze => '滚打包收';

  @override
  String get taskTag_sealIn => '封锁';

  @override
  String get taskTag_secondLine => '二线型';

  @override
  String get taskTag_seizeTheOpportunity => '把握战机';

  @override
  String get taskTag_seki => '双活';

  @override
  String get taskTag_senteAndGote => '先手与后手';

  @override
  String get taskTag_settleShape => '整形';

  @override
  String get taskTag_settleShapeInSente => '先手定形';

  @override
  String get taskTag_shape => '棋形';

  @override
  String get taskTag_shapesVitalPoint => '棋形要点';

  @override
  String get taskTag_side => '边部常型';

  @override
  String get taskTag_smallBoardEndgame => '小棋盘官子';

  @override
  String get taskTag_snapback => '倒扑';

  @override
  String get taskTag_solidConnection => '接';

  @override
  String get taskTag_solidExtension => '长';

  @override
  String get taskTag_splitInOneMove => '一步分断';

  @override
  String get taskTag_splittingMove => '分投';

  @override
  String get taskTag_squareFour => '方四';

  @override
  String get taskTag_squeeze => '滚打';

  @override
  String get taskTag_standardCapturingRaces => '常型对杀';

  @override
  String get taskTag_standardCornerAndSideEndgame => '边角常型收束';

  @override
  String get taskTag_straightFour => '直四';

  @override
  String get taskTag_straightThree => '直三';

  @override
  String get taskTag_surroundTerritory => '围空';

  @override
  String get taskTag_symmetricShape => '左右同型';

  @override
  String get taskTag_techniqueForReinforcingGroups => '补棋的方法';

  @override
  String get taskTag_techniqueForSecuringTerritory => '地中的手段';

  @override
  String get taskTag_textbookTasks => '文字题';

  @override
  String get taskTag_thirdAndFourthLine => '三路和四路';

  @override
  String get taskTag_threeEyesTwoActions => '三眼两做';

  @override
  String get taskTag_threeSpaceExtensionFromTwoStones => '立二拆三';

  @override
  String get taskTag_throwIn => '扑';

  @override
  String get taskTag_tigersMouth => '虎';

  @override
  String get taskTag_tombstoneSqueeze => '大头鬼';

  @override
  String get taskTag_tripodGroupWithExtraLegAndSimilar => '小猪嘴及类似型';

  @override
  String get taskTag_twoHaneGainOneLiberty => '两扳长一气';

  @override
  String get taskTag_twoHeadedDragon => '盘龙眼';

  @override
  String get taskTag_twoSpaceExtension => '拆二';

  @override
  String get taskTag_typesOfKo => '区分劫的种类';

  @override
  String get taskTag_underTheStones => '倒脱靴';

  @override
  String get taskTag_underneathAttachment => '托';

  @override
  String get taskTag_urgentPointOfAFight => '战斗的急所';

  @override
  String get taskTag_urgentPoints => '急所';

  @override
  String get taskTag_useConnectAndDie => '利用接不归';

  @override
  String get taskTag_useCornerSpecialProperties => '利用角部特殊性';

  @override
  String get taskTag_useDescentToFirstLine => '利用一路硬腿';

  @override
  String get taskTag_useInfluence => '厚势的作用';

  @override
  String get taskTag_useOpponentsLifeAndDeath => '利用对方死活';

  @override
  String get taskTag_useShortageOfLiberties => '利用气紧';

  @override
  String get taskTag_useSnapback => '利用倒扑';

  @override
  String get taskTag_useSurroundingStones => '利用外围棋子';

  @override
  String get taskTag_vitalAndUselessStones => '要子与废子';

  @override
  String get taskTag_vitalPointForBothSides => '双方要点';

  @override
  String get taskTag_vitalPointForCapturingRace => '对杀要点';

  @override
  String get taskTag_vitalPointForIncreasingLiberties => '延气要点';

  @override
  String get taskTag_vitalPointForKill => '杀棋要点';

  @override
  String get taskTag_vitalPointForLife => '活棋要点';

  @override
  String get taskTag_vitalPointForReducingLiberties => '紧气要点';

  @override
  String get taskTag_wedge => '挖';

  @override
  String get taskTag_wedgingCapture => '挖吃';

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
  String get theme => '主题';

  @override
  String get thick => '粗线';

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
  String get topicExam => 'Topic exam';

  @override
  String get topics => 'Topics';

  @override
  String get train => '练习';

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
  String get userInfo => '用户信息';

  @override
  String get username => '用户名';

  @override
  String get voice => 'Voice';

  @override
  String get week => 'Week';

  @override
  String get white => 'White';

  @override
  String get yes => 'Yes';
}
