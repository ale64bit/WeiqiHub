import 'package:flutter_test/flutter_test.dart';
import 'package:wqhub/board/board_state.dart';
import 'package:wqhub/game_client/ogs/territory_calculator.dart';
import 'package:wqhub/wq/wq.dart' as wq;

void main() {
  test('calculate territory with small board', () {
    // 5x5 board with clear territories
    final boardState = BoardState(size: 5);

    // Black will control the top, White the bottom
    boardState.move((col: wq.Color.black, p: (0, 1)));
    boardState.move((col: wq.Color.white, p: (0, 2)));
    boardState.move((col: wq.Color.black, p: (1, 1)));
    boardState.move((col: wq.Color.white, p: (1, 2)));
    boardState.move((col: wq.Color.black, p: (2, 1)));
    boardState.move((col: wq.Color.white, p: (2, 2)));
    boardState.move((col: wq.Color.black, p: (3, 1)));
    boardState.move((col: wq.Color.white, p: (3, 2)));
    boardState.move((col: wq.Color.black, p: (4, 1)));
    boardState.move((col: wq.Color.white, p: (4, 2)));

    // black places a stone in white's territory (we'll remove it)
    boardState.move((col: wq.Color.black, p: (2, 4)));

    final removedStones = <wq.Point>[(2, 4)];
    final komi = 5.5;

    final result = calculateTerritory(boardState, removedStones, komi);

    expect(result.ownership.length, equals(5));

    for (var row in result.ownership) {
      expect(row,
          equals([wq.Color.black, null, null, wq.Color.white, wq.Color.white]));
    }

    // Black has 5 points of territory. White has 10 points of territory and one capture
    expect(result.winner, equals(wq.Color.white));
    expect(result.scoreLead, equals(11.5));
  });
}
