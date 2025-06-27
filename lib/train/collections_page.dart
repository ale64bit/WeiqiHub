import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:animated_tree_view/tree_view/tree_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/stats/stats_db.dart';
import 'package:wqhub/train/collection_page.dart';
import 'package:wqhub/train/task_repository.dart';
import 'package:wqhub/train/task_source/black_to_play_source.dart';
import 'package:wqhub/train/task_source/collection_task_source.dart';
import 'package:wqhub/window_class_aware_state.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Collections'),
      ),
      body: TreeView.simpleTyped<TaskCollection, TreeNode<TaskCollection>>(
        tree: TaskRepository().collectionsTreeNode(),
        showRootNode: false,
        builder: (context, item) => _CollectionTile(collection: item.data!),
      ),
    );
  }
}

class _CollectionTile extends StatefulWidget {
  const _CollectionTile({
    required this.collection,
  });

  final TaskCollection collection;

  @override
  State<_CollectionTile> createState() => _CollectionTileState();
}

class _CollectionTileState extends WindowClassAwareState<_CollectionTile> {
  @override
  Widget build(BuildContext context) {
    if (isWindowClassCompact) {
      return Slidable(
        key: ValueKey<String>('collection_tile.${widget.collection.id}'),
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              backgroundColor: Colors.green,
              icon: Icons.flag,
              label: 'Start',
              padding: EdgeInsets.all(8),
              onPressed: (context) => onStart(),
            ),
            if (StatsDB().collectionActiveSession(widget.collection.id) != null)
              SlidableAction(
                backgroundColor: Colors.blue,
                icon: Icons.double_arrow,
                label: 'Continue',
                padding: EdgeInsets.all(8),
                onPressed: (context) => onContinue(),
              ),
          ],
        ),
        child: ListTile(
          title: Text(widget.collection.title),
          subtitle: Text(collectionSubtitle()),
          isThreeLine: true,
        ),
      );
    }
    return ListTile(
        title: Text(widget.collection.title),
        subtitle: Text(collectionSubtitle()),
        isThreeLine: true,
        trailing: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ElevatedButton.icon(
                label: const Text('Start'),
                icon: const Icon(Icons.flag),
                onPressed: onStart,
              ),
              if (StatsDB().collectionActiveSession(widget.collection.id) !=
                  null)
                ElevatedButton.icon(
                  label: const Text('Continue'),
                  icon: const Icon(Icons.double_arrow),
                  onPressed: onContinue,
                ),
            ],
          ),
        ));
  }

  onStart() {
    StatsDB().resetCollectionActiveSession(widget.collection.id);
    onContinue();
  }

  onContinue() {
    final activeSession =
        StatsDB().collectionActiveSession(widget.collection.id) ??
            CollectionActiveSession(
              id: widget.collection.id,
              correctCount: 0,
              wrongCount: 0,
              duration: Duration.zero,
            );
    final currentTask = activeSession.correctCount + activeSession.wrongCount;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PopScope(
          canPop: false,
          child: CollectionPage(
            taskCollection: widget.collection,
            taskSource: BlackToPlaySource(
              source:
                  CollectionTaskSource(widget.collection, offset: currentTask),
              blackToPlay: context.settings.alwaysBlackToPlay,
            ),
            initialTask: currentTask + 1,
          ),
        ),
      ),
    );
  }

  String collectionSubtitle() =>
      '${widget.collection.taskCount} tasks\nBest result: ${StatsDB().collectionStat(widget.collection.id) ?? '-'}';
}
