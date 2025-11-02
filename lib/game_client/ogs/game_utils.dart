import 'package:wqhub/wq/wq.dart' as wq;

/// Returns formatted result string with winner prefix (e.g., "B + Resignation", "W + 5.5 points").
String formatGameResult(wq.Color? winner, String outcome) {
  String winnerPrefix = switch (winner) {
    wq.Color.black => 'B + ',
    wq.Color.white => 'W + ',
    null => '',
  };
  return '$winnerPrefix$outcome';
}

/// Parse a string of SGF coordinates into a list of points.
///
/// Parameters:
///  - [stonesString]: String containing concatenated SGF coordinates (e.g., "aabbcc")
///
/// Returns a list of points parsed from the SGF coordinates.
List<wq.Point> parseStonesString(String stonesString) {
  final points = <wq.Point>[];

  for (int i = 0; i + 1 < stonesString.length; i += 2) {
    final sgfCoord = stonesString.substring(i, i + 2);
    final point = wq.parseSgfPoint(sgfCoord);
    points.add(point);
  }

  return points;
}

/// Determine whose color it is to move given the number of moves played and
/// the game starting conditions.
///
/// Parameters:
///  - [moveNumber]: Number of moves already played (typically MoveTree.moveNumber)
///  - [handicap]: Number of handicap stones (default 0)
///  - [freeHandicapPlacement]: True when handicap stones are placed during play;
///                             default false.
///
/// Returns the color that should play next.
wq.Color colorToMove(
  int moveNumber, {
  int handicap = 0,
  bool freeHandicapPlacement = false,
}) {
  // When handicap is 0 (even game) or 1 (no komi), black goes first
  // For greater handicaps:
  //  - With free placement, black plays first for each handicap stone
  //  - Without free placement, white plays first (black's stones are pre-placed)
  // Once all handicap stones are placed, the game alternates as normal
  if (handicap <= 1) {
    return moveNumber.isEven ? wq.Color.black : wq.Color.white;
  } else {
    if (freeHandicapPlacement) {
      moveNumber -= handicap;
      if (moveNumber < 0) {
        return wq.Color.black;
      }
    }
    return moveNumber.isEven ? wq.Color.white : wq.Color.black;
  }
}
