import 'package:flutter/material.dart';
import 'package:wqhub/analysis/evaluation_bar.dart';
import 'package:wqhub/analysis/katago_response.dart';

class AnalysisSideBar extends StatelessWidget {
  final KataGoResponse? resp;

  const AnalysisSideBar({
    super.key,
    required this.resp,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 8.0,
          children: [
            Text('Analysis', style: TextTheme.of(context).displayMedium),
            if (resp == null) CircularProgressIndicator(),
            if (resp != null) ...[
              EvaluationBar(
                winRate: resp!.rootInfo.winRate,
                scoreLead: resp!.rootInfo.scoreLead,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Win rate: ${(100 * resp!.rootInfo.winRate).floor()}%',
                      style: TextTheme.of(context).bodyLarge),
                  Text('Score lead: ${fmtScore(resp!.rootInfo.scoreLead)}',
                      style: TextTheme.of(context).bodyLarge),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
