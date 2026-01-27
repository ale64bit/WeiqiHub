import 'dart:math';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
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
import 'package:wqhub/game_client/rules.dart';
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
  final logger = Logger('AnalysisPage');
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
      _gameTree = AnnotatedGameTree(_boardSize);
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
        );
      },
    );

    final blackPlayerCard = PlayerCard(
      key: ValueKey('player-card-black'),
      userInfo: widget.summary.black,
      color: wq.Color.black,
      captureCount: _gameTree.curNode.captureCountWhite,
      timeDisplay: SizedBox(),
      alignment: PlayerCardAlignment.right,
    );
    final whitePlayerCard = PlayerCard(
      key: ValueKey('player-card-white'),
      userInfo: widget.summary.white,
      color: wq.Color.white,
      captureCount: _gameTree.curNode.captureCountBlack,
      timeDisplay: SizedBox(),
      alignment: PlayerCardAlignment.left,
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
                    Expanded(child: whitePlayerCard),
                    const Text('VS'),
                    Expanded(child: blackPlayerCard),
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
      rules: Rules.chinese, // TODO should come from summary or record
      komi: 7.5, // TODO should come from summary or record
      boardSize: _boardSize,
      maxVisits: 1000,
      overrideSettings: {},
    ));
    respStream.forEach((resp) {
      setState(() {
        node.metadata = resp;
      });
    });
  }

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
      rules: Rules.chinese, // TODO should come from summary or record
      komi: 7.5, // TODO should come from summary or record
      boardSize: _boardSize,
      maxVisits: 50,
      overrideSettings: {},
    ));
    respStream.forEach((resp) {
      if (context.mounted) {
        setState(() {
          final x = resp.turnNumber.toDouble();
          _mainlineNodes[resp.turnNumber].metadata = resp;
          _winrateSpots[resp.turnNumber] =
              FlSpot(x, 100 * resp.rootInfo.winRate);
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
    // Sort by number of visits
    analysis.moveInfos.sort((x, y) => (x.visits == y.visits)
        ? x.order.compareTo(y.order)
        : y.visits.compareTo(x.visits));
    // Pick the N most visited points
    for (int i = 0; i < min(10, analysis.moveInfos.length); ++i) {
      final info = analysis.moveInfos[i];
      if (info.move == null) continue;
      final p = info.move!;
      final mv = (p: p, col: _turn);
      if (i < min(10, analysis.moveInfos.length) ||
          (_gameTree.curNode.child(mv) != null)) {
        var root = analysis.rootInfo;
        annotations = annotations.add(
            info.move!,
            AnalysisAnnotation(
              order: info.order,
              visits: info.visits,
              pointLoss: pointLoss(root, info),
              winrateLoss: winrateLoss(root, info),
            ));
      }
    }
    return annotations;
  }
}
