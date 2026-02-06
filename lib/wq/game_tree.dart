import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:intl/intl.dart';
import 'package:wqhub/board/board_state.dart';
import 'package:wqhub/wq/rank.dart';
import 'package:wqhub/wq/wq.dart' as wq;

class GameTreeNode<T> {
  GameTreeNode({
    required this.move,
    required this.moveNumber,
    required this.captureCountBlack,
    required this.captureCountWhite,
    required this.diff,
    required this.parent,
  });

  final wq.Move? move;
  final int moveNumber;
  final int captureCountBlack;
  final int captureCountWhite;
  final IList<wq.Point> diff;
  final GameTreeNode<T>? parent;
  final Map<wq.Move, GameTreeNode<T>> _next = {};
  T? metadata;

  GameTreeNode<T>? get next => _next.values.firstOrNull;
  GameTreeNode<T>? child(wq.Move mv) => _next[mv];

  bool prune(wq.Move mv) => _next.remove(mv) != null;
}

class GameTree<T> {
  GameTree(int size,
      {this.initialStones = const IMapOfSetsConst(IMapConst({}))})
      : _board = BoardState(size: size, initialStones: initialStones),
        _cur = GameTreeNode(
            move: null,
            moveNumber: 0,
            captureCountBlack: 0,
            captureCountWhite: 0,
            diff: const IListConst([]),
            parent: null);

  final BoardState _board;
  final IMapOfSets<wq.Color, wq.Point> initialStones;
  GameTreeNode<T> _cur;

  GameTreeNode<T> get curNode => _cur;

  GameTreeNode<T> get rootNode {
    var root = _cur;
    while (root.parent != null) {
      root = root.parent!;
    }
    return root;
  }

  IMap<wq.Point, wq.Color> get stones => _board.stones;

  bool canMove(wq.Move mv) => _board.canMove(mv);

  int posHash() => _board.hash();

  GameTreeNode<T>? move(wq.Move mv, {bool prune = false}) {
    if (_cur._next.containsKey(mv)) {
      _cur = _cur._next[mv]!;
      final diff = _board.move(mv);
      assert(diff == _cur.diff);
      return _cur;
    }

    if (prune) _cur._next.clear();

    final diff = _board.move(mv);
    if (diff == null) return null;

    final (blackCaptures, whiteCaptures) = switch (mv.col) {
      wq.Color.black => (0, diff.length),
      wq.Color.white => (diff.length, 0),
    };
    final newNode = GameTreeNode<T>(
      move: mv,
      moveNumber: _cur.moveNumber + 1,
      captureCountBlack: _cur.captureCountBlack + blackCaptures,
      captureCountWhite: _cur.captureCountWhite + whiteCaptures,
      diff: diff,
      parent: _cur,
    );
    _cur._next[mv] = newNode;
    _cur = newNode;
    return _cur;
  }

  GameTreeNode<T>? undo() {
    if (_cur.parent == null) return null;

    if (_cur.move != null) {
      _board.undo(_cur.move!, _cur.diff);
    }
    _cur = _cur.parent!;
    return _cur;
  }

  List<wq.Move?> lastNMoves({int count = 1}) {
    final moves = <wq.Move?>[];
    var cur = curNode;
    for (int i = 0; i < count; ++i) {
      moves.add(cur.move);
      cur = cur.parent!;
    }
    return moves.reversedView;
  }

  String sgf(
      {String? rules,
      double? komi,
      String? blackNick,
      Rank? blackRank,
      String? whiteNick,
      Rank? whiteRank,
      String? result}) {
    final buf = StringBuffer('(;GM[1]FF[4]');
    buf.write('AP[wqhub]');
    buf.write('SZ[${_board.size}]');
    buf.write('DT[${DateFormat('yyyy.MM.dd').format(DateTime.now())}]');
    if (rules != null) buf.write('RU[${rules.toString().toLowerCase()}]');
    if (komi != null) buf.write('KM[${komi.toStringAsFixed(2)}]');

    final handicap = initialStones.getOrNull(wq.Color.black)?.length ?? 0;
    if (!initialStones.containsKey(wq.Color.white)) buf.write('HA[$handicap]');

    if (blackNick != null) buf.write('PB[$blackNick]');
    if (blackRank != null) buf.write('BR[${blackRank.toString()}]');
    if (whiteNick != null) buf.write('PW[$whiteNick]');
    if (whiteRank != null) buf.write('WR[${whiteRank.toString()}]');

    if (result != null) buf.write('RE[$result]');

    buf.writeln();

    // Initial stones
    for (final e in initialStones.entries) {
      if (e.value.isNotEmpty) {
        buf.write('A${e.key.toString()}');
        for (final p in e.value) {
          buf.write('[${p.toSgf()}]');
        }
      }
    }

    // Game moves
    var cur = curNode;
    while (cur.parent != null) {
      cur = cur.parent!;
    }
    while (cur._next.isNotEmpty) {
      final e = cur._next.entries.first;
      buf.write(';${e.key.col.toString()}[${e.key.p.toSgf()}]');
      cur = e.value;
    }

    buf.writeln(')');
    return buf.toString();
  }
}
