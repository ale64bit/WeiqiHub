import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wqhub/p2p_battle/p2p_battle_page.dart';
import 'package:wqhub/p2p_battle/p2p_client.dart';
import 'package:wqhub/p2p_battle/p2p_models.dart';
import 'package:wqhub/train/rank_range.dart';
import 'package:wqhub/train/task_db.dart';
import 'package:wqhub/train/task_source/task_source_type.dart';
import 'package:wqhub/train/task_type.dart';
import 'package:wqhub/train/variation_tree.dart';
import 'package:wqhub/wq/rank.dart';
import 'package:wqhub/input/int_form_field.dart';
import 'package:wqhub/input/duration_form_field.dart';
import 'package:wqhub/input/rank_range_form_field.dart';
import 'package:wqhub/window_class_aware_state.dart';

class P2PLobbyArguments {
  final String roomId;
  final String playerName;
  final String serverUrl;
  final P2PClient? client;

  P2PLobbyArguments({
    required this.roomId,
    required this.playerName,
    required this.serverUrl,
    this.client,
  });
}

class P2PLobbyPage extends StatefulWidget {
  static const routeName = '/p2p/lobby';

  final P2PLobbyArguments args;

  const P2PLobbyPage({super.key, required this.args});

  @override
  State<P2PLobbyPage> createState() => _P2PLobbyPageState();
}

class _P2PLobbyPageState extends WindowClassAwareState<P2PLobbyPage> {
  late P2PClient _client;
  P2PState? _state;
  bool _ready = false;
  bool _isStartingBattle = false;
  String? _errorMessage;
  final List<P2PChatMessage> _messages = [];
  final _chatController = TextEditingController();

  // Task selection state for creator
  final _formKey = GlobalKey<FormState>();
  var _taskCount = 10;
  var _timeLimit = Duration(minutes: 5);
  var _rankRange = RankRange(from: Rank.k15, to: Rank.d7);
  var _taskSourceType = TaskSourceType.values.first;
  final _taskTypes = {TaskType.lifeAndDeath, TaskType.tesuji};

  @override
  void initState() {
    super.initState();
    if (widget.args.client != null) {
      _client = widget.args.client!;
    } else {
      _client = P2PClient(widget.args.serverUrl);
      _client.joinRoom(widget.args.roomId, widget.args.playerName);
    }

    _client.onStateUpdate = (state) {
      if (mounted) {
        final myPlayer =
            state.players.firstWhere((p) => p.name == widget.args.playerName);
        final wasCreator = _state?.players
                .firstWhere((p) => p.name == widget.args.playerName)
                .isCreator ??
            false;

        setState(() {
          _state = state;
          _errorMessage = null;

          if (myPlayer.isCreator && !wasCreator && state.roomSettings != null) {
            _syncSettings(state.roomSettings!);
          }
        });

        if (state.battleStarted &&
            !state.battleFinished &&
            !_isStartingBattle &&
            state.startTime != null) {
          _navigateToBattle(state.startTime!, state.serverTime);
        }
      }
    };
    _client.onError = (error) {
      if (mounted) {
        setState(() {
          _errorMessage = error.toString();
        });
      }
    };
    _client.onBattleStarted = (startTime, serverTime) {
      if (mounted && _state?.roomSettings != null) {
        _navigateToBattle(startTime, serverTime);
      }
    };
    _client.onChatMessage = (message) {
      if (mounted) {
        setState(() {
          _messages.add(message);
        });
      }
    };
    _client.onKicked = () {
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('You have been kicked from the room')));
      }
    };

    _client.requestState();
  }

  void _navigateToBattle(DateTime startTime, DateTime serverTime) {
    setState(() => _isStartingBattle = true);
    final offset = serverTime.difference(DateTime.now());
    final adjustedStartTime = startTime.subtract(offset);

    Navigator.pushReplacementNamed(
      context,
      P2PBattlePage.routeName,
      arguments: P2PBattleArguments(
        client: _client,
        settings: _state!.roomSettings!,
        startTime: adjustedStartTime,
        roomId: widget.args.roomId,
        playerName: widget.args.playerName,
      ),
    );
  }

  @override
  void dispose() {
    _chatController.dispose();
    if (!_isStartingBattle) {
      _client.disconnect();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_errorMessage != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, color: Colors.red, size: 64),
                const SizedBox(height: 16),
                Text(_errorMessage!, textAlign: TextAlign.center),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Go Back'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (_state == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final currentPlayer =
        _state!.players.firstWhere((p) => p.name == widget.args.playerName);
    final isCreator = currentPlayer.isCreator;

    if (!isWindowClassCompact) {
      return Scaffold(
        appBar: _buildAppBar(),
        body: Row(
          children: [
            Expanded(
              flex: 1,
              child: _buildPlayersAndChat(isCreator),
            ),
            const VerticalDivider(),
            Expanded(
              flex: 2,
              child: isCreator ? _buildCreatorSetup() : _buildPlayerPreview(),
            ),
          ],
        ),
        bottomNavigationBar: _buildBottomBar(isCreator),
      );
    } else {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: _buildAppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Players & Chat', icon: Icon(Icons.people)),
                Tab(text: 'Settings', icon: Icon(Icons.settings)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _buildPlayersAndChat(isCreator),
              isCreator ? _buildCreatorSetup() : _buildPlayerPreview(),
            ],
          ),
          bottomNavigationBar: _buildBottomBar(isCreator),
        ),
      );
    }
  }

  AppBar _buildAppBar({PreferredSizeWidget? bottom}) {
    return AppBar(
      title: Text('Lobby: ${widget.args.roomId}'),
      actions: [
        IconButton(
          icon: const Icon(Icons.copy),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: widget.args.roomId));
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Room ID copied')));
          },
        ),
      ],
      bottom: bottom,
    );
  }

  Widget _buildPlayersAndChat(bool isCreator) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: ListView.builder(
            itemCount: _state!.players.length,
            itemBuilder: (context, index) {
              final p = _state!.players[index];
              return ListTile(
                leading: Icon(
                    p.ready ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: p.ready ? Colors.green : Colors.grey),
                title: Text(p.name + (p.isCreator ? ' (Creator)' : '')),
                trailing: isCreator && !p.isCreator
                    ? IconButton(
                        icon:
                            const Icon(Icons.person_remove, color: Colors.red),
                        onPressed: () => _client.kickPlayer(p.name),
                      )
                    : null,
              );
            },
          ),
        ),
        const Divider(),
        Expanded(
          flex: 3,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Text('Chat', style: Theme.of(context).textTheme.titleSmall),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final m = _messages[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: [
                            TextSpan(
                                text: '${m.sender}: ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            TextSpan(text: m.text),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _chatController,
                        decoration: const InputDecoration(
                            hintText: 'Type a message...'),
                        onSubmitted: (_) => _sendChat(),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: _sendChat,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(bool isCreator) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!isCreator || _state!.roomSettings != null)
            ElevatedButton(
              onPressed: () {
                setState(() => _ready = !_ready);
                _client.setReady(_ready);
              },
              child: Text(_ready ? 'Not Ready' : 'Ready'),
            ),
          if (isCreator) ...[
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: _allReady() ? _startBattle : null,
              child: const Text('Start Battle'),
            ),
          ],
        ],
      ),
    );
  }

  bool _allReady() {
    if (_state!.players.length < 2) return false;
    return _state!.players.every((p) => p.ready);
  }

  void _startBattle() {
    _client.startBattle();
  }

  void _sendChat() {
    if (_chatController.text.trim().isNotEmpty) {
      _client.sendChat(_chatController.text.trim());
      _chatController.clear();
    }
  }

  void _syncSettings(P2PRoomSettings settings) {
    _taskCount = settings.taskCount;
    _timeLimit = Duration(seconds: settings.timeLimitSeconds);
    _rankRange = RankRange(
      from: Rank.values[settings.minRankIndex],
      to: Rank.values[settings.maxRankIndex],
    );
    _taskSourceType = TaskSourceType.values[settings.taskSourceTypeIndex];
    if (settings.taskTypeIndices != null) {
      _taskTypes.clear();
      _taskTypes
          .addAll(settings.taskTypeIndices!.map((i) => TaskType.values[i]));
    }
  }

  int _availableTasks() => switch (_taskSourceType) {
        TaskSourceType.fromTaskTypes =>
          TaskDB().taskCountByType(_rankRange, _taskTypes),
        TaskSourceType.fromTaskTag => 0,
        TaskSourceType.fromMistakes => 0,
      };

  Widget _buildCreatorSetup() {
    final count = _availableTasks();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          spacing: 16,
          children: [
            Text('Room Settings',
                style: Theme.of(context).textTheme.titleLarge),
            intFormField(
              context,
              initialValue: _taskCount,
              label: 'Number of tasks',
              minValue: 1,
              maxValue: 333,
              onChanged: (v) => _taskCount = v,
            ),
            DurationFormField(
              initialValue: _timeLimit,
              label: 'Total Battle Time',
              validator: (duration) {
                if (duration != null && duration == Duration.zero) {
                  return 'Must be greater than zero';
                }
                return null;
              },
              onChanged: (v) => _timeLimit = v,
            ),
            RankRangeFormField(
              initialValue: _rankRange,
              validator: (rankRange) {
                if (rankRange!.from.index > rankRange.to.index) {
                  return 'Min rank must be less or equal than max rank';
                }
                return null;
              },
              onChanged: (v) => setState(() => _rankRange = v),
            ),
            // Minimalist version of filter selection
            Wrap(
              spacing: 8,
              children: [
                for (final type in TaskType.values)
                  FilterChip(
                    label: Text(type.name),
                    selected: _taskTypes.contains(type),
                    onSelected: (selected) => setState(() {
                      selected ? _taskTypes.add(type) : _taskTypes.remove(type);
                    }),
                  )
              ],
            ),
            Text('$count tasks available'),
            ElevatedButton(
              onPressed: count > 0 ? _confirmSettings : null,
              child: const Text('Confirm Settings'),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmSettings() {
    if (!_formKey.currentState!.validate()) return;

    // Resolve tasks
    final db = TaskDB();
    final List<String> uris = [];

    final source = switch (_taskSourceType) {
      TaskSourceType.fromTaskTypes =>
        db.taskSourceByTypes(_rankRange, ISet(_taskTypes)),
      TaskSourceType.fromTaskTag => throw UnimplementedError(),
      TaskSourceType.fromMistakes => throw UnimplementedError(),
    };

    for (int i = 0; i < _taskCount; i++) {
      uris.add(source.task.ref.uri());
      source.next(VariationStatus.correct, Duration.zero);
    }

    _client.setupTasks(P2PRoomSettings(
      taskUris: uris,
      timeLimitSeconds: _timeLimit.inSeconds,
      taskCount: _taskCount,
      minRankIndex: _rankRange.from.index,
      maxRankIndex: _rankRange.to.index,
      taskSourceTypeIndex: _taskSourceType.index,
      taskTypeIndices: _taskTypes.map((e) => e.index).toList(),
      taskTagIndex: null,
      taskSubtagIndices: null,
    ));
  }

  Widget _buildPlayerPreview() {
    final settings = _state!.roomSettings;
    if (settings == null) {
      return const Center(
          child: Text('Waiting for creator to select tasks...'));
    }

    final minRank = Rank.values[settings.minRankIndex];
    final maxRank = Rank.values[settings.maxRankIndex];
    final sourceType = TaskSourceType.values[settings.taskSourceTypeIndex];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Battle Settings',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          _SettingsRow(
              label: 'Number of tasks', value: '${settings.taskCount}'),
          _SettingsRow(
              label: 'Total Time', value: '${settings.timeLimitSeconds} s'),
          _SettingsRow(label: 'Ranks', value: '$minRank - $maxRank'),
          _SettingsRow(
              label: 'Source',
              value: switch (sourceType) {
                TaskSourceType.fromTaskTypes => 'Task Types',
                _ => sourceType.name,
              }),
          if (settings.taskTypeIndices != null &&
              settings.taskSourceTypeIndex ==
                  TaskSourceType.fromTaskTypes.index)
            _SettingsRow(
              label: 'Types',
              value: settings.taskTypeIndices!
                  .map((i) => TaskType.values[i].name)
                  .join(', '),
            ),
        ],
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  final String label;
  final String value;

  const _SettingsRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
