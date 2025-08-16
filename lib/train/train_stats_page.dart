import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/stats/stats_db.dart';
import 'package:wqhub/train/grading_exam_ranks.dart';
import 'package:wqhub/wq/rank.dart';

class TrainStatsPage extends StatelessWidget {
  static const routeName = '/train/stats';
  static final _onlyTime = DateFormat('HH:mm');
  static final _onlyDate = DateFormat('yyyy.MM.dd');

  const TrainStatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final thisWeek = today.subtract(Duration(days: today.weekday));
    final thisMonth = DateTime(now.year, now.month);
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Statistics'),
          bottom: const TabBar(
            tabs: [
              const Tab(icon: Icon(Icons.today), text: 'Today'),
              const Tab(icon: Icon(Icons.calendar_view_week), text: 'Week'),
              const Tab(icon: Icon(Icons.calendar_month), text: 'Month'),
              const Tab(icon: Icon(Icons.bar_chart), text: 'By rank'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _TimePeriodTab(
                dateLabel: 'Time', dateFormat: _onlyTime, since: today),
            _TimePeriodTab(
                dateLabel: 'Date', dateFormat: _onlyDate, since: thisWeek),
            _TimePeriodTab(
                dateLabel: 'Date', dateFormat: _onlyDate, since: thisMonth),
            _ByRankTab(),
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
                  DataColumn(label: const Text('Type')),
                  DataColumn(label: const Text('Rank')),
                  DataColumn(label: const Text('Result')),
                  if (!isCompact) DataColumn(label: const Text('Time')),
                ],
                rows: <DataRow>[
                  for (final entry in entries)
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text(widget.dateFormat.format(entry.date))),
                        DataCell(Text(entry.type,
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

class _ByRankTab extends StatelessWidget {
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
