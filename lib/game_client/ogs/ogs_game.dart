import 'dart:async';

import 'package:wqhub/board/board_state.dart';
import 'package:wqhub/game_client/automatic_counting_info.dart';
import 'package:wqhub/game_client/counting_result.dart';
import 'package:wqhub/game_client/game.dart';
import 'package:wqhub/game_client/game_result.dart';
import 'package:wqhub/game_client/ogs/ogs_websocket_manager.dart';
import 'package:wqhub/game_client/time_state.dart';
import 'package:wqhub/game_client/user_info.dart';
import 'package:wqhub/wq/grid.dart';
import 'package:wqhub/wq/rank.dart';
import 'package:wqhub/wq/wq.dart' as wq;
import 'package:logging/logging.dart';

class OGSGame extends Game {
  final Logger _logger = Logger('OGSGame');
  final OGSWebSocketManager _webSocketManager;
  final String _myUserId;
  late final StreamController<wq.Move?> _moveController;
  late final StreamController<CountingResult> _countingResultController;
  late final Completer<GameResult> _resultCompleter;
  StreamSubscription<Map<String, dynamic>>? _messageSubscription;

  // Track all moves played in the game for board state reconstruction
  final List<wq.Move> _allMoves = [];

  // Track stone removal proposals from our opponent or server
  String _recentlyRemovedStonesString = '';

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
    required String myUserId,
  })  : _webSocketManager = webSocketManager,
        _myUserId = myUserId {
    _logger.info('Initialized OGSGame with id: $id');
    _moveController = StreamController<wq.Move?>.broadcast();
    _countingResultController = StreamController<CountingResult>.broadcast();
    _resultCompleter = Completer<GameResult>();

    _allMoves.addAll(previousMoves);

    _setupGame();
  }

  @override
  Future<void> acceptCountingResult(bool agree) async {
    try {
      if (agree) {
        // end the game with the removed stones our opponent proposed
        final stonesString = _recentlyRemovedStonesString;

        _webSocketManager.send('game/removed_stones/accept', {
          'game_id': int.parse(id),
          'stones': stonesString,
          'strict_seki_mode': false,
        });
      } else {
        // continue the game
        _webSocketManager.send('game/removed_stones/reject', {
          'game_id': int.parse(id),
        });
      }
    } catch (error) {
      _logger.warning(
          'Failed to send stone removal ${agree ? "acceptance" : "rejection"} for game $id: $error');
      rethrow;
    }
  }

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
  Stream<CountingResult> countingResults() => _countingResultController.stream;

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
    final gamePrefix = 'game/$id/';

    // Only handle messages for this specific game
    if (!event.startsWith(gamePrefix)) {
      return;
    }

    final suffix = event.substring(gamePrefix.length);

    switch (suffix) {
      case 'error':
        _handleError(message['data']);

      case 'gamedata':
        _handleGameData(message['data'] as Map<String, dynamic>);

      case 'removed_stones_accepted':
        _handleRemovedStonesAccepted(message['data'] as Map<String, dynamic>);

      case 'move':
        _handleMove(message['data'] as Map<String, dynamic>);

      case 'clock':
        _handleClock(message['data'] as Map<String, dynamic>);

      default:
        _logger.fine('Unhandled game event for game $id: $suffix');
    }
  }

  void _handleError(dynamic data) {
    _logger.warning('Error received for game $id: $data');
  }

  void _handleMove(Map<String, dynamic> data) {
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
    _allMoves.add(move);
    _moveController.add(move);
  }

  void _handleGameData(Map<String, dynamic> gameData) {
    _logger.fine('Received gamedata for game $id');

    try {
      // Update player information
      final players = gameData['players'] as Map<String, dynamic>?;
      if (players != null) {
        _updatePlayerInfo(players);
      }

      // Update game result if the game has ended
      final phase = gameData['phase'] as String?;
      if (phase == 'finished' && !_resultCompleter.isCompleted) {
        final winner = gameData['winner'] as int?;
        final outcome = gameData['outcome'] as String?;

        if (winner != null && outcome != null) {
          final gameResult = _parseGameResult(winner, outcome, players);
          _resultCompleter.complete(gameResult);
        }
      }
    } catch (error) {
      _logger.warning('Error handling gamedata for game $id: $error');
    }
  }

  void _updatePlayerInfo(Map<String, dynamic> players) {
    final blackPlayerData = players['black'] as Map<String, dynamic>?;
    final whitePlayerData = players['white'] as Map<String, dynamic>?;

    if (blackPlayerData != null) {
      final blackUser = _parseUserInfo(blackPlayerData);
      black.value = blackUser;
    }

    if (whitePlayerData != null) {
      final whiteUser = _parseUserInfo(whitePlayerData);
      white.value = whiteUser;
    }
  }

  UserInfo _parseUserInfo(Map<String, dynamic> playerData) {
    final username = playerData['username'] as String? ?? '';
    final userId = (playerData['id'] as int?)?.toString() ?? '';
    final rankValue = playerData['rank'] as double? ?? 0.0;

    // Convert OGS rank (floating point) to our Rank enum
    final rank = _ogsRankToRank(rankValue);

    return UserInfo(
      userId: userId,
      username: username,
      rank: rank,
      online: false, // We don't have online status from gamedata
      winCount: 0, // We don't have win/loss counts from gamedata
      lossCount: 0,
    );
  }

  Rank _ogsRankToRank(double ogsRank) {
    if (ogsRank > 900) {
      // Professional ranks on OGS are shifted up by 1000 for whatever reason
      final proLevel = (ogsRank - 1000 - 36).floor().clamp(1, 10);
      return Rank.values[Rank.p1.index + proLevel - 1];
    } else {
      final enumIndex = ogsRank.floor().clamp(0, 39);
      return Rank.values[enumIndex];
    }
  }

  GameResult _parseGameResult(
      int winnerId, String outcome, Map<String, dynamic>? players) {
    wq.Color? winner;

    if (players != null) {
      final blackPlayer = players['black'] as Map<String, dynamic>?;
      final whitePlayer = players['white'] as Map<String, dynamic>?;

      final blackId = blackPlayer?['id'] as int?;
      final whiteId = whitePlayer?['id'] as int?;

      if (winnerId == blackId) {
        winner = wq.Color.black;
      } else if (winnerId == whiteId) {
        winner = wq.Color.white;
      }
    }

    // Map OGS outcome to our result format
    final result = switch (outcome.toLowerCase()) {
      'resignation' => 'Resignation',
      'timeout' => 'Time',
      'cancellation' => 'Cancellation',
      // Score-based results, e.g. "W+5.5"
      _ => outcome, // Keep original for score-based results
    };

    return GameResult(
      winner: winner,
      result: result,
      description: outcome,
    );
  }

  void _handleRemovedStonesAccepted(Map<String, dynamic> data) {
    _logger.fine('Received removed stones accepted for game $id');

    try {
      // Check if this is just the server telling us about our own acceptance
      final playerId = data['player_id'] as int?;
      if (playerId?.toString() == _myUserId) {
        _logger.fine('Ignoring our own stone removal acceptance');
        return;
      }

      _recentlyRemovedStonesString = data['stones'] as String? ?? '';

      final countingResult = _calculateCountingResultFromOwnership(data);
      _countingResultController.add(countingResult);
    } catch (error) {
      _logger.warning(
          'Error handling removed stones accepted for game $id: $error');
    }
  }

  void _handleClock(Map<String, dynamic> data) {
    _logger.fine('Received clock update for game $id');

    try {
      final blackTimeData = data['black_time'] as Map<String, dynamic>?;
      final whiteTimeData = data['white_time'] as Map<String, dynamic>?;

      if (blackTimeData != null) {
        blackTime.value =
            (blackTime.value.$1 + 1, _parseOGSTimeData(blackTimeData));
      }

      if (whiteTimeData != null) {
        whiteTime.value =
            (whiteTime.value.$1 + 1, _parseOGSTimeData(whiteTimeData));
      }

      _logger.fine(
          'Updated clock for game $id: blackTime=${blackTime.value}, whiteTime=${whiteTime.value}');
    } catch (error) {
      _logger.warning('Error handling clock update for game $id: $error');
    }
  }

  /// Helper function to safely convert dynamic value to double
  static Duration _parseSeconds(dynamic value) {
    if (value is double) return Duration(milliseconds: (value * 1000).toInt());
    if (value is int) return Duration(seconds: value);
    return Duration.zero;
  }

  TimeState _parseOGSTimeData(Map<String, dynamic> timeData) {
    final thinkingTime = _parseSeconds(timeData['thinking_time']);
    final periods = timeData['periods'] as int? ?? 0;
    final periodTime = _parseSeconds(timeData['period_time']);

    return TimeState(
      mainTimeLeft: thinkingTime,
      periodTimeLeft: periodTime,
      periodCount: periods,
    );
  }

  /// Calculate territory ownership and score from OGS ownership data
  CountingResult _calculateCountingResultFromOwnership(
      Map<String, dynamic> data) {
    _logger.fine('Calculating territory from OGS ownership data');

    final ownershipData = data['ownership'] as List<dynamic>;

    final ownership = generate2D<wq.Color?>(boardSize, (i, j) {
      final value = (ownershipData[i] as List<dynamic>)[j] as int;
      return switch (value) {
        -1 => wq.Color.white,
        1 => wq.Color.black,
        _ => null,
      };
    });

    final territoryCounts = count2D(ownership);
    final blackTerritory = territoryCounts[wq.Color.black] ?? 0;
    final whiteTerritory = territoryCounts[wq.Color.white] ?? 0;

    // Calculate captures during the game by reconstructing board state
    final boardState = BoardState(size: boardSize);
    var blackCaptures = 0;
    var whiteCaptures = 0;

    for (final move in _allMoves) {
      final capturedStones = boardState.move(move);
      if (capturedStones != null) {
        switch (move.col) {
          case wq.Color.black:
            blackCaptures += capturedStones.length;
          case wq.Color.white:
            whiteCaptures += capturedStones.length;
        }
      }
    }

    final blackScore = blackTerritory + whiteCaptures;
    final whiteScore = whiteTerritory + blackCaptures + komi;

    final scoreLead = (blackScore - whiteScore).abs();
    final winner = blackScore > whiteScore ? wq.Color.black : wq.Color.white;

    _logger.fine(
        'Score from ownership: Black=$blackScore (territory: $blackTerritory, captures: $whiteCaptures), '
        'White=$whiteScore (territory: $whiteTerritory, captures: $blackCaptures, komi: $komi)');
    _logger.fine('Winner: $winner, Lead: $scoreLead');

    return CountingResult(
      winner: winner,
      scoreLead: scoreLead,
      ownership: ownership,
    );
  }

  void dispose() {
    _messageSubscription?.cancel();
    _webSocketManager.leaveGame(id);
    _moveController.close();
    _countingResultController.close();

    // Complete the result future if not already completed
    if (!_resultCompleter.isCompleted) {
      _resultCompleter.completeError('Game disposed before completion');
    }
  }

  @override
  Future<void> resign() => Future.value();

  @override
  Future<GameResult> result() => _resultCompleter.future;
}
