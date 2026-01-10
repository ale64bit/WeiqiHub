import 'package:wqhub/wq/wq.dart' as wq;

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
