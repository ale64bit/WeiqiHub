import 'dart:math';

import 'package:extension_type_unions/extension_type_unions.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:wqhub/audio/audio_controller.dart';
import 'package:wqhub/board/board_annotation.dart';
import 'package:wqhub/confirm_dialog.dart';
import 'package:wqhub/game_client/counting_result.dart';
import 'package:wqhub/game_client/game.dart';
import 'package:wqhub/game_client/game_result.dart';
import 'package:wqhub/game_client/server_features.dart';
import 'package:wqhub/game_client/time_state.dart';
import 'package:wqhub/game_client/user_info.dart';
import 'package:wqhub/play/counting_result_bottom_sheet.dart';
import 'package:wqhub/play/game_navigation_bar.dart';
import 'package:wqhub/play/gameplay_bar.dart';
import 'package:wqhub/play/gameplay_menu.dart';
import 'package:wqhub/play/player_card.dart';
import 'package:wqhub/play/promotion_card.dart';
import 'package:wqhub/play/streak_card.dart';
import 'package:wqhub/play/user_info_card.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/time_display.dart';
import 'package:wqhub/timed_dialog.dart';
import 'package:wqhub/wq/annotated_game_tree.dart';
import 'package:wqhub/board/board.dart';
import 'package:wqhub/board/board_settings.dart';
import 'package:wqhub/board/coordinate_style.dart';
import 'package:wqhub/wq/wq.dart' as wq;

abstract class GameListener {
  void onSetup(Game game);
  void onPass(String gid);
  void onMove(String gid, wq.Move move);
  void onResult(String gid, GameResult result);
}

class GameRouteArguments {
  final ServerFeatures serverFeatures;
  final Game game;
  final GameListener? gameListener;

  const GameRouteArguments(
      {required this.serverFeatures,
      required this.game,
      required this.gameListener});
}

/*
State machine for the GamePage
================================================================================

State: 
  (tree, turn, state)

Transitions:
  (tree, turn, playing)  --- move -->         (tree + move, ~turn, acking)
  (tree, turn, playing)  --- pass -->         (tree, ~turn, acking)

  (tree, turn, acking)   --- move resp -->    (tree, turn, playing)
  (tree, turn, acking)   --- pass resp -->    (tree, turn, playing)

  (tree, turn, acking)   --- move error -->   (tree.undo().prune(), ~turn, playing)
  (tree, turn, acking)   --- pass error -->   (tree, ~turn, playing)                  {show snackbar}

  (tree, turn, playing)  --- move event -->   (tree + move, ~turn, playing)  {if move applicable}
  (tree, turn, acking)   --- move event -->   (tree + move, ~turn, acking)   {if move applicable}

  (tree, turn, playing)  --- req counting       --> (tree, turn, acking)
  (tree, turn, acking)   --- req counting resp  --> (tree, turn, agreeToCounting) {show waiting dialog}
  (tree, turn, acking)   --- req counting error --> (tree, turn, playing)

  (tree, turn, agreeToCounting) --- counting decision yes --> (tree, turn, counting)
  (tree, turn, agreeToCounting) --- counting decision no  --> (tree, turn, playing)

  (tree, turn, counting) --- agree with result --> {wait for game result event}
  (tree, turn, counting) --- disagree with result --> (tree, turn, playing)

  (tree, turn, _)        --- game result -->  (tree, turn, over)
*/
enum GameState {
  playing,
  acking,
  agreeToCounting,
  counting,
  over,
}

class GamePage extends StatefulWidget {
  static const routeName = '/play/game';

  final ServerFeatures serverFeatures;
  final Game game;
  final GameListener? gameListener;

  const GamePage({
    super.key,
    required this.serverFeatures,
    required this.game,
    this.gameListener,
  });

  @override
  State<GamePage> createState() => _GamePageState();
}

const _waitingDialogName = 'waiting_dialog';
const _countingResultBottomSheetName = 'counting_result_bottom_sheet';

class _GamePageState extends State<GamePage> {
  final _log = Logger('GamePage');
  final _blackTimeKey = GlobalKey(debugLabel: 'black-time-display');
  final _whiteTimeKey = GlobalKey(debugLabel: 'white-time-display');

  // State
  late AnnotatedGameTree _gameTree;
  var _turn = wq.Color.black;
  var _state = GameState.playing;
  // End state

  IMapOfSets<wq.Point, Annotation>? _territoryAnnotations;

  @override
  void initState() {
    super.initState();

    _gameTree = AnnotatedGameTree(widget.game.boardSize);

    for (final mv in widget.game.previousMoves) {
      final (r, c) = mv.p;
      if (r >= 0) _gameTree.moveAnnotated(mv, mode: AnnotationMode.mainline);
      _turn = mv.col.opposite;
    }

    widget.game.moves().forEach((mv) {
      if (mv == null) {
        onPass();
        widget.gameListener?.onPass(widget.game.id);
      } else {
        onMove(mv);
        widget.gameListener?.onMove(widget.game.id, mv);
      }
    });
    widget.game.result().then((res) {
      onGameResult(res);
      widget.gameListener?.onResult(widget.game.id, res);
    }, onError: onGameError);
    widget.game
        .automaticCountingResponses()
        .forEach(onAgreeToAutomaticCounting);
    widget.game.countingResultResponses().forEach(onAcceptCountingResult);
    widget.game.countingResults().forEach(onCountingResult);

    widget.gameListener?.onSetup(widget.game);
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
      size: widget.game.boardSize,
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
          turn:
              ((_turn == widget.game.myColor && _state == GameState.playing) ||
                      _state == GameState.over)
                  ? _turn
                  : null,
          stones: _gameTree.stones,
          annotations: _territoryAnnotations ?? _gameTree.annotations,
          confirmTap: context.settings.confirmMoves,
        );
      },
    );

    // Player cards
    final blackTimeDisplay = ValueListenableBuilder<(int, TimeState)>(
      valueListenable: widget.game.blackTime,
      builder: (BuildContext context, (int, TimeState) value, Widget? child) {
        final (tickId, timeState) = value;
        return TimeDisplay(
          key: _blackTimeKey,
          tickId: tickId,
          timeState: timeState,
          warningDuration: Duration(seconds: 10),
          enabled: _state == GameState.playing && _turn == wq.Color.black,
          tickerEnabled: widget.serverFeatures.localTimeControl,
          voiceCountdown: true,
        );
      },
    );
    final blackPlayerCard = ValueListenableBuilder<UserInfo>(
      valueListenable: widget.game.black,
      child: blackTimeDisplay,
      builder: (context, value, child) {
        return PlayerCard(
          key: ValueKey('player-card-black'),
          userInfo: value,
          color: wq.Color.black,
          captureCount: _gameTree.curNode.captureCountWhite,
          timeDisplay: child!,
          onTap: () => _showUserInfoDialog(context, widget.game.black),
          showOnlineStatus: true,
        );
      },
    );
    final whiteTimeDisplay = ValueListenableBuilder<(int, TimeState)>(
      valueListenable: widget.game.whiteTime,
      builder: (BuildContext context, (int, TimeState) value, Widget? child) {
        final (tickId, timeState) = value;
        return TimeDisplay(
          key: _whiteTimeKey,
          tickId: tickId,
          timeState: timeState,
          warningDuration: Duration(seconds: 10),
          enabled: _state == GameState.playing && _turn == wq.Color.white,
          tickerEnabled: widget.serverFeatures.localTimeControl,
          voiceCountdown: true,
        );
      },
    );
    final whitePlayerCard = ValueListenableBuilder<UserInfo>(
      valueListenable: widget.game.white,
      child: whiteTimeDisplay,
      builder: (context, value, child) {
        return PlayerCard(
          key: ValueKey('player-card-white'),
          userInfo: value,
          color: wq.Color.white,
          captureCount: _gameTree.curNode.captureCountBlack,
          timeDisplay: child!,
          onTap: () => _showUserInfoDialog(context, widget.game.white),
          showOnlineStatus: true,
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
                      _GameInfoCard(game: widget.game),
                      whitePlayerCard,
                      blackPlayerCard,
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
                          features: widget.serverFeatures,
                          onPass: onPassClicked,
                          onManualCounting: onManualCountingClicked,
                          onAutomaticCounting: onAutomaticCountingClicked,
                          onAIReferee: onAIRefereeClicked,
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
                  widget.game.myColor == wq.Color.black
                      ? whitePlayerCard
                      : blackPlayerCard,
                  Expanded(child: Center(child: board)),
                  widget.game.myColor == wq.Color.black
                      ? blackPlayerCard
                      : whitePlayerCard,
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
                        features: widget.serverFeatures,
                        rules: widget.game.rules,
                        handicap: widget.game.handicap,
                        komi: widget.game.komi,
                        isGameOver: _state == GameState.over,
                        onPass: onPassClicked,
                        onManualCounting: onManualCountingClicked,
                        onAutomaticCounting: onAutomaticCountingClicked,
                        onAIReferee: onAIRefereeClicked,
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
    if (!((_state == GameState.playing && _turn == widget.game.myColor) ||
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
      // If we are playing, send the move command to the game client
      widget.game.move((col: _turn, p: p)).then((_) {
        if (_state == GameState.acking) {
          setState(() {
            _state = GameState.playing;
          });
        }
      }, onError: (err) {
        _log.fine('move error: $err');
        // If the move could not be processed, undo it
        if (_state != GameState.acking) return;
        _gameTree.undo();
        setState(() {
          _turn = _turn.opposite;
          _state = GameState.playing;
        });
      });
      // Go into acking to wait for move confirmation
      _state = GameState.acking;
    }

    // Toggle current turn
    setState(() {
      _turn = _turn.opposite;
    });
  }

  void onMove(wq.Move mv) {
    // If the game is already over, ignore move events. Should not happen.
    if (_state == GameState.over) return;

    // Try to apply it on the board. If it's not possible, assume this is just the event
    // corresponding to the move we previously sent and ignore it.
    final node = _gameTree.moveAnnotated(mv, mode: AnnotationMode.mainline);
    if (node == null) return;

    AudioController().playForNode(_gameTree.curNode);

    setState(() {
      _turn = _turn.opposite;
    });
  }

  void onPassClicked() {
    // A pass can only processed in one of the following cases:
    //  - game is ongoing and it's our turn
    if (_state != GameState.playing) return;
    if (_turn != widget.game.myColor) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please wait for your turn'),
        showCloseIcon: true,
      ));
      return;
    }

    // Pass doesn't need to be checked for validity.

    // Send the pass command to the game client
    widget.game.pass().then((_) {
      _log.fine('pass ok');
      if (_state == GameState.acking) _state = GameState.playing;
    }, onError: (err) {
      // If the pass could not be processed, undo it
      if (_state != GameState.acking) return;
      setState(() {
        _state = GameState.playing;
      });
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('You cannot pass'),
          showCloseIcon: true,
        ));
      }
    });

    // Toggle current turn
    setState(() {
      _state = GameState.acking;
    });
  }

  void onPass() {
    switch (_state) {
      case GameState.over:
        // If the game is already over, ignore move events. Should not happen.
        return;
      case GameState.playing:
        // If we are playing, assume our opponent passed.
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Pass'),
          behavior: SnackBarBehavior.floating,
          showCloseIcon: true,
        ));
        AudioController().pass();
        setState(() {
          _state = GameState.playing;
          _turn = _turn.opposite;
        });
      case GameState.acking:
        // If we are acking, assume this is the ack for our pass request.
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Pass'),
          behavior: SnackBarBehavior.floating,
          showCloseIcon: true,
        ));
        AudioController().pass();
        setState(() {
          _state = GameState.playing;
          _turn = _turn.opposite;
        });
      default:
        break;
    }
  }

  void onResignClicked() {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: 'Confirm',
        content: 'Are you sure that you want to resign?',
        onYes: () {
          widget.game.resign();
          Navigator.of(context).pop();
        },
        onNo: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void onManualCountingClicked() {
    // TODO implement
  }

  void onAutomaticCountingClicked() {
    // We can only request automatic counting if we are playing and it's our turn.
    if (_state != GameState.playing) return;
    if (_turn != widget.game.myColor) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please wait for your turn'),
        showCloseIcon: true,
      ));
      return;
    }

    // Send automatic counting command to game client
    widget.game.automaticCounting().then((info) {
      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          routeSettings: RouteSettings(name: _waitingDialogName),
          builder: (context) {
            return TimedDialog(
              title: 'Automatic Counting',
              content: "Waiting for your opponent's decision...",
              duration: info.timeout,
            );
          },
        );
      }
      _log.fine('transition: ${_state.name} -> agreeToCounting');
      setState(() {
        _state = GameState.agreeToCounting;
      });
    }, onError: (err) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(err),
          showCloseIcon: true,
        ));
      }
    });
  }

  void onAgreeToAutomaticCounting(bool agree) {
    _log.fine('[${_state.name}] got agree to automatic counting: $agree');
    if (_state != GameState.agreeToCounting) {
      if (_state == GameState.playing && agree) {
        showDialog(
          context: context,
          builder: (context) => ConfirmDialog(
            title: 'Confirm',
            content: 'Your opponent requests automatic counting. Do you agree?',
            onYes: () {
              widget.game.agreeToAutomaticCounting(true);
              setState(() {
                _state = GameState.counting;
              });
              Navigator.of(context).pop();
            },
            onNo: () {
              widget.game.agreeToAutomaticCounting(false);
              Navigator.of(context).pop();
            },
          ),
        );
      }
      return;
    }

    maybeDismissRoute(_waitingDialogName);
    if (agree) {
      // If opponent agrees, go into counting state
      setState(() {
        _state = GameState.counting;
      });
    } else {
      // If opponent refuses, go back into playing state
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Your opponent refuses to count'),
          showCloseIcon: true,
        ));
      }
      setState(() {
        _state = GameState.playing;
        _territoryAnnotations = null;
      });
    }
  }

  void onAcceptCountingResult(bool accept) {
    _log.fine('[${_state.name}] got accept counting result: $accept');
    if (_state != GameState.counting) return;

    if (!accept) {
      maybeDismissRoute(_countingResultBottomSheetName);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Your opponent disagrees with the counting result'),
          showCloseIcon: true,
        ));
      }

      setState(() {
        _state = GameState.playing;
        _territoryAnnotations = null;
      });
    } else {
      // Nothing to do. We should receive the game result event shortly if we also
      // accepted the counting result.
    }
  }

  void onCountingResult(CountingResult res) {
    _log.fine(
        '[${_state.name}] got counting result: winner=${res.winner} lead=${res.scoreLead}');

    // Build the territory annotations, if provided.
    _territoryAnnotations = IMapOfSets.empty();
    for (int i = 0; i < widget.game.boardSize; ++i) {
      for (int j = 0; j < widget.game.boardSize; ++j) {
        if (res.ownership[i][j] != null) {
          final p = (i, j);
          final col = res.ownership[i][j];
          _territoryAnnotations = _territoryAnnotations?.add(p, (
            type: AnnotationShape.territory.u21,
            color: col == wq.Color.black ? Colors.black : Colors.white,
          ));
        }
      }
    }

    // Show counting result confirmation bottom sheet
    if (context.mounted) {
      showModalBottomSheet(
          context: context,
          isDismissible: false,
          routeSettings: RouteSettings(name: _countingResultBottomSheetName),
          builder: (context) {
            return CountingResultBottomSheet(
              scoreLead: res.scoreLead,
              winner: res.winner,
              onAccept: () {
                widget.game.acceptCountingResult(true);
                maybeDismissRoute(_countingResultBottomSheetName);
              },
              onReject: () {
                widget.game.acceptCountingResult(false);
                maybeDismissRoute(_countingResultBottomSheetName);
                setState(() {
                  _state = GameState.playing;
                  _territoryAnnotations = null;
                });
              },
            );
          });
    }

    setState(() {
      _state = GameState.counting;
    });
  }

  void onAIRefereeClicked() {
    // We can only request AI referee if we are playing and it's our turn.
    if (_state != GameState.playing) return;
    if (_turn != widget.game.myColor) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Please wait for your turn'),
        showCloseIcon: true,
      ));
      return;
    }
    if (_gameTree.curNode.moveNumber <
        (widget.serverFeatures.aiRefereeMinMoveCount[widget.game.boardSize] ??
            (1 << 30))) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('AI Referee cannot be used yet'),
        showCloseIcon: true,
      ));
      return;
    }

    widget.game.aiReferee().then((_) {}, onError: (err) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('$err'),
          showCloseIcon: true,
        ));
      }
    });
  }

  void onForceCountingClicked() {
    // We can only request forced counting if we are playing and it's our turn.
    if (_state != GameState.playing) return;
    if (_turn != widget.game.myColor) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please wait for your turn'),
        showCloseIcon: true,
      ));
      return;
    }
    if (_gameTree.curNode.moveNumber <
        (widget.serverFeatures
                .forcedCountingMinMoveCount[widget.game.boardSize] ??
            (1 << 30))) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Forced counting cannot be used yet'),
        showCloseIcon: true,
      ));
      return;
    }

    widget.game.forceCounting().then((_) {}, onError: (err) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('$err'),
          showCloseIcon: true,
        ));
      }
    });
  }

  void onGameResult(GameResult res) {
    if (_state == GameState.over) return;

    // Dismiss any existing dialog
    maybeDismissRoute(_waitingDialogName);
    maybeDismissRoute(_countingResultBottomSheetName);
    // Show game result dialog
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Result'),
            content: Text(res.result),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    setState(() {
      _state = GameState.over;
      _territoryAnnotations = null;
    });
  }

  onGameError(err) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(err),
        showCloseIcon: true,
        behavior: SnackBarBehavior.floating,
      ));
      Navigator.popUntil(context, (route) => route.isFirst);
    }
  }

  void onLeaveClicked() {
    Navigator.pop(context);
  }

  void maybeDismissRoute(String name) {
    if (context.mounted) {
      Navigator.popUntil(context, (route) {
        final pred = ModalRoute.withName(name);
        return !pred(route);
      });
    }
  }

  Future<void> _showUserInfoDialog(
      BuildContext context, ValueNotifier<UserInfo> userInfo) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        final userInfoCard = ValueListenableBuilder(
          valueListenable: userInfo,
          builder: (context, info, child) {
            return UserInfoCard(userInfo: info);
          },
        );
        final streakCard = ValueListenableBuilder(
          valueListenable: userInfo,
          builder: (context, value, child) {
            if (value.streak != null) {
              const maxStreakLen = 15;
              final s = value.streak!;
              return StreakCard(
                  streak:
                      s.substring(max(0, s.length - maxStreakLen), s.length));
            }
            return CircularProgressIndicator();
          },
        );
        final promotionRequirementCard = ValueListenableBuilder(
          valueListenable: userInfo,
          builder: (context, value, child) {
            final req = value.promotionRequirements;
            if (req != null) {
              return PromotionCard(requirements: req);
            }
            return SizedBox();
          },
        );
        return AlertDialog(
          contentPadding: EdgeInsets.all(8),
          content: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                userInfoCard,
                streakCard,
                promotionRequirementCard,
              ],
            ),
          ),
        );
      },
    );
  }
}

class _GameInfoCard extends StatelessWidget {
  final Game game;

  const _GameInfoCard({required this.game});

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
          'Rules: ${game.rules.toString()}',
          textAlign: TextAlign.center,
        ),
        if (game.handicap > 1)
          Text(
            'Handicap: ${game.handicap}',
            textAlign: TextAlign.center,
          ),
        if (game.handicap <= 1)
          Text(
            'Komi: ${game.komi}',
            textAlign: TextAlign.center,
          ),
      ],
    ));
  }
}
