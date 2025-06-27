enum Rules {
  chinese,
  japanese,
  korean;

  @override
  String toString() => switch (this) {
        Rules.chinese => 'Chinese',
        Rules.japanese => 'Japanese',
        Rules.korean => 'Korean',
      };
}
