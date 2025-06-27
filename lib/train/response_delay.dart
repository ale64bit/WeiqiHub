enum ResponseDelay {
  none,
  short,
  medium,
  long;

  Duration get duration => switch (this) {
        none => Duration.zero,
        short => Duration(milliseconds: 50),
        medium => Duration(milliseconds: 200),
        long => Duration(milliseconds: 400),
      };
}
