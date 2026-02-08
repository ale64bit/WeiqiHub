import 'dart:math';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:wqhub/confirm_dialog.dart';
import 'package:wqhub/help/collections_help_dialog.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/pop_and_window_class_aware_state.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/stats/stats_db.dart';
import 'package:wqhub/train/collection_page.dart';
import 'package:wqhub/train/task_collection.dart';
import 'package:wqhub/train/task_source/black_to_play_source.dart';
import 'package:wqhub/train/task_source/collection_task_source.dart';
import 'package:wqhub/wq/rank.dart';

class CollectionPreviewRouteArguments {
  final TaskCollection collection;

  const CollectionPreviewRouteArguments({required this.collection});
}

class CollectionPreviewPage extends StatefulWidget {
  static const routeName = '/train/collections';

  final TaskCollection collection;

  const CollectionPreviewPage({super.key, required this.collection});

  @override
  State<CollectionPreviewPage> createState() => _CollectionPreviewPageState();
}

class _CollectionPreviewPageState
    extends PopAndWindowClassAwareState<CollectionPreviewPage> {
  CollectionActiveSession? _session;
  CollectionStatEntry? _stat;
  late Future<IMap<Rank, int>> _rankDist;

  @override
  void initState() {
    super.initState();
    _rankDist = Future(() => widget.collection.rankDistribution());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.collection.id == 1 && context.settings.showCollectionsHelp) {
        showDialog(
          context: context,
          builder: (context) => CollectionsHelpDialog(),
        );
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _session = StatsDB().collectionActiveSession(widget.collection.id);
    _stat = StatsDB().collectionStat(widget.collection.id);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final title = widget.collection.title.isEmpty
        ? loc.collections
        : widget.collection.title;
    final currentInfo = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8.0,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(loc.nTasks(widget.collection.taskCount)),
                  ],
                ),
              ),
              FutureBuilder(
                future: _rankDist,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final dist = snapshot.data!;
                    var minRank = Rank.values.last;
                    var maxRank = Rank.values.first;
                    var r = 0;
                    var n = 0;
                    for (final e in dist.entries) {
                      r += e.key.index * e.value;
                      n += e.value;
                      if (e.key < minRank) minRank = e.key;
                      if (e.key > maxRank) maxRank = e.key;
                    }
                    return Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${loc.minRank}: $minRank'),
                          Text(
                              '${loc.avgRank}: ${Rank.values[(r / n).floor()]}'),
                          Text('${loc.maxRank}: $maxRank'),
                        ],
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
            ],
          ),
          Divider(),
          Text('${loc.bestResult}: ${_stat?.toString() ?? '-'}'),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          if (widget.collection.id != 1)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Center(
                  child: currentInfo,
                ),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.collection.children.length,
              itemBuilder: (BuildContext context, int index) {
                final child = widget.collection.children[index];
                if (index < widget.collection.children.length) {
                  return ListTile(
                    leading: child.avgRank != null
                        ? Text(child.avgRank.toString())
                        : null,
                    title: Text(child.title),
                    subtitle: Text(loc.nTasks(child.taskCount)),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        CollectionPreviewPage.routeName,
                        arguments: CollectionPreviewRouteArguments(
                          collection: child,
                        ),
                      );
                    },
                  );
                }
                return null;
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: widget.collection.id != 1
          ? BottomAppBar(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 400),
                  child: Row(
                    spacing: 8.0,
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () => onStart(loc),
                          child: Text(loc.start),
                        ),
                      ),
                      if (_session != null)
                        Expanded(
                          child: FilledButton(
                            onPressed: () => onContinue(),
                            child: Text(
                                '${loc.continue_} (${_currentProgress()}%)'),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            )
          : null,
    );
  }

  void onStart(AppLocalizations loc) {
    if (_session != null) {
      showDialog(
          context: context,
          builder: (context) => ConfirmDialog(
              title: loc.confirm,
              content: loc.msgConfirmDeleteCollectionProgress,
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

  void onContinue() {
    final activeSession = _session ??
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

  int _currentProgress() => (100 *
          ((_session?.correctCount ?? 0) + (_session?.wrongCount ?? 0)) /
          widget.collection.taskCount)
      .round();
}
