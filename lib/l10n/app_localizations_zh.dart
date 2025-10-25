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
  String get acceptDeadStones => '确认死子';

  @override
  String get accuracy => '答题准确率';

  @override
  String get aiReferee => 'AI 裁判';

  @override
  String get aiSensei => 'AI Sensei';

  @override
  String get alwaysBlackToPlay => '总是执黑先行';

  @override
  String get alwaysBlackToPlayDesc => '永远执黑先行，防止混淆';

  @override
  String get appearance => '外观';

  @override
  String get autoCounting => '自动点目';

  @override
  String get autoMatch => '自动匹配';

  @override
  String get behaviour => '操作';

  @override
  String get bestResult => '最优结果';

  @override
  String get black => '黑';

  @override
  String get board => '棋盘';

  @override
  String get boardSize => '棋盘颜色';

  @override
  String get boardTheme => '棋盘主题';

  @override
  String get byRank => '按段位';

  @override
  String get cancel => '取消';

  @override
  String get captures => '吃子';

  @override
  String get clearBoard => '清空';

  @override
  String get collectStats => '计入统计';

  @override
  String get collections => '棋书';

  @override
  String get confirm => '确认';

  @override
  String get confirmBoardSize => '确认棋盘大小';

  @override
  String get confirmBoardSizeDesc => '此尺寸及更大的棋盘需要确认落子';

  @override
  String get confirmMoves => '确定落子';

  @override
  String get confirmMovesDesc => '在较大的棋盘上双击以确认落子，避免误操作';

  @override
  String get continue_ => '继续';

  @override
  String get copyTaskLink => '复制题目链接';

  @override
  String get customExam => '自定义测试';

  @override
  String get dark => '深色';

  @override
  String get dontShowAgain => '不再显示';

  @override
  String get download => '下载';

  @override
  String get edgeLine => '棋盘边缘';

  @override
  String get empty => '空';

  @override
  String get endgameExam => '官子测试';

  @override
  String get enterTaskLink => '输入题目链接';

  @override
  String get errCannotBeEmpty => '不能为空';

  @override
  String get errFailedToDownloadGame => '下载棋局失败';

  @override
  String get errFailedToLoadGameList => '加载棋局列表失败，请重试。';

  @override
  String get errFailedToUploadGameToAISensei => '上传棋局到 AI Sensei 失败';

  @override
  String get errIncorrectUsernameOrPassword => '用户名或密码错误';

  @override
  String errMustBeAtLeast(num n) {
    return '必须至少$n';
  }

  @override
  String errMustBeAtMost(num n) {
    return '必须最多$n';
  }

  @override
  String get errMustBeInteger => '必须为整数';

  @override
  String get exit => '退出';

  @override
  String get exitTryMode => '退出试下模式';

  @override
  String get find => '查找';

  @override
  String get findTask => '搜题';

  @override
  String get findTaskByLink => '链接搜题';

  @override
  String get findTaskByPattern => '棋形搜题';

  @override
  String get findTaskResults => '搜题结果';

  @override
  String get findTaskSearching => '搜题中...';

  @override
  String get forceCounting => '强制数子';

  @override
  String get foxwqDesc => '野狐围棋是精心打造的专业围棋对弈、社交软件。';

  @override
  String get foxwqName => 'Fox Weiqi';

  @override
  String get gameInfo => '信息';

  @override
  String get gameRecord => '棋谱';

  @override
  String get gradingExam => '棋力测试';

  @override
  String get handicap => '让子数';

  @override
  String get help => '帮助';

  @override
  String get helpDialogCollections =>
      '棋书是经典的、精选的高质量题目合集，作为训练资源具有特殊价值。\n\n主要目标是以高成功率解完一本棋书。次要目标是尽可能快地完成。\n\n要开始或继续解答棋书，请在竖屏模式下向左滑动棋书图块，或在横屏模式下点击「开始」/「继续」按钮。';

  @override
  String get helpDialogEndgameExam =>
      '- 官子测试包含10道官子题，每题限时45秒。\n\n- 答对8题及以上（80%正确率）即为通过。\n\n- 通过当前级别测试将解锁下一级别。';

  @override
  String get helpDialogGradingExam =>
      '- 棋力测试包含10道题，每题限时45秒。\n\n- 答对8题及以上（80%正确率）即为通过。\n\n- 通过当前级别测试将解锁下一级别。';

  @override
  String get helpDialogRankedMode =>
      '- 无时间限制答题。\n\n- 题目难度会根据您的解题速度动态调整。\n\n- 专注于正确答题，冲击最高等级。';

  @override
  String get helpDialogTimeFrenzy =>
      '- 3分钟内解答尽可能多的题。\n\n- 题目难度会随着您的进度逐渐增加。\n\n- 累计答错3题即结束。';

  @override
  String get home => '主界面';

  @override
  String get komi => '贴目';

  @override
  String get language => '语言';

  @override
  String get leave => '退出房间';

  @override
  String get light => '浅色';

  @override
  String get login => '登录';

  @override
  String get logout => '退出';

  @override
  String get long => '长';

  @override
  String mMinutes(int m) {
    return '$m分钟';
  }

  @override
  String get maxNumberOfMistakes => '最大错误数';

  @override
  String get maxRank => '最高段位';

  @override
  String get medium => '中';

  @override
  String get minRank => '最低段位';

  @override
  String get minutes => '分';

  @override
  String get month => '月';

  @override
  String get msgCannotUseAIRefereeYet => '您还不能使用 AI 裁判';

  @override
  String get msgCannotUseForcedCountingYet => '手数不足，不可强制数子或强制点目';

  @override
  String get msgConfirmDeleteCollectionProgress => '确定要删除之前的棋书进度吗？';

  @override
  String get msgConfirmResignation => '确认认输？';

  @override
  String msgConfirmStopEvent(String event) {
    return '确定要停止$event吗？';
  }

  @override
  String get msgDownloadingGame => '下载棋局中';

  @override
  String msgGameSavedTo(String path) {
    return '棋局已保存至$path';
  }

  @override
  String get msgPleaseWaitForYourTurn => '请等待您的回合';

  @override
  String get msgSearchingForGame => '正在寻找对局...';

  @override
  String get msgTaskLinkCopied => '题目链接已复制';

  @override
  String get msgWaitingForOpponentsDecision => '等待决定...';

  @override
  String get msgYouCannotPass => '本局您已经不能再停一手了。';

  @override
  String get msgYourOpponentDisagreesWithCountingResult => '有人不同意点目结果。';

  @override
  String get msgYourOpponentRefusesToCount => '对方不同意点目。';

  @override
  String get msgYourOpponentRequestsAutomaticCounting => '对方要求自动点目，是否同意？';

  @override
  String get myGames => '我的棋局';

  @override
  String get myMistakes => '我的错题本';

  @override
  String nTasks(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString题',
      zero: '无题',
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
      other: '$countString题',
      zero: '无题',
    );
    return '$_temp0';
  }

  @override
  String get newBestResult => '新纪录！';

  @override
  String get no => '取消';

  @override
  String get none => '无';

  @override
  String get numberOfTasks => '题目数量';

  @override
  String nxnBoardSize(int n) {
    return '$n×$n';
  }

  @override
  String get ogsDesc =>
      'Online Go Server (OGS) 是功能强大的国际性围棋对弈平台，提供丰富的比赛和AI分析工具。';

  @override
  String get ogsName => 'Online Go Server';

  @override
  String get ok => '确定';

  @override
  String get pass => '虚手';

  @override
  String get password => '密码';

  @override
  String get play => '对局';

  @override
  String get pleaseMarkDeadStones => '请标记死子。';

  @override
  String get promotionRequirements => '升级要求';

  @override
  String pxsByoyomi(int p, int s) {
    return '$p×${s}s';
  }

  @override
  String get rank => '段位';

  @override
  String get rankedMode => '等级模式';

  @override
  String get recentRecord => '当前战绩';

  @override
  String get register => '创建帐号';

  @override
  String get rejectDeadStones => '取消死子';

  @override
  String get resign => '认输并退出';

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
  String get resultAccept => '接受';

  @override
  String get resultReject => '拒绝';

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
  String get copySGF => '复制SGF';

  @override
  String get seconds => '秒';

  @override
  String get settings => '设置';

  @override
  String get short => '短';

  @override
  String get showCoordinates => '显示坐标';

  @override
  String get simple => '普通';

  @override
  String get sortModeDifficult => '困难';

  @override
  String get sortModeRecent => '最近';

  @override
  String get sound => '声音';

  @override
  String get start => '开始';

  @override
  String get statistics => '统计';

  @override
  String get statsDateColumn => '日期';

  @override
  String get statsDurationColumn => '用时';

  @override
  String get statsTimeColumn => '时间';

  @override
  String get stoneShadows => '棋子阴影';

  @override
  String get stones => '棋子';

  @override
  String get subtopic => '子主题';

  @override
  String get system => '系统';

  @override
  String get task => '题';

  @override
  String get taskCorrect => '答对了！';

  @override
  String get taskNext => '下一题';

  @override
  String get taskNotFound => '未找到该题';

  @override
  String get taskRedo => '重做题';

  @override
  String get taskSource => '题库来源';

  @override
  String get taskSourceFromMyMistakes => '来自我的错题';

  @override
  String get taskSourceFromTaskTopic => '来自专题题库';

  @override
  String get taskSourceFromTaskTypes => '来自题型分类';

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
  String get taskTimeout => '答题超时';

  @override
  String get taskTypeAppreciation => '欣赏题';

  @override
  String get taskTypeCapture => '吃子题';

  @override
  String get taskTypeCaptureRace => '对杀题';

  @override
  String get taskTypeEndgame => '官子题';

  @override
  String get taskTypeJoseki => '定式题';

  @override
  String get taskTypeLifeAndDeath => '死活题';

  @override
  String get taskTypeMiddlegame => '中盘作战题';

  @override
  String get taskTypeOpening => '布局题';

  @override
  String get taskTypeTesuji => '手筋题';

  @override
  String get taskTypeTheory => '棋理题';

  @override
  String get taskWrong => '答错了';

  @override
  String get tasksSolved => '解题数';

  @override
  String get test => '测试';

  @override
  String get theme => '主题';

  @override
  String get thick => '粗线';

  @override
  String get timeFrenzy => '限时挑战';

  @override
  String get timePerTask => '单题用时';

  @override
  String get today => '今日';

  @override
  String get tooltipAnalyzeWithAISensei => '使用 AI Sensei 分析';

  @override
  String get tooltipDownloadGame => '下载棋局';

  @override
  String get topic => '主题';

  @override
  String get topicExam => '主题测试';

  @override
  String get topics => '主题';

  @override
  String get train => '练习';

  @override
  String get trainingAvgTimePerTask => '平均单题用时';

  @override
  String get trainingFailed => '未通过';

  @override
  String get trainingMistakes => '错误';

  @override
  String get trainingPassed => '通过';

  @override
  String get trainingTotalTime => '总用时';

  @override
  String get tryCustomMoves => '试下';

  @override
  String get tygemDesc => 'Tygem 是韩国最受欢迎的围棋对弈平台，以其激烈的在线对局氛围而闻名世界。';

  @override
  String get tygemName => 'Tygem Baduk';

  @override
  String get type => '类型';

  @override
  String get ui => '界面';

  @override
  String get userInfo => '用户信息';

  @override
  String get username => '用户名';

  @override
  String get voice => '声音';

  @override
  String get week => '周';

  @override
  String get white => '白';

  @override
  String get yes => '确定';
}
