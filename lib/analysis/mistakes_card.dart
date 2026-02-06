import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wqhub/analysis/analysis_util.dart';
import 'package:wqhub/analysis/katago_response.dart';
import 'package:wqhub/wq/game_tree.dart';

class MistakesCard extends StatelessWidget {
  final GameTreeNode<KataGoResponse> rootNode;
  final Function(int) onTapMove;

  const MistakesCard(
      {super.key, required this.rootNode, required this.onTapMove});

  @override
  Widget build(BuildContext context) {
    final mistakes = _computeMistakes();
    return Card(
      child: Column(
        spacing: 8.0,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Mistakes',
                style: TextTheme.of(context).titleLarge), // TODO localize
          ),
          Expanded(
            child: Row(
              spacing: 8.0,
              children: [
                for (int i = 0; i < 2; ++i)
                  Expanded(
                    child: ListView(
                      children: [
                        for (final mistake in mistakes[i])
                          ListTile(
                            leading: Text('${mistake.moveNumber}'),
                            title: Text(
                              fmtScore(mistake.pointLoss),
                              style: DefaultTextStyle.of(context)
                                  .style
                                  .copyWith(
                                    color: pointLossColor(mistake.pointLoss),
                                  ),
                            ),
                            trailing:
                                Text('${(100 * mistake.winrateLoss).toInt()}%'),
                            onTap: () => onTapMove(mistake.moveNumber),
                          )
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<List<_Mistake>> _computeMistakes() {
    final mistakes = [<_Mistake>[], <_Mistake>[]];
    var cur = rootNode;
    while (cur.next != null) {
      cur = cur.next!;
      final loss = nodeLoss(cur);
      if (loss != null && cur.move != null) {
        final turn = cur.move!.col.index;
        mistakes[turn].add(_Mistake(
          moveNumber: cur.moveNumber,
          pointLoss: loss.pointLoss,
          winrateLoss: loss.winrateLoss,
        ));
      }
    }
    for (final m in mistakes) {
      m.sort((a, b) {
        final wa = sqrt(a.winrateLoss < 0 ? -a.winrateLoss : 0);
        final wb = sqrt(b.winrateLoss < 0 ? -b.winrateLoss : 0);
        final la = wa * a.pointLoss;
        final lb = wb * b.pointLoss;
        if (la != lb) {
          return la.compareTo(lb);
        }
        return a.moveNumber.compareTo(b.moveNumber);
      });
    }
    return mistakes;
  }
}

class _Mistake {
  final int moveNumber;
  final double pointLoss;
  final double winrateLoss;

  const _Mistake(
      {required this.moveNumber,
      required this.pointLoss,
      required this.winrateLoss});
}
