import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;
import 'package:wqhub/game_client/game_record.dart';
import 'snapshot_utils.dart';

void main() {
  _testFileType(
    fixturesDir: fixturesDir,
    extension: '.sgf',
    groupName: 'GameRecord.fromSgf snapshots',
    expectedType: GameRecordType.sgf,
    parseFile: (file) async {
      final content = await file.readAsString();
      return GameRecord.fromSgf(content);
    },
  );

  _testFileType(
    fixturesDir: fixturesDir,
    extension: '.gib',
    groupName: 'GameRecord.fromGib snapshots',
    expectedType: GameRecordType.gib,
    parseFile: (file) async {
      final content = await file.readAsBytes();
      return GameRecord.fromGib(content);
    },
  );
}

void _testFileType({
  required String fixturesDir,
  required String extension,
  required String groupName,
  required GameRecordType expectedType,
  required Future<GameRecord> Function(File) parseFile,
}) {
  group(groupName, () {
    final dir = Directory(fixturesDir);
    final files = dir
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith(extension))
        .toList();

    for (final file in files) {
      final filename = path.basename(file.path);

      test(filename, () async {
        final record = await parseFile(file);

        expect(record.type, expectedType);

        // Verify against snapshot
        final snapshot = createSnapshot(record);
        final baseName = path.basenameWithoutExtension(filename);
        final snapshotFilePath = snapshotPath(baseName, extension);
        final expectedSnapshot = await _loadSnapshot(snapshotFilePath);

        // Decode both to compare as structured data
        final expected = jsonDecode(expectedSnapshot);
        final actual = jsonDecode(snapshot);

        expect(
          actual,
          equals(expected),
          reason: 'Snapshot mismatch for $filename\n'
              'To update: dart run test/game_record_snapshot_tests/generate_snapshots.dart',
        );
      });
    }
  });
}

/// Loads an expected snapshot from the snapshots directory
Future<String> _loadSnapshot(String filePath) async {
  final file = File(filePath);

  if (!await file.exists()) {
    // If snapshot doesn't exist, create it for the first time
    // This helps with initial test creation
    throw TestFailure('Snapshot file not found: ${file.path}\n'
        'Run: dart run test/game_record_snapshot_tests/generate_snapshots.dart');
  }

  return await file.readAsString();
}
