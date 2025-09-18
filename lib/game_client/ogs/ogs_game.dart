import 'dart:async';

import 'package:wqhub/game_client/automatic_counting_info.dart';
import 'package:wqhub/game_client/counting_result.dart';
import 'package:wqhub/game_client/game.dart';
import 'package:wqhub/game_client/game_result.dart';
import 'package:wqhub/game_client/ogs/ogs_websocket_manager.dart';
import 'package:wqhub/wq/wq.dart' as wq;
import 'package:logging/logging.dart';

class OGSGame extends Game {
  final Logger _logger = Logger('OGSGame');
  final OGSWebSocketManager _webSocketManager;
  late final StreamController<wq.Move?> _moveController;
  StreamSubscription<Map<String, dynamic>>? _messageSubscription;

  OGSGame({
    required super.id,
    required super.boardSize,
    required super.rules,
    required super.handicap,
    required super.komi,
    required super.myColor,
    required super.timeControl,
    required super.previousMoves,
    required OGSWebSocketManager webSocketManager,
  }) : _webSocketManager = webSocketManager {
    _logger.info('Initialized OGSGame with id: $id');
    _moveController = StreamController<wq.Move?>.broadcast();
    _setupGame();
  }

  @override
  Future<void> acceptCountingResult(bool agree) => Future.value();

  @override
  Future<void> agreeToAutomaticCounting(bool agree) => Future.value();

  @override
  Future<void> aiReferee() => Future.value();

  @override
  Future<AutomaticCountingInfo> automaticCounting() =>
      Future.value(AutomaticCountingInfo(timeout: Duration.zero));

  @override
  Stream<bool> automaticCountingResponses() => Stream.empty();

  @override
  Stream<bool> countingResultResponses() => Stream.empty();

  @override
  Stream<CountingResult> countingResults() => Stream.empty();

  @override
  Future<void> forceCounting() => Future.value();

  @override
  Future<void> manualCounting() => Future.value();

  @override
  Future<void> move(wq.Move move) {
    final sgfMove = move.p.toSgf();
    return _sendMove(sgfMove, move.col);
  }

  @override
  Future<void> pass() {
    // ".." isn't standard SGF format, but it's what OGS expects for a pass
    return _sendMove('..', myColor);
  }

  Future<void> _sendMove(String sgfMove, wq.Color color) async {
    try {
      await _webSocketManager.sendAndGetResponse('game/move', {
        'game_id': int.parse(id),
        'move': sgfMove,
      });

      _logger.fine('Move "$sgfMove" for game $id confirmed by server');
    } catch (error) {
      _logger.warning('Failed to send move "$sgfMove" for game $id: $error');
      rethrow;
    }
  }

  @override
  Stream<wq.Move?> moves() => _moveController.stream;

  void _setupGame() {
    // Connect to the game via WebSocket
    _webSocketManager.joinGame(id);

    // Listen for move events
    _messageSubscription = _webSocketManager.messages.listen(_handleMessage);
  }

  void _handleMessage(Map<String, dynamic> message) {
    final event = message['event'] as String;

    // Check if this is an error event for our game
    if (event == 'game/$id/error') {
      final data = message['data'];
      _logger.warning('Error received for game $id: $data');
      return;
    }

    // Check if this is a move event for our game
    if (event == 'game/$id/move') {
      final data = message['data'] as Map<String, dynamic>;
      final gameId = data['game_id'] as int;
      final moveNumber = data['move_number'] as int;
      final moveData = data['move'] as dynamic;

      _logger.fine(
          'Received move: game_id=$gameId, move_number=$moveNumber, move=$moveData');

      // Determine the color based on move number (odd = black, even = white)
      // TODO: make sure we're accounting for handicap!!
      final color = moveNumber % 2 == 1 ? wq.Color.black : wq.Color.white;

      wq.Point point;

      if (moveData is List && moveData.length >= 2) {
        // Numeric format: [row, col, time] where -1,-1 is pass
        final row = moveData[1] as int;
        final col = moveData[0] as int;
        point = (row, col);
      } else {
        _logger.severe('Unknown move format: $moveData');
        return;
      }

      if (point == (-1, -1)) {
        _moveController.add(null);
        return;
      }

      final move = (col: color, p: point);
      _moveController.add(move);
    }
  }

  void dispose() {
    _messageSubscription?.cancel();
    _webSocketManager.leaveGame(id);
    _moveController.close();
  }

  @override
  Future<void> resign() => Future.value();

  @override
  Future<GameResult> result() => Completer<GameResult>().future;
}
