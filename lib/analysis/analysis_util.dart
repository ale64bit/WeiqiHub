import 'package:flutter/material.dart';
import 'package:wqhub/analysis/katago_response.dart';
import 'package:wqhub/wq/game_tree.dart';
import 'package:wqhub/wq/wq.dart' as wq;

final pointLossBands = <(double, Color)>[
  (-12, Colors.purple),
  (-6, Colors.red),
  (-3, Colors.orange),
  (-1.5, Colors.lime),
  (-0.5, Colors.lightGreen),
  (0.5, Colors.green),
];

class NodeLoss {
  final double pointLoss;
  final double winrateLoss;

  const NodeLoss({required this.pointLoss, required this.winrateLoss});
}

double loss(wq.Color turn, double from, double to) => switch (turn) {
      wq.Color.black => to - from,
      wq.Color.white => from - to,
    };

NodeLoss? nodeLoss(GameTreeNode<KataGoResponse> node) {
  if (node.move == null) return null;
  final (:col, :p) = node.move!;
  if (node.parent == null || node.parent!.metadata == null) return null;
  // First, try to compute it directly from parent
  final parent = node.parent!;
  final md = parent.metadata!;
  for (final info in md.moveInfos) {
    if (info.move == p) {
      return NodeLoss(
        pointLoss: loss(col, md.rootInfo.scoreLead, info.scoreLead),
        winrateLoss: loss(col, md.rootInfo.winrate, info.winrate),
      );
    }
  }
  // Otherwise, try to compute it from current node root rootInfo
  if (node.metadata == null) return null;
  return NodeLoss(
    pointLoss:
        loss(col, md.rootInfo.scoreLead, node.metadata!.rootInfo.scoreLead),
    winrateLoss:
        loss(col, md.rootInfo.winrate, node.metadata!.rootInfo.winrate),
  );
}

int pointLossBandIndex(double pointLoss) {
  for (final (i, (loss, _)) in pointLossBands.indexed) {
    if (pointLoss < loss) {
      return i;
    }
  }
  return pointLossBands.length - 1;
}

Color pointLossColor(double pointLoss) =>
    pointLossBands[pointLossBandIndex(pointLoss)].$2;

String fmtScore(double x) {
  final dec = x.toInt();
  final frac = (x.abs() * 10).toInt() % 10;
  return '$dec.$frac';
}
