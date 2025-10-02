import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:animated_tree_view/tree_view/tree_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:wqhub/confirm_dialog.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/pop_and_window_class_aware_state.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/stats/stats_db.dart';
import 'package:wqhub/train/collection_page.dart';
import 'package:wqhub/train/task_repository.dart';
import 'package:wqhub/train/task_source/black_to_play_source.dart';
import 'package:wqhub/train/task_source/collection_task_source.dart';

class CollectionsPage extends StatelessWidget {
  static const routeName = '/train/collections';

  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.collections),
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

class _CollectionTileState
    extends PopAndWindowClassAwareState<_CollectionTile> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    if (isWindowClassCompact) {
      return Slidable(
        key: ValueKey<String>('collection_tile.${widget.collection.id}'),
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              backgroundColor: Colors.green,
              icon: Icons.flag,
              label: loc.start,
              padding: EdgeInsets.all(8),
              onPressed: (context) => onStart(loc),
            ),
            if (StatsDB().collectionActiveSession(widget.collection.id) != null)
              SlidableAction(
                backgroundColor: Colors.blue,
                icon: Icons.double_arrow,
                label: loc.continue_,
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
                label: Text(loc.start),
                icon: const Icon(Icons.flag),
                onPressed: () => onStart(loc),
              ),
              if (StatsDB().collectionActiveSession(widget.collection.id) !=
                  null)
                ElevatedButton.icon(
                  label: Text(loc.continue_),
                  icon: const Icon(Icons.double_arrow),
                  onPressed: onContinue,
                ),
            ],
          ),
        ));
  }

  onStart(AppLocalizations loc) {
    if (StatsDB().collectionActiveSession(widget.collection.id) != null) {
      showDialog(
          context: context,
          builder: (context) => ConfirmDialog(
              title: loc.confirm,
              content: 'Are you sure you want to delete previous attempt?',
              onYes: () {
                Navigator.pop(context);
                StatsDB().resetCollectionActiveSession(widget.collection.id);
                onContinue();
              },
              onNo: () => Navigator.pop(context)));
      return;
    }
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
    Navigator.pushNamed(
      context,
      CollectionPage.routeName,
      arguments: CollectionRouteArguments(
        taskCollection: widget.collection,
        taskSource: BlackToPlaySource(
          source: CollectionTaskSource(widget.collection, offset: currentTask),
          blackToPlay: context.settings.alwaysBlackToPlay,
        ),
        initialTask: currentTask + 1,
      ),
    );
  }

  String collectionSubtitle() =>
      '${widget.collection.taskCount} tasks\nBest result: ${StatsDB().collectionStat(widget.collection.id) ?? '-'}';
}
