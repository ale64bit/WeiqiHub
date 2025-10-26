import 'dart:math';

import 'package:extension_type_unions/extension_type_unions.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wqhub/audio/audio_controller.dart';
import 'package:wqhub/board/board_annotation.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/train/response_delay.dart';
import 'package:wqhub/train/task_repository.dart';
import 'package:wqhub/train/upsolve_mode.dart';
import 'package:wqhub/train/variation_tree.dart';
import 'package:wqhub/wq/annotated_game_tree.dart';
import 'package:wqhub/wq/wq.dart' as wq;

mixin TaskSolvingStateMixin<T extends StatefulWidget> on State<T> {
  VariationTreeIterator? _vtreeIt;
  var gameTree = AnnotatedGameTree(19);
  var turn = wq.Color.black;
  VariationStatus? solveStatus;
  bool solveStatusNotified = false;
  IMapOfSets<wq.Point, Annotation>? continuationAnnotations;
  var upsolveMode = UpsolveMode.auto;

  Task get currentTask;
  void onSolveStatus(VariationStatus status);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setupCurrentTask();
  }

  void setupCurrentTask() {
    continuationAnnotations = null;
    _vtreeIt = VariationTreeIterator(tree: currentTask.variationTree);
    gameTree = AnnotatedGameTree(currentTask.boardSize,
        initialStones: currentTask.initialStones);
    turn = currentTask.first;
    solveStatusNotified = false;
    upsolveMode = UpsolveMode.auto;
  }

  void onResetTask() {
    setState(() {
      setupCurrentTask();
    });
  }

  void onMove(wq.Point p, bool wideLayout) {
    if (!(solveStatusNotified ||
        turn == currentTask.first ||
        upsolveMode == UpsolveMode.manual)) {
      return;
    }

    if (gameTree
            .moveAnnotated((col: turn, p: p), mode: AnnotationMode.variation) !=
        null) {
      AudioController().playForNode(gameTree.curNode);
      continuationAnnotations = null;
      final status = _vtreeIt!.move(p);
      turn = turn.opposite;
      if (status != null) {
        _setSolveStatus(status, wideLayout);
      } else if (upsolveMode == UpsolveMode.auto) {
        switch (context.settings.responseDelay) {
          case ResponseDelay.none:
            _generateResponseMove(wideLayout);
          default:
            Future.delayed(context.settings.responseDelay.duration, () {
              _generateResponseMove(wideLayout);
            });
        }
      }
      setState(() {/* Update board */});
    }
  }

  void onPreviousMove() {
    if ((_vtreeIt?.depth ?? 0) > 0) {
      gameTree.undo();
      _vtreeIt?.undo();
      continuationAnnotations = null;
      turn = turn.opposite;
      setState(() {/* Update board */});
    }
  }

  void onNextMove() {
    final p = _vtreeIt?.redo();
    if (p != null) {
      gameTree.moveAnnotated((col: turn, p: p), mode: AnnotationMode.variation);
      continuationAnnotations = null;
      turn = turn.opposite;
      setState(() {/* Update board */});
    }
  }

  void _generateResponseMove(bool wideLayout) {
    if (solveStatusNotified) return;

    final resp = _vtreeIt!.genMove();
    gameTree
        .moveAnnotated((col: turn, p: resp), mode: AnnotationMode.variation);
    turn = turn.opposite;
    final status = _vtreeIt!.move(resp);
    if (status != null) {
      _setSolveStatus(status, wideLayout);
    }
    setState(() {/* Update board */});
  }

  void _setSolveStatus(VariationStatus status, bool wideLayout) {
    setState(() {
      continuationAnnotations = null;
    });
    if (!solveStatusNotified) {
      notifySolveStatus(status, wideLayout);
      solveStatusNotified = true;
    }
    if (solveStatus == null) {
      if (status == VariationStatus.correct) {
        AudioController().correct();
      } else {
        AudioController().wrong();
      }
      solveStatus = status;
      onSolveStatus(status);
    }
  }

  void onShowContinuations() {
    continuationAnnotations = IMapOfSets.empty();
    for (final (p, st)
        in _vtreeIt?.continuations() ?? <(wq.Point, VariationStatus)>[]) {
      continuationAnnotations = continuationAnnotations?.add(p, (
        type: AnnotationShape.dot.u21,
        color: switch (st) {
          VariationStatus.correct => Colors.green,
          VariationStatus.wrong => Colors.red,
        },
      ));
    }
    if (continuationAnnotations?.isNotEmpty ?? false) {
      setState(() {
        // Update board annotations
      });
    }
  }

  void onShareTask() {
    final link = currentTask.deepLink();
    Clipboard.setData(ClipboardData(text: link)).then((void _) {
      if (context.mounted) notifyTaskLinkCopied();
    });
  }

  void onCopySgf() {
    final sgfData = gameTree.sgf();
    Clipboard.setData(ClipboardData(text: sgfData)).then((void _) {
      if (context.mounted) {
        final loc = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loc.msgSgfCopied),
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
  }

  void onUpdateUpsolveMode(UpsolveMode newMode) {
    if (upsolveMode != newMode) {
      setupCurrentTask();
      setState(() {
        upsolveMode = newMode;
      });
    }
  }

  void notifySolveStatus(VariationStatus status, bool wideLayout) {
    final loc = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 16,
        children: [
          Icon(status == VariationStatus.correct
              ? Icons.check_circle
              : Icons.sentiment_very_dissatisfied),
          Text(status.toLocalizedString(loc),
              style: TextTheme.of(context).titleMedium),
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
    final loc = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 16,
        children: [
          Icon(Icons.timer),
          Text(loc.taskTimeout, style: TextTheme.of(context).titleMedium),
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
    final loc = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(loc.msgTaskLinkCopied)));
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
