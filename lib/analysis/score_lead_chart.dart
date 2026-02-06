import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wqhub/analysis/katago_response.dart';
import 'package:wqhub/wq/game_tree.dart';

class ScoreLeadChart extends StatelessWidget {
  final GameTreeNode<KataGoResponse> currentNode;
  final List<FlSpot> scoreLead;
  final Function(int) onTapMove;

  const ScoreLeadChart(
      {super.key,
      required this.currentNode,
      required this.scoreLead,
      required this.onTapMove});

  @override
  Widget build(BuildContext context) {
    final noTitles = const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    );
    final chartBackgroundColor = Color.fromARGB(150, 80, 80, 100);
    var minScoreLead = 999.0;
    var maxScoreLead = -999.0;
    for (final p in scoreLead) {
      minScoreLead = min(minScoreLead, p.y);
      maxScoreLead = max(maxScoreLead, p.y);
    }
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
        ),
        titlesData: FlTitlesData(
          show: true,
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              reservedSize: 40,
              interval: 10,
              showTitles: true,
              minIncluded: false,
              maxIncluded: false,
            ),
          ),
          rightTitles: noTitles,
          topTitles: noTitles,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              reservedSize: 24,
              interval: 50,
              showTitles: true,
              minIncluded: false,
              maxIncluded: false,
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
        lineTouchData: LineTouchData(
          touchCallback: (FlTouchEvent event, LineTouchResponse? resp) {
            if (event is FlTapDownEvent && resp != null) {
              final moveNumber = resp.touchChartCoordinate.dx.floor();
              onTapMove(moveNumber);
            }
          },
        ),
        minX: 0,
        maxX: scoreLead.length.toDouble(),
        minY: 1.2 * minScoreLead,
        maxY: 1.2 * maxScoreLead,
        extraLinesData: ExtraLinesData(
          horizontalLines: [
            HorizontalLine(y: 0, color: Colors.green.withAlpha(150))
          ],
          verticalLines: [
            VerticalLine(
                x: currentNode.moveNumber.toDouble(),
                color: Colors.amber.withAlpha(100))
          ],
        ),
      ),
    );
  }
}
