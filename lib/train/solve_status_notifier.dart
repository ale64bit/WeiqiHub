import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wqhub/train/variation_tree.dart';

mixin SolveStatusNotifier {
  BuildContext get context;

  void notifySolveStatus(VariationStatus status, bool wideLayout) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 16,
        children: [
          Icon(status == VariationStatus.correct
              ? Icons.check_circle
              : Icons.sentiment_very_dissatisfied),
          Text(status.toString(), style: TextTheme.of(context).titleMedium),
        ],
      ),
      behavior: wideLayout ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
      margin: _snackBarMargin(wideLayout),
      duration: Duration(seconds: 1),
      backgroundColor:
          status == VariationStatus.correct ? Colors.green : Colors.red,
      showCloseIcon: true,
    ));
  }

  void notifySolveTimeout(bool wideLayout) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 16,
        children: [
          Icon(Icons.timer),
          Text('Timeout', style: TextTheme.of(context).titleMedium),
        ],
      ),
      behavior: wideLayout ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
      margin: _snackBarMargin(wideLayout),
      duration: Duration(seconds: 1),
      backgroundColor: Colors.red,
      showCloseIcon: true,
    ));
  }

  void notifyTaskLinkCopied() {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Task link copied.')));
  }

  EdgeInsetsGeometry? _snackBarMargin(bool wideLayout) {
    if (wideLayout) {
      final widgetSize = MediaQuery.sizeOf(context);
      final sidebarSize = min(widgetSize.longestSide - widgetSize.shortestSide,
          widgetSize.width / 3);
      return EdgeInsets.only(right: sidebarSize);
    } else {
      return null;
    }
  }
}
