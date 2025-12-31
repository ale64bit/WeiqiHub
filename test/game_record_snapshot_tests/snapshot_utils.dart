import 'dart:convert';
import 'package:wqhub/game_client/game_record.dart';

/// Directory containing fixture files (.sgf, .gib)
const fixturesDir = 'test/game_record_snapshot_tests/fixtures';

/// Directory containing snapshot JSON files
const snapshotsDir = 'test/game_record_snapshot_tests/fixtures/snapshots';

/// Returns the path to a snapshot file for the given base name and extension
String snapshotPath(String baseName, String extension) {
  final ext = extension.replaceAll('.', '_');
  return '$snapshotsDir/$baseName$ext.json';
}

/// Creates a JSON snapshot of a GameRecord for comparison
String createSnapshot(GameRecord record) {
  final data = {
    'type': record.type.toString(),
    'moves': record.moves
        .map((move) => {
              'color': move.col.toString(),
              'row': move.p.$1,
              'col': move.p.$2,
            })
        .toList(),
  };

  // Pretty print JSON for readability
  const encoder = JsonEncoder.withIndent('  ');
  return encoder.convert(data);
}
