import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:wqhub/wq/wq.dart' as wq;

class MoveDiff {}

class BoardState {
  BoardState(
      {required this.size,
      IMapOfSets<wq.Color, wq.Point> initialStones =
          const IMapOfSetsConst(IMapConst({}))})
      : _state = List.generate(size, (_) => List.filled(size, null),
            growable: false),
        _tag =
            List.generate(size, (_) => List.filled(size, 0), growable: false),
        _traversalTag = 0,
        _curHash = 0 {
    for (final e in initialStones.entries) {
      for (final (r, c) in e.value) {
        _state[r][c] = e.key;
        _stones = _stones.add((r, c), e.key);
        _curHash ^= _zobrist[r][c][e.key.id];
      }
    }
    _prevHash.add(_curHash);
  }

  final int size;
  final List<List<wq.Color?>> _state;
  int _traversalTag;
  final List<List<int>> _tag;
  int _curHash;
  final Set<int> _prevHash = {};
  var _stones = const IMap<wq.Point, wq.Color>.empty();

  IMap<wq.Point, wq.Color> get stones => _stones;
  wq.Color? operator [](wq.Point p) => _state[p.$1][p.$2];

  int hash() => _curHash;

  bool canMove(wq.Move mv) {
    final (:col, :p) = mv;
    final (r, c) = p;

    // Check if point is valid
    if (!inside(p)) return false;

    // Check if point is empty
    if (this[p] != null) return false;

    // Add the new stone
    _state[r][c] = col;

    // Collect groups without liberties
    final List<wq.PointList> capGroups = [[], []];
    _traversalTag++;
    for (final (dr, dc) in _deltaAndSelf) {
      final np = (r + dr, c + dc);
      final (nr, nc) = np;
      if (!inside(np)) continue;

      if (_tag[nr][nc] < _traversalTag &&
          this[np] != null &&
          !_hasLiberties(np)) {
        capGroups[this[np]!.id].add(np);
      }
    }

    // Check suicide
    final isSelfCapture = capGroups[col.id].isNotEmpty;
    final isOppCapture = capGroups[col.opposite.id].isNotEmpty;
    if (isSelfCapture && !isOppCapture) {
      _state[r][c] = null;
      return false;
    }

    // Check ko
    var newHash = _curHash ^ _zobrist[r][c][col.id];
    _traversalTag++;
    for (final (rr, cc) in capGroups[col.opposite.id]) {
      if (_tag[rr][cc] < _traversalTag) {
        newHash ^= _hashGroup((rr, cc), col.opposite);
      }
    }

    // Restore board state
    _state[r][c] = null;

    return !_prevHash.contains(newHash);
  }

  IList<wq.Point>? move(wq.Move mv) {
    final (:col, :p) = mv;
    final (r, c) = p;

    // Check if point is valid
    if (!inside(p)) return null;

    // Check if point is empty
    if (this[p] != null) return null;

    // Add the new stone
    _state[r][c] = col;

    // Collect groups without liberties
    final List<wq.PointList> capGroups = [[], []];
    _traversalTag++;
    for (final (dr, dc) in _deltaAndSelf) {
      final np = (r + dr, c + dc);
      final (nr, nc) = np;
      if (!inside(np)) continue;

      if (_tag[nr][nc] < _traversalTag &&
          this[np] != null &&
          !_hasLiberties(np)) {
        capGroups[this[np]!.id].add(np);
      }
    }

    // Check suicide
    final isSelfCapture = capGroups[col.id].isNotEmpty;
    final isOppCapture = capGroups[col.opposite.id].isNotEmpty;
    if (isSelfCapture && !isOppCapture) {
      _state[r][c] = null;
      return null;
    }

    // Check ko
    var newHash = _curHash ^ _zobrist[r][c][col.id];
    _traversalTag++;
    for (final (rr, cc) in capGroups[col.opposite.id]) {
      if (_tag[rr][cc] < _traversalTag) {
        newHash ^= _hashGroup((rr, cc), col.opposite);
      }
    }
    if (_prevHash.contains(newHash)) {
      _state[r][c] = null;
      return null;
    }

    // Add position to previous seen
    _curHash = newHash;
    _prevHash.add(_curHash);

    // Remove captured groups and update stones
    _stones = _stones.add(p, col);
    var removed = const IList<wq.Point>.empty();
    for (final p in capGroups[col.opposite.id]) {
      removed = removed.addAll(_removeGroup(p));
    }

    return removed;
  }

  void undo(wq.Move mv, IList<wq.Point> added) {
    final (:col, :p) = mv;
    final (r, c) = p;

    assert(this[p] == col);

    _prevHash.remove(_curHash);

    // Remove last stone
    _state[r][c] = null;
    _curHash ^= _zobrist[r][c][col.id];
    _stones = _stones.remove(p);

    // Add captured stones back
    for (final pp in added) {
      assert(this[pp] == null);
      final (rr, cc) = pp;
      _state[rr][cc] = col.opposite;
      _curHash ^= _zobrist[rr][cc][col.opposite.id];
      _stones = _stones.add(pp, col.opposite);
    }

    assert(_prevHash.contains(_curHash));
  }

  bool inside(wq.Point p) =>
      0 <= p.$1 && p.$1 < size && 0 <= p.$2 && p.$2 < size;

  List<List<int>> libertyCount() {
    final groupId = groups();
    final groupLiberties = {};
    for (int i = 0; i < size; ++i) {
      for (int j = 0; j < size; ++j) {
        if (_state[i][j] != null) continue;
        final groupCounted = <int>{};
        for (final (di, dj) in _delta) {
          final (ni, nj) = (i + di, j + dj);
          if (!inside((ni, nj))) continue;
          final gid = groupId[ni][nj];
          if (gid != 0 && !groupCounted.contains(gid)) {
            groupLiberties.update(gid, (n) => n + 1, ifAbsent: () => 1);
            groupCounted.add(gid);
          }
        }
      }
    }
    final libertyCount = List.generate(19, (_) => List.filled(19, 0));
    for (int i = 0; i < size; ++i) {
      for (int j = 0; j < size; ++j) {
        if (_state[i][j] == null) continue;
        libertyCount[i][j] = groupLiberties[groupId[i][j]];
      }
    }
    return libertyCount;
  }

  List<List<int>> groups() {
    final groupId = List.generate(19, (_) => List.filled(19, 0));
    var groupCount = 0;
    for (int i = 0; i < size; ++i) {
      for (int j = 0; j < size; ++j) {
        if (_state[i][j] == null || groupId[i][j] != 0) continue;
        groupCount++;
        groupId[i][j] = groupCount;
        _fillGroup(i, j, groupId);
      }
    }
    return groupId;
  }

  bool _hasLiberties(wq.Point p) {
    final (r, c) = p;
    var ret = false;
    _tag[r][c] = _traversalTag;
    for (final (dr, dc) in _delta) {
      final np = (r + dr, c + dc);
      final (nr, nc) = np;
      if (!inside(np)) continue;

      if (this[np] == null) {
        ret = true;
      } else if (this[np] == this[p] && _tag[nr][nc] < _traversalTag) {
        ret |= _hasLiberties(np);
      }
    }
    return ret;
  }

  IList<wq.Point> _removeGroup(wq.Point p) {
    final (r, c) = p;
    final refCol = this[p];
    _state[r][c] = null;
    var removed = const IList<wq.Point>.empty();
    for (final (dr, dc) in _delta) {
      final np = (r + dr, c + dc);
      if (inside(np) && this[np] == refCol) {
        removed = removed.addAll(_removeGroup(np));
      }
    }
    _stones = _stones.remove(p);
    return removed.add(p);
  }

  int _hashGroup(wq.Point p, wq.Color col) {
    final (r, c) = p;
    var h = _zobrist[r][c][col.id];
    _tag[r][c] = _traversalTag;
    for (final (dr, dc) in _delta) {
      final np = (r + dr, c + dc);
      final (nr, nc) = np;
      if (!inside(np)) continue;
      if (this[np] == col && _tag[nr][nc] < _traversalTag) {
        h ^= _hashGroup(np, col);
      }
    }
    return h;
  }

  void _fillGroup(int r, int c, List<List<int>> groupId) {
    for (final (dr, dc) in _delta) {
      final (nr, nc) = (r + dr, c + dc);
      if (inside((nr, nc)) &&
          _state[r][c] == _state[nr][nc] &&
          groupId[nr][nc] == 0) {
        groupId[nr][nc] = groupId[r][c];
        _fillGroup(nr, nc, groupId);
      }
    }
  }

  static final _delta = const [
    (-1, 0),
    (1, 0),
    (0, -1),
    (0, 1),
  ];
  static final _deltaAndSelf = const [
    (0, 0),
    (-1, 0),
    (1, 0),
    (0, -1),
    (0, 1),
  ];

  static final _zobrist = const [
    [
      [0x3999a68ae64e57f6, 0xb04cce4c34442942],
      [0xbe4c414388b68403, 0x895249539ba23a3f],
      [0xd6d757fc76f5d5f2, 0xf0d8f097ce300c6d],
      [0xaf1475f8790b6a67, 0xd8aac6fecb5fc988],
      [0x5690b568112ec29a, 0x29122883a8fa6860],
      [0xf80d07506f5b24ed, 0xa6f7f89a1d89b558],
      [0x60de0106277eccdf, 0x460e9ce6e0c30c88],
      [0xb12cb40a6c3505f2, 0x98fc11cc724a686f],
      [0xc20455ed6cac0f3, 0x202ce2f19843be00],
      [0x7def7d9a851e95a2, 0xd9391e53955e9579],
      [0x656b1b69ad046dfe, 0x5bde1de0eca6a66a],
      [0xb90fd851363ece48, 0x4276d6d4c35de511],
      [0x2c18aad66bca98b2, 0x4666c2616865d250],
      [0x2a66fa696e8ecc38, 0x912ebb4733226b38],
      [0xaa05b632fe9f033a, 0x16d7da034008da78],
      [0x2ffb8a37c5b49a7a, 0xc3446a6d062aa980],
      [0xe5f357c56983e93d, 0xc54a1a2ee9331b1d],
      [0x2ffdd1a4ff71162, 0x2266e09d756887fd],
      [0xd270d5cf02daa13a, 0x2b31a13fc7532542]
    ],
    [
      [0x254ab01887d475df, 0xfb7b7f7b90cad6b6],
      [0xe34b02d12574199c, 0xb1ce8509f9dcaaf3],
      [0xe1c1b76dba05f31c, 0xb0b47ddad2338c86],
      [0x45f7120ed3525bb5, 0xb3c2931bc62685b2],
      [0xa5eebc1c37c11f40, 0xc14a1630c9c0734f],
      [0x378224b5a1f5b4d6, 0xe785b7e159116d38],
      [0x440ee6c0d1e7855a, 0xf8e73ad67db1d5cb],
      [0xef4e17702aa189af, 0xb2798df3575cfc7],
      [0x3bd1ced1bc40d40a, 0xc3646c660bdfd1e4],
      [0xa74fa1631247a273, 0x1692afff75fc0075],
      [0x27abba9bc6cf6783, 0x2ac64375f59fd46c],
      [0xa3a94b74b8e27303, 0xee47af69883f18f2],
      [0xb664defeef1db65, 0xc7cf6fccd19bba3e],
      [0x4cb3e532859f048f, 0xebc736f4b9185b81],
      [0xa3cf7ca9dfbdfc75, 0x629fa414d20ff995],
      [0x4de9ec7854ba932f, 0x7bf7f3cb2c6e14b1],
      [0x10d909e908d0f745, 0x41b3b3535570e28d],
      [0x800c282ded7a0d5d, 0x3245b0795cd79d22],
      [0x3149e5b211a41c64, 0x34422aacea576472]
    ],
    [
      [0xd2e1012ed1a713dd, 0x6889bb900d5bd832],
      [0x7d48cb2f7945298a, 0x4b125cf5f9c3ac8c],
      [0xe207571483220bd5, 0xabfeac0b9c65f77e],
      [0xc6f262031ac1798c, 0x792330d499b4e88e],
      [0x47860d3666f9bc55, 0x1cd555b1be497922],
      [0x74ab42532d534e92, 0x98dbd87eca9295e2],
      [0xb9f3465d52b93f7b, 0x35ad6bea2c4ae263],
      [0x11c96a2c59c25ff3, 0x4fc99d57d1689e6d],
      [0xe4b105836bb1a95d, 0xbbfeef278cef09e0],
      [0x79c8c7afeb3981a1, 0x8cfa9b5e39bbd86f],
      [0x588bafbaa500f077, 0xc33153d49e2d24d0],
      [0x68e47cd03739a435, 0xd78c648fa86a0352],
      [0x710d20c053db97f2, 0xce66134b325bc9cf],
      [0x957cce11080b10fb, 0x518c0e46661aff2f],
      [0x9d7652867f3b6b78, 0xc628fdc6e6ce51be],
      [0xb59d0e7d34ab0ea6, 0x44fac28f25998f4d],
      [0x9a82410a5ed1c9fd, 0x287d86729fafbbb9],
      [0x36755d94f48b8672, 0xdf475ffd83ca4dc0],
      [0x2cfa40fad239e1fd, 0xeb60601cba9bfda0]
    ],
    [
      [0xde024a4326d973, 0x640d856ef449123d],
      [0x1d6c8fc7f65602c6, 0x8b8d4729a0c9aeae],
      [0xbc1b1dcca7962f13, 0xb86b1235e0d13b86],
      [0x3208468f150ddbda, 0x520c8e7e3c9c5e82],
      [0xbaa03c40388af2b2, 0xc43beaf7a0d06c5d],
      [0x8d6b077ae30a124f, 0xb048f404b1a2331b],
      [0x2a43c1c142730f1a, 0xac0d0182bd22b130],
      [0xdcdd660f3ba7f73f, 0xa6b9d58d9a2e6e2e],
      [0x3a344511b8996691, 0x6cb0ae2a65750fb9],
      [0x6fcaa6c3c8035f50, 0xe81a29ed9e75d68],
      [0xf2dcf00caa219026, 0xa929b451ef585727],
      [0x669167c3e1d64cd6, 0x6f0ec91af04daf8c],
      [0xe18fc635aa199ecc, 0xf3e372f278bf01b9],
      [0xeb8d4cf3d0ea8605, 0x6d1c4de056f90678],
      [0x1bc15692f6e710a4, 0x2adf014ee351345e],
      [0x20b530f2946edd32, 0xd96f0503a8f91839],
      [0x8c3f4fd2929d69be, 0x5b52cacde6e3071d],
      [0x473f22fe5c273383, 0x3e5a29af05cfc023],
      [0xec27618eadb84451, 0xab27fc7a5332e457]
    ],
    [
      [0x8f92a4bc96e6ef6d, 0xb9881376b317c1f8],
      [0x1d69819155979c4e, 0x3ea5af5c48940f88],
      [0xac2fa233f1803de, 0x86d999ab9e455fca],
      [0xc8cbeee16040ea12, 0xd9304814923065cb],
      [0x31fa01aac2601b3b, 0x8681e8fc1cc2014f],
      [0x76c1301d28bf3ce8, 0x4635126add2a288c],
      [0x886f32c80ea4722d, 0x399576c65228044b],
      [0x74c6385109bde2e2, 0xc13c545ce64fca47],
      [0x15cbbefbc963ec96, 0xc20c12febfa639df],
      [0x85b5d3e68a1a84f1, 0x937c0eb57e0a2909],
      [0x6bf8c8d88e786611, 0xce88b0a78ee03df3],
      [0x27ed358e413919f6, 0xc4077d4cd5f24bff],
      [0x7cffbfd57b9bf34a, 0x1b1344680bdf276e],
      [0x3fa789df0530f566, 0x4656aa4d1aad620b],
      [0x57b5ae6deac9fb85, 0xdcb1397e855fc17b],
      [0x53b9f4dcc0d1ae7a, 0x142e77c92a6de49b],
      [0xd5f9085d490474e0, 0xd543c3a00cf095fa],
      [0x740b6e0204fc17e0, 0x7700a4cdb016ffbd],
      [0x848b8d59c24af738, 0xebabeadf006bcb52]
    ],
    [
      [0xe1875cf69536cfc1, 0x1c6fcd4d18e77172],
      [0x531fde4e5c82cc6b, 0x3c7290a3c29fb0d1],
      [0x599b41d62a2f13fb, 0x45a9dc526acff0d],
      [0x6bb55c7499afee15, 0xf5bf3d19b68fa326],
      [0xc81878a19cfa24ed, 0x7fa347b2157b2afb],
      [0x584b0faf9244a722, 0x6496f621248ddef],
      [0xed0830a2489f6769, 0x942fca8199bb52fc],
      [0x740c969621a8123, 0x516aa418e18a27b],
      [0xf11e757bdeed3801, 0x1f908f3fe45ff324],
      [0xdfa8a003cc4d3f95, 0xe6fe30561898f6d5],
      [0x85862909150ac076, 0xc1dbf74da52f97b6],
      [0x398654d8037159d6, 0x3038c32aa4574cf3],
      [0x7ea3af0e2c1b2f15, 0xa519eb4075edd574],
      [0xa0f3e181f2f86cb1, 0x91148f13f2c349f5],
      [0x8aeaffa1a5fb255f, 0x3a19878bb9cc9c0c],
      [0x8f40c52a73b4e901, 0xed2c16894ebcdf31],
      [0x485c8dfb10d1a15e, 0xe194c0f9b3db3a6f],
      [0x926900269e1cc7b5, 0xefb7b37ae2fea04d],
      [0x568f49b9fe57874c, 0xcb0e8d86170f725e]
    ],
    [
      [0xbed3ad95688e79f0, 0x4474d72afab0853b],
      [0x16bd71d76664a851, 0xdadf96e1e9db3e81],
      [0x2d36d8aaddfe64a4, 0x5a47d2fec44dd9d3],
      [0x9bbae96f44c8245a, 0xb8afaa8cebd52d89],
      [0xbd72fa844593e36e, 0xa6946bdafef87048],
      [0x61e95649c06b0ece, 0x4595b6da8874ba96],
      [0x22722923fc5e0b7c, 0x9fb9e12d672552b1],
      [0xa8e3bf62d6b207d9, 0x73d4f23b0a150864],
      [0x5abc04cf5c26ff9c, 0xb9bd318e7aaa18f1],
      [0x9ecdeec663632f5e, 0x843e46e8db0322bf],
      [0xd42c70fd24ab4864, 0x9f85cb79e92efdf9],
      [0x9d890dc63ac50a64, 0xf82f76b5d177d82d],
      [0x62d655caf613db2f, 0x6c371d35247c4205],
      [0xcef81eb4fb9c5875, 0xacd5179cef4f0569],
      [0xeda2069bc77810c, 0xdff3a8c2afda05fa],
      [0x9f7e2f612a60a9d6, 0xaef2fd4df566f641],
      [0x2e2755fb1208f1e8, 0x48b6dc87c802f0d1],
      [0x71f437776cf335b8, 0x5ce0996bbb459308],
      [0x8ec6ecc7bb771c79, 0xdf82d18ea6a8caa]
    ],
    [
      [0x20f49acd992f3628, 0x3f64d01c5281e811],
      [0xcce70c40a4604ffa, 0xec5cb25e0f4c1e79],
      [0xebf9bb1fc3e000ef, 0x891a4e2d5b31bcdb],
      [0x37ccdd919d3a533f, 0x16a2993c78bfc7c0],
      [0x76c2ae65c9351c76, 0x7afce7f94f40ce77],
      [0xc7394136d2b1c134, 0x2329ab13f9ef68c],
      [0x97ac169799cf1593, 0x90f6b35b23cb122a],
      [0x4bdf1be16702a3d9, 0xffc0aee0ee3e1fc7],
      [0x752406fcfefc1bb6, 0x9b1d1dd388e19853],
      [0x5f709c91261025d9, 0xf4e8c868b4260184],
      [0x48ee230a485b5b45, 0x23101408873d66bf],
      [0x12d7521f3be5f986, 0xaa6b83d04a775b80],
      [0x13dc795be3cbf53b, 0xa7241540386d8744],
      [0xed46774e6c408819, 0xb2e0e95e7724860b],
      [0xbbb697781e81bb12, 0x70377dd1b4643089],
      [0xaf85ad38b1b6bba6, 0x61d7175feffce362],
      [0xb73e320ead0ca348, 0x1293b0c82bd3d437],
      [0xe14817b08ae7cd80, 0xc6052bb188a774a1],
      [0x807128ef30ae2f66, 0xe9f9d66eae2e5014]
    ],
    [
      [0x51981e69f9921e5d, 0x98aece5342a106e5],
      [0xa2815f5d9f5115, 0x96cb22dafded542a],
      [0x31f47f1766024a5a, 0x9c2c5e7e2fcbb80],
      [0xd4ead4b5a72ff0b9, 0xc4753cb51e0a470e],
      [0xf990d64800cfef28, 0x86a66ad58a6982a0],
      [0x2dc3301971df2135, 0x8bac4947124e9d96],
      [0x427df71a417fa2aa, 0x1bda8f4b21b08306],
      [0x1bcf6a5a2422a9f3, 0x91f16d0642d471e9],
      [0x36a622873b842cea, 0x7c9cd84b8c1f9448],
      [0x91eab0a705d1f8c5, 0x2697384423196ac3],
      [0x5e3e4cd0f68cee02, 0xa74bc9155a4c46ae],
      [0xac34333701a23b39, 0xa8fc850bc9821367],
      [0xa635aa268bdaf6ec, 0x6fd5694cb42201bb],
      [0xc9a3b66d8585908e, 0xfc77546f6b06086f],
      [0x4a87ab8f40e91bcc, 0x693199ff3ac04c12],
      [0x38dac90d1b97f48b, 0x2f29ef58630ad496],
      [0x31e890f549e7f0bb, 0x2d42e26cd4472fd7],
      [0x6fb06e8df3a61b2d, 0x2f9649e429881b4d],
      [0xa8c18e7c52ca6eb5, 0x62b218ee08e095ab]
    ],
    [
      [0x427d0332aa40f3e5, 0x5eec287d3431f6e9],
      [0xffca835ffc3dc0a, 0xa2b2402d569530f1],
      [0x22afca3031b5d67e, 0x6b0892765535c99c],
      [0xc7378a26a0ab2616, 0xdbf3b68d0f401de2],
      [0xd70b0fc0310be15, 0x7aeb356c9f6f0b51],
      [0x71a5ea968bceb839, 0x47deb8d7f3a6422],
      [0xd31759cb989d0c41, 0x86f3deddda6ec383],
      [0x4f54863d482eb53a, 0x81e27515cf2a7416],
      [0x14b3f3984b5331ab, 0x8981d6e3b3fc5dc8],
      [0xe68a4d8466e4bf60, 0x64369926969aace3],
      [0x424f2e97d51f9d72, 0xa18802159a8aa34d],
      [0xb19de4717c10ca3c, 0x54e263156146e016],
      [0xe4d0493e06b40c53, 0x7c37eac373518a3c],
      [0xed6b4e94db55b1f8, 0x8011c74d27ce5c99],
      [0xa49d6823586ce39b, 0xdca9f655ca85bfbb],
      [0x17761f098d29573d, 0x1acdc56e90933b07],
      [0x133a470f1337e9f4, 0xfc61397bdf142122],
      [0xa2d13ccea53fbc46, 0xead4da0622a16afc],
      [0x5779b0a9666e72b, 0x7d0667d801fbac2d]
    ],
    [
      [0x701f8f0c04deadb0, 0xc712a08838418dd5],
      [0x93edce678169a55c, 0x92ee138dc7101895],
      [0x29fa25560b9ab1c0, 0x83823effd89d4e71],
      [0x10c7b1497e239965, 0xfddcee3bab1246da],
      [0x612d6dd39ff0492c, 0x51e60bceae072eea],
      [0xf3161695233bbad2, 0x276150cb6789ee52],
      [0x2542b8965c2f6858, 0x363ee6348a5ebc6e],
      [0x1a1e2a87495dab34, 0x42b6fc21c333d523],
      [0xbe53554f204b5707, 0xbac6d6a4bddf3abd],
      [0x3bcaccaf4827727, 0x922d5938f719a6af],
      [0x931f41a0c956615b, 0xabb997c8bf94d369],
      [0x354a5b1c3b394826, 0xde3c424b1cd1c901],
      [0xe03495de04fc0515, 0x5bb2985aa17b26a1],
      [0xca5b5b908fb4c92e, 0x9ced6639fea824ca],
      [0x342bd4ca15d86118, 0x9adbb62c539afbc2],
      [0x19ef043c1c4e3093, 0x8dc6e5996fbf318a],
      [0xf456dff9fa0616bf, 0x16678c8ea6fb79eb],
      [0x4be442738a6e8377, 0xb01496ca9857c1e1],
      [0x1db284c81e9534cc, 0xc51fb4f7d5a56772]
    ],
    [
      [0x132c518023dea95f, 0x7aa5faecad98ce0d],
      [0xcdd242eab6e60181, 0x4264939529310817],
      [0xd85029e4e998daa9, 0x56d6c46f5ca2286f],
      [0xd7cc9501c1faa270, 0xbd25a584a490496a],
      [0xb4c8a39617b8bd30, 0x32175e18be1db1b9],
      [0x9d23c8e2b96ee6cd, 0x63610f1d2e4ff76c],
      [0xc16e62c559c843bc, 0xb66a4e1f87d9c2dc],
      [0x47d23eadd32032d6, 0xf36033b91d32af74],
      [0x76d55c73b5f5e355, 0x41ae3b9e78f9ac96],
      [0x424089d9a4f800bc, 0x74d4f2a1753a9909],
      [0x734fcee9c43f3526, 0x12305996cdf8eec9],
      [0xc0a8c0eee5f30240, 0x5529a8371e27ed5],
      [0xed5c63842081139d, 0xe0f202caf555aa0],
      [0x95a805cfa61eb2a, 0xbcf1cef93deb96af],
      [0xf0a080117acaead4, 0x6f45230b83821dea],
      [0x409bf5a25512cc9b, 0xa277e221ed219c39],
      [0x169964d50543b20d, 0x9ac958102883e96],
      [0x785d2cf1211c2189, 0x7c21977bc937dda],
      [0xa1b8977b347f4b5b, 0x504f0bddf4009c11]
    ],
    [
      [0xea4624d57f8c0fd9, 0x4a032cace1b1d5b1],
      [0x1c5467224a0ae48b, 0x2d005e876cd139aa],
      [0xa055029e4de422e8, 0xc607f99e773e5a60],
      [0xbeb2b66152152c79, 0xb7ff441629a7cc45],
      [0x44318b043f7e1974, 0xc4ced329db51d9e6],
      [0xbbf142c8a54249aa, 0xdb1a58e21ee4b72d],
      [0x39dfd825372350cd, 0x753e26733ca8c013],
      [0x993e1fbdbee2d1b9, 0xb4600140d99d27f8],
      [0x35c802b5bd462a7c, 0x6a9000ea53d7464c],
      [0x5859bc7718220008, 0xb906d6389227fc0c],
      [0x3cc5e64cc0ec6999, 0xe14f73e750d59e8f],
      [0x71cc99a33226108e, 0x553819de5a4d7ffc],
      [0x99782ab98a3ecc07, 0x44ffd0c84a9c08e1],
      [0xdb123a1eb38755e2, 0x22ad31fe49e7f6ab],
      [0x21f45742bf37c46a, 0x7d7ada9e41b3e13c],
      [0xd15f0c6bbc320df3, 0xc0643806b70ef5d6],
      [0x46fb30c62fc9dc9f, 0x8372a0e1be1d618a],
      [0xf98e5bf6af08eeb5, 0x486814dfab8ae04c],
      [0xda390e6f1622fa8b, 0xfbaab7d236461409]
    ],
    [
      [0x8ba3840ff84d88bd, 0x70f83e8bde7f958f],
      [0x59e1d8a707b9a5a, 0x6fc79e8301a6edc7],
      [0xabf7506370431a1a, 0x7418e8b9938e9f2d],
      [0x1586314e66fef2a1, 0xacec5d19dfa671a4],
      [0x7f024c438fca1a22, 0xe485e7f0180fb0a2],
      [0xbde144e2a8f2ac57, 0x68c09daccdb16e57],
      [0x378ef452e5d0d6c2, 0x146678c1064ec0b4],
      [0x9506ce8f27972913, 0x1db806c8bbca787e],
      [0x954e37dca4ef71ac, 0xd0699662ac69c3bd],
      [0x7bb7fbc2ea42dcd0, 0x6d1c6f3b5be8836b],
      [0xadedae8ac29bcc1f, 0xdb33493ac11f7de0],
      [0x97592a59d0409e12, 0x625b1de023c18497],
      [0x4b855cbfd779f188, 0xb963561f0de7263f],
      [0xfcfc7ee10857c82d, 0x344175e8a8e08ac8],
      [0xc3c535c70c19b94e, 0x4005c381ef1ae439],
      [0x37f21d2ec3f71d5f, 0xd75ddc67a98e5c7a],
      [0xf87e2efc34f77b40, 0x36f128ce8bd2fe36],
      [0xf2ec690b40830bf0, 0xb66f56338ee662d0],
      [0xb59ca51299671aeb, 0xa9fdfeae95bb3ffb]
    ],
    [
      [0x7196118c66e08c56, 0xaa8d186ab535e8e1],
      [0xf7b73f9840fd6240, 0xf95c8b9330714ee8],
      [0xf8c3f77de50c5ae3, 0xb9744ca20fa7cae2],
      [0x5ad29fbf02309081, 0x96a102ffb6109e4c],
      [0x219498a4420fa6dd, 0xfc9d35a2f2852750],
      [0xafc8609abae6342, 0x11d69c26f55677a3],
      [0xf8dca6c1e3588172, 0x9dbc6aaa93575742],
      [0x443408e94e98bad9, 0x3b312bed3484970b],
      [0xaa59609cc7ab0980, 0x334ea21dc444b7a5],
      [0x80ecd0dac1b68ece, 0x2035ac582f4c7103],
      [0x60cab13d2c044beb, 0x9fd1170368ae5dc3],
      [0x9d52ef58d1f6d622, 0xabe8d0d9c4d6f4d4],
      [0xc80f4f54788670a9, 0x7c868505d485fb6c],
      [0x6ca54bb7dc318cef, 0x8edec29daacd7832],
      [0x4c934a85ea4e4aca, 0xfbaae58cc97dd052],
      [0x85639d201327f1be, 0xe7aaf7ecf7466ced],
      [0x73c366ce2e6619e9, 0x587a0a3794498b25],
      [0x4c35bfd8c578cf24, 0x4b4045706b92a36b],
      [0xa947948749bc0036, 0x58659476abb39a65]
    ],
    [
      [0x82d998f71de869da, 0xee383c8f79d000f],
      [0xacdb9ac1f031cd60, 0xfae66f8735ee2855],
      [0xb35b1574ff19eb93, 0xfb20ee2d09bde8cc],
      [0xa1a2accb94e413d6, 0x46dd2c8fcd010667],
      [0x7a1c240ceb921b5e, 0x5179f970149601a5],
      [0x23cf9c4e9faf7621, 0xc912d496f5f4b978],
      [0x359ac2598a046857, 0x6edd2b967cefb3de],
      [0x8522b699b72a48b3, 0xeac15462d1a418c3],
      [0xce27777dff68b591, 0xde2ec72ed9add35f],
      [0x1cb2f9fd3c41d54e, 0xefeff0284a5a667b],
      [0x37e938c6ed5e2296, 0xe0da5f82f4949b50],
      [0x7809fd82510f0971, 0x337e8da9ee8ed50f],
      [0xe2ec750bafad77df, 0xb81396cb1028e7eb],
      [0xe16e0eb04b5990f3, 0x9c709751438f8394],
      [0x5623d413564e6c34, 0x53e97d02d2e3a6da],
      [0x78f9db34cabc6d2d, 0x800bade2e7708f54],
      [0x1c335661f50febf, 0x195034861e96061],
      [0x9dcbb8dc268add07, 0x10693e8216a10067],
      [0x59fe2f99f1f01a26, 0x6b377cbcb0d983a1]
    ],
    [
      [0x5712abe2a27ed01f, 0x9b6d91d20c56dfa3],
      [0x18925302a6045ee9, 0x9f79850c0a4bc078],
      [0x5805f0bc9b9e5ac3, 0x75cc46fff6fa51be],
      [0x9f0978b3e594ceed, 0x34b750d7011f16e8],
      [0xa7ee0156d10384be, 0xdf77ba8f41796e8a],
      [0x2d39bab6a46783bd, 0xab798025a738a078],
      [0x836cb2a3e41a6a78, 0x2a244880465f0f7e],
      [0x5a2725e33cb5d656, 0x330439f48cd0ab57],
      [0x8ff3c057c40a792b, 0xc8f3e70f6de6e6d7],
      [0x58b3c0afa7354e99, 0xf88ce3801542680],
      [0xa1e65480354dfe1c, 0x9f3b2f522d3ac366],
      [0xc1ee62ff2301e402, 0xd73be8acf84a643a],
      [0x3c54edaac1c6195b, 0x441c5a60b6aea07b],
      [0xe03a726f44259e75, 0xe7eb461169ada1ee],
      [0xca5abb65731d997a, 0x13622b882069bf3],
      [0xdd4c183413fa8110, 0x1ef3b75ef45dfe4d],
      [0xbd45cb84a59a5bd8, 0xb7590656e07b6bbd],
      [0xd8a9e1017fd98dc5, 0xabb49f6638372529],
      [0x57193e4d32910a5, 0x9eb3a764b8ff7b09]
    ],
    [
      [0xabaad8847642023a, 0x944c3a16e1014835],
      [0x5c81532ee898fa57, 0x3ce431991a92bce9],
      [0x67c46cbc0cacee94, 0x63c394ce304f0218],
      [0xe47209ab7d241e09, 0xa3cc06ee850e169d],
      [0x48e0b7e2a8fce650, 0xc43b6fa38dbdd24a],
      [0xfccb593e41fdc5ee, 0xd732280b40ccfe61],
      [0xf9ba8e84d9b784d5, 0x76b1ab42304cd09b],
      [0xeca18b494910765e, 0x6ad4448f128f7fd8],
      [0x707a85e4d434bc83, 0x50a3cd1345bcee5b],
      [0x41975acc7aeab679, 0xe665f0885566239b],
      [0xf9bd6b1f57c0f32a, 0xfa84b3204660c755],
      [0x7c2086727b5cd81c, 0xd0c2dc14ec1bd60b],
      [0x5f3b8d05a8146b68, 0x671ab9da43f00934],
      [0x2d58662bb42b14a4, 0xefcf12fc6918f1e3],
      [0x72d36d306d640a83, 0x64a42b6ff341f02c],
      [0x7b29ef529370e653, 0xe88afcbe6e627bb6],
      [0x8ba428b73bcd77b8, 0x10c9fed9bf73867a],
      [0xa244c2aade8a4e88, 0x392f080d6e231a50],
      [0xabe4ef708cbf7b19, 0x2557ed2f84a193f4]
    ],
    [
      [0x9d71596e60057503, 0xcbc847ab81cf77ee],
      [0x8390bc278217cd0a, 0xb12674a0043d4c8e],
      [0x26324f89d60715, 0xeaeac35e15ee2db7],
      [0x34eb62c5c6cc0afb, 0x6748d00854878c8],
      [0x548340ca3d47409a, 0x4f1edd98e29aaca3],
      [0x8a8b6b8b5ee362b, 0x9c292fd5c787cf0d],
      [0x5bc4e5d070fc8c11, 0x84509dbf666395ea],
      [0x4e6c9250f14225fb, 0x615f86664507415f],
      [0x62c695ca9805f03e, 0x1ef58ea646ab5724],
      [0xdc2d5c00381adb85, 0xd799cf7f7b46c818],
      [0x19f15e11f31b0ea7, 0x29c0892472425419],
      [0xd659a8a4e3258f93, 0xd6ebf9b83dd96f20],
      [0xb90dbab8209c2d78, 0xeece0e8a557e2827],
      [0x1f98aa4cb554b4aa, 0xe09c158342fa0040],
      [0xa695e7868c069d0f, 0x24d38fdff5cbb2fa],
      [0xdc0134b4c4197502, 0x4adae0413a05fb7f],
      [0x5b77fa6fd95ef294, 0xf33177244df86a91],
      [0xe57b64a119367278, 0x2df21d034e5b6],
      [0x583d3ebf096a256f, 0x6b31dc32e03e93fa]
    ],
  ];
}
