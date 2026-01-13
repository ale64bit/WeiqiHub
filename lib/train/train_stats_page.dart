import 'dart:collection';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wqhub/input/rank_range_form_field.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/stats/stats_db.dart';
import 'package:wqhub/train/grading_exam_ranks.dart';
import 'package:wqhub/train/rank_range.dart';
import 'package:wqhub/wq/rank.dart';

class TrainStatsPage extends StatefulWidget {
  static const routeName = '/train/stats';

  const TrainStatsPage({super.key});

  @override
  State<TrainStatsPage> createState() => _TrainStatsPageState();
}

class _TrainStatsPageState extends State<TrainStatsPage> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(loc.statistics),
        ),
        body: <Widget>[
          _CalendarPage(),
          _ChartsPage(),
          _ByRankPage(),
          _ByTypePage(),
        ][currentPage],
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentPage,
          onDestinationSelected: (index) {
            setState(() {
              currentPage = index;
            });
          },
          destinations: <NavigationDestination>[
            NavigationDestination(
              icon: Icon(Icons.calendar_month),
              label: loc.sortModeRecent,
            ),
            NavigationDestination(
              icon: Icon(Icons.area_chart),
              label: loc.charts,
            ),
            NavigationDestination(
              icon: Icon(Icons.list),
              label: loc.byRank,
            ),
            NavigationDestination(
              icon: Icon(Icons.hexagon),
              label: loc.byType,
            ),
          ],
        ),
      ),
    );
  }
}

class _TimePeriodTab extends StatefulWidget {
  final String dateLabel;
  final DateFormat dateFormat;
  final DateTime since;

  const _TimePeriodTab({
    required this.dateLabel,
    required this.dateFormat,
    required this.since,
  });

  @override
  State<_TimePeriodTab> createState() => _TimePeriodTabState();
}

class _TimePeriodTabState extends State<_TimePeriodTab> {
  late final dailyStatsFut =
      Future(() => StatsDB().taskDailyStatsSince(widget.since));
  late final examEntriesFut =
      Future(() => StatsDB().examsSince(widget.since).reversed);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final isCompact = MediaQuery.sizeOf(context).width < 600;
    final passedIcon = Icon(Icons.check, color: Colors.green);
    final failedIcon = Icon(Icons.close, color: Colors.red);
    final taskDailyStatsText = FutureBuilder(
        future: dailyStatsFut,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final (correctCount, wrongCount) = snapshot.data!;
            final totalCount = correctCount + wrongCount;
            return Text(
                '$correctCount / $totalCount  (${(100 * correctCount / max(totalCount, 1)).floor()}%)',
                style: TextTheme.of(context).titleLarge);
          }
          return CircularProgressIndicator();
        });
    final examTable = FutureBuilder(
      future: examEntriesFut,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final entries = snapshot.data!;
          return Expanded(
            child: SingleChildScrollView(
              child: DataTable(
                columnSpacing: 8,
                columns: <DataColumn>[
                  DataColumn(label: Text(widget.dateLabel)),
                  DataColumn(label: Text(loc.type)),
                  DataColumn(label: Text(loc.rank)),
                  DataColumn(label: Text(loc.result)),
                  if (!isCompact)
                    DataColumn(label: Text(loc.statsDurationColumn)),
                ],
                rows: <DataRow>[
                  for (final entry in entries)
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text(widget.dateFormat.format(entry.date))),
                        DataCell(Text(entry.event.toLocalizedString(loc),
                            softWrap: false, overflow: TextOverflow.fade)),
                        DataCell(Text(entry.rankRange.toString())),
                        DataCell(
                          Row(
                            spacing: 4.0,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              (entry.passed ? passedIcon : failedIcon),
                              Text(
                                  '${entry.correctCount} / ${entry.correctCount + entry.wrongCount}'),
                            ],
                          ),
                        ),
                        if (!isCompact)
                          DataCell(Text('${entry.duration.inSeconds}s')),
                      ],
                    )
                ],
              ),
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8.0,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: taskDailyStatsText,
            ),
          ),
        ),
        examTable,
      ],
    );
  }
}

class _RankTotalIndicator extends StatelessWidget {
  final Rank rank;

  const _RankTotalIndicator({required this.rank});

  @override
  Widget build(BuildContext context) {
    final pass = context.stats.getTotalPassCount(rank);
    final fail = context.stats.getTotalFailCount(rank);
    final value = (pass / max(pass + fail, 1));
    return ListTile(
      leading: Text(rank.toString()),
      title: LinearProgressIndicator(value: value),
      subtitle: Text('$pass / ${pass + fail}'),
      trailing: Text('${(100 * value).truncate()}%'),
    );
  }
}

class _ByRankPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 800),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              for (final rank in gradingExamRanks)
                _RankTotalIndicator(rank: rank)
            ],
          ),
        ),
      ),
    );
  }
}

class _ByTypePage extends StatelessWidget {
  final successRates = StatsDB().taskSuccessRateByType();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: RadarChart(
        RadarChartData(
          dataSets: [
            RadarDataSet(
              fillColor: Colors.lightBlue.withAlpha(80),
              borderColor: Colors.lightBlue,
              dataEntries: [
                for (final (_, correct, wrong) in successRates)
                  RadarEntry(value: 100 * correct / (correct + wrong)),
              ],
            ),
            RadarDataSet(
              fillColor: Colors.blueAccent.withAlpha(20),
              borderColor: Colors.blueAccent.withAlpha(80),
              entryRadius: 0,
              dataEntries:
                  List.filled(successRates.length, RadarEntry(value: 100)),
            ),
          ],
          getTitle: (index, angle) {
            final type = successRates.elementAtOrNull(index)?.$1;
            return RadarChartTitle(
              text: type?.toLocalizedString(loc) ?? '?',
              angle: angle,
            );
          },
          radarBackgroundColor: Colors.transparent,
          borderData: FlBorderData(show: false),
          radarBorderData: const BorderSide(color: Colors.transparent),
          tickCount: 1,
          ticksTextStyle: TextStyle(color: Colors.transparent),
          tickBorderData: const BorderSide(color: Colors.transparent),
          gridBorderData:
              BorderSide(color: Colors.blueAccent.withAlpha(80), width: 1),
        ),
      ),
    );
  }
}

class _CalendarPage extends StatelessWidget {
  static final _onlyTime = DateFormat('HH:mm');
  static final _onlyDate = DateFormat('yyyy.MM.dd');

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final thisWeek = today.subtract(Duration(days: today.weekday));
    final thisMonth = DateTime(now.year, now.month);
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(icon: Icon(Icons.today), text: loc.today),
              Tab(icon: Icon(Icons.calendar_view_week), text: loc.week),
              Tab(icon: Icon(Icons.calendar_month), text: loc.month),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _TimePeriodTab(
                    dateLabel: loc.statsTimeColumn,
                    dateFormat: _onlyTime,
                    since: today),
                _TimePeriodTab(
                    dateLabel: loc.statsDateColumn,
                    dateFormat: _onlyDate,
                    since: thisWeek),
                _TimePeriodTab(
                    dateLabel: loc.statsDateColumn,
                    dateFormat: _onlyDate,
                    since: thisMonth),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartsPage extends StatefulWidget {
  @override
  State<_ChartsPage> createState() => _ChartsPageState();
}

class _ChartsPageState extends State<_ChartsPage> {
  final _formKey = GlobalKey<FormState>(debugLabel: 'charts_page');
  var _rankRange = RankRange(from: Rank.k15, to: Rank.d7);
  var _examType = ExamType.grading;
  var _maxExamPoints = 30;
  final _spots = <FlSpot>[];
  final _maSpots = <FlSpot>[];
  final _solveTimeSpots = <FlSpot>[];
  var _maxY = 0;
  var _maxSolveTime = 0;

  @override
  void initState() {
    super.initState();
    computeChartData();
  }

  void computeChartData() {
    // Load exam data
    final entries =
        StatsDB().recentExams(_examType, _rankRange, _maxExamPoints);

    final ma = _MovingAverageAccumulator(size: 10);
    var x = 0;
    _maxY = 10;
    _maxSolveTime = 10;
    _spots.clear();
    _maSpots.clear();
    _solveTimeSpots.clear();
    for (final e in entries.reversed) {
      final y = e.correctCount.toDouble();
      _spots.add(FlSpot(x.toDouble(), y));
      _maxY = max(_maxY, (e.correctCount + e.wrongCount));
      // Moving avg.
      _maSpots.add(FlSpot(x.toDouble(), ma.add(y)));
      // Solve time
      _solveTimeSpots
          .add(FlSpot(x.toDouble(), e.duration.inSeconds.toDouble()));
      _maxSolveTime = max(_maxSolveTime, e.duration.inSeconds);
      x++;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final noTitles = const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    );
    final examPassRateChart = LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
        ),
        titlesData: FlTitlesData(
          show: true,
          leftTitles: AxisTitles(
            axisNameWidget: Text(loc.taskCorrect),
            sideTitles: SideTitles(
              reservedSize: 40,
              showTitles: true,
              interval: 2,
            ),
          ),
          rightTitles: noTitles,
          topTitles: noTitles,
          bottomTitles: noTitles,
        ),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: _spots,
            isCurved: false,
            color: Colors.blue,
            barWidth: 2,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(show: true),
          ),
          LineChartBarData(
            spots: _maSpots,
            isCurved: true,
            color: Colors.red,
            barWidth: 2,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
        ],
        minX: _spots.firstOrNull?.x ?? 0,
        maxX: _spots.lastOrNull?.x ?? 10,
        minY: 0,
        maxY: _maxY.toDouble(),
        extraLinesData: ExtraLinesData(
          horizontalLines: [
            if (_examType == ExamType.grading || _examType == ExamType.endgame)
              HorizontalLine(y: 8, strokeWidth: 1.0, color: Colors.green),
          ],
        ),
      ),
    );
    final examSolveTimeChart = LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
        ),
        titlesData: FlTitlesData(
          show: true,
          leftTitles: AxisTitles(
            axisNameWidget: Text('${loc.statsDurationColumn} (${loc.seconds})'),
            sideTitles: SideTitles(
              reservedSize: 40,
              showTitles: true,
            ),
          ),
          rightTitles: noTitles,
          topTitles: noTitles,
          bottomTitles: noTitles,
        ),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: _solveTimeSpots,
            isCurved: true,
            color: Colors.blue,
            barWidth: 2,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: true),
          ),
        ],
        minX: _solveTimeSpots.firstOrNull?.x ?? 0,
        maxX: _solveTimeSpots.lastOrNull?.x ?? 10,
        minY: 0,
        maxY: _maxSolveTime.toDouble(),
      ),
    );
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              spacing: 8.0,
              children: <Widget>[
                Row(
                  spacing: 8.0,
                  children: [
                    Expanded(
                      flex: 2,
                      child: DropdownButtonFormField<ExamType>(
                        isExpanded: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: loc.type,
                        ),
                        initialValue: _examType,
                        items: <DropdownMenuItem<ExamType>>[
                          for (final type in [
                            ExamType.grading,
                            ExamType.endgame,
                            ExamType.custom
                          ])
                            DropdownMenuItem(
                              value: type,
                              child: Text(
                                type.toLocalizedString(loc),
                                overflow: TextOverflow.fade,
                              ),
                            ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _examType = value!;
                            computeChartData();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: loc.maxChartPoints,
                        ),
                        initialValue: _maxExamPoints,
                        items: <DropdownMenuItem<int>>[
                          for (final value in [10, 30, 50, 100, 250, 500, 1000])
                            DropdownMenuItem(
                              value: value,
                              child: Text('$value'),
                            ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _maxExamPoints = value!;
                            computeChartData();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                RankRangeFormField(
                  initialValue: _rankRange,
                  validator: (rankRange) {
                    if (rankRange!.from.index > rankRange.to.index) {
                      return 'Min rank must be less or equal than max rank';
                    }
                    return null;
                  },
                  onChanged: (RankRange newRange) {
                    setState(() {
                      _rankRange = newRange;
                      computeChartData();
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(loc.chartTitleCorrectCount),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 200),
                    child: examPassRateChart,
                  ),
                ),
                Text(loc.chartTitleExamCompletionTime),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 200),
                    child: examSolveTimeChart,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MovingAverageAccumulator {
  final int size;
  final _q = Queue<double>();

  _MovingAverageAccumulator({required this.size});

  double add(double x) {
    while (_q.length < size) {
      _q.add(x);
    }
    _q.removeFirst();
    _q.add(x);
    return _q.reduce((a, b) => a + b) / size;
  }
}
