import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:wqhub/game_client/game_record.dart';
import 'snapshot_utils.dart';

/// Script to generate snapshot files for GameRecord tests
/// Automatically discovers all .sgf and .gib files in fixtures directory
void main() async {
  // Ensure snapshots directory exists
  await Directory(snapshotsDir).create(recursive: true);

  final fixturesDirectory = Directory(fixturesDir);
  final files = fixturesDirectory.listSync().whereType<File>();

  int sgfCount = 0;
  int gibCount = 0;

  for (final file in files) {
    final filename = path.basename(file.path);
    final extension = path.extension(filename);

    if (extension == '.sgf') {
      final baseName = path.basenameWithoutExtension(filename);
      await generateSnapshot(
        file.path,
        snapshotPath(baseName, extension),
        isSgf: true,
      );
      sgfCount++;
    } else if (extension == '.gib') {
      final baseName = path.basenameWithoutExtension(filename);
      await generateSnapshot(
        file.path,
        snapshotPath(baseName, extension),
        isSgf: false,
      );
      gibCount++;
    }
  }

  print('\n✅ Generated $sgfCount SGF snapshots and $gibCount GIB snapshots');
}

Future<void> generateSnapshot(String inputPath, String outputPath,
    {required bool isSgf}) async {
  print('Generating $outputPath...');

  final GameRecord record;

  if (isSgf) {
    final content = await File(inputPath).readAsString();
    record = GameRecord.fromSgf(content);
  } else {
    final content = await File(inputPath).readAsBytes();
    record = GameRecord.fromGib(content);
  }

  final snapshot = createSnapshot(record);
  await File(outputPath).writeAsString(snapshot);

  print('  Created with ${record.moves.length} moves');
}
