import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/stats/stats_db.dart';
import 'package:wqhub/train/task_preview_tile.dart';
import 'package:wqhub/train/task_ref.dart';
import 'package:wqhub/window_class_aware_state.dart';

class MyMistakesPage extends StatefulWidget {
  static const routeName = '/train/my_mistakes';

  const MyMistakesPage({super.key});

  @override
  State<MyMistakesPage> createState() => _MyMistakesPageState();
}

class _MyMistakesPageState extends WindowClassAwareState<MyMistakesPage> {
  late List<(TaskRef, TaskSolveStats)> tasks;
  var selectedSortMode = _SortMode.recent;

  @override
  void initState() {
    super.initState();
    tasks = StatsDB().mistakesByMostRecent();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.myMistakes),
        actions: <Widget>[
          DropdownButton<_SortMode>(
            icon: Icon(Icons.sort),
            value: selectedSortMode,
            items: _SortMode.entries(loc),
            onChanged: (_SortMode? sortLabel) {
              if (sortLabel != null && sortLabel != selectedSortMode) {
                setState(() {
                  selectedSortMode = sortLabel;
                  switch (selectedSortMode) {
                    case _SortMode.recent:
                      tasks = StatsDB().mistakesByMostRecent();
                    case _SortMode.difficult:
                      tasks = StatsDB().mistakesBySuccessRate();
                  }
                });
              }
            },
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 800),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: switch (windowClass) {
                WindowClass.compact => 3,
                WindowClass.medium => 6,
                WindowClass.expanded => 6,
                WindowClass.large => 6,
                WindowClass.extraLarge => 6,
              },
            ),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final (ref, stats) = tasks[index];
              return TaskPreviewTile(
                  task: ref,
                  solveStats: stats,
                  onHideTask: () {
                    StatsDB().ignoreTaskMistake(ref.rank, ref.type, ref.id);
                    setState(() {
                      tasks.removeAt(index);
                    });
                  });
            },
          ),
        ),
      ),
    );
  }
}

typedef _SortModeEntry = DropdownMenuItem<_SortMode>;

enum _SortMode {
  recent,
  difficult;

  static List<_SortModeEntry> entries(AppLocalizations loc) =>
      UnmodifiableListView<_SortModeEntry>(
        values.map<_SortModeEntry>(
          (l) => _SortModeEntry(
              value: l,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(l.toLocalizedString(loc)),
              )),
        ),
      );

  String toLocalizedString(AppLocalizations loc) => switch (this) {
        _SortMode.recent => loc.sortModeRecent,
        _SortMode.difficult => loc.sortModeDifficult,
      };
}
