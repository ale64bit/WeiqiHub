import 'dart:io';
import 'dart:typed_data';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wqhub/audio/audio_controller.dart';
import 'package:wqhub/save_sgf_form.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/wq/annotated_game_tree.dart';
import 'package:wqhub/board/board.dart';
import 'package:wqhub/board/board_settings.dart';
import 'package:wqhub/board/coordinate_style.dart';
import 'package:wqhub/play/game_navigation_bar.dart';
import 'package:wqhub/wq/handicap.dart';
import 'package:wqhub/wq/wq.dart' as wq;

class LocalBoardPage extends StatefulWidget {
  static const routeName = '/local_board';

  const LocalBoardPage({super.key});

  @override
  State<LocalBoardPage> createState() => _LocalBoardPageState();
}

class _LocalBoardPageState extends State<LocalBoardPage> {
  var _boardSize = 19;
  var _handicap = 0;
  var _gameTree = AnnotatedGameTree(19);
  var _turn = wq.Color.black;
  var _variation = false;

  static const WidgetStateProperty<Icon> variationThumbIcon =
      WidgetStateProperty<Icon>.fromMap(
    <WidgetStatesConstraint, Icon>{
      WidgetState.selected: Icon(Icons.hdr_auto),
      WidgetState.any: Icon(Icons.lens),
    },
  );

  @override
  Widget build(BuildContext context) {
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
          onPointClicked: _onPointClicked,
          turn: _turn,
          stones: _gameTree.stones,
          annotations: _gameTree.annotations,
          confirmTap: context.settings.confirmMoves,
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Board'),
        actions: <Widget>[
          Switch(
            thumbIcon: variationThumbIcon,
            value: _variation,
            onChanged: (v) {
              _variation = v;
              if (!_variation) {
                while (_gameTree.isVariation) {
                  _gameTree.undo();
                  _turn = _turn.opposite;
                }
              }
              setState(() {});
            },
          ),
          _LocalBoardMenu(
            onUpdateBoard: _updateBoard,
            onSaveSgf: _onSaveSgf,
          ),
        ],
      ),
      body: Center(
        child: board,
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

  void _onPointClicked(p) {
    if (_gameTree.moveAnnotated((col: _turn, p: p),
            mode: _variation
                ? AnnotationMode.variation
                : AnnotationMode.mainline) !=
        null) {
      if (context.settings.sound) {
        AudioController().playForNode(_gameTree.curNode);
      }
      setState(() {
        _turn = _turn.opposite;
      });
    }
  }

  _updateBoard(int size, int handicap) {
    _boardSize = size;
    _handicap = handicap;
    _gameTree = AnnotatedGameTree(_boardSize,
        initialStones: IMapOfSets({
          wq.Color.black: handicapPosition.getOrNull((_boardSize, _handicap)) ??
              const ISetConst({}),
        }));
    _turn = (_handicap > 1) ? wq.Color.white : wq.Color.black;
    setState(() {/* Update board */});
  }

  _onSaveSgf() async {
    final res = await showModalBottomSheet<SaveSgfFormResult>(
        context: context,
        builder: (context) {
          return SaveSgfForm();
        });
    if (res != null) {
      final sgfData = _gameTree.sgf(
        rules: res.rules,
        komi: res.komi,
        blackNick: res.blackNick,
        blackRank: res.blackRank,
        whiteNick: res.whiteNick,
        whiteRank: res.whiteRank,
        result: res.result,
      );
      final filename = res.suggestedFilename();
      if (Platform.isLinux) {
        final downloadDir = await getDownloadsDirectory();
        final f = File('${downloadDir?.path}/$filename');
        await f.writeAsString(sgfData);
        if (context.mounted) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('SGF saved to Downloads folder'),
            showCloseIcon: true,
            behavior: SnackBarBehavior.floating,
          ));
        }
      } else {
        await Share.shareXFiles(
            [
              XFile.fromData(
                Uint8List.fromList(sgfData.codeUnits),
                mimeType: 'application/x-go-sgf',
              )
            ],
            text: filename,
            fileNameOverrides: [filename]);
      }
    }
  }
}

class _LocalBoardMenu extends StatefulWidget {
  final Function(int, int) onUpdateBoard;
  final Function() onSaveSgf;

  const _LocalBoardMenu({required this.onUpdateBoard, required this.onSaveSgf});

  @override
  State<_LocalBoardMenu> createState() => _LocalBoardMenuState();
}

class _LocalBoardMenuState extends State<_LocalBoardMenu> {
  final FocusNode _buttonFocusNode = FocusNode(debugLabel: 'Menu Button');
  var _boardSize = 19;
  var _handicap = 0;

  @override
  void dispose() {
    _buttonFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      childFocusNode: _buttonFocusNode,
      menuChildren: <Widget>[
        SubmenuButton(
          menuChildren: <Widget>[
            for (final size in {9, 13, 19})
              MenuItemButton(
                onPressed: () {
                  if (_boardSize != size) {
                    setState(() {
                      _boardSize = size;
                      _handicap = 0;
                    });
                    widget.onUpdateBoard(_boardSize, _handicap);
                  }
                },
                leadingIcon: Icon(_boardSize == size
                    ? Icons.check_box
                    : Icons.check_box_outline_blank),
                child: Text('${size}×$size'),
              )
          ],
          child: const Text('Board size'),
        ),
        SubmenuButton(
          menuChildren: <Widget>[
            for (int h = 0; h <= _maxHandicapForBoardSize(_boardSize); h++)
              MenuItemButton(
                onPressed: () {
                  if (_handicap != h) {
                    setState(() {
                      _handicap = h;
                    });
                    widget.onUpdateBoard(_boardSize, _handicap);
                  }
                },
                leadingIcon: Icon(_handicap == h
                    ? Icons.check_box
                    : Icons.check_box_outline_blank),
                child: Text('$h'),
              )
          ],
          child: const Text('Handicap'),
        ),
        MenuItemButton(
            onPressed: widget.onSaveSgf, child: const Text('Save SGF')),
      ],
      builder: (context, controller, child) {
        return IconButton(
          focusNode: _buttonFocusNode,
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: const Icon(Icons.more_vert),
        );
      },
    );
  }

  int _maxHandicapForBoardSize(int size) => switch (size) {
        9 => 5,
        13 => 9,
        19 => 9,
        _ => 0,
      };
}
