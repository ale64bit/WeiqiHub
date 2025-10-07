// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get about => 'О приложении';

  @override
  String get accuracy => 'Точность';

  @override
  String get aiReferee => 'ИИ-судья';

  @override
  String get aiSensei => 'AI Sensei';

  @override
  String get alwaysBlackToPlay => 'Всегда ход чёрных';

  @override
  String get alwaysBlackToPlayDesc =>
      'Устанавливать все задачи как ход чёрных, чтобы избежать путаницы';

  @override
  String get appearance => 'Appearance';

  @override
  String get autoCounting => 'Автоподсчёт';

  @override
  String get autoMatch => 'Auto-Match';

  @override
  String get behaviour => 'Behaviour';

  @override
  String get bestResult => 'Лучший результат';

  @override
  String get black => 'Чёрные';

  @override
  String get board => 'Доска';

  @override
  String get boardSize => 'Размер доски';

  @override
  String get boardTheme => 'Тема доски';

  @override
  String get byRank => 'По рангу';

  @override
  String get cancel => 'Отмена';

  @override
  String get captures => 'Захваты';

  @override
  String get collectStats => 'Collect statistics';

  @override
  String get collections => 'Коллекции';

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
  String get continue_ => 'Продолжить';

  @override
  String get copyTaskLink => 'Копировать ссылку на задачу';

  @override
  String get customExam => 'Custom exam';

  @override
  String get dark => 'Тёмная';

  @override
  String get dontShowAgain => 'Больше не показывать';

  @override
  String get download => 'Скачать';

  @override
  String get edgeLine => 'Линия края';

  @override
  String get endgameExam => 'Endgame exam';

  @override
  String get enterTaskLink => 'Введите ссылку на задачу';

  @override
  String get errCannotBeEmpty => 'Cannot be empty';

  @override
  String get errFailedToDownloadGame => 'Не удалось скачать партию';

  @override
  String get errFailedToLoadGameList =>
      'Не удалось загрузить список партий. Пожалуйста, попробуйте снова.';

  @override
  String get errFailedToUploadGameToAISensei =>
      'Не удалось загрузить партию в AI Sensei';

  @override
  String get errIncorrectUsernameOrPassword =>
      'Неверное имя пользователя или пароль';

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
  String get find => 'Найти';

  @override
  String get findTask => 'Найти задачу';

  @override
  String get forceCounting => 'Force counting';

  @override
  String get foxwqDesc => 'Самый популярный сервер в Китае и в мире.';

  @override
  String get foxwqName => 'Фокс Вэйци';

  @override
  String get gameInfo => 'Информация о партии';

  @override
  String get gameRecord => 'Запись партии';

  @override
  String get gradingExam => 'Grading exam';

  @override
  String get handicap => 'Фора';

  @override
  String get help => 'Помощь';

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
  String get home => 'Главная';

  @override
  String get komi => 'Коми';

  @override
  String get language => 'Язык';

  @override
  String get leave => 'Leave';

  @override
  String get light => 'Светлая';

  @override
  String get login => 'Войти';

  @override
  String get logout => 'Выйти';

  @override
  String get long => 'Long';

  @override
  String mMinutes(int m) {
    return '$m мин';
  }

  @override
  String get maxNumberOfMistakes => 'Максимальное количество ошибок';

  @override
  String get maxRank => 'Макс. ранг';

  @override
  String get medium => 'Medium';

  @override
  String get minRank => 'Мин. ранг';

  @override
  String get minutes => 'Минуты';

  @override
  String get month => 'Month';

  @override
  String get msgCannotUseAIRefereeYet => 'ИИ-судья ещё нельзя использовать';

  @override
  String get msgCannotUseForcedCountingYet =>
      'Forced counting cannot be used yet';

  @override
  String get msgConfirmDeleteCollectionProgress =>
      'Are you sure that you want to delete the previous attempt?';

  @override
  String get msgConfirmResignation => 'Вы уверены, что хотите сдаться?';

  @override
  String msgConfirmStopEvent(String event) {
    return 'Вы уверены, что хотите остановить $event?';
  }

  @override
  String get msgDownloadingGame => 'Скачивание партии';

  @override
  String msgGameSavedTo(String path) {
    return 'Партия сохранена в $path';
  }

  @override
  String get msgPleaseWaitForYourTurn => 'Пожалуйста, дождитесь своего хода';

  @override
  String get msgSearchingForGame => 'Поиск партии...';

  @override
  String get msgTaskLinkCopied => 'Ссылка на задачу скопирована.';

  @override
  String get msgWaitingForOpponentsDecision =>
      'Ожидание решения вашего оппонента...';

  @override
  String get msgYouCannotPass => 'Вы не можете пасовать';

  @override
  String get msgYourOpponentDisagreesWithCountingResult =>
      'Ваш оппонент не согласен с результатом подсчёта';

  @override
  String get msgYourOpponentRefusesToCount =>
      'Ваш оппонент отказывается от подсчёта';

  @override
  String get msgYourOpponentRequestsAutomaticCounting =>
      'Ваш оппонент запрашивает автоматический подсчёт. Вы согласны?';

  @override
  String get myGames => 'Мои партии';

  @override
  String get myMistakes => 'Мои ошибки';

  @override
  String nTasks(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString задач',
      one: '1 задача',
      zero: 'Нет задач',
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
      other: '$countString задач доступно',
      one: '1 задача доступна',
      zero: 'Нет доступных задач',
    );
    return '$_temp0';
  }

  @override
  String get newBestResult => 'Новый рекорд!';

  @override
  String get no => 'Нет';

  @override
  String get none => 'Нет';

  @override
  String get numberOfTasks => 'Количество задач';

  @override
  String nxnBoardSize(int n) {
    return '$n×$n';
  }

  @override
  String get ogsDesc =>
      'Главная онлайн-платформа для игры в Го с турнирами, анализом от ИИ и активным сообществом.';

  @override
  String get ogsName => 'Online Go Server';

  @override
  String get ok => 'ОК';

  @override
  String get pass => 'Пас';

  @override
  String get password => 'Пароль';

  @override
  String get play => 'Играть';

  @override
  String get promotionRequirements => 'Promotion requirements';

  @override
  String pxsByoyomi(int p, int s) {
    return '$p×$sс';
  }

  @override
  String get rank => 'Ранг';

  @override
  String get rankedMode => 'Ranked mode';

  @override
  String get recentRecord => 'Recent record';

  @override
  String get register => 'Зарегистрироваться';

  @override
  String get resign => 'Сдаться';

  @override
  String get responseDelay => 'Response delay';

  @override
  String get responseDelayDesc =>
      'Duration of the delay before the response appears while solving tasks';

  @override
  String get responseDelayLong => 'Длинная';

  @override
  String get responseDelayMedium => 'Средняя';

  @override
  String get responseDelayNone => 'Нет';

  @override
  String get responseDelayShort => 'Короткая';

  @override
  String get result => 'Результат';

  @override
  String get rules => 'Правила';

  @override
  String get rulesChinese => 'Китайские';

  @override
  String get rulesJapanese => 'Японские';

  @override
  String get rulesKorean => 'Корейские';

  @override
  String get save => 'Сохранить';

  @override
  String get saveSGF => 'Сохранить SGF';

  @override
  String get seconds => 'Секунды';

  @override
  String get settings => 'Настройки';

  @override
  String get short => 'Short';

  @override
  String get showCoordinates => 'Показывать координаты';

  @override
  String get simple => 'Simple';

  @override
  String get sortModeDifficult => 'Сложные';

  @override
  String get sortModeRecent => 'Недавние';

  @override
  String get sound => 'Звук';

  @override
  String get start => 'Начать';

  @override
  String get statistics => 'Статистика';

  @override
  String get statsDateColumn => 'Дата';

  @override
  String get statsDurationColumn => 'Время';

  @override
  String get statsTimeColumn => 'Время';

  @override
  String get stoneShadows => 'Тени камней';

  @override
  String get stones => 'Камни';

  @override
  String get subtopic => 'Подтема';

  @override
  String get system => 'Система';

  @override
  String get task => 'Задача';

  @override
  String get taskCorrect => 'Верно';

  @override
  String get taskNext => 'Следующая';

  @override
  String get taskRedo => 'Переделать';

  @override
  String get taskSource => 'Task source';

  @override
  String get taskSourceFromMyMistakes => 'Из моих ошибок';

  @override
  String get taskSourceFromTaskTopic => 'Из темы задач';

  @override
  String get taskSourceFromTaskTypes => 'Из типов задач';

  @override
  String get taskTag_afterJoseki => 'После джосеки';

  @override
  String get taskTag_aiOpening => 'AI opening';

  @override
  String get taskTag_aiVariations => 'AI variations';

  @override
  String get taskTag_attack => 'Атака';

  @override
  String get taskTag_attackAndDefenseInKo => 'Attack and defense in a ko';

  @override
  String get taskTag_attackAndDefenseOfCuts => 'Атака и защита разрезаний';

  @override
  String get taskTag_attackAndDefenseOfInvadingStones =>
      'Attack and defense of invading stones';

  @override
  String get taskTag_avoidKo => 'Избежать ко';

  @override
  String get taskTag_avoidMakingDeadShape => 'Avoid making dead shape';

  @override
  String get taskTag_avoidTrap => 'Avoid trap';

  @override
  String get taskTag_basicEndgame => 'Endgame: basic';

  @override
  String get taskTag_basicLifeAndDeath => 'Базовые задачи на жизнь и смерть';

  @override
  String get taskTag_basicMoves => 'Базовые ходы';

  @override
  String get taskTag_basicTesuji => 'Tesuji';

  @override
  String get taskTag_beginner => 'Базовые приемы';

  @override
  String get taskTag_bend => 'Bend';

  @override
  String get taskTag_bentFour => 'Изогнутая четверка';

  @override
  String get taskTag_bentFourInTheCorner => 'Изогнутая четверка в углу';

  @override
  String get taskTag_bentThree => 'Изогнутая тройка';

  @override
  String get taskTag_bigEyeLiberties => 'Big eye\'s liberties';

  @override
  String get taskTag_bigEyeVsSmallEye =>
      'Группа с большим глазом против группы с маленьким глазом';

  @override
  String get taskTag_bigPoints => 'Большой пункт';

  @override
  String get taskTag_blindSpot => 'Слепое пятно';

  @override
  String get taskTag_breakEye => 'Разрушение глаза';

  @override
  String get taskTag_breakEyeInOneStep => 'Разрушение глаза в один ход';

  @override
  String get taskTag_breakEyeInSente => 'Разрушение глаза в сенте';

  @override
  String get taskTag_breakOut => 'Break out';

  @override
  String get taskTag_breakPoints => 'Break points';

  @override
  String get taskTag_breakShape => 'Разрушить форму';

  @override
  String get taskTag_bridgeUnder => 'Bridge under';

  @override
  String get taskTag_brilliantSequence => 'Brilliant sequence';

  @override
  String get taskTag_bulkyFive => 'Машинка';

  @override
  String get taskTag_bump => 'Удар';

  @override
  String get taskTag_captureBySnapback => 'Захват в защелку';

  @override
  String get taskTag_captureInLadder => 'Захват лестницы';

  @override
  String get taskTag_captureInOneMove => 'Захват в один ход';

  @override
  String get taskTag_captureOnTheSide => 'Захват на стороне';

  @override
  String get taskTag_captureToLive => 'Capture to live';

  @override
  String get taskTag_captureTwoRecaptureOne => 'Захвати два - верни один';

  @override
  String get taskTag_capturingRace => 'Семеай';

  @override
  String get taskTag_capturingTechniques => 'Техника захвата';

  @override
  String get taskTag_carpentersSquareAndSimilar =>
      'Плотницкий квадрат и похожее';

  @override
  String get taskTag_chooseTheFight => 'Выбрать бой';

  @override
  String get taskTag_clamp => 'Зажим';

  @override
  String get taskTag_clampCapture => 'Clamp capture';

  @override
  String get taskTag_closeInCapture => 'Closing-in capture';

  @override
  String get taskTag_combination => 'Комбинация';

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
  String get taskTag_connect => 'Соединение';

  @override
  String get taskTag_connectAndDie => 'Connect and die';

  @override
  String get taskTag_connectInOneMove => 'Соединение в один ход';

  @override
  String get taskTag_contactFightTesuji => 'Техника ближнего боя';

  @override
  String get taskTag_contactPlay => 'Contact play';

  @override
  String get taskTag_corner => 'Угол';

  @override
  String get taskTag_cornerIsGoldSideIsSilverCenterIsGrass =>
      'Угол - золото, сторона - серебро, центр - трава.';

  @override
  String get taskTag_counter => 'Counter';

  @override
  String get taskTag_counterAttack => 'Контратака';

  @override
  String get taskTag_cranesNest => 'Crane\'s nest';

  @override
  String get taskTag_crawl => 'Crawl';

  @override
  String get taskTag_createShortageOfLiberties => 'Создание нехватки дыханий';

  @override
  String get taskTag_crossedFive => 'Crossed five';

  @override
  String get taskTag_cut => 'Разрезание';

  @override
  String get taskTag_cut2 => 'Разрезание';

  @override
  String get taskTag_cutAcross => 'Cut across';

  @override
  String get taskTag_defendFromInvasion => 'Защита от вторжения';

  @override
  String get taskTag_defendPoints => 'Defend points';

  @override
  String get taskTag_defendWeakPoint => 'Defend weak point';

  @override
  String get taskTag_descent => 'Descent';

  @override
  String get taskTag_diagonal => 'Косуми';

  @override
  String get taskTag_directionOfCapture => 'Направление захвата';

  @override
  String get taskTag_directionOfEscape => 'Направление побега';

  @override
  String get taskTag_directionOfPlay => 'Направление игры';

  @override
  String get taskTag_doNotUnderestimateOpponent =>
      'Не стоит недооценивать противника';

  @override
  String get taskTag_doubleAtari => 'Двойное атари';

  @override
  String get taskTag_doubleCapture => 'Double capture';

  @override
  String get taskTag_doubleKo => 'Двойное ко';

  @override
  String get taskTag_doubleSenteEndgame => 'Двойное сенте в йосе';

  @override
  String get taskTag_doubleSnapback => 'Двойная защелка';

  @override
  String get taskTag_endgame => 'Endgame: general';

  @override
  String get taskTag_endgameFundamentals => 'Endgame fundamentals';

  @override
  String get taskTag_endgameIn5x5 => '5х5 йосе';

  @override
  String get taskTag_endgameOn4x4 => '4х4 йосе';

  @override
  String get taskTag_endgameTesuji => 'Йосе-тесуджи';

  @override
  String get taskTag_engulfingAtari => 'Engulfing atari';

  @override
  String get taskTag_escape => 'Побег';

  @override
  String get taskTag_escapeInOneMove => 'Побег в один ход';

  @override
  String get taskTag_exploitShapeWeakness => 'Exploit shape weakness';

  @override
  String get taskTag_eyeVsNoEye => 'Группа с глазом против группы без глаза';

  @override
  String get taskTag_fillNeutralPoints => 'Заполнение нейтральных пунктов';

  @override
  String get taskTag_findTheRoot => 'Find the root';

  @override
  String get taskTag_firstLineBrilliantMove => 'Блестящий ход на 1-й линии';

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
  String get taskTag_hane => 'Хане';

  @override
  String get taskTag_increaseEyeSpace => 'Увеличить глазное пространство';

  @override
  String get taskTag_increaseLiberties => 'Наращивание дыханий';

  @override
  String get taskTag_indirectAttack => 'Косвенная атака';

  @override
  String get taskTag_influenceKeyPoints => 'Influence key points';

  @override
  String get taskTag_insideKill => 'Inside kill';

  @override
  String get taskTag_insideMoves => 'Inside moves';

  @override
  String get taskTag_interestingTasks => 'Интересные задания';

  @override
  String get taskTag_internalLibertyShortage => 'Internal liberty shortage';

  @override
  String get taskTag_invadingTechnique => 'Invading technique';

  @override
  String get taskTag_invasion => 'Вторжение';

  @override
  String get taskTag_jGroupAndSimilar => 'J-group and similar';

  @override
  String get taskTag_josekiFundamentals => 'Joseki fundamentals';

  @override
  String get taskTag_jump => 'Прыжок';

  @override
  String get taskTag_keepSente => 'Сохранить сенте';

  @override
  String get taskTag_killAfterCapture => 'Убийство после захвата';

  @override
  String get taskTag_killByEyePointPlacement => 'Kill by eye point placement';

  @override
  String get taskTag_knightsMove => 'Knight\'s move';

  @override
  String get taskTag_ko => 'Ко';

  @override
  String get taskTag_kosumiWedge => 'Kosumi wedge';

  @override
  String get taskTag_largeKnightsMove => 'Large knight move';

  @override
  String get taskTag_largeMoyoFight => 'Large moyo fight';

  @override
  String get taskTag_lifeAndDeath => 'Жизнь и смерть';

  @override
  String get taskTag_lifeAndDeathOn4x4 => '4х4 жизнь и смерть';

  @override
  String get taskTag_lookForLeverage => 'Look for leverage';

  @override
  String get taskTag_looseLadder => 'Loose ladder';

  @override
  String get taskTag_lovesickCut => 'Lovesick cut';

  @override
  String get taskTag_makeEye => 'Построение глаза';

  @override
  String get taskTag_makeEyeInOneStep => 'Построение глаза в один ход';

  @override
  String get taskTag_makeEyeInSente => 'Построение глаза в сенте';

  @override
  String get taskTag_makeKo => 'Начать ко';

  @override
  String get taskTag_makeShape => 'Построить форму';

  @override
  String get taskTag_middlegame => 'Середина игры';

  @override
  String get taskTag_monkeyClimbingMountain => 'Monkey climbing the mountain';

  @override
  String get taskTag_mouseStealingOil => 'Mouse stealing oil';

  @override
  String get taskTag_moveOut => 'Убегание';

  @override
  String get taskTag_moveTowardsEmptySpace =>
      'Двигаться к пустому пространству';

  @override
  String get taskTag_multipleBrilliantMoves => 'Multiple brilliant moves';

  @override
  String get taskTag_net => 'Net';

  @override
  String get taskTag_netCapture => 'Net capture';

  @override
  String get taskTag_observeSubtleDifference => 'Заметить тонкую разницу';

  @override
  String get taskTag_occupyEncloseAndApproachCorner =>
      'Occupy, enclose and approach corners';

  @override
  String get taskTag_oneStoneTwoPurposes => 'Один ход, две цели';

  @override
  String get taskTag_opening => 'Фусеки';

  @override
  String get taskTag_openingChoice => 'Opening choice';

  @override
  String get taskTag_openingFundamentals => 'Opening fundamentals';

  @override
  String get taskTag_orderOfEndgameMoves => 'Порядок ходов в йосе';

  @override
  String get taskTag_orderOfMoves => 'Порядок ходов';

  @override
  String get taskTag_orderOfMovesInKo => 'Порядок ходов в ко';

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
  String get taskTag_profitInSente => 'Прибыль в сенте';

  @override
  String get taskTag_profitUsingLifeAndDeath => 'Profit using life and death';

  @override
  String get taskTag_push => 'Push';

  @override
  String get taskTag_pyramidFour => 'Пирамида';

  @override
  String get taskTag_realEyeAndFalseEye => 'Глаз против ложного глаза';

  @override
  String get taskTag_rectangularSix => 'Rectangular six';

  @override
  String get taskTag_reduceEyeSpace => 'Уменьшить глазное пространство';

  @override
  String get taskTag_reduceLiberties => 'Сокращение дыханий';

  @override
  String get taskTag_reduction => 'Reduction';

  @override
  String get taskTag_runWeakGroup => 'Побег слабой группы';

  @override
  String get taskTag_sabakiAndUtilizingInfluence =>
      'Sabaki and utilizing influence';

  @override
  String get taskTag_sacrifice => 'Жертва';

  @override
  String get taskTag_sacrificeAndSqueeze => 'Sacrifice and squeeze';

  @override
  String get taskTag_sealIn => 'Seal in';

  @override
  String get taskTag_secondLine => '2-я линия';

  @override
  String get taskTag_seizeTheOpportunity => 'Seize the opportunity';

  @override
  String get taskTag_seki => 'Секи';

  @override
  String get taskTag_senteAndGote => 'Сенте и готе';

  @override
  String get taskTag_settleShape => 'Settle shape';

  @override
  String get taskTag_settleShapeInSente => 'Settle shape in sente';

  @override
  String get taskTag_shape => 'Форма';

  @override
  String get taskTag_shapesVitalPoint => 'Жизненно важный пункт формы';

  @override
  String get taskTag_side => 'Сторона';

  @override
  String get taskTag_smallBoardEndgame => 'Йосе на маленькой доске';

  @override
  String get taskTag_snapback => 'Защелка';

  @override
  String get taskTag_solidConnection => 'Solid connection';

  @override
  String get taskTag_solidExtension => 'Solid extension';

  @override
  String get taskTag_splitInOneMove => 'Разделение в один ход';

  @override
  String get taskTag_splittingMove => 'Splitting move';

  @override
  String get taskTag_squareFour => 'Square four';

  @override
  String get taskTag_squeeze => 'Сжатие';

  @override
  String get taskTag_standardCapturingRaces => 'Standard capturing races';

  @override
  String get taskTag_standardCornerAndSideEndgame =>
      'Стандартное йосе в углу и на стороне';

  @override
  String get taskTag_straightFour => 'Четыре в ряд';

  @override
  String get taskTag_straightThree => 'Три в ряд';

  @override
  String get taskTag_surroundTerritory => 'Surround territory';

  @override
  String get taskTag_symmetricShape => 'Симметричная форма';

  @override
  String get taskTag_techniqueForReinforcingGroups => 'Техника усиления';

  @override
  String get taskTag_techniqueForSecuringTerritory =>
      'Техника защиты территории';

  @override
  String get taskTag_textbookTasks => 'Задачи из книг';

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
  String get taskTag_tigersMouth => 'Пасть тигра';

  @override
  String get taskTag_tombstoneSqueeze => 'Сжатие надгробной плиты';

  @override
  String get taskTag_tripodGroupWithExtraLegAndSimilar =>
      'Tripod group with extra leg and similar';

  @override
  String get taskTag_twoHaneGainOneLiberty => 'Double hane grows one liberty';

  @override
  String get taskTag_twoHeadedDragon => 'Двухглавый дракон';

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
  String get taskTag_urgentPoints => 'Срочный пункт';

  @override
  String get taskTag_useConnectAndDie => 'Use connect and die';

  @override
  String get taskTag_useCornerSpecialProperties =>
      'Использование особых свойств угла';

  @override
  String get taskTag_useDescentToFirstLine => 'Use descent to first line';

  @override
  String get taskTag_useInfluence => 'Использовать влияние';

  @override
  String get taskTag_useOpponentsLifeAndDeath =>
      'Use opponent\'s life and death';

  @override
  String get taskTag_useShortageOfLiberties => 'Использовать нехватку дыханий';

  @override
  String get taskTag_useSnapback => 'Использование защелки';

  @override
  String get taskTag_useSurroundingStones => 'Использование внешних камней';

  @override
  String get taskTag_vitalAndUselessStones => 'Важные и бесполезные камни';

  @override
  String get taskTag_vitalPointForBothSides => 'Важный пункт для обеих сторон';

  @override
  String get taskTag_vitalPointForCapturingRace =>
      'Vital point for capturing race';

  @override
  String get taskTag_vitalPointForIncreasingLiberties =>
      'Vital point for increasing liberties';

  @override
  String get taskTag_vitalPointForKill => 'Жизненно важный пункт для убийства';

  @override
  String get taskTag_vitalPointForLife => 'Жизненно важный пункт для жизни';

  @override
  String get taskTag_vitalPointForReducingLiberties =>
      'Важная точка для сокращения дыханий';

  @override
  String get taskTag_wedge => 'Клин';

  @override
  String get taskTag_wedgingCapture => 'Wedging capture';

  @override
  String get taskTimeout => 'Время вышло';

  @override
  String get taskTypeAppreciation => 'Appreciation';

  @override
  String get taskTypeCapture => 'Capture stones';

  @override
  String get taskTypeCaptureRace => 'Семеай';

  @override
  String get taskTypeEndgame => 'Йосе';

  @override
  String get taskTypeJoseki => 'Джосеки';

  @override
  String get taskTypeLifeAndDeath => 'Жизнь и смерть';

  @override
  String get taskTypeMiddlegame => 'Середина игры';

  @override
  String get taskTypeOpening => 'Фусеки';

  @override
  String get taskTypeTesuji => 'Тесуджи';

  @override
  String get taskTypeTheory => 'Теория';

  @override
  String get taskWrong => 'Неверно';

  @override
  String get tasksSolved => 'Задач решено';

  @override
  String get test => 'Тест';

  @override
  String get theme => 'Тема';

  @override
  String get thick => 'Thick';

  @override
  String get timeFrenzy => 'Time frenzy';

  @override
  String get timePerTask => 'Time per task';

  @override
  String get today => 'Сегодня';

  @override
  String get tooltipAnalyzeWithAISensei => 'Анализировать с AI Sensei';

  @override
  String get tooltipDownloadGame => 'Скачать партию';

  @override
  String get topic => 'Тема';

  @override
  String get topicExam => 'Topic exam';

  @override
  String get topics => 'Темы';

  @override
  String get train => 'Тренироваться';

  @override
  String get trainingAvgTimePerTask => 'Avg time per task';

  @override
  String get trainingFailed => 'Failed';

  @override
  String get trainingMistakes => 'Ошибки';

  @override
  String get trainingPassed => 'Passed';

  @override
  String get trainingTotalTime => 'Общее время';

  @override
  String get tryCustomMoves => 'Попробовать свои ходы';

  @override
  String get tygemDesc =>
      'Самый популярный сервер в Корее и один из самых популярных в мире.';

  @override
  String get tygemName => 'Tygem Baduk';

  @override
  String get type => 'Тип';

  @override
  String get ui => 'Интерфейс';

  @override
  String get userInfo => 'Информация о пользователе';

  @override
  String get username => 'Имя пользователя';

  @override
  String get voice => 'Голос';

  @override
  String get week => 'Неделя';

  @override
  String get white => 'Белые';

  @override
  String get yes => 'Да';
}
