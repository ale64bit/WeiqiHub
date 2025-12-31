import 'package:wqhub/game_client/rules.dart';
import 'package:wqhub/wq/wq.dart' as wq;

extension KataGoMove on wq.Move {
  List<String> toKataGoMove() => [
        col.toString(),
        '(${p.$2},${p.$1})',
      ];
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
  });

  Map<String, dynamic> toJson() {
    return {
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
  }
}
