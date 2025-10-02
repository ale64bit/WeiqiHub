// Some utilities for working with Lists of Lists.

List<List<T>> generate2D<T>(int boardSize, T Function(int i, int j) generator) {
  return List.generate(
      boardSize, (i) => List.generate(boardSize, (j) => generator(i, j)));
}

Map<T, int> count2D<T>(List<List<T>> grid) {
  final Map<T, int> counts = {};
  for (final row in grid) {
    for (final item in row) {
      counts[item] = (counts[item] ?? 0) + 1;
    }
  }
  return counts;
}
