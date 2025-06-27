extension ParseExt on Iterable<int> {
  static final _space = ' '.codeUnitAt(0);
  static final _tab = '\t'.codeUnitAt(0);
  static final _newLine = '\n'.codeUnitAt(0);
  static final _cr = '\r'.codeUnitAt(0);
  static final _openParen = '('.codeUnitAt(0);
  static final _openBracket = '['.codeUnitAt(0);
  static final _closedBracket = ']'.codeUnitAt(0);

  Iterable<int> skipSpace() {
    return skipWhile(
        (c) => c == _space || c == _tab || c == _newLine || c == _cr);
  }

  Iterable<int> match(int want) {
    if (first != want) {
      throw FormatException('expected "$want", but got "$first"');
    }
    return skip(1);
  }

  Iterable<int> matchSemicolon() => match(';'.codeUnitAt(0));
  Iterable<int> matchColon() => match(':'.codeUnitAt(0));
  Iterable<int> matchEqual() => match('='.codeUnitAt(0));
  Iterable<int> matchComma() => match(','.codeUnitAt(0));

  Iterable<int> matchString(String s) =>
      s.codeUnits.fold(this, (it, i) => it.match(i));

  (Iterable<int>, T) tag<T>(
      String open, String close, (Iterable<int>, T) Function(Iterable<int>) f) {
    final (it, t) = f(matchString(open));
    return (it.skipSpace().matchString(close), t);
  }

  (Iterable<int>, T) parentheses<T>(
          (Iterable<int>, T) Function(Iterable<int>) f) =>
      tag('(', ')', f);

  (Iterable<int>, T) brackets<T>(
          (Iterable<int>, T) Function(Iterable<int>) f) =>
      tag('[', ']', f);

  (Iterable<int>, String) propName() {
    var it = this;
    final sb = StringBuffer();
    while (it.isUpper()) {
      sb.writeCharCode(it.first);
      it = it.skip(1);
    }
    return (it, sb.toString());
  }

  (Iterable<int>, List<int>) collectUntil(int ch) =>
      collectUntilCond((it) => it.first == ch);

  (Iterable<int>, List<int>) collectUntilCond(
      bool Function(Iterable<int>) cond) {
    var it = this;
    final ret = <int>[];
    while (!cond(it)) {
      ret.add(it.first);
      it = it.skip(1);
    }
    return (it, ret);
  }

  bool isLower() => 'a'.codeUnitAt(0) <= first && first <= 'z'.codeUnitAt(0);
  bool isUpper() => 'A'.codeUnitAt(0) <= first && first <= 'Z'.codeUnitAt(0);
  bool isOpenParen() => first == _openParen;
  bool isOpenBracket() => first == _openBracket;
  bool isClosedBracket() => first == _closedBracket;
  bool isComma() => first == ','.codeUnitAt(0);
  bool isBackslash() => first == r'\'.codeUnitAt(0);
}
