import 'dart:convert';
import 'package:wqhub/parse/gib/gib.dart';
import 'package:wqhub/parse/sgf/sgf.dart';
import 'package:wqhub/wq/wq.dart' as wq;

enum GameRecordType {
  sgf,
  gib,
}

class GameRecord {
  final List<wq.Move> moves;
  final GameRecordType type;
  final List<int> rawData;

  factory GameRecord.fromSgf(String sgfStr) {
    final sgf = Sgf.parse(sgfStr);
    if (sgf.trees.isEmpty) throw const FormatException('Empty SGF');
    final tree = sgf.trees.first;
    if (tree.nodes.length < 2) {
      throw const FormatException('Not enough SGF nodes');
    }

    final moves = <wq.Move>[];
    for (final node in tree.nodes.skip(1)) {
      if (node.containsKey('B')) {
        moves.add((col: wq.Color.black, p: wq.parseSgfPoint(node['B']!.first)));
      } else if (node.containsKey('W')) {
        moves.add((col: wq.Color.white, p: wq.parseSgfPoint(node['W']!.first)));
      }
    }
    return GameRecord(
      moves: moves,
      type: GameRecordType.sgf,
      rawData: utf8.encode(sgfStr),
    );
  }

  factory GameRecord.fromGib(List<int> gibData) {
    final gib = Gib.parse(gibData);

    final moves = <wq.Move>[];
    for (final entry in gib.game) {
      switch (entry.cmd) {
        case 'STO':
          final col = int.parse(entry.args[2]);
          final r = int.parse(entry.args[4]);
          final c = int.parse(entry.args[3]);
          if (col == 1 || col == 2) {
            moves.add(
                (col: col == 1 ? wq.Color.black : wq.Color.white, p: (r, c)));
          }
      }
    }
    return GameRecord(
      moves: moves,
      type: GameRecordType.gib,
      rawData: gibData,
    );
  }

  GameRecord({required this.moves, required this.type, required this.rawData});
}
