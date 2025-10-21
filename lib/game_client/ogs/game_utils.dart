import 'package:wqhub/wq/wq.dart' as wq;

/// Parse a string of SGF coordinates into a list of moves for a given color.
///
/// Parameters:
///  - [stonesString]: String containing concatenated SGF coordinates (e.g., "aabbcc")
///  - [color]: The color of the stones to be parsed
///
/// Returns a list of moves with the specified color and parsed points.
List<wq.Move> parseStonesString(String stonesString, wq.Color color) {
  final moves = <wq.Move>[];

  for (int i = 0; i < stonesString.length; i += 2) {
    final sgfCoord = stonesString.substring(i, i + 2);
    final point = wq.parseSgfPoint(sgfCoord);
    moves.add((col: color, p: point));
  }

  return moves;
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
