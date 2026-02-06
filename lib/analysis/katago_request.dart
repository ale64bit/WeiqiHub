import 'package:protobuf/well_known_types/google/protobuf/struct.pb.dart';
import 'package:wqhub/game_client/rules.dart';
import 'package:wqhub/generated/katago.pb.dart' as katagopb;
import 'package:wqhub/wq/wq.dart' as wq;

extension KataGoMove on wq.Move {
  List<String> toKataGoMove() => [
        col.toString(),
        '(${p.$2},${p.$1})',
      ];
}

extension ProtoMove on wq.Move {
  katagopb.Request_Move toProtoMove() => katagopb.Request_Move(
        color: col.toString(),
        point: '(${p.$2},${p.$1})',
      );
}

class KataGoRequest {
  final String id;
  final List<wq.Move> initialStones;
  final wq.Color? initialPlayer;
  final List<wq.Move> moves;
  final Rules rules;
  final double komi;
  final int boardSize;
  final List<int>? analyzeTurns;
  final bool includePolicy;
  final bool includeOwnership;
  final bool includeMovesOwnership;
  final int maxVisits;
  final Map<String, dynamic> overrideSettings;
  final double? reportDuringSearchEvery;
  final Map<String, String> metadata;

  const KataGoRequest({
    required this.id,
    required this.initialStones,
    this.initialPlayer,
    required this.moves,
    required this.rules,
    required this.komi,
    required this.boardSize,
    this.analyzeTurns,
    this.includePolicy = false,
    this.includeOwnership = false,
    this.includeMovesOwnership = false,
    required this.maxVisits,
    required this.overrideSettings,
    this.reportDuringSearchEvery,
    required this.metadata,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'initialStones': initialStones.map((mv) => mv.toKataGoMove()).toList(),
        if (initialPlayer != null) 'initialPlayer': initialPlayer.toString(),
        'moves': moves.map((mv) => mv.toKataGoMove()).toList(),
        'rules': rules.name,
        'komi': komi,
        'boardXSize': boardSize,
        'boardYSize': boardSize,
        if (analyzeTurns != null) 'analyzeTurns': analyzeTurns,
        'includePolicy': includePolicy,
        'includeOwnership': includeOwnership,
        'includeMovesOwnership': includeMovesOwnership,
        'maxVisits': maxVisits,
        'overrideSettings': overrideSettings,
        if (reportDuringSearchEvery != null)
          'reportDuringSearchEvery': reportDuringSearchEvery,
      };

  katagopb.Request toProto() => katagopb.Request(
        id: id,
        initialStones: initialStones.map((mv) => mv.toProtoMove()),
        initialPlayer: initialPlayer?.toString(),
        moves: moves.map((mv) => mv.toProtoMove()),
        rules: rules.name,
        komi: komi,
        boardSize: boardSize,
        analyzeTurns: analyzeTurns,
        includePolicy: includePolicy,
        includeOwnership: includeOwnership,
        includeMovesOwnership: includeMovesOwnership,
        maxVisits: maxVisits,
        reportDuringSearchEvery: reportDuringSearchEvery,
        overrideSettings: overrideSettings.entries.map((e) => MapEntry(
            e.key,
            switch (e.value) {
              num n => Value(numberValue: n.toDouble()),
              bool b => Value(boolValue: b),
              String _ => Value(stringValue: e.value.toString()),
              _ => Value(),
            })),
        metadata: metadata.entries,
      );
}
