import 'package:flutter/material.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/train/task_preview_tile.dart';
import 'package:wqhub/train/task_repository.dart';
import 'package:wqhub/window_class_aware_state.dart';

class CollectionResultRouteArguments {
  const CollectionResultRouteArguments({
    required this.taskCollection,
    required this.totalTime,
    required this.failedTasks,
    required this.newBest,
  });

  final TaskCollection taskCollection;
  final Duration totalTime;
  final List<TaskRef> failedTasks;
  final bool newBest;
}

class CollectionResultPage extends StatefulWidget {
  static const routeName = '/train/collection_result';

  const CollectionResultPage({
    super.key,
    required this.taskCollection,
    required this.totalTime,
    required this.failedTasks,
    required this.newBest,
  });

  final TaskCollection taskCollection;
  final Duration totalTime;
  final List<TaskRef> failedTasks;
  final bool newBest;

  @override
  State<CollectionResultPage> createState() => _CollectionResultPageState();
}

class _CollectionResultPageState
    extends WindowClassAwareState<CollectionResultPage> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final correctCount =
        widget.taskCollection.taskCount - widget.failedTasks.length;
    final successRate =
        (100 * correctCount / widget.taskCollection.taskCount).toInt();
    final passed = successRate >= 80;
    return Scaffold(
      appBar: AppBar(
        title: widget.newBest
            ? Row(
                spacing: 8.0,
                children: [
                  Icon(Icons.emoji_events, color: Colors.amberAccent),
                  Text(loc.newBestResult),
                ],
              )
            : Text(loc.result),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: Card(
            child: ListTile(
              leading: switch (passed) {
                true => Icon(Icons.mood, color: Colors.green),
                false => Icon(Icons.mood_bad, color: Colors.red),
              },
              title: Text(passed ? loc.trainingPassed : loc.trainingFailed),
              subtitle: Text(
                  '$correctCount / ${widget.taskCollection.taskCount} ($successRate%)'),
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.totalTime.toString().substring(2, 7),
                    style: TextTheme.of(context).headlineSmall,
                  ),
                  Text(
                      '${loc.sSeconds((widget.totalTime.inSeconds / widget.taskCollection.taskCount).round())} ${loc.perTask}')
                ],
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 800),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: switch (windowClass) {
                WindowClass.compact => 3,
                WindowClass.medium => 5,
                WindowClass.expanded => 6,
                WindowClass.large => 6,
                WindowClass.extraLarge => 6,
              },
            ),
            itemCount: widget.failedTasks.length,
            itemBuilder: (context, index) => TaskPreviewTile(
              task: widget.failedTasks[index],
              solved: false,
            ),
          ),
        ),
      ),
    );
  }
}
