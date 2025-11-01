import 'dart:convert';
import 'package:wqhub/wq/wq.dart' as wq;
import 'package:wqhub/game_client/game_record.dart';

class PandanetSgfParser {
  static GameRecord parse(String sgfStr) {
    final moves = <wq.Move>[];
    final cleaned = sgfStr
        .replaceAll('\r', '')
        .replaceAll('\n', ' ')
        .replaceAll('\t', ' ')
        .replaceAllMapped(RegExp(r'\s+'), (_) => ' ')
        .trim();

    final moveExp = RegExp(r';\s*([BW])\s*\[([a-s]{0,2})\]', caseSensitive: false);
    for (final m in moveExp.allMatches(cleaned)) {
      final color = m.group(1)!.toUpperCase() == 'B'
          ? wq.Color.black
          : wq.Color.white;
      final coords = m.group(2) ?? '';
      if (coords.isEmpty) continue;
      try {
        moves.add((col: color, p: wq.parseSgfPoint(coords)));
      } catch (_) {
        // Misformated, skip, maybe throw ex.?
      }
    }

    return GameRecord(
      moves: moves,
      type: GameRecordType.sgf,
      rawData: utf8.encode(sgfStr),
    );
  }
}
