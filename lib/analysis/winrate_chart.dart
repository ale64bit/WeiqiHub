import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wqhub/analysis/katago_response.dart';
import 'package:wqhub/wq/game_tree.dart';

class WinrateChart extends StatelessWidget {
  final GameTreeNode<KataGoResponse> currentNode;
  final List<FlSpot> winrate;
  final Function(int) onTapMove;

  const WinrateChart(
      {super.key,
      required this.currentNode,
      required this.winrate,
      required this.onTapMove});

  @override
  Widget build(BuildContext context) {
    final noTitles = const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    );
    final chartBackgroundColor = Color.fromARGB(150, 80, 80, 100);
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
              showTitles: true,
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
        lineTouchData: LineTouchData(
          touchCallback: (FlTouchEvent event, LineTouchResponse? resp) {
            if (event is FlTapDownEvent && resp != null) {
              final moveNumber = resp.touchChartCoordinate.dx.floor();
              onTapMove(moveNumber);
            }
          },
        ),
        minX: 0,
        maxX: winrate.length.toDouble(),
        minY: 0,
        maxY: 100.0,
        extraLinesData: ExtraLinesData(
          horizontalLines: [
            HorizontalLine(y: 50, color: Colors.green.withAlpha(150))
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
