import 'dart:async';

import 'package:wqhub/board/board_state.dart';
import 'package:wqhub/game_client/automatic_counting_info.dart';
import 'package:wqhub/game_client/counting_result.dart';
import 'package:wqhub/game_client/game.dart';
import 'package:wqhub/game_client/game_result.dart';
import 'package:wqhub/game_client/ogs/game_utils.dart';
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
  final bool _freeHandicapPlacement;
  late final StreamController<wq.Move?> _moveController;
  late final StreamController<CountingResult> _countingResultController;
  late final StreamController<bool> _countingResultResponsesController;
  late final Completer<GameResult> _resultCompleter;
  StreamSubscription<Map<String, dynamic>>? _messageSubscription;

  // Track all moves played in the game for board state reconstruction
  final List<wq.Move> _allMoves = [];

  // Track stone removal proposals from our opponent or server
  String _recentlyRemovedStonesString = '';

  // Track current phase to detect transitions
  String _currentPhase = "play";

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
    required bool freeHandicapPlacement,
  })  : _webSocketManager = webSocketManager,
        _myUserId = myUserId,
        _freeHandicapPlacement = freeHandicapPlacement {
    _logger.info('Initialized OGSGame with id: $id');
    _moveController = StreamController<wq.Move?>.broadcast();
    _countingResultController = StreamController<CountingResult>.broadcast();
    _countingResultResponsesController = StreamController<bool>.broadcast();
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

  Future<void> toggleManuallyRemovedStones(
      List<wq.Point> stones, bool removed) async {
    if (_currentPhase != 'stone removal') {
      _logger.warning(
          'toggleManuallyRemovedStones called outside of stone removal phase');
      return;
    }

    try {
      final stonesString = stones.map((point) => point.toSgf()).join();

      _webSocketManager.send('game/removed_stones/set', {
        'game_id': int.parse(id),
        'stones': stonesString,
        'removed': removed,
      });

      _logger.fine(
          'Sent stone removal proposal for game $id: stones=$stonesString, removed=$removed');
    } catch (error) {
      _logger.warning(
          'Failed to send stone removal proposal for game $id: $error');
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
  Stream<bool> countingResultResponses() =>
      _countingResultResponsesController.stream;

  @override
  Stream<CountingResult> countingResults() => _countingResultController.stream;

  @override
  Future<void> forceCounting() => Future.value();

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

  @override
  Future<void> resign() async {
    try {
      _webSocketManager.send('game/resign', {
        'game_id': int.parse(id),
      });
    } catch (error) {
      _logger.warning('Failed to send resignation for game $id: $error');
      rethrow;
    }
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

    if (event == 'chat-join' || event == 'chat-part') {
      _handleChatPresence(message);
      return;
    }

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

      case 'removed_stones':
        _handleRemovedStonesSet(message['data'] as Map<String, dynamic>);

      case 'move':
        _handleMove(message['data'] as Map<String, dynamic>);

      case 'clock':
        _handleClock(message['data'] as Map<String, dynamic>);

      case 'phase':
        _handlePhase(message['data']);

      default:
        _logger.fine('Unhandled game event for game $id: $suffix');
    }
  }

  void _handleError(dynamic data) {
    _logger.warning('Error received for game $id: $data');
  }

  void _handleChatPresence(Map<String, dynamic> message) {
    final event = message['event'] as String;
    final data = message['data'] as Map<String, dynamic>;
    final channel = data['channel'] as String;

    if (channel != 'game-$id') {
      return;
    }

    if (event == 'chat-join') {
      final users = data['users'] as List<dynamic>;
      for (final user in users) {
        final userId = user['id'].toString();
        _logger.fine('User $userId joined game-$id chat');

        _updatePlayerOnlineStatus(userId, true);
      }
    } else if (event == 'chat-part') {
      final user = data['user'] as Map<String, dynamic>;
      final userId = user['id'].toString();
      _logger.fine('User $userId left game-$id chat');

      _updatePlayerOnlineStatus(userId, false);
    }
  }

  void _updatePlayerOnlineStatus(String userId, bool isOnline) {
    if (black.value.userId == userId && black.value.online != isOnline) {
      black.value = black.value.copyWith(online: isOnline);
      _logger.fine('Updated black player presence: $isOnline');
    }

    if (white.value.userId == userId && white.value.online != isOnline) {
      white.value = white.value.copyWith(online: isOnline);
      _logger.fine('Updated white player presence: $isOnline');
    }
  }

  void _handleMove(Map<String, dynamic> data) {
    final gameId = data['game_id'] as int;
    final moveNumber = data['move_number'] as int;
    final moveData = data['move'] as dynamic;

    _logger.fine(
        'Received move: game_id=$gameId, move_number=$moveNumber, move=$moveData');

    final color = colorToMove(
        // move number from the server is 1-indexed
        moveNumber - 1,
        handicap: handicap,
        freeHandicapPlacement: _freeHandicapPlacement);

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

      // Check for phase changes
      final phase = gameData['phase'] as String;
      _updatePhase(phase);

      if (phase == 'finished' && !_resultCompleter.isCompleted) {
        // Update game result if the game has ended
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

      // Signal that opponent accepted the counting result
      _countingResultResponsesController.add(true);
    } catch (error) {
      _logger.warning(
          'Error handling removed stones accepted for game $id: $error');
    }
  }

  void _handleRemovedStonesSet(Map<String, dynamic> data) {
    _logger.fine('Received removed stones set for game $id');

    try {
      _recentlyRemovedStonesString = data['stones'] as String? ?? '';
      final countingResult = _calculateCountingResultFromOwnership(data);
      _countingResultController.add(countingResult);
    } catch (error) {
      _logger.warning('Error handling removed stones set for game $id: $error');
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

  void _handlePhase(dynamic data) {
    _logger.fine('Received phase message for game $id: $data');

    try {
      final phase = data as String;
      _updatePhase(phase);
    } catch (error) {
      _logger.warning('Error handling phase message for game $id: $error');
    }
  }

  void _updatePhase(String phase) {
    if (phase != _currentPhase) {
      if (_currentPhase == 'stone removal' && phase == 'play') {
        // Transition from counting/stone removal back to play - this indicates
        // that one of the players sent the game/removed_stones/reject message
        _countingResultResponsesController.add(false);
      }
      _currentPhase = phase;
      _logger.fine('Phase changed to: $phase');
    }
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
      isFinal: false,
    );
  }

  void dispose() {
    _messageSubscription?.cancel();
    _webSocketManager.leaveGame(id);
    _moveController.close();
    _countingResultController.close();
    _countingResultResponsesController.close();

    // Complete the result future if not already completed
    if (!_resultCompleter.isCompleted) {
      _resultCompleter.completeError('Game disposed before completion');
    }
  }

  @override
  Future<GameResult> result() => _resultCompleter.future;
}
