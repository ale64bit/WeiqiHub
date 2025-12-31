import 'package:extension_type_unions/extension_type_unions.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:wqhub/analysis/analysis_side_bar.dart';
import 'package:wqhub/analysis/katago.dart';
import 'package:wqhub/analysis/katago_request.dart';
import 'package:wqhub/analysis/katago_response.dart';
import 'package:wqhub/audio/audio_controller.dart';
import 'package:wqhub/board/board.dart';
import 'package:wqhub/board/board_annotation.dart';
import 'package:wqhub/board/board_settings.dart';
import 'package:wqhub/board/coordinate_style.dart';
import 'package:wqhub/game_client/rules.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/play/game_navigation_bar.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/wq/annotated_game_tree.dart';
import 'package:wqhub/wq/wq.dart' as wq;

class KataGoRouteArguments {
  final KataGoConfig config;

  const KataGoRouteArguments({required this.config});
}

class KataGoPage extends StatefulWidget {
  static const routeName = '/katago';

  const KataGoPage({super.key, required this.config});

  final KataGoConfig config;

  @override
  State<KataGoPage> createState() => _KataGoPageState();
}

class _KataGoPageState extends State<KataGoPage> {
  late final KataGo katago;

  final _boardSize = 19;
  final _gameTree = AnnotatedGameTree(19);
  var _turn = wq.Color.black;
  final _katagoResponses = <String, KataGoResponse>{};

  @override
  void initState() {
    super.initState();
    KataGo.create(widget.config).then((kg) {
      katago = kg;
      _queryKataGo(_posKey(_turn, _gameTree.posHash()), [], const IMap.empty());
    });
  }

  @override
  void dispose() {
    super.dispose();
    katago.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final curResp = _katagoResponses[_posKey(_turn, _gameTree.posHash())];
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
          annotations: _annotationsFromResponse(
            _gameTree.annotations,
            curResp,
          ),
          confirmTap: context.settings.confirmMoves,
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.board),
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
            child: AnalysisSideBar(
              resp: curResp,
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

  void _onPointClicked(p) {
    if (_gameTree
            .moveAnnotated((col: _turn, p: p), mode: AnnotationMode.mainline) !=
        null) {
      AudioController().playForNode(_gameTree.curNode);

      {
        final moves = <wq.Move>[];
        var cur = _gameTree.curNode;
        while (cur.parent != null) {
          moves.add(cur.move!);
          cur = cur.parent!;
        }
        _queryKataGo(_posKey(_turn.opposite, _gameTree.posHash()),
            moves.reversed, _gameTree.stones);
      }

      setState(() {
        _turn = _turn.opposite;
      });
    }
  }

  void _queryKataGo(String key, Iterable<wq.Move> moves,
      IMap<wq.Point, wq.Color> stones) async {
    final respStream = katago.query(KataGoRequest(
      id: '$key-${DateTime.now().millisecondsSinceEpoch}',
      reportDuringSearchEvery: 0.1,
      initialStones: [],
      moves: moves.toList(),
      rules: Rules.chinese,
      komi: 7.5,
      boardSize: _boardSize,
      maxVisits: 5000,
      overrideSettings: {},
    ));
    await for (final resp in respStream) {
      setState(() {
        _katagoResponses[key] = resp;
      });
    }
  }

  String _posKey(wq.Color turn, int posHash) => '${turn.index}_$posHash';

  IMapOfSets<wq.Point, Annotation> _annotationsFromResponse(
      IMapOfSets<wq.Point, Annotation> baseAnnotations, KataGoResponse? resp) {
    if (resp == null) {
      return baseAnnotations;
    }
    for (final info in resp.moveInfos) {
      if (info.order < 15 && info.move != null) {
        baseAnnotations = baseAnnotations.addValues(
            info.move!, _annotationsFromMoveInfo(info));
      }
    }
    return baseAnnotations;
  }

  Iterable<Annotation> _annotationsFromMoveInfo(MoveInfo info) => [
        (
          color: _colorFromOrder(info.order),
          type: AnnotationShape.filledCircle.u21,
        ),
        (
          color: Colors.black,
          type: '${info.order + 1}'.u22,
        ),
      ];

  Color _colorFromOrder(int order) {
    if (order == 0) {
      return Colors.lightBlueAccent;
    } else if (order <= 3) {
      return Colors.lightGreen;
    } else if (order <= 9) {
      return Colors.yellow;
    } else {
      return Colors.orange;
    }
  }
}
