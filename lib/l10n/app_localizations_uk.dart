// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get analysis => 'Аналіз';

  @override
  String get winrate => 'Шанс на перемогу';

  @override
  String get scoreLead => 'Перевага в очках';

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
  String get avgRank => 'Сер. ранг';

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
  String get byType => 'За типом';

  @override
  String get cancel => 'Скасувати';

  @override
  String get captures => 'Захоплення';

  @override
  String get chartTitleCorrectCount => 'Правильні відповіді';

  @override
  String get chartTitleExamCompletionTime => 'Час виконання';

  @override
  String get charts => 'Графіки';

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
  String get deleteCorrectlySolvedMistakes =>
      'Remove correctly solved mistakes';

  @override
  String get deleteCorrectlySolvedMistakesDesc =>
      'Remove previous mistakes if solved correctly later';

  @override
  String get deselectAll => 'Зняти виділення';

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
  String get errNetworkError =>
      'Помилка мережі. Перевірте з\'єднання і спробуйте знову.';

  @override
  String get error => 'Помилка';

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
  String get fullscreen => 'Повний екран';

  @override
  String get fullscreenDesc =>
      'Показувати додаток у повноекранному режимі. Для застосування цього параметра необхідно перезапустити додаток.';

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
  String get hidePlayerRanks => 'Приховати ранги гравців';

  @override
  String get hidePlayerRanksDesc =>
      'Приховувати ранги в лобі сервера та під час гри';

  @override
  String get helpDialogCollections =>
      'Колекції - це класичні, ретельно відібрані набори високоякісних завдань, які надзвичайно корисні для тренування.\nГоловна мета - розв’язати колекцію з високою успішністю. Друга мета - зробити це якомога швидше.';

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
  String get maxChartPoints => 'Макс. точок';

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
  String get msgConfirmDeletePreset => 'Видалити цей шаблон?';

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
  String get msgPresetAlreadyExists => 'Шаблон з такою назвою вже існує.';

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
  String get perTask => 'на вправу';

  @override
  String get play => 'Грати';

  @override
  String get pleaseMarkDeadStones => 'Будь-ласка, позначте мертві камені.';

  @override
  String get presetName => 'Назва шаблону';

  @override
  String get presets => 'Шаблони';

  @override
  String get promotionRequirements => 'Вимоги для підвищення';

  @override
  String pxsByoyomi(int p, int s) {
    return '$p×${s}s';
  }

  @override
  String get randomizeTaskOrientation =>
      'Випадково згенерована орієнтація діаграм';

  @override
  String get randomizeTaskOrientationDesc =>
      'Випадково повертає діаграми вправ по горизонталі, вертакалі чи діагоналі, щоб ускладнити запам\'ятовування і покращити розпізнавання паттернів.';

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
  String get savePreset => 'Зберегти шаблон';

  @override
  String get saveSGF => 'Зберегти SGF';

  @override
  String get seconds => 'Секунди';

  @override
  String get selectAll => 'Вибрати все';

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
