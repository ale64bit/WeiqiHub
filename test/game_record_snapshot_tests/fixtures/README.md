# GameRecord Snapshot Tests

This directory contains snapshot tests for `GameRecord.fromSgf` and `GameRecord.fromGib` methods.

## How It Works

The tests automatically discover all `.sgf` and `.gib` files in the `fixtures/` directory and validate them against their corresponding snapshot JSON files. **No need to write new test cases** - just add your file and regenerate snapshots!

## Structure

- `fixtures/` - Test data files
  - `*.sgf` - Sample SGF game files
  - `*.gib` - Sample GIB game files
  - `snapshots/` - Expected output JSON files for comparison

## Running Tests

Run all snapshot tests:
```bash
flutter test test/game_record_snapshot_tests/
```

Or run all tests:
```bash
flutter test
```

## Regenerating Snapshots

If you modify the `GameRecord` parsing logic or want to update the expected outputs:

```bash
dart run test/game_record_snapshot_tests/generate_snapshots.dart
```

The generator automatically discovers all `.sgf` and `.gib` files in the fixtures directory.

This will regenerate all snapshot JSON files in `fixtures/snapshots/`.

## Snapshot Format

Each snapshot is a JSON file containing:
```json
{
  "type": "GameRecordType.sgf",
  "moveCount": 14,
  "moves": [
    {
      "color": "B",  // "B" for black, "W" for white
      "row": 4,
      "col": 4
    },
    ...
  ]
}
```

## Adding New Test Cases

1. Add a new `.sgf` or `.gib` file to `test/game_record_snapshot_tests/fixtures/`
2. Run the generator: `dart run test/game_record_snapshot_tests/generate_snapshots.dart`
3. Run tests to verify: `flutter test test/game_record_snapshot_tests/`

**That's it!** The test framework automatically discovers and tests your new file.
