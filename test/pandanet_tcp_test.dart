import 'package:flutter_test/flutter_test.dart';
import 'package:wqhub/game_client/pandanet/game_utils.dart';

void main() {
  group('isSubsequence (from PandanetTcpManager)', () {
    test('matches connection message', () {
      expect(
        isSubsequence('21 {Joseki [7k*] has connected.}', '21 { has connected.}'),
        isTrue,
      );
    });

    test('matches match message', () {
      expect(
        isSubsequence('21 {Match 53: ichirob3 [ 2d*] vs. ka5dusa [ 2d*] }',
                      '21 {Match :  vs.  }'),
        isTrue,
      );
    });

    test('matches game result', () {
      expect(
        isSubsequence('21 {Game 2: hoshikunn vs Flavgo : W 64.5 B 70.0}',
                      '21 {Game :  vs  : W  B }'),
        isTrue,
      );
    });

    test('rejects incomplete message', () {
      expect(
        isSubsequence('21 {Game 22: Pbot1d02 vs tqqq}',
                      '21 {Game :  vs  : Black resigns.}'),
        isFalse,
      );
    });

    test('rejects unrelated text', () {
      expect(isSubsequence('hello world', '21 { has connected.}'), isFalse);
    });

    test('accepts partial subsequence without prefix', () {
      expect(
        isSubsequence('21 {Game 22: Pbot1d02 vs tqqq : Black resigns.}',
                      'Game vs : Black resigns.}'),
        isTrue,
      );
    });
  });
}
