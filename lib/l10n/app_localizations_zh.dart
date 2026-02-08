// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get analysis => '分析';

  @override
  String get winrate => '胜率';

  @override
  String get scoreLead => '领先目数';

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
  String get avgRank => '平均段位';

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
  String get byType => '按类型';

  @override
  String get cancel => '取消';

  @override
  String get captures => '吃子';

  @override
  String get chartTitleCorrectCount => '正确数量';

  @override
  String get chartTitleExamCompletionTime => '考试完成时间';

  @override
  String get charts => '图表';

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
  String get copySGF => '复制SGF';

  @override
  String get copyTaskLink => '复制题目链接';

  @override
  String get customExam => '自定义测试';

  @override
  String get dark => '深色';

  @override
  String get deselectAll => '取消全选';

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
  String errLoginFailedWithDetails(String message) {
    return '登录失败：$message';
  }

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
  String get errNetworkError => '网络错误，请检查您的连接并重试。';

  @override
  String get error => '错误';

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
  String get fullscreen => '全屏';

  @override
  String get fullscreenDesc => '以全屏模式显示应用。必须重启应用此设置才能生效。';

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
  String get hidePlayerRanks => '隐藏棋手段位';

  @override
  String get hidePlayerRanksDesc => '在服务器大厅和对局时隐藏段位';

  @override
  String get helpDialogCollections =>
      '棋书是经典的、精选的高质量题目合集，作为训练资源具有特殊价值。\n\n主要目标是以高成功率解完一本棋书。次要目标是尽可能快地完成。';

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
  String get maxChartPoints => '最大点数';

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
  String get msgConfirmDeletePreset => '确定要删除此预设吗？';

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
  String get msgPresetAlreadyExists => '已存在同名的预设。';

  @override
  String get msgSearchingForGame => '正在寻找对局...';

  @override
  String get msgSgfCopied => 'SGF已复制到剪贴板';

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
  String get ogsDesc => '国际性服务器，在欧洲和美洲最受欢迎。';

  @override
  String get ogsName => 'Online Go Server';

  @override
  String get ok => '确定';

  @override
  String get pass => '虚手';

  @override
  String get password => '密码';

  @override
  String get perTask => '每题';

  @override
  String get play => '对局';

  @override
  String get pleaseMarkDeadStones => '请标记死子。';

  @override
  String get presetName => '预设名称';

  @override
  String get presets => '预设';

  @override
  String get promotionRequirements => '升级要求';

  @override
  String pxsByoyomi(int p, int s) {
    return '$p×${s}s';
  }

  @override
  String get randomizeTaskOrientation => '随机化题目方向';

  @override
  String get randomizeTaskOrientationDesc =>
      '随机旋转和翻转题目，沿水平、垂直和对角轴线，防止记忆化并增强模式识别能力。';

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
  String sSeconds(int s) {
    return '$s秒';
  }

  @override
  String get save => '保存';

  @override
  String get savePreset => '保存预设';

  @override
  String get saveSGF => '保存SGF';

  @override
  String get seconds => '秒';

  @override
  String get selectAll => '全选';

  @override
  String get settings => '设置';

  @override
  String get short => '短';

  @override
  String get showCoordinates => '显示坐标';

  @override
  String get showMoveErrorsAsCrosses => '显示错误着法为叉号';

  @override
  String get showMoveErrorsAsCrossesDesc => '将错误着法显示为红色叉号而非红色圆点';

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
  String get timeFrenzyMistakes => '记录限时挑战错误';

  @override
  String get timeFrenzyMistakesDesc => '启用以保存限时挑战中的错误';

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
