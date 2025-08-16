import 'package:extension_type_unions/extension_type_unions.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:wqhub/audio/audio_controller.dart';
import 'package:wqhub/board/board.dart';
import 'package:wqhub/board/board_annotation.dart';
import 'package:wqhub/board/board_settings.dart';
import 'package:wqhub/board/coordinate_style.dart';
import 'package:wqhub/confirm_dialog.dart';
import 'package:wqhub/game_client/counting_result.dart';
import 'package:wqhub/game_client/rules.dart';
import 'package:wqhub/game_client/server_features.dart';
import 'package:wqhub/play/ai_bot.dart';
import 'package:wqhub/play/score_estimator.dart';
import 'package:wqhub/play/counting_result_bottom_sheet.dart';
import 'package:wqhub/play/game_navigation_bar.dart';
import 'package:wqhub/play/gameplay_bar.dart';
import 'package:wqhub/play/gameplay_menu.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/wq/annotated_game_tree.dart';
import 'package:wqhub/wq/wq.dart' as wq;

class AIGameRouteArguments {
  final Rules rules;
  final int boardSize;
  final int handicap;
  final double komi;
  final wq.Color myColor;
  final MoveSelection moveSelection;

  AIGameRouteArguments({
    required this.rules,
    required this.boardSize,
    required this.handicap,
    required this.komi,
    required this.myColor,
    required this.moveSelection,
  });
}

enum GameState {
  preparing,
  playing,
  over,
}

class AIGamePage extends StatefulWidget {
  static const routeName = '/play/ai_game';

  final Rules rules;
  final int boardSize;
  final int handicap;
  final double komi;
  final wq.Color myColor;
  final MoveSelection moveSelection;

  const AIGamePage({
    super.key,
    required this.rules,
    required this.boardSize,
    required this.handicap,
    required this.komi,
    required this.myColor,
    required this.moveSelection,
  });

  @override
  State<AIGamePage> createState() => _AIGamePageState();
}

class _AIGamePageState extends State<AIGamePage> {
  static const botFeatures = ServerFeatures(
    manualCounting: false,
    automaticCounting: false,
    aiReferee: false,
    aiRefereeMinMoveCount: const IMapConst({}),
    forcedCounting: true,
    forcedCountingMinMoveCount: const IMapConst({9: 55}),
    localTimeControl: false,
  );

  final _log = Logger('AIGamePage');
  AIBot? _aiBot;
  ScoreEstimator? _scoreEstimator;

  // State
  late AnnotatedGameTree _gameTree;
  var _turn = wq.Color.black;
  var _state = GameState.preparing;
  // End State

  IMapOfSets<wq.Point, Annotation>? _territoryAnnotations;
  IMapOfSets<wq.Point, Annotation>? _policyAnnotations;

  @override
  void initState() {
    super.initState();
    initBot();
    _gameTree = AnnotatedGameTree(widget.boardSize);
  }

  @override
  void dispose() {
    _aiBot?.close();
    _scoreEstimator?.close();
    super.dispose();
  }

  void initBot() async {
    _log.fine('tflite interpreter version: ${version}');
    _aiBot = await AIBot.new9x9(widget.moveSelection);
    _scoreEstimator = await ScoreEstimator.new9x9();
    setState(() {
      _state = GameState.playing;
    });
    AudioController().startToPlay();
  }

  @override
  Widget build(BuildContext context) {
    final wideLayout = MediaQuery.sizeOf(context).aspectRatio > 1.5;

    // Board
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
      size: widget.boardSize,
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
          onPointClicked: onPointClicked,
          // Show the hovering stone only when we can actually place a stone.
          turn: ((_turn == widget.myColor && _state == GameState.playing) ||
                  _state == GameState.over)
              ? _turn
              : null,
          stones: _gameTree.stones,
          annotations: _territoryAnnotations ??
              _policyAnnotations ??
              _gameTree.annotations,
          confirmTap: context.settings.confirmMoves,
        );
      },
    );

    return Scaffold(
      body: wideLayout
          ? Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: board),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: <Widget>[
                      _GameInfoCard(
                        rules: widget.rules,
                        handicap: widget.handicap,
                        komi: widget.komi,
                      ),
                      SizedBox(height: 8),
                      if (_state == GameState.over)
                        GameNavigationBar(
                          gameTree: _gameTree,
                          onMovesSkipped: (n) {
                            setState(() {
                              _turn = (_gameTree.curNode.move?.col ??
                                      wq.Color.white)
                                  .opposite;
                            });
                          },
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        ),
                      if (_state != GameState.over)
                        GameplayBar(
                          features: botFeatures,
                          onPass: onPassClicked,
                          onManualCounting: () {},
                          onAutomaticCounting: () {},
                          onAIReferee: () {},
                          onForceCounting: onForceCountingClicked,
                          onResign: onResignClicked,
                        )
                    ],
                  ),
                ),
              ],
            )
          : Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(child: Center(child: board)),
                  Stack(
                    children: [
                      if (_state == GameState.over)
                        GameNavigationBar(
                          gameTree: _gameTree,
                          onMovesSkipped: (n) {
                            setState(() {
                              _turn = (_gameTree.curNode.move?.col ??
                                      wq.Color.white)
                                  .opposite;
                            });
                          },
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                      GameplayMenu(
                        features: botFeatures,
                        rules: widget.rules,
                        handicap: widget.handicap,
                        komi: widget.komi,
                        isGameOver: _state == GameState.over,
                        onPass: onPassClicked,
                        onManualCounting: () {},
                        onAutomaticCounting: () {},
                        onAIReferee: () {},
                        onForceCounting: onForceCountingClicked,
                        onResign: onResignClicked,
                        onLeave: onLeaveClicked,
                      ),
                    ],
                  ),
                ],
              ),
            ),
      floatingActionButton: (wideLayout && _state == GameState.over)
          ? FloatingActionButton.large(
              onPressed: onLeaveClicked,
              tooltip: 'Leave game',
              child: Icon(Icons.logout),
            )
          : null,
    );
  }

  void onPointClicked(wq.Point p) {
    // A move can only processed in one of the following cases:
    //  - game is ongoing and it's our turn
    //  - game is over
    if (!((_state == GameState.playing && _turn == widget.myColor) ||
        _state == GameState.over)) {
      return;
    }

    // First try to apply the move to the tree to check validity
    final node = _gameTree.moveAnnotated((col: _turn, p: p),
        mode: _state == GameState.over
            ? AnnotationMode.variation
            : AnnotationMode.mainline);
    if (node == null) return;

    AudioController().playForNode(_gameTree.curNode);

    if (_state == GameState.playing) {
      _aiBot?.update(_gameTree);
      _turn = _turn.opposite;
      genMove();
    } else {
      _turn = _turn.opposite;
    }

    setState(() {});
  }

  void onPassClicked() {
    // A pass can only processed in one of the following cases:
    //  - game is ongoing and it's our turn
    if (_state != GameState.playing) return;
    if (_turn != widget.myColor) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please wait for your turn'),
        showCloseIcon: true,
      ));
      return;
    }

    // Pass doesn't need to be checked for validity.

    if (_state == GameState.playing) {
      _aiBot?.update(_gameTree);
      _turn = _turn.opposite;
      passOrGenMove();
    } else {
      _turn = _turn.opposite;
    }

    setState(() {});
  }

  CountingResult count() {
    final stones = _gameTree.stones;
    final result =
        _scoreEstimator!.estimate((i, j) => stones[(i, j)], komi: widget.komi);
    _territoryAnnotations = IMapOfSets.empty();
    for (int i = 0; i < widget.boardSize; ++i) {
      for (int j = 0; j < widget.boardSize; ++j) {
        if (result.ownership[i][j] != null) {
          final p = (i, j);
          final col = result.ownership[i][j];
          _territoryAnnotations = _territoryAnnotations?.add(p, (
            type: AnnotationShape.territory.u21,
            color: col == wq.Color.black ? Colors.black : Colors.white,
          ));
        }
      }
    }
    return result;
  }

  void passOrGenMove() {
    // Too early, keep fighting
    if (_gameTree.curNode.moveNumber < 30) {
      genMove();
      return;
    }

    final countResult = count();
    if (countResult.winner == widget.myColor.opposite) {
      _turn = _turn.opposite;
      AudioController().pass();
      gameOver(countResult);
      return;
    }

    _territoryAnnotations = null;
    genMove();
  }

  void gameOver(CountingResult res) {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        builder: (context) {
          return CountingResultBottomSheet(
            scoreLead: res.scoreLead,
            winner: res.winner,
            onAccept: () {
              Navigator.pop(context);
              setState(() {
                _state = GameState.over;
                _territoryAnnotations = null;
              });
            },
            onReject: () {
              Navigator.pop(context);
              setState(() {
                _territoryAnnotations = null;
              });
            },
          );
        });
  }

  void genMove() {
    var validMove = false;
    for (int i = 0; i < 3; ++i) {
      final mv = _aiBot!.genMove(_turn);
      final (r, c) = mv.p;
      if (r < 0) {
        AudioController().pass();
        _turn = _turn.opposite;
      } else {
        final node = _gameTree.moveAnnotated(mv, mode: AnnotationMode.mainline);
        if (node != null) {
          _aiBot?.update(_gameTree);
          _turn = _turn.opposite;
          validMove = true;
          break;
        }
      }
    }
    if (!validMove) {
      AudioController().pass();
      _turn = _turn.opposite;
    }
    setState(() {});
  }

  void onLeaveClicked() {
    Navigator.pop(context);
  }

  void onToggleOwnership() {
    if (_territoryAnnotations == null) {
      _territoryAnnotations = IMapOfSets.empty();
      final stones = _gameTree.stones;
      final result = _scoreEstimator!
          .estimate((i, j) => stones[(i, j)], komi: widget.komi);
      for (int i = 0; i < widget.boardSize; ++i) {
        for (int j = 0; j < widget.boardSize; ++j) {
          if (result.ownership[i][j] != null) {
            final p = (i, j);
            final col = result.ownership[i][j];
            _territoryAnnotations = _territoryAnnotations?.add(p, (
              type: AnnotationShape.territory.u21,
              color: col == wq.Color.black ? Colors.black : Colors.white,
            ));
          }
        }
      }
    } else {
      _territoryAnnotations = null;
    }
    setState(() {});
  }

  void onTogglePolicy() {
    if (_policyAnnotations == null) {
      _policyAnnotations = IMapOfSets.empty();
      final policy = _aiBot!.policy(_turn);
      for (int i = 0; i < widget.boardSize; ++i) {
        for (int j = 0; j < widget.boardSize; ++j) {
          final p = policy[i * widget.boardSize + j];
          if (_gameTree.stones.containsKey((i, j))) continue;

          var color = Color.fromARGB(255, 155, 155, 155);
          final alpha = (p * 255).floor();
          if (p < 0.20) {
            color = Color.fromARGB(alpha, 255, 243, 59);
          } else if (p < 0.40) {
            color = Color.fromARGB(alpha, 253, 199, 12);
          } else if (p < 0.60) {
            color = Color.fromARGB(alpha, 243, 144, 63);
          } else if (p < 0.80) {
            color = Color.fromARGB(alpha, 237, 104, 60);
          } else {
            color = Color.fromARGB(alpha, 255, 62, 58);
          }

          _policyAnnotations = _policyAnnotations?.add((
            i,
            j
          ), (
            type: AnnotationShape.dot.u21,
            color: color,
          ));
        }
      }
    } else {
      _policyAnnotations = null;
    }
    setState(() {});
  }

  void onResignClicked() {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: 'Confirm',
        content: 'Are you sure that you want to resign?',
        onYes: () {
          setState(() {
            _state = GameState.over;
          });
          Navigator.of(context).pop();
        },
        onNo: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void onForceCountingClicked() {
    // We can only request forced counting if we are playing and it's our turn.
    if (_state != GameState.playing) return;
    if (_turn != widget.myColor) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please wait for your turn'),
        showCloseIcon: true,
      ));
      return;
    }
    if (_gameTree.curNode.moveNumber <
        (botFeatures.forcedCountingMinMoveCount[widget.boardSize] ??
            (1 << 30))) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Forced counting cannot be used yet'),
        showCloseIcon: true,
      ));
      return;
    }

    final countResult = count();
    setState(() {});
    gameOver(countResult);
  }
}

class _GameInfoCard extends StatelessWidget {
  final Rules rules;
  final int handicap;
  final double komi;

  const _GameInfoCard(
      {required this.rules, required this.handicap, required this.komi});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Game Info',
          textAlign: TextAlign.center,
          style: TextTheme.of(context).titleLarge,
        ),
        Text(
          'Rules: ${rules.toString()}',
          textAlign: TextAlign.center,
        ),
        if (handicap > 1)
          Text(
            'Handicap: ${handicap}',
            textAlign: TextAlign.center,
          ),
        if (handicap <= 1)
          Text(
            'Komi: ${komi}',
            textAlign: TextAlign.center,
          ),
      ],
    ));
  }
}
