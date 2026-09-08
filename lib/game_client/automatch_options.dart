import 'package:flutter/foundation.dart';
import 'package:wqhub/game_client/game.dart';

/// Additional, server-specific options for an automatch request.
///
/// Only servers implementing [OGSAutomatch] currently honor these; other game
/// clients keep their default matchmaking behavior.
@immutable
class AutomatchOptions {
  /// How many ranks stronger than the player an opponent may be.
  final int upperRankDiff;

  /// How many ranks weaker than the player an opponent may be.
  final int lowerRankDiff;

  const AutomatchOptions({
    required this.upperRankDiff,
    required this.lowerRankDiff,
  });

  const AutomatchOptions.defaults()
      : upperRankDiff = defaultRankDiff,
        lowerRankDiff = defaultRankDiff;

  /// OGS default rank difference for automatch requests.
  /// https://github.com/online-go/online-go.com/blob/b0d661e69cef0ce57c2c5d4e2e04109227ba9a96/src/lib/preferences.ts#L57-L58
  static const int defaultRankDiff = 3;

  /// Largest rank difference selectable in the matchmaking UI.
  static const int maxRankDiff = 9;

  AutomatchOptions copyWith({int? upperRankDiff, int? lowerRankDiff}) =>
      AutomatchOptions(
        upperRankDiff: upperRankDiff ?? this.upperRankDiff,
        lowerRankDiff: lowerRankDiff ?? this.lowerRankDiff,
      );

  @override
  int get hashCode => Object.hash(upperRankDiff, lowerRankDiff);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AutomatchOptions &&
          other.runtimeType == runtimeType &&
          other.upperRankDiff == upperRankDiff &&
          other.lowerRankDiff == lowerRankDiff;
}

/// Implemented by game clients that accept [AutomatchOptions] when starting an
/// automatch request.
abstract interface class OGSAutomatch {
  /// Like `GameClient.findGame`, but forwards [options] (e.g. the acceptable
  /// opponent rank range) to the server.
  Future<Game> findMatch(String presetId, AutomatchOptions options);
}
