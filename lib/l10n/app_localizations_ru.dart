// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get analysis => 'Анализ';

  @override
  String get winrate => 'Шанс на победу';

  @override
  String get scoreLead => 'Преимущество в очках';

  @override
  String get about => 'О приложении';

  @override
  String get acceptDeadStones => 'Принять мёртвые камни';

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
  String get appearance => 'Интерфейс';

  @override
  String get autoCounting => 'Автоподсчёт';

  @override
  String get autoMatch => 'Автоподбор';

  @override
  String get avgRank => 'Средн. ранг';

  @override
  String get behaviour => 'Поведение';

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
  String get byType => 'По типу';

  @override
  String get cancel => 'Отмена';

  @override
  String get captures => 'Захваты';

  @override
  String get chartTitleCorrectCount => 'Правильные ответы';

  @override
  String get chartTitleExamCompletionTime => 'Время выполнения';

  @override
  String get charts => 'Графики';

  @override
  String get clearBoard => 'Очистить';

  @override
  String get collectStats => 'Добавлять в статистику';

  @override
  String get collections => 'Коллекции';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get confirmBoardSize => 'Минимальный размер доски';

  @override
  String get confirmBoardSizeDesc =>
      'Подтверждение ходов требуется для досок этого размера и больше';

  @override
  String get confirmMoves => 'Подтверждение ходов';

  @override
  String get confirmMovesDesc =>
      'Двойное нажатие на один и тот же пункт для подтверждения хода, чтобы избежать случайных нажатий';

  @override
  String get continue_ => 'Продолжить';

  @override
  String get copySGF => 'Копировать SGF';

  @override
  String get copyTaskLink => 'Копировать ссылку на задачу';

  @override
  String get customExam => 'Пользовательский экзамен';

  @override
  String get dark => 'Тёмная';

  @override
  String get deselectAll => 'Снять выделение';

  @override
  String get dontShowAgain => 'Больше не показывать';

  @override
  String get download => 'Скачать';

  @override
  String get edgeLine => 'Линия края';

  @override
  String get empty => 'Пусто';

  @override
  String get endgameExam => 'Экзамены по йосе';

  @override
  String get enterTaskLink => 'Введите ссылку на задачу';

  @override
  String get errCannotBeEmpty => 'Обязательное поле';

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
  String errLoginFailedWithDetails(String message) {
    return 'Вход не выполнен: $message';
  }

  @override
  String errMustBeAtLeast(num n) {
    return 'Должно быть не менее $n';
  }

  @override
  String errMustBeAtMost(num n) {
    return 'Должно быть не более $n';
  }

  @override
  String get errMustBeInteger => 'Должно быть целым числом';

  @override
  String get errNetworkError =>
      'Ошибка сети. Проверьте подключение и попробуйте снова.';

  @override
  String get error => 'Ошибка';

  @override
  String get exit => 'Выход';

  @override
  String get exitTryMode => 'Выйти из режима пробных ходов';

  @override
  String get find => 'Найти';

  @override
  String get findTask => 'Найти задачу';

  @override
  String get findTaskByLink => 'По ссылке';

  @override
  String get findTaskByPattern => 'По позиции';

  @override
  String get findTaskResults => 'Результаты поиска';

  @override
  String get findTaskSearching => 'Поиск...';

  @override
  String get forceCounting => 'Принудительный подсчёт';

  @override
  String get foxwqDesc => 'Самый популярный сервер в Китае и в мире.';

  @override
  String get foxwqName => 'Фокс Вэйци';

  @override
  String get fullscreen => 'Полный экран';

  @override
  String get fullscreenDesc =>
      'Показывать приложение в полноэкранном режиме. Для применения настройки необходимо перезапустить приложение.';

  @override
  String get gameInfo => 'Информация о партии';

  @override
  String get gameRecord => 'Запись партии';

  @override
  String get gradingExam => 'Контрольный экзамен';

  @override
  String get handicap => 'Фора';

  @override
  String get help => 'Помощь';

  @override
  String get hidePlayerRanks => 'Скрыть ранги игроков';

  @override
  String get hidePlayerRanksDesc =>
      'Скрывать ранги в лобби сервера и во время игры';

  @override
  String get helpDialogCollections =>
      'Коллекции — это классические, тщательно отобранные наборы высококачественных задач, которые вместе представляют особую ценность как учебный ресурс.\n\nОсновная цель — решить коллекцию с высоким процентом успеха. Вторичная цель — решить её как можно быстрее.';

  @override
  String get helpDialogEndgameExam =>
      '- Экзамены по йосе — это наборы из 10 задач по йосе, и у вас есть 45 секунд на каждую задачу.\n\n- Вы сдаёте экзамен, если решаете 8 или более задач правильно (80% успеха).\n\n- Сдача экзамена для данного ранга открывает экзамен для следующего ранга.';

  @override
  String get helpDialogGradingExam =>
      '- Контрольные экзамены — это наборы из 10 задач, и у вас есть 45 секунд на каждую задачу.\n\n- Вы сдаёте экзамен, если решаете 8 или более задач правильно (80% успеха).\n\n- Сдача экзамена для данного ранга открывает экзамен для следующего ранга.';

  @override
  String get helpDialogRankedMode =>
      '- Решайте задачи без ограничения по времени.\n\n- Сложность задач увеличивается в зависимости от того, насколько быстро вы их решаете.\n\n- Сосредоточьтесь на правильном решении и достигните максимально возможного ранга.';

  @override
  String get helpDialogTimeFrenzy =>
      '- У вас есть 3 минуты, чтобы решить как можно больше задач.\n\n- Задачи становятся всё сложнее по мере их решения.\n\n- Если вы допустите 3 ошибки, вы проиграете.';

  @override
  String get home => 'Главная';

  @override
  String get komi => 'Коми';

  @override
  String get language => 'Язык';

  @override
  String get leave => 'Покинуть';

  @override
  String get light => 'Светлая';

  @override
  String get login => 'Войти';

  @override
  String get logout => 'Выйти';

  @override
  String get long => 'Длинная';

  @override
  String mMinutes(int m) {
    return '$m мин';
  }

  @override
  String get maxChartPoints => 'Макс. точек';

  @override
  String get maxNumberOfMistakes => 'Максимальное количество ошибок';

  @override
  String get maxRank => 'Макс. ранг';

  @override
  String get medium => 'Средняя';

  @override
  String get minRank => 'Мин. ранг';

  @override
  String get minutes => 'Минуты';

  @override
  String get month => 'Месяц';

  @override
  String get msgCannotUseAIRefereeYet => 'ИИ-судья ещё нельзя использовать';

  @override
  String get msgCannotUseForcedCountingYet =>
      'Принудительный подсчёт ещё нельзя использовать';

  @override
  String get msgConfirmDeleteCollectionProgress =>
      'Вы уверены, что хотите начать коллекцию заново? Текущий прогресс будет удалён.';

  @override
  String get msgConfirmDeletePreset => 'Удалить этот шаблон?';

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
  String get msgPresetAlreadyExists => 'Шаблон с таким именем уже существует.';

  @override
  String get msgSearchingForGame => 'Поиск партии...';

  @override
  String get msgSgfCopied => 'SGF скопирован в буфер обмена';

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
      'Международный сервер, наиболее популярный в Европе и Америках.';

  @override
  String get ogsName => 'Online Go Server';

  @override
  String get ok => 'ОК';

  @override
  String get pass => 'Пас';

  @override
  String get password => 'Пароль';

  @override
  String get perTask => 'на задачу';

  @override
  String get play => 'Играть';

  @override
  String get pleaseMarkDeadStones => 'Пожалуйста, отметьте мёртвые камни.';

  @override
  String get presetName => 'Название шаблона';

  @override
  String get presets => 'Шаблоны';

  @override
  String get promotionRequirements => 'Требования для повышения';

  @override
  String pxsByoyomi(int p, int s) {
    return '$p×$sс';
  }

  @override
  String get randomizeTaskOrientation => 'Случайная ориентация задач';

  @override
  String get randomizeTaskOrientationDesc =>
      'Случайно поворачивает и отражает задачи вдоль горизонтальной, вертикальной и диагональной осей, чтобы предотвратить запоминание и улучшить распознавание паттернов.';

  @override
  String get rank => 'Ранг';

  @override
  String get rankedMode => 'Рейтинговый режим';

  @override
  String get recentRecord => 'Недавние результаты';

  @override
  String get register => 'Зарегистрироваться';

  @override
  String get rejectDeadStones => 'Отклонить мёртвые камни';

  @override
  String get resign => 'Сдаться';

  @override
  String get responseDelay => 'Задержка ответа';

  @override
  String get responseDelayDesc =>
      'Задержка перед показом ответного хода при решении задач';

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
  String get resultAccept => 'Принять';

  @override
  String get resultReject => 'Отказаться';

  @override
  String get rules => 'Правила';

  @override
  String get rulesChinese => 'Китайские';

  @override
  String get rulesJapanese => 'Японские';

  @override
  String get rulesKorean => 'Корейские';

  @override
  String sSeconds(int s) {
    return '$s с';
  }

  @override
  String get save => 'Сохранить';

  @override
  String get savePreset => 'Сохранить шаблон';

  @override
  String get saveSGF => 'Сохранить SGF';

  @override
  String get seconds => 'Секунды';

  @override
  String get selectAll => 'Выбрать все';

  @override
  String get settings => 'Настройки';

  @override
  String get short => 'Короткая';

  @override
  String get showCoordinates => 'Показывать координаты';

  @override
  String get showMoveErrorsAsCrosses => 'Отображать неправильные ходы крестами';

  @override
  String get showMoveErrorsAsCrossesDesc =>
      'Отображать неправильные ходы красными крестами вместо красных точек';

  @override
  String get simple => 'Простая';

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
  String get taskNext => 'Следующий';

  @override
  String get taskNotFound => 'Задача не найдена';

  @override
  String get taskRedo => 'Переделать';

  @override
  String get taskSource => 'Происхождение задач';

  @override
  String get taskSourceFromMyMistakes => 'Из моих ошибок';

  @override
  String get taskSourceFromTaskTopic => 'Из темы задач';

  @override
  String get taskSourceFromTaskTypes => 'Из типов задач';

  @override
  String get taskTimeout => 'Время вышло';

  @override
  String get taskTypeAppreciation => 'Оценка позиции';

  @override
  String get taskTypeCapture => 'Захват камней';

  @override
  String get taskTypeCaptureRace => 'Семеай';

  @override
  String get taskTypeEndgame => 'Йосе';

  @override
  String get taskTypeJoseki => 'Дзёсэки';

  @override
  String get taskTypeLifeAndDeath => 'Жизнь и смерть';

  @override
  String get taskTypeMiddlegame => 'Середина игры';

  @override
  String get taskTypeOpening => 'Фусэки';

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
  String get thick => 'Толстая';

  @override
  String get timeFrenzy => 'Временной раж';

  @override
  String get timeFrenzyMistakes => 'Отслеживать ошибки во Временном раже';

  @override
  String get timeFrenzyMistakesDesc =>
      'Включить для сохранения ошибок, сделанных во Временном раже';

  @override
  String get timePerTask => 'Время на задачу';

  @override
  String get today => 'Сегодня';

  @override
  String get tooltipAnalyzeWithAISensei => 'Анализировать с AI Sensei';

  @override
  String get tooltipDownloadGame => 'Скачать партию';

  @override
  String get topic => 'Тема';

  @override
  String get topicExam => 'Тематический экзамен';

  @override
  String get topics => 'Темы';

  @override
  String get train => 'Тренироваться';

  @override
  String get trainingAvgTimePerTask => 'Ср. время на задачу';

  @override
  String get trainingFailed => 'Не сдано';

  @override
  String get trainingMistakes => 'Ошибки';

  @override
  String get trainingPassed => 'Сдано';

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
