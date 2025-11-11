import 'package:wqhub/wq/rank.dart';
import 'package:characters/characters.dart';

extension RankParsing on Rank {
  static Rank fromString(String input) {
    if (input.isEmpty) return Rank.unknown;
    final cleaned = input.toLowerCase().trim().replaceAll(RegExp(r'[+?]'), '');
    final match = RegExp(r'(\d+)\s*([kdp])$').firstMatch(cleaned);
    if (match == null) return Rank.unknown;

    final num = int.parse(match.group(1)!);
    final suffix = match.group(2)!;

    switch (suffix) {
      case 'k':
        final idx = 30 - num;
        return idx >= Rank.k30.index && idx <= Rank.k1.index
            ? Rank.values[idx]
            : Rank.unknown;
      case 'd':
        final idx = Rank.k1.index + num;
        return idx <= Rank.d10.index ? Rank.values[idx] : Rank.unknown;
      case 'p':
        final idx = Rank.d10.index + num;
        return idx <= Rank.p10.index ? Rank.values[idx] : Rank.unknown;
      default:
        return Rank.unknown;
    }
  }
}

bool isSubsequence(String text, String pattern) {
  final textChars = text.characters;
  final patternChars = pattern.characters;
  var pIndex = 0;
  for (final ch in textChars) {
    if (pIndex < patternChars.length && ch == patternChars.elementAt(pIndex)) {
      pIndex++;
      if (pIndex == patternChars.length) return true;
    }
  }
  return pIndex == patternChars.length;
}
