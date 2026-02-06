import 'dart:math';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:wqhub/analysis/analysis_charts_card.dart';
import 'package:wqhub/analysis/analysis_util.dart';
import 'package:wqhub/analysis/evaluation_card.dart';
import 'package:wqhub/analysis/katago.dart';
import 'package:wqhub/analysis/katago_request.dart';
import 'package:wqhub/analysis/katago_response.dart';
import 'package:wqhub/analysis/mistakes_card.dart';
import 'package:wqhub/analysis/performance_dialog.dart';
import 'package:wqhub/audio/audio_controller.dart';
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

enum AnalysisExploreMode {
  manual,
  variationOnHover,
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

  var _boardSize = 19;
  var _gameTree = AnnotatedGameTree<KataGoResponse>(19);
  var _turn = wq.Color.black;
  final _mainlineNodes = <GameTreeNode<KataGoResponse>>[];
  final _winrateSpots = <FlSpot>[];
  final _scoreLeadSpots = <FlSpot>[];
  var _initialized = false;
  var _exploreMode = AnalysisExploreMode.manual;
  String? _fullGameQueryId;

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
    if (_fullGameQueryId != null) {
      widget.kataGo.terminate(
        TerminateRequest(
          id: Uuid().v4(),
          terminateId: _fullGameQueryId!,
        ),
      );
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
          onPointHovered: _onPointHovered,
          onPointClicked: _onPointClicked,
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

    final gameNavigationBar = GameNavigationBar(
      mainAxisAlignment: MainAxisAlignment.center,
      gameTree: _gameTree,
      onMovesSkipped: (count) {
        setState(() {
          if (count.isOdd) {
            _turn = _turn.opposite;
          }
        });
      },
    );

    final analysisSideBar = Column(
      children: [
        EvaluationCard(currentNode: _gameTree.curNode),
        gameNavigationBar,
        Expanded(
          child: AnalysisChartsCard(
            currentNode: _gameTree.curNode,
            winrate: _winrateSpots,
            scoreLead: _scoreLeadSpots,
            onTapMove: _onGoToMove,
          ),
        ),
        Expanded(
          child: MistakesCard(
            rootNode: _gameTree.rootNode,
            onTapMove: _onGoToMove,
          ),
        ),
      ],
    );

    final settingsDrawer = Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.bar_chart),
            title: Text('Performance'), // TODO localize
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => PerformanceDialog(
                  summary: widget.summary,
                  rootNode: _gameTree.rootNode,
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text('Mode'), // TODO localize
            trailing: DropdownButton<AnalysisExploreMode>(
              value: _exploreMode,
              items: [
                for (final mode in AnalysisExploreMode.values)
                  DropdownMenuItem(
                    value: mode,
                    child: Text(mode.name),
                  ),
              ],
              borderRadius: BorderRadius.circular(8),
              onChanged: (AnalysisExploreMode? value) {
                if (value != null) {
                  setState(() {
                    _exploreMode = value;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.analysis),
      ),
      endDrawer: settingsDrawer,
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
                Expanded(child: analysisSideBar),
              ],
            ),
          ),
        ],
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

  void _onGoToMove(int moveNumber) {
    _onGoMainline();
    setState(() {
      while (moveNumber < _gameTree.curNode.moveNumber &&
          _gameTree.undo() != null) {
        _turn = _turn.opposite;
      }
      while (_gameTree.curNode.moveNumber < moveNumber &&
          _gameTree.redo() != null) {
        _turn = _turn.opposite;
      }
    });
  }

  void _onPointHovered(wq.Point? p) {
    if (_exploreMode != AnalysisExploreMode.variationOnHover) return;
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

  void _onPointClicked(wq.Point p) {
    if (_exploreMode != AnalysisExploreMode.manual) return;
    if (_gameTree.moveAnnotated((col: _turn, p: p),
            mode: AnnotationMode.variation) !=
        null) {
      AudioController().playForNode(_gameTree.curNode);
      setState(() {
        _turn = _turn.opposite;
      });
      _queryCurrentPosition();
    }
  }

  Map<String, String> _queryMetadata() => {
        'id': widget.summary.id,
        'black_nick': widget.summary.black.username,
        'white_nick': widget.summary.white.username,
        'black_rank': widget.summary.black.rank.toString(),
        'white_rank': widget.summary.white.rank.toString(),
        'time': widget.summary.dateTime.toIso8601String(),
        'result': widget.summary.result.result,
      };

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
      id: 'var-${Uuid().v4()}',
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
      metadata: _queryMetadata(),
    ));
    respStream.forEach((resp) {
      if (context.mounted) {
        setState(() {
          _pruneCandidateMoves(resp);
          node.metadata = resp;
        });
      }
    });
  }

  void _analyzeFullGame() {
    _fullGameQueryId = 'full-${Uuid().v4()}';
    final respStream = widget.kataGo.query(KataGoRequest(
      id: _fullGameQueryId!,
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
      metadata: _queryMetadata(),
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
            pointLoss: loss(analysis.rootInfo.currentPlayer,
                analysis.rootInfo.scoreLead, info.scoreLead),
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

  static BoardAnnotation _lastMoveMainlineAnnotation(
      GameTreeNode<KataGoResponse> node) {
    final (:col, :p) = node.move!;
    Color? innerColor;
    final loss = nodeLoss(node);
    if (loss != null) {
      innerColor = pointLossBands[pointLossBandIndex(loss.pointLoss)].$2;
    }
    return LastMoveAnnotation(
      turn: col,
      innerColor: innerColor,
    );
  }
}
