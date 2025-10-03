import 'package:flutter/material.dart';
import 'package:wqhub/audio/audio_controller.dart';
import 'package:wqhub/board/board.dart';
import 'package:wqhub/board/board_settings.dart';
import 'package:wqhub/board/coordinate_style.dart';
import 'package:wqhub/game_client/game_client.dart';
import 'package:wqhub/game_client/game_record.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/play/game_navigation_bar.dart';
import 'package:wqhub/play/player_card.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/wq/annotated_game_tree.dart';
import 'package:wqhub/wq/wq.dart' as wq;

class GameRecordRouteArguments {
  final GameSummary summary;
  final GameRecord record;

  const GameRecordRouteArguments({required this.summary, required this.record});
}

class GameRecordPage extends StatefulWidget {
  static const routeName = '/play/game_record';

  const GameRecordPage(
      {super.key, required this.summary, required this.record});

  final GameSummary summary;
  final GameRecord record;

  @override
  State<GameRecordPage> createState() => _GameRecordPageState();
}

class _GameRecordPageState extends State<GameRecordPage> {
  late AnnotatedGameTree _gameTree;
  wq.Color? _turn;

  @override
  void initState() {
    super.initState();
    _gameTree = AnnotatedGameTree(widget.summary.boardSize);
    for (final mv in widget.record.moves) {
      final (r, c) = mv.p;
      if (r >= 0) _gameTree.moveAnnotated(mv, mode: AnnotationMode.mainline);
      _turn = mv.col.opposite;
    }
    if (context.mounted) setState(() {/* update board */});
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
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
      size: widget.summary.boardSize,
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
          turn: _turn,
          stones: _gameTree.stones,
          annotations: _gameTree.annotations,
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
    );
    final whitePlayerCard = PlayerCard(
      key: ValueKey('player-card-white'),
      userInfo: widget.summary.white,
      color: wq.Color.white,
      captureCount: _gameTree.curNode.captureCountBlack,
      timeDisplay: SizedBox(),
    );

    return Scaffold(
      appBar: wideLayout
          ? null
          : AppBar(
              title: Text(widget.summary.result.result),
            ),
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
                      _GameInfoCard(summary: widget.summary),
                      whitePlayerCard,
                      blackPlayerCard,
                      SizedBox(height: 8),
                      GameNavigationBar(
                        gameTree: _gameTree,
                        onMovesSkipped: (n) {
                          setState(() {
                            _turn =
                                (_gameTree.curNode.move?.col ?? wq.Color.white)
                                    .opposite;
                          });
                        },
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  whitePlayerCard,
                  Expanded(child: Center(child: board)),
                  blackPlayerCard,
                  Stack(
                    children: [
                      GameNavigationBar(
                        gameTree: _gameTree,
                        onMovesSkipped: (n) {
                          setState(() {
                            _turn =
                                (_gameTree.curNode.move?.col ?? wq.Color.white)
                                    .opposite;
                          });
                        },
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
      floatingActionButton: wideLayout
          ? FloatingActionButton.large(
              onPressed: onLeaveClicked,
              tooltip: loc.leave,
              child: Icon(Icons.logout),
            )
          : null,
    );
  }

  void onPointClicked(wq.Point p) {
    if (_turn == null) return;

    // First try to apply the move to the tree to check validity
    final node = _gameTree
        .moveAnnotated((col: _turn!, p: p), mode: AnnotationMode.variation);
    if (node == null) return;

    AudioController().playForNode(_gameTree.curNode);

    // Toggle current turn
    setState(() {
      _turn = _turn?.opposite;
    });
  }

  void onLeaveClicked() {
    Navigator.pop(context);
  }
}

class _GameInfoCard extends StatelessWidget {
  final GameSummary summary;

  const _GameInfoCard({required this.summary});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Card(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          loc.gameRecord,
          textAlign: TextAlign.center,
          style: TextTheme.of(context).titleLarge,
        ),
        Text(
          '${loc.result}: ${summary.result.result}',
          textAlign: TextAlign.center,
        ),
        // if (game.handicap > 1)
        //   Text(
        //     'Handicap: ${game.handicap}',
        //     textAlign: TextAlign.center,
        //   ),
        // if (game.handicap <= 1)
        //   Text(
        //     'Komi: ${game.komi}',
        //     textAlign: TextAlign.center,
        //   ),
      ],
    ));
  }
}
