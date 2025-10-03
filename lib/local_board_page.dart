import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show dirname;
import 'package:share_plus/share_plus.dart';
import 'package:wqhub/audio/audio_controller.dart';
import 'package:wqhub/l10n/app_localizations.dart';
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
        title: Text(loc.board),
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
      AudioController().playForNode(_gameTree.curNode);
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
      final fileName = res.suggestedFilename();

      if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
        final FileSaveLocation? result = await getSaveLocation(
          suggestedName: fileName,
          initialDirectory: context.settings.getSaveDirectory(),
        );
        if (result != null) {
          final f = File(result.path);
          await f.writeAsBytes(utf8.encode(sgfData));
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('SGF saved to ${result.path}'),
            showCloseIcon: true,
            behavior: SnackBarBehavior.floating,
          ));
          context.settings.saveDirectory = dirname(result.path);
        }
      } else {
        Rect? sharePositionOrigin;
        if (defaultTargetPlatform == TargetPlatform.iOS) {
          DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
          IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
          if (iosInfo.model.toLowerCase().contains('ipad')) {
            final box = context.findRenderObject() as RenderBox?;
            sharePositionOrigin = box!.localToGlobal(Offset.zero) & box.size;
          }
        }
        final params = ShareParams(
          files: [
            XFile.fromData(
              utf8.encode(sgfData),
              mimeType: 'application/x-go-sgf',
            )
          ],
          fileNameOverrides: [fileName],
          sharePositionOrigin: sharePositionOrigin,
        );
        await SharePlus.instance.share(params);
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
    final loc = AppLocalizations.of(context)!;
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
                child: Text(loc.nxnBoardSize(size)),
              )
          ],
          child: Text(loc.boardSize),
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
          child: Text(loc.handicap),
        ),
        MenuItemButton(onPressed: widget.onSaveSgf, child: Text(loc.saveSGF)),
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
