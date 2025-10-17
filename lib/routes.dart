import 'package:flutter/material.dart';
import 'package:wqhub/local_board_page.dart';
import 'package:wqhub/main_page.dart';
import 'package:wqhub/play/automatch_page.dart';
import 'package:wqhub/play/game_page.dart';
import 'package:wqhub/play/game_record_page.dart';
import 'package:wqhub/play/my_games_page.dart';
import 'package:wqhub/play/server_lobby_page.dart';
import 'package:wqhub/play/server_login_page.dart';
import 'package:wqhub/settings/about_page.dart';
import 'package:wqhub/settings/appearance_settings_page.dart';
import 'package:wqhub/settings/behavior_settings_page.dart';
import 'package:wqhub/settings/language_page.dart';
import 'package:wqhub/settings/settings_page.dart';
import 'package:wqhub/settings/settings_route_arguments.dart';
import 'package:wqhub/settings/sound_settings_page.dart';
import 'package:wqhub/train/collection_page.dart';
import 'package:wqhub/train/collections_page.dart';
import 'package:wqhub/train/custom_exam_page.dart';
import 'package:wqhub/train/custom_exam_selection_page.dart';
import 'package:wqhub/train/endgame_exam_page.dart';
import 'package:wqhub/train/endgame_exam_selection_page.dart';
import 'package:wqhub/train/grading_exam_page.dart';
import 'package:wqhub/train/grading_exam_selection_page.dart';
import 'package:wqhub/train/my_mistakes_page.dart';
import 'package:wqhub/train/ranked_mode_page.dart';
import 'package:wqhub/train/single_task_page.dart';
import 'package:wqhub/train/subtag_rank_selection_page.dart';
import 'package:wqhub/train/subtags_page.dart';
import 'package:wqhub/train/tag_exam_page.dart';
import 'package:wqhub/train/tags_page.dart';
import 'package:wqhub/train/task_pattern_search_page.dart';
import 'package:wqhub/train/task_pattern_search_results_page.dart';
import 'package:wqhub/train/time_frenzy_page.dart';
import 'package:wqhub/train/train_stats_page.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

final Map<String, WidgetBuilder> routes = {
  // Settings
  AboutPage.routeName: (context) => AboutPage(),
  BehaviourSettingsPage.routeName: (context) => BehaviourSettingsPage(),
  SoundSettingsPage.routeName: (context) => SoundSettingsPage(),
  // Local board
  LocalBoardPage.routeName: (context) => LocalBoardPage(),
  // Play
  // Train
  GradingExamSelectionPage.routeName: (context) => GradingExamSelectionPage(),
  EndgameExamSelectionPage.routeName: (context) => EndgameExamSelectionPage(),
  CollectionsPage.routeName: (context) => CollectionsPage(),
  TagsPage.routeName: (context) => TagsPage(),
  CustomExamSelectionPage.routeName: (context) => CustomExamSelectionPage(),
  MyMistakesPage.routeName: (context) => MyMistakesPage(),
  TrainStatsPage.routeName: (context) => TrainStatsPage(),
  TaskPatternSearchPage.routeName: (context) => TaskPatternSearchPage(),
};

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Navigator.defaultRouteName:
      final args = settings.arguments as MainRouteArguments;
      return _mpr(
          settings,
          MainPage(
            destination: args.destination,
            rebuildApp: args.rebuildApp,
          ));
    case SettingsPage.routeName:
      final args = settings.arguments as SettingsRouteArguments;
      return _mpr(settings, SettingsPage(rebuildApp: args.rebuildApp));
    case AppearanceSettingsPage.routeName:
      final args = settings.arguments as SettingsRouteArguments;
      return _mpr(
          settings, AppearanceSettingsPage(rebuildApp: args.rebuildApp));
    case LanguagePage.routeName:
      final args = settings.arguments as SettingsRouteArguments;
      return _mpr(settings, LanguagePage(rebuildApp: args.rebuildApp));
    case SingleTaskPage.routeName:
      final args = settings.arguments as SingleTaskRouteArguments;
      return _mpr(settings, SingleTaskPage(task: args.task));
    case TimeFrenzyPage.routeName:
      final args = settings.arguments as TimeFrenzyRouteArguments;
      return _mprNoPop(settings, TimeFrenzyPage(taskSource: args.taskSource));
    case GradingExamPage.routeName:
      final args = settings.arguments as GradingExamRouteArguments;
      return _mprNoPop(settings, GradingExamPage(rank: args.rank));
    case EndgameExamPage.routeName:
      final args = settings.arguments as EndgameExamRouteArguments;
      return _mprNoPop(settings, EndgameExamPage(rank: args.rank));
    case SubtagsPage.routeName:
      final args = settings.arguments as SubtagsRouteArguments;
      return _mpr(settings, SubtagsPage(tag: args.tag));
    case SubtagRankSelectionPage.routeName:
      final args = settings.arguments as SubtagRankSelectionRouteArguments;
      return _mpr(settings, SubtagRankSelectionPage(subtag: args.subtag));
    case TagExamPage.routeName:
      final args = settings.arguments as TagExamRouteArguments;
      return _mprNoPop(
          settings,
          TagExamPage(
            tag: args.tag,
            rankRange: args.rankRange,
          ));
    case CollectionPage.routeName:
      final args = settings.arguments as CollectionRouteArguments;
      return _mprNoPop(
          settings,
          CollectionPage(
            taskCollection: args.taskCollection,
            taskSource: args.taskSource,
            initialTask: args.initialTask,
          ));
    case CustomExamPage.routeName:
      final args = settings.arguments as CustomExamRouteArguments;
      return _mprNoPop(
          settings,
          CustomExamPage(
            taskCount: args.taskCount,
            timePerTask: args.timePerTask,
            rankRange: args.rankRange,
            maxMistakes: args.maxMistakes,
            taskSourceType: args.taskSourceType,
            taskTypes: args.taskTypes,
            taskTag: args.taskTag,
            collectStats: args.collectStats,
          ));
    case RankedModePage.routeName:
      final args = settings.arguments as RankedModeRouteArguments;
      return _mprNoPop(settings, RankedModePage(taskSource: args.taskSource));
    case ServerLoginPage.routeName:
      final args = settings.arguments as ServerLoginRouteArguments;
      return _mpr(settings, ServerLoginPage(gameClient: args.gameClient));
    case ServerLobbyPage.routeName:
      final args = settings.arguments as ServerLobbyRouteArguments;
      return _mpr(settings, ServerLobbyPage(gameClient: args.gameClient));
    case MyGamesPage.routeName:
      final args = settings.arguments as MyGamesRouteArguments;
      return _mpr(
          settings,
          MyGamesPage(
            gameClient: args.gameClient,
            gameList: args.gameList,
          ));
    case GameRecordPage.routeName:
      final args = settings.arguments as GameRecordRouteArguments;
      return _mpr(
          settings,
          GameRecordPage(
            summary: args.summary,
            record: args.record,
          ));
    case AutomatchPage.routeName:
      final args = settings.arguments as AutomatchRouteArguments;
      return _mprNoPop(
          settings,
          AutomatchPage(
            gameClient: args.gameClient,
            preset: args.preset,
          ));
    case GamePage.routeName:
      final args = settings.arguments as GameRouteArguments;
      return _mprNoPop(
          settings,
          GamePage(
            serverFeatures: args.serverFeatures,
            game: args.game,
            gameListener: args.gameListener,
          ));
    case TaskPatternSearchResultsPage.routeName:
      final args = settings.arguments as TaskPatternSearchResultsRouteArguments;
      return _mpr(
        settings,
        TaskPatternSearchResultsPage(
          rankRange: args.rankRange,
          taskTypes: args.taskTypes,
          stones: args.stones,
          empty: args.empty,
        ),
      );
  }
  assert(false, 'Missing named route implementation: ${settings.name}');
  return null;
}

Route<dynamic> _mpr(RouteSettings settings, Widget w) => MaterialPageRoute(
      settings: settings,
      builder: (context) => w,
    );

Route<dynamic> _mprNoPop(RouteSettings settings, Widget w) => MaterialPageRoute(
      settings: settings,
      builder: (context) => PopScope(
        canPop: false,
        child: w,
      ),
    );
