import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wqhub/analysis/evaluation_bar.dart';
import 'package:wqhub/analysis/katago_response.dart';
import 'package:wqhub/l10n/app_localizations.dart';

class AnalysisSideBar extends StatelessWidget {
  final KataGoResponse? analysis;
  final List<FlSpot> winrate;
  final List<FlSpot> scoreLead;

  const AnalysisSideBar({
    super.key,
    required this.analysis,
    required this.winrate,
    required this.scoreLead,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    var minScoreLead = 999.0;
    var maxScoreLead = -999.0;
    for (final p in scoreLead) {
      minScoreLead = min(minScoreLead, p.y);
      maxScoreLead = max(maxScoreLead, p.y);
    }
    final noTitles = const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    );
    final chartBackgroundColor = Color.fromARGB(150, 80, 80, 100);
    final winrateChart = LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
        ),
        titlesData: FlTitlesData(
          show: true,
          leftTitles: AxisTitles(
            axisNameWidget: Text('${loc.winrate} (%)'),
            sideTitles: SideTitles(
              reservedSize: 40,
              showTitles: true,
            ),
          ),
          rightTitles: noTitles,
          topTitles: noTitles,
          bottomTitles: noTitles,
        ),
        backgroundColor: chartBackgroundColor,
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: winrate,
            color: Colors.grey,
            barWidth: 1,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.black,
              cutOffY: 50,
              applyCutOffY: true,
            ),
            aboveBarData: BarAreaData(
              show: true,
              color: Colors.white,
              cutOffY: 50,
              applyCutOffY: true,
            ),
          ),
        ],
        minX: 0,
        maxX: winrate.length.toDouble(),
        minY: 0,
        maxY: 100.0,
        extraLinesData: ExtraLinesData(
          horizontalLines: [
            HorizontalLine(y: 50, color: Colors.green.withAlpha(150))
          ],
          verticalLines: [
            if (analysis != null)
              VerticalLine(
                  x: analysis!.turnNumber.toDouble(),
                  color: Colors.amber.withAlpha(100))
          ],
        ),
      ),
    );
    final scoreLeadChart = LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
        ),
        titlesData: FlTitlesData(
          show: true,
          leftTitles: AxisTitles(
            axisNameWidget: Text(loc.scoreLead),
            sideTitles: SideTitles(
              reservedSize: 40,
              interval: 10,
              showTitles: true,
            ),
          ),
          rightTitles: noTitles,
          topTitles: noTitles,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              reservedSize: 40,
              interval: 50,
              showTitles: true,
            ),
          ),
        ),
        backgroundColor: chartBackgroundColor,
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: scoreLead,
            color: Colors.grey,
            barWidth: 1,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.black,
              applyCutOffY: true,
            ),
            aboveBarData: BarAreaData(
              show: true,
              color: Colors.white,
              applyCutOffY: true,
            ),
          ),
        ],
        minX: 0,
        maxX: winrate.length.toDouble(),
        minY: minScoreLead,
        maxY: maxScoreLead,
        extraLinesData: ExtraLinesData(
          horizontalLines: [
            HorizontalLine(y: 0, color: Colors.green.withAlpha(150))
          ],
          verticalLines: [
            if (analysis != null)
              VerticalLine(
                  x: analysis!.turnNumber.toDouble(),
                  color: Colors.amber.withAlpha(100))
          ],
        ),
      ),
    );

    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 8.0,
          children: [
            if (analysis == null) CircularProgressIndicator(),
            if (analysis != null) ...[
              EvaluationBar(
                winRate: analysis!.rootInfo.winRate,
                scoreLead: analysis!.rootInfo.scoreLead,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                      '${loc.winrate}: ${(100 * analysis!.rootInfo.winRate).floor()}%',
                      style: TextTheme.of(context).bodyLarge),
                  Text(
                      '${loc.scoreLead}: ${fmtScore(analysis!.rootInfo.scoreLead)}',
                      style: TextTheme.of(context).bodyLarge),
                ],
              ),
            ],
            Expanded(child: winrateChart),
            SizedBox(height: 8.0),
            Expanded(child: scoreLeadChart),
          ],
        ),
      ),
    );
  }
}
