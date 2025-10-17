import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:wqhub/cancellable_isolate_stream.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/stats/stats_db.dart';
import 'package:wqhub/train/rank_range.dart';
import 'package:wqhub/train/task_preview_tile.dart';
import 'package:wqhub/train/task_repository.dart';
import 'package:wqhub/train/task_type.dart';
import 'package:wqhub/window_class_aware_state.dart';
import 'package:wqhub/wq/wq.dart' as wq;

class TaskPatternSearchResultsRouteArguments {
  final RankRange rankRange;
  final ISet<TaskType> taskTypes;
  final IMap<wq.Point, wq.Color> stones;
  final ISet<wq.Point> empty;

  TaskPatternSearchResultsRouteArguments(
      {required this.rankRange,
      required this.taskTypes,
      required this.stones,
      required this.empty});
}

class TaskPatternSearchResultsPage extends StatefulWidget {
  static const routeName = '/train/task_pattern_search_results';

  final RankRange rankRange;
  final ISet<TaskType> taskTypes;
  final IMap<wq.Point, wq.Color> stones;
  final ISet<wq.Point> empty;

  const TaskPatternSearchResultsPage({
    super.key,
    required this.rankRange,
    required this.taskTypes,
    required this.stones,
    required this.empty,
  });

  @override
  State<TaskPatternSearchResultsPage> createState() =>
      _TaskPatternSearchResultsPageState();
}

class _TaskPatternSearchResultsPageState
    extends WindowClassAwareState<TaskPatternSearchResultsPage> {
  late final CancellableIsolateStream<Task> _results;
  final _tasks = <Task>[];
  final _taskAdded = <int>{};
  var _searchComplete = false;

  @override
  void initState() {
    super.initState();
    _results = findTasks(
        widget.rankRange, widget.taskTypes, widget.stones, widget.empty);
  }

  @override
  void dispose() {
    _searchComplete = true;
    _results.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _results.stream,
      builder: (context, snapshot) {
        final loc = AppLocalizations.of(context)!;
        if (snapshot.connectionState == ConnectionState.done) {
          _searchComplete = true;
        }
        if (snapshot.hasData) {
          Task t = snapshot.data!;
          if (!_taskAdded.contains(t.id)) {
            _taskAdded.add(t.id);
            _tasks.add(t);
            if (_tasks.length >= 100) _results.cancel();
          }
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(
                _searchComplete ? loc.findTaskResults : loc.findTaskSearching),
            actions: [
              if (!_searchComplete)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
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
                itemCount: _tasks.length,
                itemBuilder: (context, index) => TaskPreviewTile(
                  task: TaskStatEntry.ofTask(_tasks[index]),
                  showSolveRatio: false,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
