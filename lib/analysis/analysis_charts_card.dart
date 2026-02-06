import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wqhub/analysis/katago_response.dart';
import 'package:wqhub/analysis/score_lead_chart.dart';
import 'package:wqhub/analysis/winrate_chart.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/wq/game_tree.dart';

class AnalysisChartsCard extends StatelessWidget {
  final GameTreeNode<KataGoResponse> currentNode;
  final List<FlSpot> winrate;
  final List<FlSpot> scoreLead;
  final Function(int) onTapMove;

  const AnalysisChartsCard({
    super.key,
    required this.currentNode,
    required this.winrate,
    required this.scoreLead,
    required this.onTapMove,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final scoreLeadChart = ScoreLeadChart(
      currentNode: currentNode,
      scoreLead: scoreLead,
      onTapMove: onTapMove,
    );
    final winrateChart = WinrateChart(
      currentNode: currentNode,
      winrate: winrate,
      onTapMove: onTapMove,
    );
    return DefaultTabController(
      length: 2,
      child: Card(
        margin: EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(text: loc.scoreLead),
                  Tab(text: loc.winrate),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: scoreLeadChart,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: winrateChart,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
