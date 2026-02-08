import 'package:flutter/material.dart';
import 'package:wqhub/game_client/game_client_list.dart';
import 'package:wqhub/help/ranked_mode_help_dialog.dart';
import 'package:wqhub/help/time_frenzy_help_dialog.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/main_page_bottom_navigation_bar.dart';
import 'package:wqhub/main_page_navigation_rail.dart';
import 'package:wqhub/p2p_battle/p2p_home_page.dart';
import 'package:wqhub/play/server_card.dart';
import 'package:wqhub/section_button.dart';
import 'package:wqhub/settings/settings_button.dart';
import 'package:wqhub/settings/settings_page.dart';
import 'package:wqhub/settings/settings_route_arguments.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/train/collection_preview_page.dart';
import 'package:wqhub/train/custom_exam_selection_page.dart';
import 'package:wqhub/train/endgame_exam_selection_page.dart';
import 'package:wqhub/train/my_mistakes_page.dart';
import 'package:wqhub/train/ranked_mode_page.dart';
import 'package:wqhub/train/single_task_page.dart';
import 'package:wqhub/train/task.dart';
import 'package:wqhub/train/task_db.dart';
import 'package:wqhub/train/task_pattern_search_page.dart';
import 'package:wqhub/train/task_source/black_to_play_source.dart';
import 'package:wqhub/train/task_source/ranked_mode_task_source.dart';
import 'package:wqhub/local_board_page.dart';
import 'package:wqhub/train/grading_exam_selection_page.dart';
import 'package:wqhub/train/task_source/time_frenzy_task_source.dart';
import 'package:wqhub/train/time_frenzy_page.dart';
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
          const Divider(),
          Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, P2PHomePage.routeName);
              },
              child: ListTile(
                leading: Icon(Icons.people),
                title: Text('P2P Tsumego Battle'),
                subtitle: Text(
                    'Tsumego battle with other players'), //subtitle: Text(loc.p2pDesc),
              ),
            ),
          ),
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
                if (context.settings.showTimeFrenzyHelp) {
                  showDialog(
                    context: context,
                    builder: (context) => TimeFrenzyHelpDialog(),
                  );
                } else {
                  Navigator.pushNamed(
                    context,
                    TimeFrenzyPage.routeName,
                    arguments: TimeFrenzyRouteArguments(
                      taskSource: BlackToPlaySource(
                        source: TimeFrenzyTaskSource(
                            randomizeLayout:
                                context.settings.randomizeTaskOrientation),
                        blackToPlay: context.settings.alwaysBlackToPlay,
                      ),
                    ),
                  );
                }
              },
            ),
            SectionButton(
              icon: Icons.trending_up,
              label: loc.rankedMode,
              onPressed: () {
                if (context.settings.showRankedModeHelp) {
                  showDialog(
                    context: context,
                    builder: (context) => RankedModeHelpDialog(),
                  );
                } else {
                  Navigator.pushNamed(
                    context,
                    RankedModePage.routeName,
                    arguments: RankedModeRouteArguments(
                      taskSource: BlackToPlaySource(
                        source: RankedModeTaskSource(
                            context.stats.rankedModeRank,
                            context.settings.randomizeTaskOrientation),
                        blackToPlay: context.settings.alwaysBlackToPlay,
                      ),
                    ),
                  );
                }
              },
            ),
            SectionButton(
              icon: Icons.book,
              label: loc.collections,
              onPressed: () {
                Navigator.pushNamed(context, CollectionPreviewPage.routeName,
                    arguments: CollectionPreviewRouteArguments(
                      collection: TaskDB().collections,
                    ));
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
              onPressed: () => showFindTaskDialog(context),
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

  void showFindTaskDialog(BuildContext parentContext) {
    final loc = AppLocalizations.of(parentContext)!;
    showDialog(
      context: parentContext,
      builder: (context) {
        return AlertDialog(
          title: Text(loc.findTask),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 8.0,
            children: [
              ElevatedButton.icon(
                icon: Icon(Icons.link),
                label: Text(loc.findTaskByLink),
                onPressed: () {
                  Navigator.of(parentContext).pop();
                  WidgetsBinding.instance.addPostFrameCallback(
                      (_) => showFindTaskByLinkDialog(parentContext));
                },
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.pattern),
                label: Text(loc.findTaskByPattern),
                onPressed: () {
                  Navigator.of(parentContext).pop();
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushNamed(
                      context,
                      TaskPatternSearchPage.routeName,
                    );
                  });
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, (null, true)),
              child: Text(loc.cancel),
            ),
          ],
        );
      },
    );
  }

  void showFindTaskByLinkDialog(BuildContext context) {
    showDialog<(Task?, bool)>(
      context: context,
      builder: (context) => _FindTaskDialog(),
    ).then((res) {
      if (res != null) {
        var (task, dismissed) = res;
        if (dismissed) return;
        if (task != null) {
          if (context.mounted) {
            if (context.settings.alwaysBlackToPlay) {
              task = task.withBlackToPlay();
            }
            task = task.withRandomSymmetry(
                randomize: context.settings.randomizeTaskOrientation);

            Navigator.pushNamed(
              context,
              SingleTaskPage.routeName,
              arguments: SingleTaskRouteArguments(task: task),
            );
          }
        } else {
          if (context.mounted) {
            final loc = AppLocalizations.of(context)!;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(loc.taskNotFound),
              dismissDirection: DismissDirection.horizontal,
              showCloseIcon: true,
            ));
          }
        }
      }
    }, onError: (err) {
      if (context.mounted) {
        final loc = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(loc.taskNotFound),
          dismissDirection: DismissDirection.horizontal,
          showCloseIcon: true,
        ));
      }
    });
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
            Navigator.pop(
                context, (TaskDB().getByUri(controller.text.trim()), false));
          },
          child: Text(loc.find),
        ),
      ],
    );
  }
}
