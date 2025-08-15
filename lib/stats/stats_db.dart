import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:wqhub/train/rank_range.dart';
import 'package:wqhub/train/task_repository.dart';
import 'package:wqhub/train/task_type.dart';
import 'package:wqhub/wq/rank.dart';

@immutable
class TaskStatEntry {
  final Rank rank;
  final TaskType type;
  final int id;
  final int correctCount;
  final int wrongCount;

  const TaskStatEntry(
      {required this.rank,
      required this.type,
      required this.id,
      required this.correctCount,
      required this.wrongCount});

  @override
  int get hashCode => Object.hash(rank, type, id, correctCount, wrongCount);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is TaskStatEntry &&
        other.rank == rank &&
        other.type == type &&
        other.id == id &&
        other.correctCount == correctCount &&
        other.wrongCount == wrongCount;
  }
}

@immutable
class ExamEntry {
  final DateTime date;
  final String type;
  final RankRange rankRange;
  final int correctCount;
  final int wrongCount;
  final bool passed;
  final Duration duration;

  const ExamEntry(
      {required this.date,
      required this.type,
      required this.rankRange,
      required this.correctCount,
      required this.wrongCount,
      required this.passed,
      required this.duration});

  @override
  int get hashCode => Object.hash(
      date, type, rankRange, correctCount, wrongCount, passed, duration);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is ExamEntry &&
        other.date == date &&
        other.type == type &&
        other.rankRange == rankRange &&
        other.correctCount == correctCount &&
        other.wrongCount == wrongCount &&
        other.passed == passed &&
        other.duration == duration;
  }
}

@immutable
class CollectionStatEntry {
  final int id;
  final int correctCount;
  final int wrongCount;
  final Duration duration;
  final DateTime completed;

  const CollectionStatEntry(
      {required this.id,
      required this.correctCount,
      required this.wrongCount,
      required this.duration,
      required this.completed});

  @override
  String toString() =>
      '${(100 * correctCount / max(correctCount + wrongCount, 1)).round()}% in ${duration.toString().split('.').first}';

  @override
  int get hashCode =>
      Object.hash(id, correctCount, wrongCount, duration, completed);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is CollectionStatEntry &&
        other.id == id &&
        other.correctCount == correctCount &&
        other.wrongCount == wrongCount &&
        other.duration == duration &&
        other.completed == completed;
  }
}

@immutable
class CollectionActiveSession {
  final int id;
  final int correctCount;
  final int wrongCount;
  final Duration duration;

  const CollectionActiveSession(
      {required this.id,
      required this.correctCount,
      required this.wrongCount,
      required this.duration});

  @override
  int get hashCode => Object.hash(id, correctCount, wrongCount, duration);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is CollectionActiveSession &&
        other.id == id &&
        other.correctCount == correctCount &&
        other.wrongCount == wrongCount &&
        other.duration == duration;
  }
}

class StatsDB {
  static final Logger _log = Logger('StatsDB');
  static StatsDB? _instance;

  factory StatsDB() => _instance!;

  final Database _db;
  final PreparedStatement _addTaskAttemptCorrect;
  final PreparedStatement _addDailyTaskAttemptCorrect;
  final PreparedStatement _addTaskAttemptWrong;
  final PreparedStatement _addDailyTaskAttemptWrong;
  final PreparedStatement _ignoreTaskMistake;
  final PreparedStatement _mistakesByMostRecent;
  final PreparedStatement _mistakesBySuccessRate;
  final PreparedStatement _countMistakesByRange;
  final PreparedStatement _getMistakesByRange;
  final PreparedStatement _collectionStat;
  final PreparedStatement _collectionActiveSession;
  final PreparedStatement _updateCollectionActiveSession;
  final PreparedStatement _resetCollectionActiveSession;
  final PreparedStatement _deleteCollectionActiveSession;
  final PreparedStatement _updateCollectionStat;
  final PreparedStatement _addExamAttempt;
  final PreparedStatement _examsSince;
  final PreparedStatement _taskDailyStatsSince;

  static init() async {
    _log.info('init: sqlite3 ${sqlite3.version}');
    assert(_instance == null);

    final directory = await ((Platform.isIOS || Platform.isMacOS)
        ? getLibraryDirectory()
        : getApplicationDocumentsDirectory());
    final filename = '${directory.path}/wqhub_stats.db';
    _log.info('path: $filename');
    final db = sqlite3.open(filename);

    db.execute('''
      ----------------------------------------------------------------------------------
      -- Task stats
      ----------------------------------------------------------------------------------
      CREATE TABLE IF NOT EXISTS task_stats (
        rank                 INTEGER NOT NULL,
        type                 INTEGER NOT NULL,
        id                   INTEGER NOT NULL,
        correct_count        INTEGER NOT NULL DEFAULT 0,
        wrong_count          INTEGER NOT NULL DEFAULT 0, 
        latest_attempt       DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        latest_wrong_attempt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        ignore_mistake       BOOLEAN NOT NULL DEFAULT 0,
        PRIMARY KEY (rank, type, id)
      ) WITHOUT ROWID;

      CREATE INDEX IF NOT EXISTS mistakes_by_most_recent
        ON task_stats(latest_wrong_attempt DESC)
        WHERE wrong_count>0 AND NOT ignore_mistake;

      CREATE INDEX IF NOT EXISTS mistakes_by_success_rate 
        ON task_stats(100 * correct_count / (correct_count + wrong_count), wrong_count DESC)
        WHERE wrong_count>0 AND NOT ignore_mistake;

      CREATE TABLE IF NOT EXISTS task_daily_stats (
        date          TEXT PRIMARY KEY,
        correct_count INTEGER NOT NULL DEFAULT 0,
        wrong_count   INTEGER NOT NULL DEFAULT 0
      );

      ----------------------------------------------------------------------------------
      -- Collection stats
      ----------------------------------------------------------------------------------
      CREATE TABLE IF NOT EXISTS collection_active_sessions (
        id            INTEGER PRIMARY KEY,
        correct_count INTEGER NOT NULL,
        wrong_count   INTEGER NOT NULL,
        duration_sec  INTEGER NOT NULL
      );

      CREATE TABLE IF NOT EXISTS collection_stats (
        id            INTEGER PRIMARY KEY,
        correct_count INTEGER NOT NULL,
        wrong_count   INTEGER NOT NULL,
        duration_sec  INTEGER NOT NULL,
        completed     INTEGER NOT NULL
      );

      ----------------------------------------------------------------------------------
      -- Exam history
      ----------------------------------------------------------------------------------

      CREATE TABLE IF NOT EXISTS exams (
        date          TEXT PRIMARY KEY,
        type          TEXT NOT NULL,
        from_rank     INTEGER NOT NULL,
        to_rank       INTEGER NOT NULL,
        correct_count INTEGER NOT NULL,
        wrong_count   INTEGER NOT NULL,
        passed        BOOLEAN NOT NULL,
        duration_sec  INTEGER NOT NULL
      );
    ''');

    _instance = StatsDB._(db: db);
  }

  StatsDB._({required Database db})
      : _db = db,
        _addTaskAttemptCorrect = db.prepare('''
          INSERT INTO task_stats(rank, type, id, correct_count) VALUES(?, ?, ?, 1)
            ON CONFLICT(rank, type, id) DO UPDATE SET 
              correct_count = correct_count+1,
              latest_attempt = CURRENT_TIMESTAMP;
        ''', persistent: true),
        _addDailyTaskAttemptCorrect = db.prepare('''
          INSERT INTO task_daily_stats(date, correct_count, wrong_count) 
            VALUES(date(), 1, 0)
            ON CONFLICT(date) DO UPDATE SET
              correct_count = correct_count+1;
        ''', persistent: true),
        _addTaskAttemptWrong = db.prepare('''
          INSERT INTO task_stats(rank, type, id, wrong_count) VALUES(?, ?, ?, 1)
            ON CONFLICT(rank, type, id) DO UPDATE SET 
              wrong_count = wrong_count+1,
              latest_attempt = CURRENT_TIMESTAMP,
              latest_wrong_attempt = CURRENT_TIMESTAMP,
              ignore_mistake = 0;
        ''', persistent: true),
        _addDailyTaskAttemptWrong = db.prepare('''
          INSERT INTO task_daily_stats(date, correct_count, wrong_count) 
            VALUES(date(), 0, 1)
            ON CONFLICT(date) DO UPDATE SET
              wrong_count = wrong_count+1;
        ''', persistent: true),
        _ignoreTaskMistake = db.prepare('''
          UPDATE task_stats
            SET ignore_mistake = 1
            WHERE rank = ? AND type = ? AND id = ?;
        ''', persistent: true),
        _mistakesByMostRecent = db.prepare('''
          SELECT rank, type, id, correct_count, wrong_count FROM task_stats 
            WHERE wrong_count>0 AND NOT ignore_mistake
            ORDER BY latest_wrong_attempt DESC
            LIMIT ?;
        ''', persistent: true),
        _mistakesBySuccessRate = db.prepare('''
          SELECT rank, type, id, correct_count, wrong_count FROM task_stats 
            WHERE wrong_count>0 AND NOT ignore_mistake
            ORDER BY 
              100 * correct_count / (correct_count + wrong_count), 
              wrong_count DESC
            LIMIT ?;
        ''', persistent: true),
        _countMistakesByRange = db.prepare('''
          SELECT count(1) FROM task_stats 
            WHERE rank BETWEEN ? AND ?;
        ''', persistent: true),
        _getMistakesByRange = db.prepare('''
          SELECT rank, type, id FROM task_stats 
            WHERE rank BETWEEN ? AND ?
            ORDER BY RANDOM()
            LIMIT ?;
        ''', persistent: true),
        _collectionStat = db.prepare('''
          SELECT id, correct_count, wrong_count, duration_sec, completed FROM collection_stats
            WHERE id = ?;
        ''', persistent: true),
        _collectionActiveSession = db.prepare('''
          SELECT id, correct_count, wrong_count, duration_sec FROM collection_active_sessions
            WHERE id = ?;
        ''', persistent: true),
        _updateCollectionActiveSession = db.prepare('''
          INSERT INTO collection_active_sessions(id, correct_count, wrong_count, duration_sec) 
            VALUES (?4, ?1, ?2, ?3)
            ON CONFLICT(id) DO UPDATE
            SET correct_count = correct_count + ?1,
                wrong_count = wrong_count + ?2,
                duration_sec = duration_sec + ?3
            WHERE id = ?4;
        ''', persistent: true),
        _updateCollectionStat = db.prepare('''
          INSERT INTO collection_stats(id, correct_count, wrong_count, duration_sec, completed) 
            VALUES (?1, ?2, ?3, ?4, ?5)
            ON CONFLICT(id) DO UPDATE
            SET correct_count = ?2,
                wrong_count = ?3,
                duration_sec = ?4,
                completed = ?5
            WHERE id = ?1;
        ''', persistent: true),
        _resetCollectionActiveSession = db.prepare('''
          INSERT INTO collection_active_sessions
            VALUES(?1, 0, 0, 0)
            ON CONFLICT(id) DO UPDATE
            SET correct_count = 0,
                wrong_count = 0,
                duration_sec = 0
            WHERE id = ?1;
        ''', persistent: true),
        _deleteCollectionActiveSession = db.prepare('''
          DELETE FROM collection_active_sessions WHERE id = ?;
        ''', persistent: true),
        _addExamAttempt = db.prepare('''
          INSERT INTO exams(date, type, from_rank, to_rank, correct_count, wrong_count, passed, duration_sec)
            VALUES (datetime(), ?, ?, ?, ?, ?, ?, ?);
        ''', persistent: true),
        _examsSince = db.prepare('''
          SELECT * FROM exams WHERE date >= ?;
        ''', persistent: true),
        _taskDailyStatsSince = db.prepare('''
          SELECT 
            COALESCE(SUM(correct_count), 0) as total_correct_count, 
            COALESCE(SUM(wrong_count), 0) as total_wrong_count 
          FROM task_daily_stats 
          WHERE date >= ?;
        ''', persistent: true);

  addTaskAttempt(Rank rank, TaskType type, int id, bool correct) {
    if (correct) {
      _addTaskAttemptCorrect.execute([rank.index, type.index, id]);
      _addDailyTaskAttemptCorrect.execute();
    } else {
      _addTaskAttemptWrong.execute([rank.index, type.index, id]);
      _addDailyTaskAttemptWrong.execute();
    }
  }

  ignoreTaskMistake(Rank rank, TaskType type, int id) {
    _ignoreTaskMistake.execute([rank.index, type.index, id]);
  }

  List<TaskStatEntry> mistakesByMostRecent({int maxResults = 1000}) {
    final resultSet = _mistakesByMostRecent.select([maxResults]);
    return _entriesFromResultSet(resultSet);
  }

  List<TaskStatEntry> mistakesBySuccessRate({int maxResults = 1000}) {
    final resultSet = _mistakesBySuccessRate.select([maxResults]);
    return _entriesFromResultSet(resultSet);
  }

  int countMistakesByRange(RankRange rankRange) {
    final result = _countMistakesByRange
        .select([rankRange.from.index, rankRange.to.index]);
    return result.first.values.first! as int;
  }

  List<TaskRef> getMistakesByRange(RankRange rankRange, int n) {
    final resultSet = _getMistakesByRange
        .select([rankRange.from.index, rankRange.to.index, n]);
    return [
      for (final row in resultSet)
        TaskRef(
          rank: Rank.values[row['rank'] as int],
          type: TaskType.values[row['type'] as int],
          id: row['id'] as int,
        )
    ];
  }

  void deleteMistakes(Iterable<TaskRef> refs) {
    final entries = refs
        .map((ref) => '(${ref.rank.index},${ref.type.index},${ref.id})')
        .join(',');
    _db.execute('''
      BEGIN TRANSACTION;
        DELETE FROM task_stats WHERE (rank, type, id) IN ($entries);
      COMMIT;
    ''');
  }

  List<TaskStatEntry> _entriesFromResultSet(ResultSet resultSet) => [
        for (final row in resultSet)
          TaskStatEntry(
            rank: Rank.values[row['rank'] as int],
            type: TaskType.values[row['type'] as int],
            id: row['id'] as int,
            correctCount: row['correct_count'] as int,
            wrongCount: row['wrong_count'] as int,
          )
      ];

  CollectionStatEntry? collectionStat(int id) {
    final resultSet = _collectionStat.select([id]);
    for (final row in resultSet) {
      return CollectionStatEntry(
        id: id,
        correctCount: row['correct_count'] as int,
        wrongCount: row['wrong_count'] as int,
        duration: Duration(seconds: row['duration_sec'] as int),
        completed: DateTime.fromMillisecondsSinceEpoch(row['completed'] as int),
      );
    }
    return null;
  }

  CollectionActiveSession? collectionActiveSession(int id) {
    final resultSet = _collectionActiveSession.select([id]);
    for (final row in resultSet) {
      return CollectionActiveSession(
        id: id,
        correctCount: row['correct_count'] as int,
        wrongCount: row['wrong_count'] as int,
        duration: Duration(seconds: row['duration_sec'] as int),
      );
    }
    return null;
  }

  resetCollectionActiveSession(int id) =>
      _resetCollectionActiveSession.execute([id]);

  deleteCollectionActiveSession(int id) =>
      _deleteCollectionActiveSession.execute([id]);

  updateCollectionActiveSession(int id,
      {int correctDelta = 0,
      int wrongDelta = 0,
      Duration durationDelta = Duration.zero}) {
    _updateCollectionActiveSession
        .execute([correctDelta, wrongDelta, durationDelta.inSeconds, id]);
  }

  updateCollectionStat(CollectionStatEntry entry) {
    _updateCollectionStat.execute([
      entry.id,
      entry.correctCount,
      entry.wrongCount,
      entry.duration.inSeconds,
      entry.completed.millisecondsSinceEpoch,
    ]);
  }

  addExamAttempt(String examType, RankRange rankRange, int correctCount,
      int wrongCount, bool passed, Duration duration) {
    _addExamAttempt.execute([
      examType,
      rankRange.from.index,
      rankRange.to.index,
      correctCount,
      wrongCount,
      passed,
      duration.inSeconds,
    ]);
  }

  List<ExamEntry> examsSince(DateTime since) {
    final date = DateFormat('yyyy-MM-dd HH:mm:ss').format(since);
    final resultSet = _examsSince.select([date]);
    final entries = <ExamEntry>[];
    for (final row in resultSet) {
      entries.add(ExamEntry(
        date: DateTime.parse(row['date'] as String),
        type: row['type'] as String,
        rankRange: RankRange(
          from: Rank.values[row['from_rank'] as int],
          to: Rank.values[row['to_rank'] as int],
        ),
        correctCount: row['correct_count'] as int,
        wrongCount: row['wrong_count'] as int,
        passed: (row['passed'] as int) != 0,
        duration: Duration(seconds: row['duration_sec'] as int),
      ));
    }
    return entries;
  }

  (int, int) taskDailyStatsSince(DateTime since) {
    final date = DateFormat('yyyy-MM-dd').format(since);
    final resultSet = _taskDailyStatsSince.select([date]);
    for (final row in resultSet) {
      return (
        row['total_correct_count'] as int,
        row['total_wrong_count'] as int,
      );
    }
    return (0, 0);
  }

  void dispose() => _db.dispose();
}
