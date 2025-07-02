import 'package:flutter/material.dart';
import 'package:wqhub/game_client/game_client_list.dart';
import 'package:wqhub/main_page_bottom_navigation_bar.dart';
import 'package:wqhub/main_page_navigation_rail.dart';
import 'package:wqhub/play/server_card.dart';
import 'package:wqhub/settings/settings_button.dart';
import 'package:wqhub/settings/settings_page.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/train/collections_page.dart';
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

class MainPage extends StatefulWidget {
  final Function() reloadAppTheme;

  const MainPage({super.key, required this.reloadAppTheme});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends WindowClassAwareState<MainPage> {
  MainPageDestination _selectedDestination = MainPageDestination.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isWindowClassCompact
          ? AppBar(
              title: Text('WeiqiHub'),
              actions: <Widget>[
                SettingsButton(reloadAppTheme: widget.reloadAppTheme),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SettingsPage(reloadAppTheme: widget.reloadAppTheme),
                  ),
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
    return Center(
      child: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LocalBoardPage(),
            ),
          );
        },
        icon: Icon(Icons.grid_on),
        label: const Text('Board'),
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
            FloatingActionButton.extended(
              heroTag: null,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GradingExamSelectionPage(),
                  ),
                );
              },
              icon: Icon(Icons.verified),
              label: const Text('Grading exam'),
            ),
            FloatingActionButton.extended(
              heroTag: null,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EndgameExamSelectionPage(),
                  ),
                );
              },
              icon: Icon(Icons.verified),
              label: const Text('Endgame exam'),
            ),
            FloatingActionButton.extended(
              heroTag: null,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PopScope(
                      canPop: false,
                      child: TimeFrenzyPage(
                        taskSource: BlackToPlaySource(
                          source: TimeFrenzyTaskSource(),
                          blackToPlay: context.settings.alwaysBlackToPlay,
                        ),
                      ),
                    ),
                  ),
                );
              },
              icon: Icon(Icons.bolt),
              label: const Text('Time frenzy'),
            ),
            FloatingActionButton.extended(
              heroTag: null,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PopScope(
                      canPop: false,
                      child: RankedModePage(
                        taskSource: BlackToPlaySource(
                          source: RankedModeTaskSource(
                              context.stats.rankedModeRank),
                          blackToPlay: context.settings.alwaysBlackToPlay,
                        ),
                      ),
                    ),
                  ),
                );
              },
              icon: Icon(Icons.trending_up),
              label: const Text('Ranked mode'),
            ),
            FloatingActionButton.extended(
              heroTag: null,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CollectionsPage(),
                  ),
                );
              },
              icon: Icon(Icons.book),
              label: const Text('Collections'),
            ),
            FloatingActionButton.extended(
              heroTag: null,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TagsPage(),
                  ),
                );
              },
              icon: Icon(Icons.category),
              label: const Text('Topics'),
            ),
            FloatingActionButton.extended(
              heroTag: null,
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SingleTaskPage(
                                  task: context.settings.alwaysBlackToPlay
                                      ? task.withBlackToPlay()
                                      : task)),
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
              icon: Icon(Icons.search),
              label: const Text('Find task'),
            ),
            FloatingActionButton.extended(
              heroTag: null,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyMistakesPage(),
                  ),
                );
              },
              icon: Icon(Icons.sentiment_very_dissatisfied),
              label: const Text('My mistakes'),
            ),
            FloatingActionButton.extended(
              heroTag: null,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrainStatsPage(),
                  ),
                );
              },
              icon: Icon(Icons.query_stats),
              label: const Text('Statistics'),
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
    return AlertDialog(
      icon: Icon(Icons.search),
      title: const Text('Find task'),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter the task link',
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, (null, true)),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context,
                (TaskRepository().readByUri(controller.text.trim()), false));
          },
          child: const Text('Find'),
        ),
      ],
    );
  }
}
