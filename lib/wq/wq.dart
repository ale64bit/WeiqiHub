enum Color {
  black,
  white;

  Color get opposite =>
      switch (this) { Color.black => Color.white, Color.white => Color.black };

  int get id => switch (this) { Color.black => 0, Color.white => 1 };

  @override
  String toString() => switch (this) { Color.black => 'B', Color.white => 'W' };

  static Color? fromString(String col) => switch (col) {
        'B' => black,
        'W' => white,
        _ => null,
      };
}

typedef Point = (int r, int c);
typedef PointList = List<Point>;

Point parseSgfPoint(String s) {
  if (s == 'tt' || s == '') return (-1, -1);
  final offset = 'a'.codeUnitAt(0);
  return (
    s.codeUnitAt(1) - offset,
    s.codeUnitAt(0) - offset,
  );
}

extension SgfConversion on Point {
  String toSgf() => switch (this) {
        (-1, -1) => 'tt',
        _ => String.fromCharCodes(
            ['a'.codeUnitAt(0) + this.$2, 'a'.codeUnitAt(0) + this.$1]),
      };
}

typedef Move = ({Color col, Point p});
