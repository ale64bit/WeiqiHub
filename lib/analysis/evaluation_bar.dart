import 'package:flutter/material.dart';

class EvaluationBar extends StatelessWidget {
  final double winRate;
  final double scoreLead;

  const EvaluationBar(
      {super.key, required this.winRate, required this.scoreLead});

  @override
  Widget build(BuildContext context) {
    const barHeight = 40.0;
    final scoreContainer = winRate < 0.5
        ? Container(
            alignment: Alignment.centerRight,
            child: Text('W+${fmtScore(scoreLead.abs())} ',
                style: TextStyle(color: Colors.black, fontSize: barHeight / 2)),
          )
        : Container(
            alignment: Alignment.centerLeft,
            child: Text(' B+${fmtScore(scoreLead)}',
                style: TextStyle(color: Colors.white, fontSize: barHeight / 2)),
          );
    return Container(
      padding: EdgeInsets.all(2.0),
      height: barHeight,
      decoration: BoxDecoration(
        color: Colors.grey,
        border: Border.all(width: 2.0),
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: Stack(
        children: <Widget>[
          LinearProgressIndicator(
            value: winRate,
            color: Colors.black,
            backgroundColor: Colors.white,
            minHeight: barHeight,
          ),
          scoreContainer,
          Align(
            alignment: AlignmentGeometry.center,
            child: SizedBox(
              height: barHeight,
              child: VerticalDivider(
                color: Colors.red,
                width: 8.0,
                thickness: 4.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String fmtScore(double x) {
  final dec = x.toInt();
  final frac = (x.abs() * 10).toInt() % 10;
  return '$dec.$frac';
}
