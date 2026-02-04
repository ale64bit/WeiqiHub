import 'dart:math';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wqhub/analysis/analysis_side_bar.dart';
import 'package:wqhub/analysis/katago.dart';
import 'package:wqhub/analysis/katago_request.dart';
import 'package:wqhub/analysis/katago_response.dart';
import 'package:wqhub/board/board.dart';
import 'package:wqhub/board/board_annotation.dart';
import 'package:wqhub/board/board_settings.dart';
import 'package:wqhub/board/coordinate_style.dart';
import 'package:wqhub/game_client/game_client.dart';
import 'package:wqhub/game_client/game_record.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/play/game_navigation_bar.dart';
import 'package:wqhub/play/player_card.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/wq/annotated_game_tree.dart';
import 'package:wqhub/wq/game_tree.dart';
import 'package:wqhub/wq/wq.dart' as wq;

class AnalysisRouteArguments {
  final KataGo kataGo;
  final GameSummary summary;
  final GameRecord record;

  const AnalysisRouteArguments(
      {required this.kataGo, required this.summary, required this.record});
}

class AnalysisPage extends StatefulWidget {
  static const routeName = '/analysis';

  final KataGo kataGo;
  final GameSummary summary;
  final GameRecord record;

  const AnalysisPage(
      {super.key,
      required this.kataGo,
      required this.summary,
      required this.record});

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  static const maxVisits = 1000;

  static final winrateLossBands = <(double, Color)>[
    (-0.24, Colors.purple),
    (-0.12, Colors.red),
    (-0.06, Colors.orange),
    (-0.03, Colors.amberAccent),
    (-0.01, Colors.lime),
    (0.01, Colors.green),
    (1.0, Colors.lightBlueAccent),
  ];

  var _boardSize = 19;
  var _gameTree = AnnotatedGameTree<KataGoResponse>(19);
  var _turn = wq.Color.black;
  final _mainlineNodes = <GameTreeNode<KataGoResponse>>[];
  // Chart data
  final _winrateSpots = <FlSpot>[];
  final _scoreLeadSpots = <FlSpot>[];
  var _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _boardSize = widget.summary.boardSize;
      _gameTree = AnnotatedGameTree(_boardSize,
          lastMoveMainlineAnnotationFunc: _lastMoveMainlineAnnotation);
      _turn = wq.Color.black;
      _winrateSpots.add(FlSpot(0, 50));
      _scoreLeadSpots.add(FlSpot(0, 0));
      _mainlineNodes.add(_gameTree.curNode);
      for (final (i, mv) in widget.record.moves.indexed) {
        _mainlineNodes
            .add(_gameTree.moveAnnotated(mv, mode: AnnotationMode.mainline)!);
        _winrateSpots.add(FlSpot(i.toDouble(), 50));
        _scoreLeadSpots.add(FlSpot(i.toDouble(), 0));
        _turn = _turn.opposite;
      }
      _analyzeFullGame();
      _initialized = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.kataGo.terminateAll(TerminateAllRequest(id: 'AnalysisPage.dispose'));
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final borderSize =
        1.5 * (Theme.of(context).textTheme.labelMedium?.fontSize ?? 0);
    final border = context.settings.showCoordinates
        ? BoardBorderSettings(
            size: borderSize,
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
            rowCoordinates: CoordinateStyle(
              labels: CoordinateLabels.numbers,
              reverse: true,
            ),
            columnCoordinates: CoordinateStyle(
              labels: CoordinateLabels.alphaNoI,
            ),
          )
        : null;
    final boardSettings = BoardSettings(
      size: _boardSize,
      subBoard: SubBoard(
        topLeft: (0, 0),
        size: _boardSize,
      ),
      theme: context.settings.boardTheme,
      edgeLine: context.settings.edgeLine,
      border: border,
      stoneShadows: context.settings.stoneShadows,
    );
    final board = LayoutBuilder(
      builder: (context, constraints) {
        final boardSize = constraints.biggest.shortestSide -
            2 * (boardSettings.border?.size ?? 0);
        return Board(
          size: boardSize,
          settings: boardSettings,
          turn: _turn,
          stones: _gameTree.stones,
          annotations: _analysisAnnotations(),
          confirmTap: context.settings.confirmMoves,
          onPointHovered: _onPointHovered,
        );
      },
    );

    final blackPlayerCard = PlayerCard(
      key: ValueKey('player-card-black'),
      userInfo: widget.summary.black,
      color: wq.Color.black,
      captureCount: _gameTree.curNode.captureCountWhite,
      timeDisplay: SizedBox(),
      alignment: PlayerCardAlignment.left,
    );
    final whitePlayerCard = PlayerCard(
      key: ValueKey('player-card-white'),
      userInfo: widget.summary.white,
      color: wq.Color.white,
      captureCount: _gameTree.curNode.captureCountBlack,
      timeDisplay: SizedBox(),
      alignment: PlayerCardAlignment.right,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.analysis),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: board,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 8.0,
                  children: [
                    Expanded(child: blackPlayerCard),
                    const Text('VS'),
                    Expanded(child: whitePlayerCard),
                  ],
                ),
                Expanded(
                  child: AnalysisSideBar(
                    analysis: _gameTree.curNode.metadata,
                    winrate: _winrateSpots,
                    scoreLead: _scoreLeadSpots,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: GameNavigationBar(
          mainAxisAlignment: MainAxisAlignment.center,
          gameTree: _gameTree,
          onMovesSkipped: (count) {
            setState(() {
              if (count.isOdd) {
                _turn = _turn.opposite;
              }
            });
          },
        ),
      ),
    );
  }

  void _onGoMainline() {
    setState(() {
      while (_gameTree.isVariation) {
        _gameTree.undo();
        _turn = _turn.opposite;
      }
    });
  }

  void _onPointHovered(wq.Point? p) {
    _onGoMainline();
    if (p == null) return;
    final node = _gameTree.curNode;
    if (node.metadata == null) return;
    final idx = node.metadata!.moveInfos.indexWhere((info) => info.move == p);
    if (idx < 0) return;
    final info = node.metadata!.moveInfos[idx];
    setState(() {
      for (final p in info.pv) {
        if (p != null) {
          final mv = (col: _turn, p: p);
          _gameTree.moveAnnotated(mv, mode: AnnotationMode.variation);
          _turn = _turn.opposite;
        }
      }
    });
  }

/*
  void _queryCurrentPosition() {
    final node = _gameTree.curNode;
    if (node.metadata != null) return;

    final moves = <wq.Move>[];
    var cur = node;
    while (cur.parent != null) {
      moves.add(cur.move!);
      cur = cur.parent!;
    }
    final respStream = widget.kataGo.query(KataGoRequest(
      id: 'one-${DateTime.now().millisecondsSinceEpoch}',
      reportDuringSearchEvery: 0.2,
      initialPlayer: _turn,
      initialStones: [
        for (final e in _gameTree.initialStones.entries)
          for (final p in e.value) (col: e.key, p: p)
      ],
      moves: moves.reversed.toList(),
      rules: widget.summary.rules,
      komi: widget.summary.komi,
      boardSize: _boardSize,
      maxVisits: maxVisits,
      overrideSettings: {},
    ));
    respStream.forEach((resp) {
      setState(() {
        node.metadata = resp;
      });
    });
  }
  */

  void _analyzeFullGame() {
    final respStream = widget.kataGo.query(KataGoRequest(
      id: 'full-${DateTime.now().millisecondsSinceEpoch}',
      reportDuringSearchEvery: 0.2,
      initialPlayer: wq.Color.black,
      initialStones: [
        for (final e in _gameTree.initialStones.entries)
          for (final p in e.value) (col: e.key, p: p)
      ],
      analyzeTurns: List.generate(widget.record.moves.length + 1, (i) => i),
      moves: widget.record.moves,
      rules: widget.summary.rules,
      komi: widget.summary.komi,
      boardSize: _boardSize,
      maxVisits: maxVisits,
      overrideSettings: {},
    ));
    respStream.forEach((resp) {
      if (context.mounted) {
        setState(() {
          _pruneCandidateMoves(resp);
          final x = resp.turnNumber.toDouble();
          _mainlineNodes[resp.turnNumber].metadata = resp;
          _winrateSpots[resp.turnNumber] =
              FlSpot(x, 100 * resp.rootInfo.winrate);
          _scoreLeadSpots[resp.turnNumber] = FlSpot(x, resp.rootInfo.scoreLead);
        });
      }
    });
  }

  IMap<wq.Point, BoardAnnotation> _analysisAnnotations() {
    var annotations = _gameTree.annotations;
    final analysis = _gameTree.curNode.metadata;
    if (analysis == null) {
      return annotations;
    }
    for (final info in analysis.moveInfos) {
      final p = info.move!;
      final mv = (p: p, col: _turn);
      final isActualMove = _gameTree.curNode.child(mv) != null;
      annotations = annotations.add(
          info.move!,
          AnalysisAnnotation(
            order: info.order,
            visits: info.visits,
            maxVisits: maxVisits,
            pointLoss: pointLoss(analysis.rootInfo, info),
            actualMove: isActualMove,
          ));
    }
    return annotations;
  }

  void _removeMoveInfo(KataGoResponse resp, int i) {
    final last = resp.moveInfos.removeLast();
    if (i < resp.moveInfos.length - 1) {
      resp.moveInfos[i] = last;
    }
  }

  void _pruneCandidateMoves(KataGoResponse resp) {
    for (int i = 0; i < resp.moveInfos.length;) {
      final info = resp.moveInfos[i];
      if (info.move == null) {
        _removeMoveInfo(resp, i);
        continue;
      }
      final p = info.move!;
      final mv = (p: p, col: _turn);
      final isTopCandidate = info.order < 10;
      final isActualMove = _gameTree.curNode.child(mv) != null;
      if (!(isTopCandidate || isActualMove)) {
        _removeMoveInfo(resp, i);
      } else {
        ++i;
      }
    }
  }

  static Color _lastMoveAnnotationColor(double winrateLoss) {
    for (final (loss, color) in winrateLossBands) {
      if (winrateLoss < loss) {
        return color;
      }
    }
    return winrateLossBands.last.$2;
  }

  static BoardAnnotation _lastMoveMainlineAnnotation(
      GameTreeNode<KataGoResponse> node) {
    final (:col, :p) = node.move!;
    Color? innerColor;
    final wrLoss = _nodeWinrateLoss(node);
    // TODO: need to consider when loss is 0% because it's already min/max.
    // In such case, we need to try to use the point loss which is unbounded.
    if (wrLoss != null) {
      innerColor = _lastMoveAnnotationColor(wrLoss);
    }
    return LastMoveAnnotation(
      turn: col,
      innerColor: innerColor,
    );
  }

  static double? _nodeWinrateLoss(GameTreeNode<KataGoResponse> node) {
    final (:col, :p) = node.move!;
    if (node.parent == null || node.parent!.metadata == null) return null;
    // First, try to compute it directly from parent
    final parent = node.parent!;
    final md = parent.metadata!;
    for (final info in md.moveInfos) {
      if (info.move == p) {
        if (info.order == 0) return 1.0;
        return winrateLoss(col, md.rootInfo.winrate, info.winrate);
      }
    }
    // Otherwise, try to compute it from current node root rootInfo
    if (node.metadata == null) return null;
    return winrateLoss(
        col, md.rootInfo.winrate, node.metadata!.rootInfo.winrate);
  }
}
