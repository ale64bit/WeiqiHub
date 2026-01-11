import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:wqhub/random_util.dart';
import 'package:wqhub/symmetry.dart';
import 'package:wqhub/train/rank_range.dart';
import 'package:wqhub/train/task.dart';
import 'package:wqhub/train/task_collection.dart';
import 'package:wqhub/train/task_ref.dart';
import 'package:wqhub/train/task_source/distribution_task_source.dart';
import 'package:wqhub/train/task_source/task_source.dart';
import 'package:wqhub/train/task_tag.dart';
import 'package:wqhub/train/task_type.dart';
import 'package:wqhub/train/variation_tree.dart';
import 'package:wqhub/wq/rank.dart';
import 'package:wqhub/wq/util.dart';
import 'package:wqhub/wq/wq.dart' as wq;

class TaskDB {
  static final Logger _log = Logger('TaskDB');
  static TaskDB? _instance;

  factory TaskDB() => _instance!;

  final PreparedStatement _selectTask;
  final PreparedStatement _selectBucketTask;
  final PreparedStatement _selectAllBucketTasks;
  final PreparedStatement _selectTagTask;
  final PreparedStatement _selectCollectionTasks;
  final List<List<int>> _taskBucketCount;
  final List<List<int>> _taskBucketOffset;
  final List<List<int>> _tagBucketCount;
  final List<List<int>> _tagBucketOffset;
  final TaskCollection collections;

  static Future<String> _resolveDbPath() async {
    final pkgInfo = await PackageInfo.fromPlatform();
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path =
        join(documentsDirectory.path, 'wqhub_tasks_${pkgInfo.version}.db');
    final f = File(path);
    if (!f.existsSync()) {
      _log.info('copying task database to $path');
      final data = await rootBundle.load('assets/tasks/wqhub_tasks.db');
      f.writeAsBytesSync(data.buffer.asUint8List());
    }
    return path;
  }

  static Future<void> init() async {
    assert(_instance == null);
    _log.info('loading task database');

    final db = sqlite3.open(
      await _resolveDbPath(),
      mode: OpenMode.readOnly,
    );

    final collectionData =
        await rootBundle.loadString('assets/tasks/collections.json');
    final collections = TaskCollection.fromJson(jsonDecode(collectionData));
    final (taskBucketCount, taskBucketOffset) = _computeTaskBuckets(db);
    final (tagBucketCount, tagBucketOffset) = _computeTagBuckets(db);
    _instance = TaskDB._(
      db: db,
      taskBucketCount: taskBucketCount,
      taskBucketOffset: taskBucketOffset,
      tagBucketCount: tagBucketCount,
      tagBucketOffset: tagBucketOffset,
      collections: collections,
    );
  }

  static (List<List<int>>, List<List<int>>) _computeTaskBuckets(Database db) {
    final rand = Random(DateTime.now().microsecond);
    final count = _emptyTable(Rank.values.length, TaskType.values.length);
    final offset = _emptyTable(Rank.values.length, TaskType.values.length);

    final resultSet = db.select('''
      SELECT rank, type, COUNT(*) AS total 
        FROM tasks 
        GROUP BY rank, type;
      ''');
    for (final row in resultSet) {
      final rank = row['rank'] as int;
      final type = row['type'] as int;
      final total = row['total'] as int;
      count[rank][type] = total;
      offset[rank][type] = rand.nextInt(total);
    }

    return (count, offset);
  }

  static (List<List<int>>, List<List<int>>) _computeTagBuckets(Database db) {
    final rand = Random(DateTime.now().microsecond);
    final count = _emptyTable(TaskTag.values.length, Rank.values.length);
    final offset = _emptyTable(TaskTag.values.length, Rank.values.length);

    final resultSet = db.select('''
      SELECT tag, rank, COUNT(*) AS total 
        FROM task_tags 
        GROUP BY tag, rank;
      ''');
    for (final row in resultSet) {
      final tag = row['tag'] as int;
      final rank = row['rank'] as int;
      final total = row['total'] as int;
      count[tag][rank] = total;
      offset[tag][rank] = rand.nextInt(total);
    }

    return (count, offset);
  }

  static List<List<int>> _emptyTable(int r, int c) =>
      List.generate(r, (_) => List.filled(c, 0));

  TaskDB._({
    required Database db,
    required List<List<int>> taskBucketCount,
    required List<List<int>> taskBucketOffset,
    required List<List<int>> tagBucketCount,
    required List<List<int>> tagBucketOffset,
    required this.collections,
  })  : _taskBucketCount = taskBucketCount,
        _taskBucketOffset = taskBucketOffset,
        _tagBucketCount = tagBucketCount,
        _tagBucketOffset = tagBucketOffset,
        _selectTask = db.prepare(
            'SELECT * FROM tasks WHERE rank = ? AND type = ? AND id = ?;',
            persistent: true),
        _selectBucketTask = db.prepare(
            'SELECT * FROM tasks WHERE rank = ? AND type = ? LIMIT 1 OFFSET ?;',
            persistent: true),
        _selectAllBucketTasks = db.prepare('''
            SELECT id, black_stones, white_stones, fingerprint 
            FROM tasks WHERE rank = ? AND type = ?;
            ''', persistent: true),
        _selectTagTask = db.prepare(
            'SELECT type, id FROM task_tags WHERE tag = ? AND rank = ? LIMIT 1 OFFSET ?;',
            persistent: true),
        _selectCollectionTasks = db.prepare(
            'SELECT rank, type, task_id FROM collection_tasks WHERE id = ? ORDER BY idx;',
            persistent: true);

  int taskCountByRankAndType(Rank rank, TaskType type) =>
      _taskBucketCount[rank.index][type.index];

  int taskCountByTagAndRank(TaskTag tag, Rank rank) =>
      _tagBucketCount[tag.index][rank.index];

  int taskCountByType(RankRange rankRange, Set<TaskType> types) {
    var total = 0;
    for (final rank in rankRange) {
      for (final type in types) {
        total += taskCountByRankAndType(rank, type);
      }
    }
    return total;
  }

  int approxTaskCountByTag(RankRange rankRange, Set<TaskTag> tags) {
    // This count is approximate since tasks can have more than one tag.
    // However it's good enough for display purposes.
    var total = 0;
    for (final rank in rankRange) {
      for (final tag in tags) {
        total += taskCountByTagAndRank(tag, rank);
      }
    }
    return total;
  }

  Task? getByUri(String link) {
    try {
      final uri = Uri.parse(link);
      if (uri.scheme != 'wqhub') {
        throw FormatException('unrecognized scheme: ${uri.scheme}');
      }
      final p = uri.pathSegments.last;
      final rank = Rank.values[int.parse(p.substring(0, 2), radix: 16)];
      final type = TaskType.values[int.parse(p.substring(2, 4), radix: 16)];
      final id = int.parse(p.substring(4), radix: 16);
      return getTask(rank, type, id);
    } catch (_) {
      return null;
    }
  }

  Task? getTaskByRef(TaskRef ref) => getTask(ref.rank, ref.type, ref.id);

  Task? getTask(Rank rank, TaskType type, int id) {
    final resultSet = _selectTask.select([rank.index, type.index, id]);
    final row = resultSet.firstOrNull;
    if (row != null) {
      return _taskFromRow(row);
    }
    return null;
  }

  Task? randTaskByRankAndType(Rank rank, TaskType type) {
    final offset = _nextTaskOffset(rank, type);
    final resultSet =
        _selectBucketTask.select([rank.index, type.index, offset]);
    final row = resultSet.firstOrNull;
    if (row != null) {
      return _taskFromRow(row);
    }
    return null;
  }

  TaskRef? randTaskByTagAndRank(TaskTag tag, Rank rank) {
    final offset = _nextTagOffset(tag, rank);
    final resultSet = _selectTagTask.select([tag.index, rank.index, offset]);
    final row = resultSet.firstOrNull;
    if (row != null) {
      return TaskRef(
        rank: rank,
        type: TaskType.values[row['type'] as int],
        id: row['id'] as int,
      );
    }
    return null;
  }

  IList<Task> takeByTypes(Rank rank, ISet<TaskType> types, int n) {
    assert(types.isNotEmpty);
    final bucketDist = types
        .map((type) => ((rank, type), taskCountByRankAndType(rank, type)))
        .where((e) => e.$2 > 0);
    return List.generate(n, (_) {
      final (rank, type) = randomDist(bucketDist);
      return randTaskByRankAndType(rank, type)!;
    }).toIList();
  }

  IList<Task> takeByTag(TaskTag tag, RankRange rankRange, int n) {
    final bucketDist = [
      for (final rank in rankRange)
        if (taskCountByTagAndRank(tag, rank) > 0)
          (rank, taskCountByTagAndRank(tag, rank))
    ];
    return List.generate(n, (_) {
      final rank = randomDist(bucketDist);
      final ref = randTaskByTagAndRank(tag, rank)!;
      return getTaskByRef(ref)!;
    }).toIList();
  }

  IList<TaskRef> takeByCollection(int id) {
    final resultSet = _selectCollectionTasks.select([id]);
    return [
      for (final row in resultSet)
        TaskRef(
          rank: Rank.values[row['rank'] as int],
          type: TaskType.values[row['type'] as int],
          id: row['task_id'] as int,
        )
    ].toIList();
  }

  TaskSource taskSourceByTypes(RankRange rankRange, ISet<TaskType> taskTypes) {
    final buckets = [
      for (final rank in rankRange)
        for (final taskType in taskTypes)
          if (taskCountByRankAndType(rank, taskType) > 0)
            ((rank, taskType), taskCountByRankAndType(rank, taskType))
    ];
    return DistributionTaskSource(
      buckets: buckets,
      nextTask: (bucket) => randTaskByRankAndType(bucket.$1, bucket.$2)!,
    );
  }

  TaskSource taskSourceByTags(RankRange rankRange, ISet<TaskTag> tags) {
    final buckets = [
      for (final rank in rankRange)
        for (final tag in tags)
          if (taskCountByTagAndRank(tag, rank) > 0)
            ((tag, rank), taskCountByTagAndRank(tag, rank))
    ];
    return DistributionTaskSource(
      buckets: buckets,
      nextTask: ((TaskTag, Rank) bucket) {
        final (tag, rank) = bucket;
        final ref = randTaskByTagAndRank(tag, rank)!;
        return getTaskByRef(ref)!;
      },
    );
  }

  Stream<TaskRef> searchTaskInBucket(
      Rank rank,
      TaskType type,
      IMap<wq.Point, wq.Color> wantStones,
      ISet<wq.Point> wantEmpty,
      Set<int> wantFeatures) async* {
    final cursor = _selectAllBucketTasks.selectCursor([rank.index, type.index]);
    while (cursor.moveNext()) {
      final row = cursor.current;
      final fingerprint = row['fingerprint'] as List<int>;
      if (!_matchFingerprint(fingerprint.reversedView, wantFeatures)) {
        await Future.delayed(Duration.zero);
        continue;
      }
      final gotStones = IMap({
        for (final p in parseStonesString(row['black_stones'] as String))
          p: wq.Color.black,
        for (final p in parseStonesString(row['white_stones'] as String))
          p: wq.Color.white,
      });
      if (_matchStones(wantStones, wantEmpty, gotStones)) {
        yield TaskRef(
          rank: rank,
          type: type,
          id: row['id'] as int,
        );
      }
    }
  }

  Stream<TaskRef> searchTask(RankRange rankRange, ISet<TaskType> types,
      IMap<wq.Point, wq.Color> stones, ISet<wq.Point> empty) async* {
    final features = _computePatternFeatures(stones);
    for (final rank in rankRange) {
      for (final type in types) {
        yield* searchTaskInBucket(rank, type, stones, empty, features);
        await Future.delayed(Duration.zero);
      }
    }
  }

  Task _taskFromRow(Row row) {
    return Task(
      ref: TaskRef(
        id: row['id'] as int,
        rank: Rank.values[row['rank'] as int],
        type: TaskType.values[row['type'] as int],
      ),
      first: wq.Color.values[row['first'] as int],
      boardSize: row['board_size'] as int,
      subBoardSize: row['subboard_size'] as int,
      topLeft: (
        row['top_left_r'] as int,
        row['top_left_c'] as int,
      ),
      initialStones: IMapOfSets({
        wq.Color.black: parseStonesString(row['black_stones'] as String),
        wq.Color.white: parseStonesString(row['white_stones'] as String),
      }),
      variationTree: VariationTree.parse(row['variation_tree'] as String),
      fingerprint: row['fingerprint'] as List<int>,
    );
  }

  int _nextTaskOffset(Rank rank, TaskType type) {
    final offset = _taskBucketOffset[rank.index][type.index]++;
    if (_taskBucketOffset[rank.index][type.index] >=
        _taskBucketCount[rank.index][type.index]) {
      _taskBucketOffset[rank.index][type.index] = 0;
    }
    return offset;
  }

  int _nextTagOffset(TaskTag tag, Rank rank) {
    final offset = _tagBucketOffset[tag.index][rank.index]++;
    if (_tagBucketOffset[tag.index][rank.index] >=
        _tagBucketCount[tag.index][rank.index]) {
      _tagBucketOffset[tag.index][rank.index] = 0;
    }
    return offset;
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
