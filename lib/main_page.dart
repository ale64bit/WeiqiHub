import 'package:flutter/material.dart';
import 'package:wqhub/game_client/game_client_list.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/main_page_bottom_navigation_bar.dart';
import 'package:wqhub/main_page_navigation_rail.dart';
import 'package:wqhub/play/server_card.dart';
import 'package:wqhub/section_button.dart';
import 'package:wqhub/settings/settings_button.dart';
import 'package:wqhub/settings/settings_page.dart';
import 'package:wqhub/settings/settings_route_arguments.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/train/collections_page.dart';
import 'package:wqhub/train/custom_exam_selection_page.dart';
import 'package:wqhub/train/endgame_exam_selection_page.dart';
import 'package:wqhub/train/my_mistakes_page.dart';
import 'package:wqhub/train/ranked_mode_page.dart';
import 'package:wqhub/train/single_task_page.dart';
import 'package:wqhub/train/task_repository.dart';
import 'package:wqhub/train/task_source/black_to_play_source.dart';
import 'package:wqhub/train/task_source/ranked_mode_task_source.dart';
import 'package:wqhub/local_board_page.dart';
import 'package:wqhub/train/grading_exam_selection_page.dart';
import 'package:wqhub/train/task_source/time_frenzy_task_source.dart';
import 'package:wqhub/train/time_frenzy_page.dart';
import 'package:wqhub/train/tags_page.dart';
import 'package:wqhub/train/train_stats_page.dart';
import 'package:wqhub/window_class_aware_state.dart';

enum MainPageDestination { home, play, train }

class MainRouteArguments {
  final MainPageDestination destination;
  final Function() rebuildApp;

  const MainRouteArguments(
      {required this.destination, required this.rebuildApp});
}

class MainPage extends StatefulWidget {
  final MainPageDestination destination;
  final Function() rebuildApp;

  const MainPage(
      {super.key, required this.destination, required this.rebuildApp});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends WindowClassAwareState<MainPage> {
  late MainPageDestination _selectedDestination = widget.destination;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isWindowClassCompact
          ? AppBar(
              title: Text('WeiqiHub'),
              actions: <Widget>[
                SettingsButton(reloadAppTheme: widget.rebuildApp),
              ],
            )
          : null,
      body: isWindowClassCompact
          ? _destinationBody()
          : Row(
              children: <Widget>[
                MainPageNavigationRail(
                    currentDestination: _selectedDestination,
                    onDestinationSelected: _setSelectedDestination),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(child: _destinationBody()),
              ],
            ),
      bottomNavigationBar: isWindowClassCompact
          ? MainPageBottomNavigationBar(
              currentDestination: _selectedDestination,
              onDestinationSelected: _setSelectedDestination,
            )
          : null,
      floatingActionButton: isWindowClassCompact
          ? null
          : FloatingActionButton.small(
              heroTag: null,
              child: Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  SettingsPage.routeName,
                  arguments:
                      SettingsRouteArguments(rebuildApp: widget.rebuildApp),
                );
              },
            ),
    );
  }

  Widget _destinationBody() => switch (_selectedDestination) {
        MainPageDestination.home => const _Home(),
        MainPageDestination.play => const _Play(),
        MainPageDestination.train => _Train(
              columns: switch (windowClass) {
            WindowClass.compact => 2,
            WindowClass.medium => 3,
            WindowClass.expanded => 4,
            WindowClass.large => 4,
            WindowClass.extraLarge => 4,
          }),
      };

  void _setSelectedDestination(MainPageDestination dest) {
    setState(() {
      _selectedDestination = dest;
    });
  }
}

class _Home extends StatelessWidget {
  const _Home();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 400),
        child: GridView(
          padding: EdgeInsets.all(8),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            crossAxisCount: 1,
            childAspectRatio: 2.5,
          ),
          children: <Widget>[
            SectionButton(
              icon: Icons.grid_on,
              label: loc.board,
              onPressed: () {
                Navigator.pushNamed(context, LocalBoardPage.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Play extends StatelessWidget {
  const _Play();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          for (final gameClient in gameClients)
            ServerCard(gameClient: gameClient),
        ],
      ),
    );
  }
}

class _Train extends StatelessWidget {
  const _Train({required this.columns});

  final int columns;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 800),
        child: GridView(
          padding: EdgeInsets.all(8),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            crossAxisCount: columns,
            childAspectRatio: 2.5,
          ),
          children: <Widget>[
            SectionButton(
              icon: Icons.verified,
              label: loc.gradingExam,
              onPressed: () {
                Navigator.pushNamed(
                    context, GradingExamSelectionPage.routeName);
              },
            ),
            SectionButton(
              icon: Icons.verified,
              label: loc.endgameExam,
              onPressed: () {
                Navigator.pushNamed(
                    context, EndgameExamSelectionPage.routeName);
              },
            ),
            SectionButton(
              icon: Icons.bolt,
              label: loc.timeFrenzy,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  TimeFrenzyPage.routeName,
                  arguments: TimeFrenzyRouteArguments(
                    taskSource: BlackToPlaySource(
                      source: TimeFrenzyTaskSource(),
                      blackToPlay: context.settings.alwaysBlackToPlay,
                    ),
                  ),
                );
              },
            ),
            SectionButton(
              icon: Icons.trending_up,
              label: loc.rankedMode,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  RankedModePage.routeName,
                  arguments: RankedModeRouteArguments(
                    taskSource: BlackToPlaySource(
                      source:
                          RankedModeTaskSource(context.stats.rankedModeRank),
                      blackToPlay: context.settings.alwaysBlackToPlay,
                    ),
                  ),
                );
              },
            ),
            SectionButton(
              icon: Icons.book,
              label: loc.collections,
              onPressed: () {
                Navigator.pushNamed(context, CollectionsPage.routeName);
              },
            ),
            SectionButton(
              icon: Icons.category,
              label: loc.topics,
              onPressed: () {
                Navigator.pushNamed(context, TagsPage.routeName);
              },
            ),
            SectionButton(
              icon: Icons.tune,
              label: loc.customExam,
              onPressed: () {
                Navigator.pushNamed(context, CustomExamSelectionPage.routeName);
              },
            ),
            SectionButton(
              icon: Icons.search,
              label: loc.findTask,
              onPressed: () {
                showDialog<(Task?, bool)>(
                  context: context,
                  builder: (context) => _FindTaskDialog(),
                ).then((res) {
                  if (res != null) {
                    final (task, dismissed) = res;
                    if (dismissed) return;
                    if (task != null) {
                      if (context.mounted) {
                        Navigator.pushNamed(
                          context,
                          SingleTaskPage.routeName,
                          arguments: SingleTaskRouteArguments(
                            task: context.settings.alwaysBlackToPlay
                                ? task.withBlackToPlay()
                                : task,
                          ),
                        );
                      }
                    } else {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text('Task not found.'),
                          dismissDirection: DismissDirection.horizontal,
                          showCloseIcon: true,
                        ));
                      }
                    }
                  }
                }, onError: (err) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text('Task not found.'),
                      dismissDirection: DismissDirection.horizontal,
                      showCloseIcon: true,
                    ));
                  }
                });
              },
            ),
            SectionButton(
              icon: Icons.sentiment_very_dissatisfied,
              label: loc.myMistakes,
              onPressed: () {
                Navigator.pushNamed(context, MyMistakesPage.routeName);
              },
            ),
            SectionButton(
              icon: Icons.query_stats,
              label: loc.statistics,
              onPressed: () {
                Navigator.pushNamed(context, TrainStatsPage.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FindTaskDialog extends StatefulWidget {
  @override
  State<_FindTaskDialog> createState() => _FindTaskDialogState();
}

class _FindTaskDialogState extends State<_FindTaskDialog> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return AlertDialog(
      icon: Icon(Icons.search),
      title: Text(loc.findTask),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: loc.enterTaskLink,
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, (null, true)),
          child: Text(loc.cancel),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context,
                (TaskRepository().readByUri(controller.text.trim()), false));
          },
          child: Text(loc.find),
        ),
      ],
    );
  }
}
