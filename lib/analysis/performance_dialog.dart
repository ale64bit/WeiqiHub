import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wqhub/analysis/analysis_util.dart';
import 'package:wqhub/analysis/katago_response.dart';
import 'package:wqhub/game_client/game_client.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/play/player_card.dart';
import 'package:wqhub/wq/game_tree.dart';
import 'package:wqhub/wq/wq.dart' as wq;

class PerformanceDialog extends StatelessWidget {
  final GameSummary summary;
  final GameTreeNode<KataGoResponse> rootNode;
  const PerformanceDialog(
      {super.key, required this.summary, required this.rootNode});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final stats = _computeMoveCounts();
    final blackPlayerCard = PlayerCard(
      key: ValueKey('player-card-black'),
      userInfo: summary.black,
      color: wq.Color.black,
      timeDisplay: SizedBox(),
      alignment: PlayerCardAlignment.left,
    );
    final whitePlayerCard = PlayerCard(
      key: ValueKey('player-card-white'),
      userInfo: summary.white,
      color: wq.Color.white,
      timeDisplay: SizedBox(),
      alignment: PlayerCardAlignment.right,
    );
    return AlertDialog(
      title: Center(child: const Text('Performance')), // TODO localize
      content: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 400),
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: {
            0: FractionColumnWidth(2 / 5),
            1: FractionColumnWidth(1 / 5),
            2: FractionColumnWidth(2 / 5),
          },
          children: <TableRow>[
            for (final (i, (loss, color)) in pointLossBands.indexed)
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: _MoveCountBar(
                      moveCount: stats.moveCount[0][i],
                      totalCount: stats.totalMoves[0],
                      color: color,
                      direction: TextDirection.rtl,
                    ),
                  ),
                  Text(
                    loss > 0 ? '< $loss' : '≥ ${-loss}',
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: _MoveCountBar(
                      moveCount: stats.moveCount[1][i],
                      totalCount: stats.totalMoves[1],
                      color: color,
                      direction: TextDirection.ltr,
                    ),
                  ),
                ],
              ),
            TableRow(
              children: [
                const SizedBox(),
                Text(
                  'Point loss', // TODO localize
                  textAlign: TextAlign.center,
                ),
                const SizedBox(),
              ],
            ),
            TableRow(
              children: [
                const SizedBox(height: 24),
                const SizedBox(height: 24),
                const SizedBox(height: 24),
              ],
            ),
            TableRow(
              children: [
                Text(fmtScore(-stats.meanLoss[0]), textAlign: TextAlign.center),
                Text(
                  'Mean loss', // TODO localize
                  textAlign: TextAlign.center,
                ),
                Text(fmtScore(-stats.meanLoss[1]), textAlign: TextAlign.center),
              ],
            ),
            TableRow(
              children: [
                blackPlayerCard,
                Text('VS', textAlign: TextAlign.center),
                whitePlayerCard,
              ],
            ),
          ].reversed.toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(loc.ok),
        ),
      ],
    );
  }

  _MoveStats _computeMoveCounts() {
    final totalMoves = [0, 0];
    final meanLoss = [.0, .0];
    final moveCounts = [
      List.filled(pointLossBands.length, 0),
      List.filled(pointLossBands.length, 0),
    ];
    var cur = rootNode;
    while (cur.next != null) {
      cur = cur.next!;
      final loss = nodeLoss(cur);
      if (loss != null && cur.move != null) {
        final turn = cur.move!.col.index;
        totalMoves[turn]++;
        meanLoss[turn] += loss.pointLoss;
        moveCounts[turn][pointLossBandIndex(loss.pointLoss)]++;
      }
    }
    for (int i = 0; i < 2; ++i) {
      meanLoss[i] /= max(1, totalMoves[i]);
    }
    return _MoveStats(
      totalMoves: totalMoves,
      moveCount: moveCounts,
      meanLoss: meanLoss,
    );
  }
}

class _MoveStats {
  final List<int> totalMoves;
  final List<List<int>> moveCount;
  final List<double> meanLoss;

  _MoveStats(
      {required this.totalMoves,
      required this.moveCount,
      required this.meanLoss});
}

class _MoveCountBar extends StatelessWidget {
  final int moveCount;
  final int totalCount;
  final Color color;
  final TextDirection direction;

  const _MoveCountBar(
      {required this.moveCount,
      required this.totalCount,
      required this.color,
      required this.direction});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.center,
      children: [
        Transform.flip(
          flipX: direction == TextDirection.rtl,
          child: LinearProgressIndicator(
            minHeight: 30,
            borderRadius: BorderRadius.circular(4.0),
            color: color,
            value: moveCount / totalCount,
          ),
        ),
        Text('$moveCount'),
      ],
    );
  }
}
