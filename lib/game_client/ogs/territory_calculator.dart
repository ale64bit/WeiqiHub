import 'package:wqhub/board/board_state.dart';
import 'package:wqhub/game_client/counting_result.dart';
import 'package:wqhub/wq/wq.dart' as wq;

/// Calculate territory ownership and score after stone removal
///
/// Takes a [BoardState] representing the final board position and a list of
/// [removedStones] that should be considered dead/removed, plus [komi].
/// Returns a [CountingResult] with territory ownership, winner, and score lead.
///
/// Scoring includes:
/// - Territory controlled (1 point per intersection)
/// - Captured stones (1 point per removed stone for the opponent)
/// - Komi compensation for white
/// TODO: handle seki and dame points correctly (for Japanese rules)
CountingResult calculateTerritory(
  BoardState boardState,
  List<wq.Point> removedStones,
  double komi, {
  int blackCaptures = 0,
  int whiteCaptures = 0,
}) {
  final boardSize = boardState.size;

  // Calculate territory ownership for each point
  final ownership =
      List.generate(boardSize, (i) => List<wq.Color?>.filled(boardSize, null));

  // Simple territory calculation using flood fill
  final visited =
      List.generate(boardSize, (i) => List<bool>.filled(boardSize, false));

  for (int r = 0; r < boardSize; r++) {
    for (int c = 0; c < boardSize; c++) {
      final point = (r, c);
      if (!visited[r][c] &&
          (boardState[point] == null || removedStones.contains(point))) {
        // This is an empty point or removed stone, determine territory ownership
        final territoryColor = _calculatePointTerritory(
            boardState, point, visited, removedStones, boardSize);
        if (territoryColor != null) {
          // Fill the entire territory region with this color
          _fillTerritoryRegion(point, territoryColor, ownership, boardState,
              removedStones, boardSize);
        }
      }
    }
  }

  // Count score
  var blackScore = 0.0;
  var whiteScore = 0.0;

  // Add capture counts from gameplay
  blackScore +=
      whiteCaptures.toDouble(); // Black gets points for capturing white stones
  whiteScore +=
      blackCaptures.toDouble(); // White gets points for capturing black stones

  // Count captured stones from manual removal
  for (final removedPoint in removedStones) {
    final removedStoneColor = boardState[removedPoint];
    if (removedStoneColor == wq.Color.black) {
      whiteScore += 1.0; // White gets a point for capturing black
    } else if (removedStoneColor == wq.Color.white) {
      blackScore += 1.0; // Black gets a point for capturing white
    }
  }

  for (int r = 0; r < boardSize; r++) {
    for (int c = 0; c < boardSize; c++) {
      final point = (r, c);
      final stoneColor = boardState[point];
      final territoryColor = ownership[r][c];

      // Count territory
      if (stoneColor == null || removedStones.contains(point)) {
        if (territoryColor == wq.Color.black) {
          blackScore += 1.0;
        } else if (territoryColor == wq.Color.white) {
          whiteScore += 1.0;
        }
      }
    }
  }

  // Add komi for white
  whiteScore += komi;

  // Determine winner and score lead
  final scoreLead = (blackScore - whiteScore).abs();
  final winner = blackScore > whiteScore ? wq.Color.black : wq.Color.white;

  return CountingResult(
    winner: winner,
    scoreLead: scoreLead,
    ownership: ownership,
  );
}

/// Determine territory ownership for an empty region using flood fill
wq.Color? _calculatePointTerritory(
  BoardState boardState,
  wq.Point startPoint,
  List<List<bool>> visited,
  List<wq.Point> removedStones,
  int boardSize,
) {
  final queue = <wq.Point>[startPoint];
  final surroundingColors = <wq.Color>{};

  while (queue.isNotEmpty) {
    final point = queue.removeAt(0);
    final (r, c) = point;

    if (r < 0 || r >= boardSize || c < 0 || c >= boardSize || visited[r][c]) {
      continue;
    }

    final stoneColor = boardState[point];

    if (stoneColor != null && !removedStones.contains(point)) {
      // This is a living stone, record its color
      surroundingColors.add(stoneColor);
      continue;
    }

    // This is an empty point or removed stone
    visited[r][c] = true;

    // Add neighbors to queue
    final neighbors = [(r - 1, c), (r + 1, c), (r, c - 1), (r, c + 1)];

    for (final neighbor in neighbors) {
      queue.add(neighbor);
    }
  }

  // Determine ownership based on surrounding colors
  if (surroundingColors.length == 1) {
    // Territory is surrounded by only one color
    return surroundingColors.first;
  } else {
    // Territory is contested or neutral
    return null;
  }
}

/// Fill a territory region with the specified color
void _fillTerritoryRegion(
  wq.Point startPoint,
  wq.Color color,
  List<List<wq.Color?>> ownership,
  BoardState boardState,
  List<wq.Point> removedStones,
  int boardSize,
) {
  final queue = <wq.Point>[startPoint];
  final visited = <wq.Point>{};

  while (queue.isNotEmpty) {
    final point = queue.removeAt(0);
    final (r, c) = point;

    if (r < 0 ||
        r >= boardSize ||
        c < 0 ||
        c >= boardSize ||
        visited.contains(point)) {
      continue;
    }

    final stoneColor = boardState[point];

    if (stoneColor != null && !removedStones.contains(point)) {
      // This is a living stone, stop
      continue;
    }

    // This is an empty point or removed stone
    visited.add(point);
    ownership[r][c] = color;

    // Add neighbors
    final neighbors = [(r - 1, c), (r + 1, c), (r, c - 1), (r, c + 1)];

    for (final neighbor in neighbors) {
      queue.add(neighbor);
    }
  }
}
