import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class P2PPlayer {
  final String name;
  final bool ready;
  final bool isCreator;
  final bool hasResults;
  final Map<String, dynamic>? results;

  P2PPlayer({
    required this.name,
    required this.ready,
    required this.isCreator,
    required this.hasResults,
    this.results,
  });

  factory P2PPlayer.fromJson(Map<String, dynamic> json) {
    return P2PPlayer(
      name: json['name'],
      ready: json['ready'],
      isCreator: json['isCreator'],
      hasResults: json['hasResults'],
      results: json['results'],
    );
  }
}

class P2PRoomSettings {
  final List<String> taskUris;
  final int timeLimitSeconds;
  final int taskCount;
  final int minRankIndex;
  final int maxRankIndex;
  final int taskSourceTypeIndex;
  final List<int>? taskTypeIndices;
  final int? taskTagIndex;
  final List<int>? taskSubtagIndices;

  P2PRoomSettings({
    required this.taskUris,
    required this.timeLimitSeconds,
    required this.taskCount,
    required this.minRankIndex,
    required this.maxRankIndex,
    required this.taskSourceTypeIndex,
    this.taskTypeIndices,
    this.taskTagIndex,
    this.taskSubtagIndices,
  });

  Map<String, dynamic> toJson() => {
        'taskUris': taskUris,
        'timeLimitSeconds': timeLimitSeconds,
        'taskCount': taskCount,
        'minRankIndex': minRankIndex,
        'maxRankIndex': maxRankIndex,
        'taskSourceTypeIndex': taskSourceTypeIndex,
        'taskTypeIndices': taskTypeIndices,
        'taskTagIndex': taskTagIndex,
        'taskSubtagIndices': taskSubtagIndices,
      };

  factory P2PRoomSettings.fromJson(Map<String, dynamic> json) {
    return P2PRoomSettings(
      taskUris: List<String>.from(json['taskUris']),
      timeLimitSeconds: json['timeLimitSeconds'],
      taskCount: json['taskCount'] ?? 0,
      minRankIndex: json['minRankIndex'] ?? 0,
      maxRankIndex: json['maxRankIndex'] ?? 0,
      taskSourceTypeIndex: json['taskSourceTypeIndex'] ?? 0,
      taskTypeIndices: json['taskTypeIndices'] != null
          ? List<int>.from(json['taskTypeIndices'])
          : null,
      taskTagIndex: json['taskTagIndex'],
      taskSubtagIndices: json['taskSubtagIndices'] != null
          ? List<int>.from(json['taskSubtagIndices'])
          : null,
    );
  }
}

class P2PChatMessage {
  final String sender;
  final String text;
  final DateTime timestamp;

  P2PChatMessage({
    required this.sender,
    required this.text,
    required this.timestamp,
  });

  factory P2PChatMessage.fromJson(Map<String, dynamic> json) {
    return P2PChatMessage(
      sender: json['sender'],
      text: json['text'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp']),
    );
  }
}

class P2PState {
  final IList<P2PPlayer> players;
  final P2PRoomSettings? roomSettings;
  final bool battleStarted;
  final bool battleFinished;
  final DateTime? startTime;
  final DateTime serverTime;

  P2PState({
    required this.players,
    this.roomSettings,
    required this.battleStarted,
    required this.serverTime,
    this.battleFinished = false,
    this.startTime,
  });

  factory P2PState.fromJson(Map<String, dynamic> json) {
    return P2PState(
      players:
          (json['players'] as List).map((p) => P2PPlayer.fromJson(p)).toIList(),
      roomSettings: json['roomSettings'] != null
          ? P2PRoomSettings.fromJson(json['roomSettings'])
          : null,
      battleStarted: json['battleStarted'],
      battleFinished: json['battleFinished'] ?? false,
      startTime: json['startTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['startTime'])
          : null,
      serverTime: DateTime.fromMillisecondsSinceEpoch(json['serverTime']),
    );
  }
}
