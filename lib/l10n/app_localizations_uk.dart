// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get about => 'Про WeiqiHub';

  @override
  String get acceptDeadStones => 'Прийняти мертві камені';

  @override
  String get accuracy => 'Точність';

  @override
  String get aiReferee => 'Суддя-ШІ';

  @override
  String get aiSensei => 'AI Sensei';

  @override
  String get alwaysBlackToPlay => 'Завжди хід чорних';

  @override
  String get alwaysBlackToPlayDesc =>
      'Встановити перший хід чорних для усіх вправ, щоб уникнути плутанини';

  @override
  String get appearance => 'Оформлення';

  @override
  String get autoCounting => 'Авто-підрахунок';

  @override
  String get autoMatch => 'Авто-матч';

  @override
  String get behaviour => 'Поведінка';

  @override
  String get bestResult => 'Найкращий результат';

  @override
  String get black => 'Чорні';

  @override
  String get board => 'Дошка';

  @override
  String get boardSize => 'Розмір дошки';

  @override
  String get boardTheme => 'Тема дошки';

  @override
  String get byRank => 'За рангом';

  @override
  String get cancel => 'Скасувати';

  @override
  String get captures => 'Захоплення';

  @override
  String get clearBoard => 'Очистити';

  @override
  String get collectStats => 'Зібрати статистику';

  @override
  String get collections => 'Колекції';

  @override
  String get confirm => 'Підтвердити';

  @override
  String get confirmBoardSize => 'Підтвердити розмір дошки';

  @override
  String get confirmBoardSizeDesc =>
      'Дошки цього або більших розмірів вимагають підтвердження ходів';

  @override
  String get confirmMoves => 'Підтвердження ходів';

  @override
  String get confirmMovesDesc =>
      'Натискайте двічі, щоб підтвердити хід на великій дошці, щоб уникнути помилок';

  @override
  String get continue_ => 'Продовжити';

  @override
  String get copySGF => 'Скопіювати SGF';

  @override
  String get copyTaskLink => 'Скопіювати посилання на вправу';

  @override
  String get customExam => 'Користувацький тест';

  @override
  String get dark => 'Темна';

  @override
  String get dontShowAgain => 'Більше не показувати';

  @override
  String get download => 'Завантажити';

  @override
  String get edgeLine => 'Лінія краю дошки';

  @override
  String get empty => 'Пусто';

  @override
  String get endgameExam => 'Тест по йосе';

  @override
  String get enterTaskLink => 'Введіть посилання на вправу';

  @override
  String get errCannotBeEmpty => 'Не може бути порожнім';

  @override
  String get errFailedToDownloadGame => 'Не вдалося завантажити гру';

  @override
  String get errFailedToLoadGameList =>
      'Не вдалося завантажити список ігор. Спробуйте пізніше';

  @override
  String get errFailedToUploadGameToAISensei =>
      'Не вдалося завантажити гру на AI Sensei';

  @override
  String get errIncorrectUsernameOrPassword => 'Невірний логін або пароль';

  @override
  String errLoginFailedWithDetails(String message) {
    return 'Вхід не виконано: $message';
  }

  @override
  String get errNetworkError =>
      'Помилка мережі. Перевірте з\'єднання і спробуйте знову.';

  @override
  String errMustBeAtLeast(num n) {
    return 'Повинно бути не менше $n';
  }

  @override
  String errMustBeAtMost(num n) {
    return 'Повинно бути не більше $n';
  }

  @override
  String get errMustBeInteger => 'Повинно бути цілим числом';

  @override
  String get exit => 'Вийти';

  @override
  String get exitTryMode => 'Вийти з режиму пробних ходів';

  @override
  String get find => 'Знайти';

  @override
  String get findTask => 'Знайти вправу';

  @override
  String get findTaskByLink => 'По посиланню';

  @override
  String get findTaskByPattern => 'По позиції';

  @override
  String get findTaskResults => 'Результати пошуку';

  @override
  String get findTaskSearching => 'Шукаю...';

  @override
  String get forceCounting => 'Примусовий підрахунок';

  @override
  String get foxwqDesc => 'Найпопулярніший сервер у Китаї і світі.';

  @override
  String get foxwqName => 'Fox Weiqi';

  @override
  String get gameInfo => 'Інформація про гру';

  @override
  String get gameRecord => 'Запис гри';

  @override
  String get gradingExam => 'Контрольний тест';

  @override
  String get handicap => 'Фора';

  @override
  String get help => 'Допомога';

  @override
  String get helpDialogCollections =>
      'Колекції - це класичні, ретельно відібрані набори високоякісних завдань, які надзвичайно корисні для тренування.\nГоловна мета - розв’язати колекцію з високою успішністю. Друга мета - зробити це якомога швидше.\nЩоб розпочати або продовжити розв’язування колекції, проведіть по плитці колекції ліворуч у портретному режимі або натисніть кнопки Почати / Продовжити у ландшафтному режимі.';

  @override
  String get helpDialogEndgameExam =>
      '- Тести по йосе - це набори з 10 вправ, на які виділяється 45 секунд на вправу.\n\n- Ви успішно проходите тест, якщо правильно вирішуєте 8 чи більше (80% успішність).\n\n- Прохдження тесту на певний ранг відкриває дотуп до тесту на наступний ранг.';

  @override
  String get helpDialogGradingExam =>
      '- Контрольний тест — це набір 10 вправ, на які виділяється по 45 секунд на вправу.\n\n- Ви успішно проходите тест, якщо правильно вирішуєте 8 чи більше (80% успішність).\n\n- Прохдження тесту на певний ранг відкриває дотуп до тесту на наступний ранг.';

  @override
  String get helpDialogRankedMode =>
      '- Розв\'язуйте вправи без часових обмежень.\n\n- Склідність вправ росте в залежності від того як швидко ви їх вирішуєте.\n\n- Зосередьтесь на правильних відповідях і досягніть максимально можливого рангу.';

  @override
  String get helpDialogTimeFrenzy =>
      '- У вас є 3 хвилини, щоб вирішити щонайбільше вправ.\n\n- Склідність вправ росте в процесі розв\'язання.\n\n- Якщо зробите три помилки - ви програєте.';

  @override
  String get home => 'Головна';

  @override
  String get komi => 'Комі';

  @override
  String get language => 'Мова';

  @override
  String get leave => 'Залишити';

  @override
  String get light => 'Світла';

  @override
  String get login => 'Увійти';

  @override
  String get logout => 'Вийти';

  @override
  String get long => 'Довга';

  @override
  String mMinutes(int m) {
    return '$m хв.';
  }

  @override
  String get maxNumberOfMistakes => 'Максимальна кількість помилок';

  @override
  String get maxRank => 'Макс. ранг';

  @override
  String get medium => 'Середня';

  @override
  String get minRank => 'Мін. ранг';

  @override
  String get minutes => 'Хвилини';

  @override
  String get month => 'Місяць';

  @override
  String get msgCannotUseAIRefereeYet =>
      'Поки що не можна використовувати ШІ-суддю';

  @override
  String get msgCannotUseForcedCountingYet =>
      'Поки що не можна використовувати примусовий підрахунок';

  @override
  String get msgConfirmDeleteCollectionProgress =>
      'Ви впевнені, що хочете почати колекцію заново? Поточний прогрес буде втрачено.';

  @override
  String get msgConfirmResignation => 'Ви впевнені, що хочете здатися';

  @override
  String msgConfirmStopEvent(String event) {
    return 'Ви впевнені, що хочете зупинити $event?';
  }

  @override
  String get msgDownloadingGame => 'Гра завантажується';

  @override
  String msgGameSavedTo(String path) {
    return 'Гру збережено в $path';
  }

  @override
  String get msgPleaseWaitForYourTurn => 'Будь-ласка, зачекайте на ваш хід';

  @override
  String get msgSearchingForGame => 'Шукаю на гру...';

  @override
  String get msgSgfCopied => 'SGF скопійовано в буфер обміну';

  @override
  String get msgTaskLinkCopied => 'Посилання на вправу скопійовано.';

  @override
  String get msgWaitingForOpponentsDecision => 'Чекаємо на рішення опонента...';

  @override
  String get msgYouCannotPass => 'Ви не можете пропустити хід';

  @override
  String get msgYourOpponentDisagreesWithCountingResult =>
      'Опонент не погоджується із результатом підрахунку';

  @override
  String get msgYourOpponentRefusesToCount =>
      'Опонент відмовляється від підрахунку';

  @override
  String get msgYourOpponentRequestsAutomaticCounting =>
      'Опонент запитує на автоматичний підрахунок. Погоджуєтесь?';

  @override
  String get myGames => 'Мої ігри';

  @override
  String get myMistakes => 'Мої помилки';

  @override
  String nTasks(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString вправ',
      one: '1 вправа доступна',
      zero: 'Немає вправ',
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
      other: '$countString вправ доступно',
      one: '1 вправа доступна',
      zero: 'Немає доступних вправ',
    );
    return '$_temp0';
  }

  @override
  String get newBestResult => 'Новий рекорд!';

  @override
  String get no => 'Ні';

  @override
  String get none => 'Немає';

  @override
  String get numberOfTasks => 'Кількість вправ';

  @override
  String nxnBoardSize(int n) {
    return '$n×$n';
  }

  @override
  String get ogsDesc =>
      'Міжнародний сервер, найпопулярніший в Європі та Америці.';

  @override
  String get ogsName => 'Online Go Server';

  @override
  String get ok => 'ОК';

  @override
  String get pass => 'Пас';

  @override
  String get password => 'Пароль';

  @override
  String get play => 'Грати';

  @override
  String get pleaseMarkDeadStones => 'Будь-ласка, позначте мертві камені.';

  @override
  String get promotionRequirements => 'Вимоги для підвищення';

  @override
  String pxsByoyomi(int p, int s) {
    return '$p×${s}s';
  }

  @override
  String get rank => 'Ранг';

  @override
  String get rankedMode => 'З рейтингом';

  @override
  String get recentRecord => 'Отсанні результати';

  @override
  String get register => 'Зареєструватися';

  @override
  String get rejectDeadStones => 'Відхилити мертві камені';

  @override
  String get resign => 'Здатися';

  @override
  String get responseDelay => 'Затримка відповіді';

  @override
  String get responseDelayDesc =>
      'Час затримки перед тим як з\'явиться відповідь під час вирішення вправ';

  @override
  String get responseDelayLong => 'Довга';

  @override
  String get responseDelayMedium => 'Середня';

  @override
  String get responseDelayNone => 'Відсутня';

  @override
  String get responseDelayShort => 'Коротка';

  @override
  String get result => 'Результат';

  @override
  String get resultAccept => 'Прийняти';

  @override
  String get resultReject => 'Відмовити';

  @override
  String get rules => 'Правила';

  @override
  String get rulesChinese => 'Китайські';

  @override
  String get rulesJapanese => 'Японські';

  @override
  String get rulesKorean => 'Корейські';

  @override
  String sSeconds(int s) {
    return '${s}s';
  }

  @override
  String get save => 'Зберегти';

  @override
  String get saveSGF => 'Зберегти SGF';

  @override
  String get seconds => 'Секунди';

  @override
  String get settings => 'Налаштування';

  @override
  String get short => 'Короткий';

  @override
  String get showCoordinates => 'Відображати координати';

  @override
  String get showMoveErrorsAsCrosses => 'Позначати невірні ходи хрестиком';

  @override
  String get showMoveErrorsAsCrossesDesc =>
      'Відображати невірні ходи як червоними хрестиками замість червоних крапок';

  @override
  String get simple => 'Проста';

  @override
  String get sortModeDifficult => 'Складні';

  @override
  String get sortModeRecent => 'Нещодавні';

  @override
  String get sound => 'Звук';

  @override
  String get start => 'Почати';

  @override
  String get statistics => 'Статистика';

  @override
  String get statsDateColumn => 'Дата';

  @override
  String get statsDurationColumn => 'Тривалість';

  @override
  String get statsTimeColumn => 'Час';

  @override
  String get stoneShadows => 'Тіні в каменів';

  @override
  String get stones => 'Камені';

  @override
  String get subtopic => 'Підтема';

  @override
  String get system => 'Система';

  @override
  String get task => 'Вправа';

  @override
  String get taskCorrect => 'Правильно';

  @override
  String get taskNext => 'Наступна';

  @override
  String get taskNotFound => 'Вправа не знайдена';

  @override
  String get taskRedo => 'Переробити';

  @override
  String get taskSource => 'Джерело вправи';

  @override
  String get taskSourceFromMyMistakes => 'Із моїх помилок';

  @override
  String get taskSourceFromTaskTopic => 'Із теми вправ';

  @override
  String get taskSourceFromTaskTypes => 'Із типів вправ';

  @override
  String get taskTag_afterJoseki => 'Після джосекі';

  @override
  String get taskTag_aiOpening => 'ШІ фусекі';

  @override
  String get taskTag_aiVariations => 'ШІ варіанти';

  @override
  String get taskTag_attack => 'Атака';

  @override
  String get taskTag_attackAndDefenseInKo => 'Атака і захист в ko';

  @override
  String get taskTag_attackAndDefenseOfCuts => 'Атака і захист розрізів';

  @override
  String get taskTag_attackAndDefenseOfInvadingStones =>
      'Атака і захист при вторгненні';

  @override
  String get taskTag_avoidKo => 'Уникнення ко';

  @override
  String get taskTag_avoidMakingDeadShape =>
      'Уникнення створення мертвої форми';

  @override
  String get taskTag_avoidTrap => 'Уникнення пасток';

  @override
  String get taskTag_basicEndgame => 'Йосе: основи';

  @override
  String get taskTag_basicLifeAndDeath => 'Життя та смерть: основи';

  @override
  String get taskTag_basicMoves => 'Базові прийоми';

  @override
  String get taskTag_basicTesuji => 'Тесуджі';

  @override
  String get taskTag_beginner => 'Для початківців';

  @override
  String get taskTag_bend => 'Загибання';

  @override
  String get taskTag_bentFour => 'Загнута четвірка';

  @override
  String get taskTag_bentFourInTheCorner => 'Загнута четвірка в куті';

  @override
  String get taskTag_bentThree => 'Загнута трійка';

  @override
  String get taskTag_bigEyeLiberties => 'Дихання у великих очка';

  @override
  String get taskTag_bigEyeVsSmallEye => 'Велике око проти малого ока';

  @override
  String get taskTag_bigPoints => 'Великій пункт';

  @override
  String get taskTag_blindSpot => 'Сліпа пляма';

  @override
  String get taskTag_breakEye => 'Знищення ока';

  @override
  String get taskTag_breakEyeInOneStep => 'Знищення ока в один хід';

  @override
  String get taskTag_breakEyeInSente => 'Знищення ока в сенте';

  @override
  String get taskTag_breakOut => 'Прорив';

  @override
  String get taskTag_breakPoints => 'Пункти розриву';

  @override
  String get taskTag_breakShape => 'Знищення форми';

  @override
  String get taskTag_bridgeUnder => 'З\'єднання знизу';

  @override
  String get taskTag_brilliantSequence => 'Блискуча послідовність';

  @override
  String get taskTag_bulkyFive => 'Форма-автомобіль';

  @override
  String get taskTag_bump => 'Удар';

  @override
  String get taskTag_captureBySnapback => 'Захоплення в мишоловку';

  @override
  String get taskTag_captureInLadder => 'Захоплення в сходи';

  @override
  String get taskTag_captureInOneMove => 'Захоплення в один хід';

  @override
  String get taskTag_captureOnTheSide => 'Захоплення на стороні';

  @override
  String get taskTag_captureToLive => 'Захоплення щоб жити';

  @override
  String get taskTag_captureTwoRecaptureOne => 'Захопити два, поверни один';

  @override
  String get taskTag_capturingRace => 'Семеай';

  @override
  String get taskTag_capturingTechniques => 'Техніки захоплення';

  @override
  String get taskTag_carpentersSquareAndSimilar =>
      'Столярний кутник і подібні форми';

  @override
  String get taskTag_chooseTheFight => 'Обери свій бій';

  @override
  String get taskTag_clamp => 'Лещата';

  @override
  String get taskTag_clampCapture => 'Захоплення лещатами';

  @override
  String get taskTag_closeInCapture => 'Захоплення оточенням';

  @override
  String get taskTag_combination => 'Комбінація';

  @override
  String get taskTag_commonLifeAndDeath => 'Життя та смерть: основні форми';

  @override
  String get taskTag_compareSize => 'Порівняння розміру';

  @override
  String get taskTag_compareValue => 'Порівняння цінності';

  @override
  String get taskTag_completeKoToSecureEndgameAdvantage =>
      'Завершення ко для отримання переваги в йосе';

  @override
  String get taskTag_compositeProblems => 'Складені вправи';

  @override
  String get taskTag_comprehensiveTasks => 'Комплексні вправи';

  @override
  String get taskTag_connect => 'З\'єднання';

  @override
  String get taskTag_connectAndDie => 'З\'єднання і смерть';

  @override
  String get taskTag_connectInOneMove => 'З\'єднання за один хід';

  @override
  String get taskTag_contactFightTesuji => 'Тесуджі контактної боротьби';

  @override
  String get taskTag_contactPlay => 'Контактна гра';

  @override
  String get taskTag_corner => 'Кут';

  @override
  String get taskTag_cornerIsGoldSideIsSilverCenterIsGrass =>
      'Кут — золото, сторона — срібло, центр — зілля';

  @override
  String get taskTag_counter => 'Контрудар';

  @override
  String get taskTag_counterAttack => 'Контратака';

  @override
  String get taskTag_cranesNest => 'Журавлине гніздо';

  @override
  String get taskTag_crawl => 'Проповзання';

  @override
  String get taskTag_createShortageOfLiberties => 'Створення нестачи дихань';

  @override
  String get taskTag_crossedFive => 'Перехресна п\'ятірка';

  @override
  String get taskTag_cut => 'Розділення';

  @override
  String get taskTag_cut2 => 'Розділення';

  @override
  String get taskTag_cutAcross => 'Розділення поперек';

  @override
  String get taskTag_defendFromInvasion => 'Захист від вторгнення';

  @override
  String get taskTag_defendPoints => 'Захист очків';

  @override
  String get taskTag_defendWeakPoint => 'Захист слабкого пункта';

  @override
  String get taskTag_descent => 'Спуск';

  @override
  String get taskTag_diagonal => 'Косумі';

  @override
  String get taskTag_directionOfCapture => 'Напрямок захоплення';

  @override
  String get taskTag_directionOfEscape => 'Напрямок втечі';

  @override
  String get taskTag_directionOfPlay => 'Напрямок гри';

  @override
  String get taskTag_doNotUnderestimateOpponent => 'Не недооцінюйте суперника';

  @override
  String get taskTag_doubleAtari => 'Подвійне атарі';

  @override
  String get taskTag_doubleCapture => 'Подвійне захоплення';

  @override
  String get taskTag_doubleKo => 'Подвійне ко';

  @override
  String get taskTag_doubleSenteEndgame => 'Подвійне сенте в йосе';

  @override
  String get taskTag_doubleSnapback => 'Подвійна мишоловка';

  @override
  String get taskTag_endgame => 'Йосе: загальне';

  @override
  String get taskTag_endgameFundamentals => 'Йосе: основи';

  @override
  String get taskTag_endgameIn5x5 => 'Йосе на 5x5';

  @override
  String get taskTag_endgameOn4x4 => 'Йосе на 4x4';

  @override
  String get taskTag_endgameTesuji => 'Йосе тесуджі';

  @override
  String get taskTag_engulfingAtari => 'Оточуюче атарі';

  @override
  String get taskTag_escape => 'Втеча';

  @override
  String get taskTag_escapeInOneMove => 'Втеча в один хід';

  @override
  String get taskTag_exploitShapeWeakness => 'Використання слабкостей форми';

  @override
  String get taskTag_eyeVsNoEye => 'Око проти відсутності ока';

  @override
  String get taskTag_fillNeutralPoints => 'Заповнення нейтральних пунктів';

  @override
  String get taskTag_findTheRoot => 'Знайти корінь';

  @override
  String get taskTag_firstLineBrilliantMove => 'Блискучі ходи на першій лінії';

  @override
  String get taskTag_flowerSix => 'Квіткова шістка';

  @override
  String get taskTag_goldenChickenStandingOnOneLeg =>
      'Золотий півник на одній нозі';

  @override
  String get taskTag_groupLiberties => 'Дихання групи';

  @override
  String get taskTag_groupsBase => 'База групи';

  @override
  String get taskTag_hane => 'Хане';

  @override
  String get taskTag_increaseEyeSpace => 'Збільшення місця для очей';

  @override
  String get taskTag_increaseLiberties => 'Збільшення дихань';

  @override
  String get taskTag_indirectAttack => 'Непряма атака';

  @override
  String get taskTag_influenceKeyPoints => 'Ключові пункти впливу';

  @override
  String get taskTag_insideKill => 'Вбити зсередини';

  @override
  String get taskTag_insideMoves => 'Ходи зсередини';

  @override
  String get taskTag_interestingTasks => 'Цікаві вправи';

  @override
  String get taskTag_internalLibertyShortage => 'Внутрішня нестача дихань';

  @override
  String get taskTag_invadingTechnique => 'Техніки вторгнення';

  @override
  String get taskTag_invasion => 'Вторгнення';

  @override
  String get taskTag_jGroupAndSimilar => 'Група-J і схожі на неї';

  @override
  String get taskTag_josekiFundamentals => 'Основи джосекі';

  @override
  String get taskTag_jump => 'Стрибок';

  @override
  String get taskTag_keepSente => 'Утримання сенте';

  @override
  String get taskTag_killAfterCapture => 'Вбивство після захоплення';

  @override
  String get taskTag_killByEyePointPlacement => 'Вбивство ходом в пункт ока';

  @override
  String get taskTag_knightsMove => 'Хід кейма';

  @override
  String get taskTag_ko => 'Ко';

  @override
  String get taskTag_kosumiWedge => 'Вклинювання кыосумі';

  @override
  String get taskTag_largeKnightsMove => 'Хід огейма (довга кейма)';

  @override
  String get taskTag_largeMoyoFight => 'Бій за велике мойо';

  @override
  String get taskTag_lifeAndDeath => 'Життя та смерть: загальні';

  @override
  String get taskTag_lifeAndDeathOn4x4 => 'Життя та смерть на дошці 4x4';

  @override
  String get taskTag_lookForLeverage => 'Пошук важелів тиску';

  @override
  String get taskTag_looseLadder => 'Відкриті сходи';

  @override
  String get taskTag_lovesickCut => 'Відокремлення закоханих';

  @override
  String get taskTag_makeEye => 'Створення ока';

  @override
  String get taskTag_makeEyeInOneStep => 'Створення ока за один хід';

  @override
  String get taskTag_makeEyeInSente => 'Створення ока в сенте';

  @override
  String get taskTag_makeKo => 'Створення ко';

  @override
  String get taskTag_makeShape => 'Створення форми';

  @override
  String get taskTag_middlegame => 'Середина гри';

  @override
  String get taskTag_monkeyClimbingMountain => 'Мавпа, що видирається на гору';

  @override
  String get taskTag_mouseStealingOil => 'Мишеня краде масло';

  @override
  String get taskTag_moveOut => 'Втеча';

  @override
  String get taskTag_moveTowardsEmptySpace => 'Рух до порожнього місця';

  @override
  String get taskTag_multipleBrilliantMoves => 'Декілька блискучих ходів';

  @override
  String get taskTag_net => 'Тенета (ґета)';

  @override
  String get taskTag_netCapture => 'Захоплення ґетою';

  @override
  String get taskTag_observeSubtleDifference => 'Знаходження тонкої різниці';

  @override
  String get taskTag_occupyEncloseAndApproachCorner =>
      'Зайняти, оточити та наблизитись до кута';

  @override
  String get taskTag_oneStoneTwoPurposes => 'Один камінь — дві цілі';

  @override
  String get taskTag_opening => 'Фусекі';

  @override
  String get taskTag_openingChoice => 'Вибір фусекі';

  @override
  String get taskTag_openingFundamentals => 'Основи фусекі';

  @override
  String get taskTag_orderOfEndgameMoves => 'Послідовність ходів в йосе';

  @override
  String get taskTag_orderOfMoves => 'Послідовність ходів';

  @override
  String get taskTag_orderOfMovesInKo => 'Послідовність ходів в ко';

  @override
  String get taskTag_orioleCapturesButterfly =>
      'Жовта плиска впіймала метелика';

  @override
  String get taskTag_pincer => 'Взяття в кліщі';

  @override
  String get taskTag_placement => 'Вторгнення';

  @override
  String get taskTag_plunderingTechnique => 'Грабіжницький прийом';

  @override
  String get taskTag_preventBambooJoint => 'Запобігання з\'єднанню бамбук';

  @override
  String get taskTag_preventBridgingUnder => 'Запобігання з\'єднанню знизу';

  @override
  String get taskTag_preventOpponentFromApproaching =>
      'Запобігання наближення опонента';

  @override
  String get taskTag_probe => 'Пробний хід';

  @override
  String get taskTag_profitInSente => 'Прибуток у сенте';

  @override
  String get taskTag_profitUsingLifeAndDeath =>
      'Прибуток використовуючі життя та смерть';

  @override
  String get taskTag_push => 'Протискування';

  @override
  String get taskTag_pyramidFour => 'Піраміда з чотирьох';

  @override
  String get taskTag_realEyeAndFalseEye => 'Справжнє око проти фальшивого';

  @override
  String get taskTag_rectangularSix => 'Прямокутна шістка';

  @override
  String get taskTag_reduceEyeSpace => 'Зменшення місця для очей';

  @override
  String get taskTag_reduceLiberties => 'Зменшення диханнь';

  @override
  String get taskTag_reduction => 'Зменшення';

  @override
  String get taskTag_runWeakGroup => 'Втеча слабкої групи';

  @override
  String get taskTag_sabakiAndUtilizingInfluence =>
      'Сабакі та використання впливу';

  @override
  String get taskTag_sacrifice => 'Жертва';

  @override
  String get taskTag_sacrificeAndSqueeze => 'Жертва і стиснення';

  @override
  String get taskTag_sealIn => 'Ув\'язнення';

  @override
  String get taskTag_secondLine => 'Друга лінія';

  @override
  String get taskTag_seizeTheOpportunity => 'Використання можливостей';

  @override
  String get taskTag_seki => 'Секі';

  @override
  String get taskTag_senteAndGote => 'Сенте і готе';

  @override
  String get taskTag_settleShape => 'Стабілізація форми';

  @override
  String get taskTag_settleShapeInSente => 'Стабілізація форми в сенте';

  @override
  String get taskTag_shape => 'Форма';

  @override
  String get taskTag_shapesVitalPoint => 'Критичний пункт форми';

  @override
  String get taskTag_side => 'Сторона';

  @override
  String get taskTag_smallBoardEndgame => 'Йосе на маленькій дошці';

  @override
  String get taskTag_snapback => 'Мишоловка';

  @override
  String get taskTag_solidConnection => 'Надійне з\'єднення';

  @override
  String get taskTag_solidExtension => 'Надійне розширення';

  @override
  String get taskTag_splitInOneMove => 'Розділення за один хід';

  @override
  String get taskTag_splittingMove => 'Хід для розділення';

  @override
  String get taskTag_squareFour => 'Квадратна четвірка';

  @override
  String get taskTag_squeeze => 'Стиснення';

  @override
  String get taskTag_standardCapturingRaces => 'Стандартні семеаї';

  @override
  String get taskTag_standardCornerAndSideEndgame =>
      'Стандартне йосе в куті та на стороні';

  @override
  String get taskTag_straightFour => 'Чотири в лінію';

  @override
  String get taskTag_straightThree => 'Три в лінію';

  @override
  String get taskTag_surroundTerritory => 'Оточення території';

  @override
  String get taskTag_symmetricShape => 'Симетрична форма';

  @override
  String get taskTag_techniqueForReinforcingGroups => 'Техніка посилення груп';

  @override
  String get taskTag_techniqueForSecuringTerritory =>
      'Техніка отримання території';

  @override
  String get taskTag_textbookTasks => 'Вправи з підручників';

  @override
  String get taskTag_thirdAndFourthLine => 'Третя та четверта лінія';

  @override
  String get taskTag_threeEyesTwoActions => 'Три ока, два хода';

  @override
  String get taskTag_threeSpaceExtensionFromTwoStones =>
      'Розширення на три пункти від двох каменів';

  @override
  String get taskTag_throwIn => 'Накаде';

  @override
  String get taskTag_tigersMouth => 'Паща тигра';

  @override
  String get taskTag_tombstoneSqueeze => 'Стисання кам\'яної пагоди';

  @override
  String get taskTag_tripodGroupWithExtraLegAndSimilar =>
      'Тринога група з додатковою ногою і подібні';

  @override
  String get taskTag_twoHaneGainOneLiberty => 'Подвійне хане дає одне даме';

  @override
  String get taskTag_twoHeadedDragon => 'Двоголовий дракон';

  @override
  String get taskTag_twoSpaceExtension => 'Розширення на два пункти';

  @override
  String get taskTag_typesOfKo => 'Типи ко';

  @override
  String get taskTag_underTheStones => 'Під каменями';

  @override
  String get taskTag_underneathAttachment => 'Прилипання знизу';

  @override
  String get taskTag_urgentPointOfAFight => 'Терміновий пункт в боротьбі';

  @override
  String get taskTag_urgentPoints => 'Термінові пункти';

  @override
  String get taskTag_useConnectAndDie => 'З\'єднання і смерть';

  @override
  String get taskTag_useCornerSpecialProperties =>
      'Використання спеціальних властивостей кута';

  @override
  String get taskTag_useDescentToFirstLine =>
      'Використання спуску на першу лінію';

  @override
  String get taskTag_useInfluence => 'Використання вплива';

  @override
  String get taskTag_useOpponentsLifeAndDeath =>
      'Використання життя та смерті опонента';

  @override
  String get taskTag_useShortageOfLiberties => 'Використання дамедзумарі';

  @override
  String get taskTag_useSnapback => 'Використання мишоловки';

  @override
  String get taskTag_useSurroundingStones => 'Використання оточуючих каменів';

  @override
  String get taskTag_vitalAndUselessStones => 'Критичне і непотрібні камені';

  @override
  String get taskTag_vitalPointForBothSides =>
      'Критичний пункт для обох сторін';

  @override
  String get taskTag_vitalPointForCapturingRace => 'Критичний пункт для семеай';

  @override
  String get taskTag_vitalPointForIncreasingLiberties =>
      'Критичний пункт для збільшення дихань';

  @override
  String get taskTag_vitalPointForKill => 'Критичний пункт для вбивства';

  @override
  String get taskTag_vitalPointForLife => 'Критичний пункт для життя';

  @override
  String get taskTag_vitalPointForReducingLiberties =>
      'Критичний пункт для зменшення дихань';

  @override
  String get taskTag_wedge => 'Вклинювання';

  @override
  String get taskTag_wedgingCapture => 'Захоплення вклинюванням';

  @override
  String get taskTimeout => 'Час вийшло';

  @override
  String get taskTypeAppreciation => 'Оцінка позиції';

  @override
  String get taskTypeCapture => 'Захоплення каменів';

  @override
  String get taskTypeCaptureRace => 'Семеай';

  @override
  String get taskTypeEndgame => 'Йосе';

  @override
  String get taskTypeJoseki => 'Джосекі';

  @override
  String get taskTypeLifeAndDeath => 'Життя та смерть';

  @override
  String get taskTypeMiddlegame => 'Середина гри';

  @override
  String get taskTypeOpening => 'Фусекі';

  @override
  String get taskTypeTesuji => 'Тесуджі';

  @override
  String get taskTypeTheory => 'Теорія';

  @override
  String get taskWrong => 'Невірно';

  @override
  String get tasksSolved => 'Вправ вирішено';

  @override
  String get test => 'Тест';

  @override
  String get theme => 'Тема';

  @override
  String get thick => 'Товста';

  @override
  String get timeFrenzy => 'Часове шаленство';

  @override
  String get timeFrenzyMistakes =>
      'Відслітковувати помилки у Часовому шаленстві';

  @override
  String get timeFrenzyMistakesDesc =>
      'Увімкнути збереження помилок зробленими в Часовому шаленстві';

  @override
  String get randomizeTaskOrientation =>
      'Випадково згенерована орієнтація діаграм';

  @override
  String get randomizeTaskOrientationDesc =>
      'Випадково повертає діаграми вправ по горизонталі, вертакалі чи діагоналі, щоб ускладнити запам\'ятовування і покращити розпізнавання паттернів.';

  @override
  String get timePerTask => 'Час на вправу';

  @override
  String get today => 'Сьогодні';

  @override
  String get tooltipAnalyzeWithAISensei => 'Аналізувати з AI Sensei';

  @override
  String get tooltipDownloadGame => 'Завантажити гру';

  @override
  String get topic => 'Тема';

  @override
  String get topicExam => 'Тематичний тест';

  @override
  String get topics => 'Теми';

  @override
  String get train => 'Тренуватися';

  @override
  String get trainingAvgTimePerTask => 'Середній час на вправу';

  @override
  String get trainingFailed => 'Не пройдено';

  @override
  String get trainingMistakes => 'Помилки';

  @override
  String get trainingPassed => 'Пройдено';

  @override
  String get trainingTotalTime => 'Загальний час';

  @override
  String get tryCustomMoves => 'Спробувати власні ходи';

  @override
  String get tygemDesc =>
      'Найпопулрніший сервер в Кореї і один з найпопулярніших в світі.';

  @override
  String get tygemName => 'Tygem Baduk';

  @override
  String get type => 'Тип';

  @override
  String get ui => 'Інтерфейс';

  @override
  String get userInfo => 'Інформація про користувача';

  @override
  String get username => 'Ім\'я користувача';

  @override
  String get voice => 'Голос';

  @override
  String get week => 'Тиждень';

  @override
  String get white => 'Білі';

  @override
  String get yes => 'Так';
}
