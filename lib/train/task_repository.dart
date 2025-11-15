import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:math';

import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:crypto/crypto.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:wqhub/cancellable_isolate_stream.dart';
import 'package:wqhub/random_util.dart';
import 'package:wqhub/train/rank_range.dart';
import 'package:wqhub/train/task_source/distribution_task_source.dart';
import 'package:wqhub/train/task_source/task_source.dart';
import 'package:wqhub/symmetry.dart';
import 'package:wqhub/train/task_tag.dart';
import 'package:wqhub/train/task_type.dart';
import 'package:wqhub/train/variation_tree.dart';
import 'package:wqhub/wq/rank.dart' as wq;
import 'package:wqhub/wq/rank.dart';
import 'package:wqhub/wq/wq.dart' as wq;

@immutable
class TaskRef {
  final Rank rank;
  final TaskType type;
  final int id;

  const TaskRef({required this.rank, required this.type, required this.id});

  factory TaskRef.ofUri(String link) {
    final uri = Uri.parse(link);
    if (uri.scheme != 'wqhub') {
      throw FormatException('unrecognized scheme: ${uri.scheme}');
    }
    final p = uri.pathSegments.last;
    return TaskRef(
      rank: Rank.values[int.parse(p.substring(0, 2), radix: 16)],
      type: TaskType.values[int.parse(p.substring(2, 4), radix: 16)],
      id: int.parse(p.substring(4), radix: 16),
    );
  }

  @override
  int get hashCode => Object.hash(rank, type, id);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is TaskRef &&
        other.rank == rank &&
        other.type == type &&
        other.id == id;
  }
}

class Task {
  final int id;
  final wq.Rank rank;
  final TaskType type;
  final wq.Color first;
  final int boardSize;
  final int subBoardSize;
  final wq.Point topLeft;
  final IMapOfSets<wq.Color, wq.Point> initialStones;
  final VariationTree variationTree;

  const Task(
      {required this.id,
      required this.rank,
      required this.type,
      required this.first,
      required this.boardSize,
      required this.subBoardSize,
      required this.topLeft,
      required this.initialStones,
      required this.variationTree});

  Task withColorToPlay(wq.Color color) => switch (first == color) {
        true => this,
        false => Task(
            id: id,
            rank: rank,
            type: type,
            first: color,
            boardSize: boardSize,
            subBoardSize: subBoardSize,
            topLeft: topLeft,
            initialStones: IMapOfSets({
              wq.Color.black: initialStones.get(wq.Color.white),
              wq.Color.white: initialStones.get(wq.Color.black),
            }),
            variationTree: variationTree,
          ),
      };

  Task withSymmetry(Symmetry symmetry) {
    if (symmetry == Symmetry.identity) {
      return this;
    }

    final transformedStonesMap = <wq.Color, ISet<wq.Point>>{};
    for (final entry in initialStones.entries) {
      final transformedPoints = entry.value.fold<ISet<wq.Point>>(
        const ISet<wq.Point>.empty(),
        (accPoints, point) =>
            accPoints.add(symmetry.transformPoint(point, boardSize)),
      );
      transformedStonesMap[entry.key] = transformedPoints;
    }

    return Task(
      id: id,
      rank: rank,
      type: type,
      first: first,
      boardSize: boardSize,
      subBoardSize: subBoardSize,
      topLeft: _transformTopLeft(topLeft, boardSize, subBoardSize, symmetry),
      initialStones: IMapOfSets(transformedStonesMap),
      variationTree: variationTree.withSymmetry(symmetry, boardSize),
    );
  }

  static wq.Point _transformTopLeft(
      wq.Point topLeft, int boardSize, int subBoardSize, Symmetry symmetry) {
    if (symmetry == Symmetry.identity) return topLeft;

    final (x1, y1) = topLeft;
    final (x2, y2) = (x1 + subBoardSize - 1, y1 + subBoardSize - 1);

    final topRight = (x2, y1);
    final bottomRight = (x2, y2);
    final bottomLeft = (x1, y2);

    final tlS = symmetry.transformPoint(topLeft, boardSize);
    final trS = symmetry.transformPoint(topRight, boardSize);
    final blS = symmetry.transformPoint(bottomRight, boardSize);
    final brS = symmetry.transformPoint(bottomLeft, boardSize);

    final topLeftS = (
      [tlS.$1, trS.$1, blS.$1, brS.$1].reduce(min),
      [tlS.$2, trS.$2, blS.$2, brS.$2].reduce(min),
    );

    return topLeftS;
  }

  Task withRandomSymmetry({required bool randomize}) => randomize
      ? withSymmetry(Symmetry.values[Random().nextInt(Symmetry.values.length)])
      : this;

  String deepLink() {
    final rs = rank.index.toRadixString(16).padLeft(2, '0');
    final ts = type.index.toRadixString(16).padLeft(2, '0');
    final ids = id.toRadixString(16).padLeft(8, '0');
    return 'wqhub://t/$rs$ts$ids';
  }
}

class _RandomIndexSource {
  final List<int> _indices;
  var _i = 0;

  _RandomIndexSource(int size) : _indices = [for (int i = 0; i < size; ++i) i] {
    _indices.shuffle();
  }

  int get next {
    final ret = _indices[_i++];
    if (_i >= _indices.length) _i = 0;
    return ret;
  }
}

class _TaskBucket {
  static final _randomIndexSource = [
    for (int i = 0; i <= 13; ++i) _RandomIndexSource(1 << i)
  ];

  final wq.Rank rank;
  final TaskType type;
  final ByteData data;
  final ByteData patternIndexData;

  _TaskBucket(this.rank, this.type, this.data, this.patternIndexData);

  int get size => data.getInt16(0);

  Task readOne() {
    final src = _randomIndexSource[size.bitLength];
    var i = src.next;
    while (i >= size) {
      i = src.next;
    }
    return at(i);
  }

  IList<Task> readN(int n) => IList([for (int i = 0; i < n; ++i) readOne()]);

  Task at(int index) {
    assert(0 <= index && index < size);
    final id = data.getInt32(2 + index * 8);
    var offset = data.getInt32(2 + index * 8 + 4);

    // Read header info
    final firstByte = data.getUint8(offset++);
    final sizeByte = data.getUint8(offset++);
    final topLeftSgf = String.fromCharCodes(
        [data.getUint8(offset++), data.getUint8(offset++)]);

    // Read initial black stones
    final initialBlackStoneCount = data.getUint8(offset++);
    var initialBlackStones = const ISet<wq.Point>.empty();
    for (int i = 0; i < initialBlackStoneCount; ++i) {
      final p = String.fromCharCodes(
          [data.getUint8(offset++), data.getUint8(offset++)]);
      initialBlackStones = initialBlackStones.add(wq.parseSgfPoint(p));
    }

    // Read initial white stones
    final initialWhiteStoneCount = data.getUint8(offset++);
    var initialWhiteStones = const ISet<wq.Point>.empty();
    for (int i = 0; i < initialWhiteStoneCount; ++i) {
      final p = String.fromCharCodes(
          [data.getUint8(offset++), data.getUint8(offset++)]);
      initialWhiteStones = initialWhiteStones.add(wq.parseSgfPoint(p));
    }

    // Read variation tree
    final (vtree, _) = _parseVariationTree(offset);

    return Task(
      id: id,
      rank: rank,
      type: type,
      first: wq.Color.values[firstByte - 1],
      boardSize: (sizeByte >> 4) + 4,
      subBoardSize: (sizeByte & 0xf) + 4,
      topLeft: wq.parseSgfPoint(topLeftSgf),
      initialStones: IMapOfSets({
        wq.Color.black: initialBlackStones,
        wq.Color.white: initialWhiteStones,
      }),
      variationTree: vtree,
    );
  }

  IMap<wq.Point, wq.Color> _stonesAt(int index) {
    assert(0 <= index && index < size);
    var offset = data.getInt32(2 + index * 8 + 4);

    // Read header info
    data.getUint8(offset++);
    data.getUint8(offset++);
    String.fromCharCodes([data.getUint8(offset++), data.getUint8(offset++)]);

    var stones = const IMap<wq.Point, wq.Color>.empty();

    // Read initial black stones
    final initialBlackStoneCount = data.getUint8(offset++);
    for (int i = 0; i < initialBlackStoneCount; ++i) {
      final p = String.fromCharCodes(
          [data.getUint8(offset++), data.getUint8(offset++)]);
      stones = stones.add(wq.parseSgfPoint(p), wq.Color.black);
    }

    // Read initial white stones
    final initialWhiteStoneCount = data.getUint8(offset++);
    for (int i = 0; i < initialWhiteStoneCount; ++i) {
      final p = String.fromCharCodes(
          [data.getUint8(offset++), data.getUint8(offset++)]);
      stones = stones.add(wq.parseSgfPoint(p), wq.Color.white);
    }

    return stones;
  }

  int _idAt(int index) {
    assert(0 <= index && index < size);
    return data.getInt32(2 + index * 8);
  }

  Task? readById(int id) {
    var l = 0;
    var r = size - 1;
    while (l <= r) {
      final mid = (l + r) >> 1;
      final midId = _idAt(mid);
      if (midId < id) {
        l = mid + 1;
      } else if (id < midId) {
        r = mid - 1;
      } else {
        return at(mid);
      }
    }
    return null;
  }

  (VariationTree, int) _parseVariationTree(int offset) {
    var children = const IMap<wq.Point, VariationTree>.empty();
    while (true) {
      final b0 = data.getUint8(offset++);
      if (b0 == '+'.codeUnitAt(0)) {
        return (
          VariationTree(status: VariationStatus.correct, children: children),
          offset
        );
      } else if (b0 == '-'.codeUnitAt(0)) {
        return (
          VariationTree(status: VariationStatus.wrong, children: children),
          offset
        );
      } else if (b0 == '?'.codeUnitAt(0)) {
        return (VariationTree(status: null, children: children), offset);
      }
      final p =
          wq.parseSgfPoint(String.fromCharCodes([b0, data.getUint8(offset++)]));
      final (child, newOffset) = _parseVariationTree(offset);
      children = children.add(p, child);
      offset = newOffset;
    }
  }

  static final int _patternHashSizeInBytes = 32;

  Stream<Task> find(IMap<wq.Point, wq.Color> wantStones,
      ISet<wq.Point> wantEmpty, Set<int> wantFeatures) async* {
    for (int i = 0; i < size; ++i) {
      final gotStones = _stonesAt(i);
      final h = patternIndexData.buffer
          .asUint8List(_patternHashSizeInBytes * i, _patternHashSizeInBytes)
          .reversedView;
      if (_matchFingerprint(h, wantFeatures) &&
          _matchStones(wantStones, wantEmpty, gotStones)) {
        yield at(i);
      }
    }
  }

  bool _matchFingerprint(List<int> h, Set<int> wantFeatures) {
    for (final fp in wantFeatures) {
      final x = h[fp >> 3];
      if ((x & (1 << (fp & 7))) == 0) return false;
    }
    return true;
  }

  bool _matchStones(
    IMap<wq.Point, wq.Color> wantStones,
    ISet<wq.Point> wantEmpty,
    IMap<wq.Point, wq.Color> gotStones,
  ) {
    final ex = wantStones.entries.first;
    for (final sym in Symmetry.values) {
      final (rx, cx) = sym.transformPoint(ex.key, 19);
      for (final ey in gotStones.entries) {
        final (ry, cy) = ey.key;
        // Assume ex and ey represent the same stone and check if the remaining stones match.
        var ok = true;
        for (final pz in wantEmpty) {
          final (rz, cz) = sym.transformPoint(pz, 19);
          final zz = gotStones.get((ry + (rz - rx), cy + (cz - cx)));
          if (zz != null) {
            ok = false;
            break;
          }
        }
        for (final ez in wantStones.entries) {
          final (rz, cz) = sym.transformPoint(ez.key, 19);
          final zz = gotStones.get((ry + (rz - rx), cy + (cz - cx)));
          if (zz == null || ((ex.value == ey.value) != (zz == ez.value))) {
            ok = false;
            break;
          }
        }
        if (ok) return true;
      }
    }
    return false;
  }
}

class _TagBucket {
  final List<(TaskType, int)> tasks;
  var cur = 0;

  _TagBucket({required this.tasks});

  (TaskType, int) next() {
    final ret = cur;
    cur++;
    if (cur == tasks.length) cur = 0;
    return tasks[ret];
  }
}

class TaskTags {
  final Map<(wq.Rank, TaskTag), _TagBucket> tasks;

  static Future<TaskTags> loadFromRes(String resName) async {
    final data = await rootBundle.load(resName);
    return _parseTags(data);
  }

  static TaskTags _parseTags(ByteData data) {
    final tasks = Map<(wq.Rank, TaskTag), _TagBucket>.new();
    var offset = 0;
    var size = data.getUint16(offset);
    offset += 2;
    while (size > 0) {
      final tagId = data.getUint8(offset);
      offset++;
      final rank = data.getUint8(offset);
      offset++;
      final taskEntries = <(TaskType, int)>[];
      for (int i = 0; i < size; ++i) {
        final type = TaskType.values[data.getUint8(offset)];
        offset++;
        final tid = data.getUint32(offset);
        offset += 4;
        taskEntries.add((type, tid));
      }
      taskEntries.shuffle();
      final key = (
        wq.Rank.values[rank],
        TaskTag.values.firstWhere((t) => t.index == tagId)
      );
      assert(taskEntries.isNotEmpty);
      tasks[key] = _TagBucket(tasks: taskEntries);

      size = data.getUint16(offset);
      offset += 2;
    }
    return TaskTags(tasks: tasks);
  }

  const TaskTags({required this.tasks});
}

class TaskCollection {
  final int id;
  final String title;
  final List<TaskRef> tasks;
  final List<TaskCollection> children;
  final int taskCount;

  TaskCollection(
      {required this.id,
      required this.title,
      required this.tasks,
      required this.children})
      : taskCount = tasks.length + children.sumBy((n) => n.taskCount);

  Iterable<TaskRef> allTasks() =>
      tasks.isEmpty ? children.expand((child) => child.allTasks()) : tasks;

  static Future<TaskCollection> loadFromRes(String resName) async {
    final data = await rootBundle.load(resName);
    final (col, _) = _parseCollection(data, 0);
    return col;
  }

  static (TaskCollection, int) _parseCollection(ByteData data, int offset) {
    final nodeId = data.getUint16(offset);
    offset += 2;
    final titleLen = data.getUint8(offset);
    offset++;
    final codeUnits = <int>[];
    for (int i = 0; i < titleLen; ++i) {
      codeUnits.add(data.getUint8(offset));
      offset++;
    }
    final title = String.fromCharCodes(codeUnits);
    final childrenCount = data.getUint8(offset);
    offset++;
    if (childrenCount > 0) {
      // inner node
      final children = <TaskCollection>[];
      for (int i = 0; i < childrenCount; ++i) {
        final (child, newOffset) = _parseCollection(data, offset);
        children.add(child);
        offset = newOffset;
      }
      return (
        TaskCollection(id: nodeId, title: title, tasks: [], children: children),
        offset
      );
    } else {
      // leaf node
      final taskRefs = <TaskRef>[];
      final taskCount = data.getUint16(offset);
      offset += 2;
      for (int i = 0; i < taskCount; ++i) {
        final rank = Rank.values[data.getUint8(offset)];
        offset++;
        final type = TaskType.values[data.getUint8(offset)];
        offset++;
        final id = data.getUint32(offset);
        offset += 4;
        taskRefs.add(TaskRef(rank: rank, type: type, id: id));
      }
      return (
        TaskCollection(id: nodeId, title: title, tasks: taskRefs, children: []),
        offset
      );
    }
  }
}

class TaskRepository {
  static TaskRepository? _db;

  factory TaskRepository() => _db!;

  static init() async {
    assert(_db == null);
    final ranks = const [
      Rank.k15,
      Rank.k14,
      Rank.k13,
      Rank.k12,
      Rank.k11,
      Rank.k10,
      Rank.k9,
      Rank.k8,
      Rank.k7,
      Rank.k6,
      Rank.k5,
      Rank.k4,
      Rank.k3,
      Rank.k2,
      Rank.k1,
      Rank.d1,
      Rank.d2,
      Rank.d3,
      Rank.d4,
      Rank.d5,
      Rank.d6,
      Rank.d7,
    ];
    final entries = await Future.wait(ranks
        .expand((rank) => TaskType.values.map((typ) => (rank, typ)))
        .map((rt) async {
      final (rank, typ) = rt;
      final data =
          await rootBundle.load('assets/tasks/${rank.index}_${typ.index}.bin');
      final patternIndexData =
          await rootBundle.load('assets/tasks/${rank.index}_${typ.index}.idx');
      return (rt, _TaskBucket(rank, typ, data, patternIndexData));
    }));
    final buckets = <(wq.Rank, TaskType), _TaskBucket>{
      for (final (rt, bucket) in entries) rt: bucket
    };
    final collections =
        await TaskCollection.loadFromRes('assets/tasks/col.bin');
    final tags = await TaskTags.loadFromRes('assets/tasks/tag.bin');
    _db = TaskRepository._(buckets, collections, tags);
  }

  TaskRepository._(this._buckets, this._collectionRoot, this._tags)
      : _collectionTreeNode =
            TreeNode<TaskCollection>.root(data: _collectionRoot) {
    _populateCollectionTreeNode(_collectionRoot, _collectionTreeNode);
    _log.fine(
        '${_buckets.values.sumBy((b) => b.size)} tasks loaded from ${_buckets.length} buckets');
    _log.fine(
        '${_collectionRoot.children.length} collections loaded: ${_collectionRoot.taskCount} tasks');
    _log.fine('${_tags.tasks.length} tag buckets loaded');
  }

  final _log = Logger('TaskRepository');
  final Map<(wq.Rank, TaskType), _TaskBucket> _buckets;
  final TaskCollection _collectionRoot;
  final TreeNode<TaskCollection> _collectionTreeNode;
  final TaskTags _tags;

  Task? readOne(wq.Rank rank, TaskType type) {
    return _buckets[(rank, type)]?.readOne();
  }

  IList<Task> readByTypes(Rank rank, ISet<TaskType> types, int n) {
    assert(types.isNotEmpty);
    final bucketDist = types
        .mapNotNull((t) => _buckets[(rank, t)])
        .map((b) => ((b.rank, b.type), b.size));
    return IList([
      for (int i = 0; i < n; i++) _buckets[randomDist(bucketDist)]!.readOne()
    ]);
  }

  Task? readByRef(TaskRef ref) =>
      _buckets[(ref.rank, ref.type)]?.readById(ref.id);

  Task? readById(wq.Rank rank, TaskType type, int id) =>
      _buckets[(rank, type)]?.readById(id);

  Task? readByUri(String link) {
    try {
      final uri = Uri.parse(link);
      if (uri.scheme != 'wqhub') {
        throw FormatException('unrecognized scheme: ${uri.scheme}');
      }
      final p = uri.pathSegments.last;
      final rank = Rank.values[int.parse(p.substring(0, 2), radix: 16)];
      final type = TaskType.values[int.parse(p.substring(2, 4), radix: 16)];
      final id = int.parse(p.substring(4), radix: 16);
      return readById(rank, type, id);
    } catch (_) {
      return null;
    }
  }

  IList<Task> readByTag(TaskTag tag, RankRange rankRange, int n) {
    final bucketDist = [
      for (int i = rankRange.from.index; i <= rankRange.to.index; ++i)
        (i, _tags.tasks[(Rank.values[i], tag)]?.tasks.length ?? 0)
    ];
    final tasks = <Task>[];
    for (int i = 0; i < n; ++i) {
      final rank = Rank.values[randomDist(bucketDist)];
      final (type, id) = _tags.tasks[(rank, tag)]!.next();
      tasks.add(readById(rank, type, id)!);
    }
    return IList(tasks);
  }

  TaskSource taskSourceByTypes(RankRange rankRange, ISet<TaskType> taskTypes) {
    final buckets = [
      for (int i = rankRange.from.index; i <= rankRange.to.index; ++i)
        for (final taskType in taskTypes)
          if (_buckets[(Rank.values[i], taskType)] != null)
            (
              _buckets[(Rank.values[i], taskType)]!,
              _buckets[(Rank.values[i], taskType)]!.size,
            )
    ];
    return DistributionTaskSource(
      buckets: buckets,
      nextTask: (_TaskBucket bucket) => bucket.readOne(),
    );
  }

  TaskSource taskSourceByTag(RankRange rankRange, TaskTag tag) {
    final buckets = [
      for (int i = rankRange.from.index; i <= rankRange.to.index; ++i)
        if (_tags.tasks[(Rank.values[i], tag)] != null)
          (
            (Rank.values[i], _tags.tasks[(Rank.values[i], tag)]!),
            _tags.tasks[(Rank.values[i], tag)]?.tasks.length ?? 0
          )
    ];
    return DistributionTaskSource(
      buckets: buckets,
      nextTask: ((Rank, _TagBucket) bucket) {
        final (rank, tagBucket) = bucket;
        final (type, id) = tagBucket.next();
        return readById(rank, type, id)!;
      },
    );
  }

  int countByTypes(RankRange rankRange, ISet<TaskType> types) {
    var total = 0;
    for (int i = rankRange.from.index; i <= rankRange.to.index; ++i)
      for (final type in types)
        total += _buckets[(Rank.values[i], type)]?.size ?? 0;
    return total;
  }

  int countByTag(RankRange rankRange, TaskTag tag) {
    var total = 0;
    for (int i = rankRange.from.index; i <= rankRange.to.index; ++i)
      total += _tags.tasks[(Rank.values[i], tag)]?.tasks.length ?? 0;
    return total;
  }

  TaskCollection collections() => _collectionRoot;
  TreeNode<TaskCollection> collectionsTreeNode() => _collectionTreeNode;

  _populateCollectionTreeNode(
      TaskCollection col, TreeNode<TaskCollection> node) {
    for (final childCol in col.children) {
      final childNode = TreeNode<TaskCollection>(data: childCol);
      _populateCollectionTreeNode(childCol, childNode);
      node.add(childNode);
    }
  }

  Stream<Task> _find(RankRange rankRange, ISet<TaskType> types,
      IMap<wq.Point, wq.Color> stones, ISet<wq.Point> empty) async* {
    final features = _computePatternFeatures(stones);
    for (final e in _buckets.entries) {
      final (rank, type) = e.key;
      if (!rankRange.contains(rank) || !types.contains(type)) continue;
      yield* e.value.find(stones, empty, features);
      await Future.delayed(
          Duration.zero); // yield control to handle cancellation
    }
  }

  Set<int> _computePatternFeatures(IMap<wq.Point, wq.Color> stones) {
    final features = <int>{};
    for (final ex in stones.entries) {
      final (rx, cx) = ex.key;
      final xCol = ex.value;
      for (final ey in stones.entries) {
        final (ry, cy) = ey.key;
        final yCol = ey.value;

        if (ex.key == ey.key) continue;
        features.add(_fingerprint(rx, cx, xCol, ry, cy, yCol));
      }
    }
    return features;
  }

  int _fingerprint(
      int rx, int cx, wq.Color xCol, int ry, int cy, wq.Color yCol) {
    final lens = [(rx - ry).abs(), (cx - cy).abs()];
    lens.sort();
    final sameCol = xCol == yCol ? 1 : 0;
    final digest =
        sha256.convert(utf8.encode('${lens[0]}.${lens[1]}.$sameCol'));
    return digest.bytes[0];
  }
}

class _FindTaskRequest {
  final TaskRepository taskRepo;
  final RankRange rankRange;
  final ISet<TaskType> taskTypes;
  final IMap<wq.Point, wq.Color> stones;
  final ISet<wq.Point> empty;
  final SendPort sendPort;

  const _FindTaskRequest({
    required this.taskRepo,
    required this.rankRange,
    required this.taskTypes,
    required this.stones,
    required this.empty,
    required this.sendPort,
  });
}

CancellableIsolateStream<Task> findTasks(
    RankRange rankRange,
    ISet<TaskType> taskTypes,
    IMap<wq.Point, wq.Color> stones,
    ISet<wq.Point> empty) {
  final mainRecvPort = ReceivePort();
  final ctrl = StreamController<Task>();
  SendPort? isoSendPort;

  void cancel() {
    isoSendPort?.send('cancel');
    mainRecvPort.close();
    ctrl.close();
  }

  final req = _FindTaskRequest(
    taskRepo: TaskRepository(),
    rankRange: rankRange,
    taskTypes: taskTypes,
    stones: stones,
    empty: empty,
    sendPort: mainRecvPort.sendPort,
  );

  Isolate.spawn(_findTaskOnIsolate, req).then((isolate) {
    // Nothing to do
  }).catchError((err) {
    ctrl.addError(err);
    ctrl.close();
  });

  mainRecvPort.listen((msg) {
    if (msg is SendPort) {
      isoSendPort = msg;
    } else if (msg == null) {
      mainRecvPort.close();
      ctrl.close();
    } else if (msg is Task) {
      ctrl.add(msg);
    }
  });

  return CancellableIsolateStream(stream: ctrl.stream, cancel: cancel);
}

void _findTaskOnIsolate(_FindTaskRequest req) async {
  final recvPort = ReceivePort();
  StreamSubscription? sub;

  req.sendPort.send(recvPort.sendPort);

  void cancelSearch() {
    recvPort.close();
    sub?.cancel();
  }

  recvPort.listen((msg) {
    if (msg == 'cancel') cancelSearch();
  });

  sub = req.taskRepo
      ._find(req.rankRange, req.taskTypes, req.stones, req.empty)
      .listen((t) {
    req.sendPort.send(t);
  }, onError: (err) {
    req.sendPort.send(null);
    cancelSearch();
  }, onDone: () {
    req.sendPort.send(null);
    cancelSearch();
  }, cancelOnError: true);
}
