import 'package:flutter/material.dart';
import 'package:wqhub/p2p_battle/p2p_client.dart';
import 'package:wqhub/p2p_battle/p2p_home_page.dart';
import 'package:wqhub/p2p_battle/p2p_lobby_page.dart';
import 'package:wqhub/p2p_battle/p2p_models.dart';
import 'package:wqhub/train/task_preview_tile.dart';
import 'package:wqhub/train/task_ref.dart';
import 'package:wqhub/window_class_aware_state.dart';

class P2PResultsArguments {
  final P2PClient client;
  final String roomId;
  final String playerName;

  P2PResultsArguments({
    required this.client,
    required this.roomId,
    required this.playerName,
  });
}

class P2PResultsPage extends StatefulWidget {
  static const routeName = '/p2p/results';
  final P2PResultsArguments args;

  const P2PResultsPage({super.key, required this.args});

  @override
  State<P2PResultsPage> createState() => _P2PResultsPageState();
}

class _P2PResultsPageState extends WindowClassAwareState<P2PResultsPage> {
  P2PState? _state;
  bool _isRestarting = false;

  @override
  void initState() {
    super.initState();
    widget.args.client.onStateUpdate = (state) {
      if (mounted) {
        setState(() {
          _state = state;
        });
      }
    };
    widget.args.client.onBattleRestarted = () {
      if (mounted) {
        setState(() => _isRestarting = true);
        Navigator.popUntil(context, ModalRoute.withName(P2PHomePage.routeName));
        Navigator.pushNamed(
          context,
          P2PLobbyPage.routeName,
          arguments: P2PLobbyArguments(
            roomId: widget.args.roomId,
            playerName: widget.args.playerName,
            serverUrl: widget.args.client.serverUrl,
            client: widget.args.client,
          ),
        );
      }
    };
  }

  @override
  void dispose() {
    if (!_isRestarting) {
      widget.args.client.disconnect();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_state == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final players = _state!.players.toList();
    // Sort by solveCount descending, then by timeTakenMs ascending
    players.sort((a, b) {
      final aSolved = a.results?['solveCount'] ?? 0;
      final bSolved = b.results?['solveCount'] ?? 0;
      if (aSolved != bSolved) {
        return bSolved.compareTo(aSolved);
      }
      final aTime = a.results?['timeTakenMs'] ?? double.infinity;
      final bTime = b.results?['timeTakenMs'] ?? double.infinity;
      return aTime.compareTo(bTime);
    });

    final currentPlayer = _state!.players.firstWhere(
        (p) => p.name == widget.args.playerName,
        orElse: () => _state!.players.first);
    final isCreator = currentPlayer.isCreator;

    return Scaffold(
      appBar: AppBar(
        title: Text('Battle Results'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.popUntil(
              context, ModalRoute.withName(P2PHomePage.routeName)),
        ),
        actions: [
          if (isCreator)
            TextButton.icon(
              onPressed: () => widget.args.client.restartBattle(),
              icon: const Icon(Icons.refresh),
              label: const Text('Rematch'),
            ),
        ],
      ),
      body: ListView.builder(
        itemCount: players.length,
        itemBuilder: (context, index) {
          final p = players[index];
          final solveCount = p.results?['solveCount'] ?? 0;
          final attemptCount = p.results?['attemptCount'] ?? 0;

          final timeTakenMs = p.results?['timeTakenMs'] as int?;
          final timeStr = timeTakenMs != null
              ? '${(timeTakenMs / 1000).toStringAsFixed(1)}s'
              : '';

          return ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(p.name),
            subtitle: Text('Solved: $solveCount / $attemptCount' +
                (timeStr.isNotEmpty ? ' in $timeStr' : '')),
            trailing: p.hasResults
                ? const Icon(Icons.check, color: Colors.green)
                : const Text('Wait...'),
            onTap: p.hasResults ? () => _showPlayerDetails(p) : null,
          );
        },
      ),
    );
  }

  void _showPlayerDetails(P2PPlayer player) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _PlayerResultsPage(
          player: player,
        ),
      ),
    );
  }
}

class _PlayerResultsPage extends StatefulWidget {
  final P2PPlayer player;

  const _PlayerResultsPage({required this.player});

  @override
  State<_PlayerResultsPage> createState() => _PlayerResultsPageState();
}

class _PlayerResultsPageState
    extends WindowClassAwareState<_PlayerResultsPage> {
  @override
  Widget build(BuildContext context) {
    final results =
        widget.player.results?['results'] as Map<String, dynamic>? ?? {};
    final completedTasks = results.entries.map((e) {
      return (TaskRef.ofUri(e.key), e.value as bool);
    }).toList();

    final solveCount = widget.player.results?['solveCount'] ?? 0;
    final attemptCount = widget.player.results?['attemptCount'] ?? 0;
    final successRate =
        attemptCount > 0 ? (100 * solveCount / attemptCount).toInt() : 0;
    final timeTakenMs = widget.player.results?['timeTakenMs'] as int?;
    final timeStr = timeTakenMs != null
        ? '${(timeTakenMs / 1000).toStringAsFixed(1)}s'
        : '';

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.player.name}\'s Results'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Icon(
                solveCount == attemptCount && attemptCount > 0
                    ? Icons.mood
                    : Icons.mood_bad,
                color: solveCount == attemptCount && attemptCount > 0
                    ? Colors.green
                    : Colors.orange,
              ),
              title: Text(solveCount == attemptCount && attemptCount > 0
                  ? 'Perfect!'
                  : 'Completed'),
              subtitle: Text('$solveCount / $attemptCount ($successRate%)' +
                  (timeStr.isNotEmpty ? ' in $timeStr' : '')),
            ),
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: switch (windowClass) {
                WindowClass.compact => 3,
                WindowClass.medium => 5,
                WindowClass.expanded => 6,
                WindowClass.large => 6,
                WindowClass.extraLarge => 6,
              },
            ),
            itemCount: completedTasks.length,
            itemBuilder: (context, index) {
              final (ref, solved) = completedTasks[index];
              return TaskPreviewTile(
                task: ref,
                solved: solved,
              );
            },
          ),
        ),
      ),
    );
  }
}
