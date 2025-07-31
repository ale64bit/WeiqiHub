import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:wqhub/stats/stats_db.dart';
import 'package:wqhub/train/task_preview_tile.dart';
import 'package:wqhub/window_class_aware_state.dart';

class MyMistakesPage extends StatefulWidget {
  static const routeName = '/train/my_mistakes';

  const MyMistakesPage({super.key});

  @override
  State<MyMistakesPage> createState() => _MyMistakesPageState();
}

class _MyMistakesPageState extends WindowClassAwareState<MyMistakesPage> {
  late List<TaskStatEntry> tasks;
  var selectedSortMode = _SortMode.recent;

  @override
  void initState() {
    super.initState();
    tasks = StatsDB().mistakesByMostRecent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My mistakes'),
        actions: <Widget>[
          DropdownButton<_SortMode>(
            icon: Icon(Icons.sort),
            value: selectedSortMode,
            items: _SortMode.entries,
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
            itemBuilder: (context, index) => TaskPreviewTile(
                task: tasks[index],
                onHideTask: () {
                  StatsDB().ignoreTaskMistake(
                      tasks[index].rank, tasks[index].type, tasks[index].id);
                  setState(() {
                    tasks.removeAt(index);
                  });
                }),
          ),
        ),
      ),
    );
  }
}

typedef _SortModeEntry = DropdownMenuItem<_SortMode>;

enum _SortMode {
  recent('Recent'),
  difficult('Difficult');

  const _SortMode(this.label);
  final String label;

  static final List<_SortModeEntry> entries =
      UnmodifiableListView<_SortModeEntry>(
    values.map<_SortModeEntry>(
      (l) => _SortModeEntry(
          value: l,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(l.label),
          )),
    ),
  );
}
