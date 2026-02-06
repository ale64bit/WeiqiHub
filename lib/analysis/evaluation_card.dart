import 'package:flutter/material.dart';
import 'package:wqhub/analysis/analysis_util.dart';
import 'package:wqhub/analysis/evaluation_bar.dart';
import 'package:wqhub/analysis/katago_response.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/wq/game_tree.dart';

class EvaluationCard extends StatelessWidget {
  final GameTreeNode<KataGoResponse> currentNode;

  const EvaluationCard({super.key, required this.currentNode});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final analysis = currentNode.metadata;
    final loss = nodeLoss(currentNode);
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (analysis == null) CircularProgressIndicator(),
            if (analysis != null) ...[
              EvaluationBar(
                winRate: analysis.rootInfo.winrate,
                scoreLead: analysis.rootInfo.scoreLead,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                      '${loc.winrate}: ${(100 * analysis.rootInfo.winrate).floor()}%',
                      style: TextTheme.of(context).bodyLarge),
                  if (loss != null)
                    Text('Point loss: ${fmtScore(loss.pointLoss)}',
                        style:
                            TextTheme.of(context).bodyLarge), // TODO localize
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
