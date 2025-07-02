import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wqhub/train/rank_range.dart';
import 'package:intl/intl.dart';

class ExamRankCard extends StatelessWidget {
  final RankRange rankRange;
  final int passCount;
  final int failCount;
  final bool isActive;
  final Function()? onTap;

  const ExamRankCard(
      {super.key,
      required this.rankRange,
      required this.passCount,
      required this.failCount,
      required this.isActive,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);
    final passedIcon = Icon(Icons.verified, color: Colors.amber);
    final lockedIcon = Icon(Icons.lock, color: Colors.grey);
    final pendingIcon = Icon(Icons.pending);
    return Card(
      color: isActive
          ? colorScheme.primaryContainer
          : colorScheme.surfaceContainer,
      child: InkWell(
        onTap: isActive ? onTap : null,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: isActive
                  ? (passCount > 0 ? passedIcon : pendingIcon)
                  : lockedIcon,
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    rankRange.toString(),
                    style: textTheme.titleLarge,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        '✓ $passCount',
                        textAlign: TextAlign.center,
                        style: textTheme.labelSmall,
                      )),
                      Expanded(
                          child: Text(
                        '✗ $failCount',
                        textAlign: TextAlign.center,
                        style: textTheme.labelSmall,
                      )),
                    ],
                  ),
                  Text(
                    NumberFormat.percentPattern()
                        .format((passCount) / max(passCount + failCount, 1)),
                    style: textTheme.labelSmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
