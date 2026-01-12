import 'dart:async';

import 'package:wqhub/board/board_state.dart';
import 'package:wqhub/game_client/automatic_counting_info.dart';
import 'package:wqhub/game_client/counting_result.dart';
import 'package:wqhub/game_client/game.dart';
import 'package:wqhub/game_client/game_result.dart';
import 'package:wqhub/game_client/game_timer.dart';
import 'package:wqhub/game_client/ogs/chat_presence_manager.dart';
import 'package:wqhub/game_client/ogs/http_client.dart';
import 'package:wqhub/game_client/ogs/game_utils.dart';
import 'package:wqhub/game_client/ogs/ogs_websocket_manager.dart';
import 'package:wqhub/game_client/rules.dart';
import 'package:wqhub/game_client/time_state.dart';
import 'package:wqhub/game_client/user_info.dart';
import 'package:wqhub/wq/grid.dart';
import 'package:wqhub/wq/rank.dart';
import 'package:wqhub/wq/util.dart';
import 'package:wqhub/wq/wq.dart' as wq;
import 'package:logging/logging.dart';

class OGSGame extends Game {
  final Logger _logger = Logger('OGSGame');
  final OGSWebSocketManager _webSocketManager;
  final String _myUserId;
  final String _jwtToken;
  final HttpClient _aiHttpClient;
  final bool _freeHandicapPlacement;
  late final StreamController<wq.Move?> _moveController;
  late final StreamController<CountingResult> _countingResultController;
  late final StreamController<bool> _countingResultResponsesController;
  late final Completer<GameResult> _resultCompleter;
  StreamSubscription<Map<String, dynamic>>? _messageSubscription;
  late final ChatPresenceManager _chatPresenceManager;
  StreamSubscription<Set<String>>? _presenceSubscription;

  // Game timers for local countdown
  late final GameTimer _blackTimer;
  late final GameTimer _whiteTimer;

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
    required String jwtToken,
    required String aiServerUrl,
    required bool freeHandicapPlacement,
  })  : _webSocketManager = webSocketManager,
        _myUserId = myUserId,
        _jwtToken = jwtToken,
        _aiHttpClient =
            HttpClient(serverUrl: aiServerUrl, defaultApiVersion: null),
        _freeHandicapPlacement = freeHandicapPlacement {
    _logger.info('Initialized OGSGame with id: $id');
    _moveController = StreamController<wq.Move?>.broadcast();
    _countingResultController = StreamController<CountingResult>.broadcast();
    _countingResultResponsesController = StreamController<bool>.broadcast();
    _resultCompleter = Completer<GameResult>();

    _allMoves.addAll(previousMoves);

    final initialTimeState = TimeState(
      mainTimeLeft: timeControl.mainTime,
      periodTimeLeft: timeControl.timePerPeriod,
      periodCount: timeControl.periodCount,
    );
    _blackTimer = GameTimer(initialState: initialTimeState);
    _whiteTimer = GameTimer(initialState: initialTimeState);

    _blackTimer.addListener(() {
      blackTime.value = _blackTimer.value;
    });
    _whiteTimer.addListener(() {
      whiteTime.value = _whiteTimer.value;
    });

    // Initialize chat presence manager - this will auto-join the chat channel
    _chatPresenceManager = ChatPresenceManager(
      channel: 'game-$id',
      webSocketManager: _webSocketManager,
    );
    _presenceSubscription =
        _chatPresenceManager.presenceUpdates.listen(_handlePresenceUpdate);

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

  void _handlePresenceUpdate(Set<String> presentUsers) {
    _logger.fine('Presence update: ${presentUsers.length} users present');

    final blackUserId = black.value.userId;
    final whiteUserId = white.value.userId;

    final blackOnline = presentUsers.contains(blackUserId);
    final whiteOnline = presentUsers.contains(whiteUserId);

    if (black.value.online != blackOnline) {
      black.value = black.value.copyWith(online: blackOnline);
      _logger.fine('Updated black player presence: $blackOnline');
    }

    if (white.value.online != whiteOnline) {
      white.value = white.value.copyWith(online: whiteOnline);
      _logger.fine('Updated white player presence: $whiteOnline');
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
      online: _chatPresenceManager.isPresent(userId),
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

    return GameResult(
      winner: winner,
      result: formatGameResult(winner, outcome),
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
      _recentlyRemovedStonesString = data['all_removed'] as String? ?? '';
      final countingResult = _calculateCountingResultFromOwnership(data);
      _countingResultController.add(countingResult);
    } catch (error) {
      _logger.warning('Error handling removed stones set for game $id: $error');
    }
  }

  void _handleClock(Map<String, dynamic> data) {
    _logger.fine('Received clock update for game $id');

    // If the game has already ended, stop both timers and ignore clock updates
    if (_resultCompleter.isCompleted) {
      _blackTimer.stop();
      _whiteTimer.stop();
      _logger.fine('Ignoring clock update for completed game $id');
      return;
    }

    try {
      final blackTimeData = data['black_time'] as Map<String, dynamic>?;
      final whiteTimeData = data['white_time'] as Map<String, dynamic>?;
      final currentPlayer = data['current_player'] as int?;

      void updatePlayerTimer(
        Map<String, dynamic>? timeData,
        GameTimer timer,
        String playerId,
      ) {
        if (timeData != null) {
          final newState = _parseOGSTimeData(timeData);
          final isPlayerTurn = currentPlayer == int.tryParse(playerId);

          if (isPlayerTurn) {
            timer.start(newState);
          } else {
            timer.stop();
            timer.value = (timer.value.$1 + 1, newState);
          }
        }
      }

      updatePlayerTimer(blackTimeData, _blackTimer, black.value.userId);
      updatePlayerTimer(whiteTimeData, _whiteTimer, white.value.userId);

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
      } else if (_currentPhase == 'play' && phase == 'stone removal') {
        // Transition from play to stone removal - call AI server for auto-scoring
        _setAIRemovedStones();
      }
      _currentPhase = phase;
      _logger.fine('Phase changed to: $phase');
    }
  }

  /// Calculate territory ownership and score from OGS ownership data
  CountingResult _calculateCountingResultFromOwnership(
      Map<String, dynamic> data) {
    _logger.fine('Calculating area ownership from OGS territory data');

    final ownershipData = data['ownership'] as List<dynamic>;

    // First create ownership grid from OGS territory data
    final ownership = generate2D<wq.Color?>(boardSize, (i, j) {
      final value = (ownershipData[i] as List<dynamic>)[j] as int;
      return switch (value) {
        -1 => wq.Color.white,
        1 => wq.Color.black,
        _ => null,
      };
    });

    // Parse removed stones from the message
    final allRemovedString = data['all_removed'] as String? ?? '';
    final removedStones = parseStonesString(allRemovedString).toSet();

    _logger.fine(
        'Removed stones from message: $allRemovedString -> ${removedStones.length} stones');

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

    // Ensure living stones are marked as owned by their respective colors
    _ensureLivingStonesMarkedInOwnership(ownership, removedStones);

    _logger.fine(
        'Score from ownership: Black=$blackScore (area: $blackTerritory, captures: $whiteCaptures), '
        'White=$whiteScore (area: $whiteTerritory, captures: $blackCaptures, komi: $komi)');
    _logger.fine('Winner: $winner, Lead: $scoreLead');

    return CountingResult(
      winner: winner,
      scoreLead: scoreLead,
      ownership: ownership,
      isFinal: false,
    );
  }

  /// Convert current game state to 2D array format expected by AI server
  /// 0 = empty, 1 = black, 2 = white
  List<List<int>> _getCurrentBoardStateForAIServer() {
    final boardState = BoardState(size: boardSize);

    // Replay all moves to get current board state
    for (final move in _allMoves) {
      boardState.move(move);
    }

    final board = generate2D<int>(
        boardSize,
        (row, col) => switch (boardState[(row, col)]) {
              null => 0,
              wq.Color.black => 1,
              wq.Color.white => 2,
            });

    return board;
  }

  /// Gives the rules string expected by OGS APIs
  String _rulesToOgsString(Rules rules) => switch (rules) {
        Rules.chinese => 'chinese',
        Rules.japanese => 'japanese',
        Rules.korean => 'korean',
      };

  /// Gets a score evaluation from the server
  Future<Map<String, dynamic>?> _callAIServer(
      List<List<int>> boardState, String playerToMove) async {
    _logger.fine('Calling AI server for game $id');

    final payload = {
      'player_to_move': playerToMove,
      'width': boardSize,
      'height': boardSize,
      'rules': _rulesToOgsString(rules),
      'board_state': boardState,
      'autoscore': true,
      'jwt': _jwtToken,
    };

    try {
      final responseData = await _aiHttpClient.postJson('/score', payload);
      _logger.fine('AI server response received for game $id');
      return responseData;
    } catch (e) {
      _logger.warning('AI server request failed for game $id: $e');
      return null;
    }
  }

  Future<void> _setAIRemovedStones() async {
    _logger.fine('Requesting AI server analysis for game $id');

    // Get current board state and determine whose turn it is
    final boardState = _getCurrentBoardStateForAIServer();
    final playerToMove = myColor == wq.Color.black ? 'black' : 'white';

    // Call AI server
    final aiResponse = await _callAIServer(boardState, playerToMove);

    if (aiResponse == null) {
      _logger.warning('AI server returned null response for game $id');
      return;
    }

    _logger.fine('Sending removed stones from AI server for game $id');

    // Extract removed stones from AI response
    final removedStones =
        aiResponse['autoscored_removed'] as List<dynamic>? ?? [];

    // Convert AI response format to OGS stones string format
    // AI returns: [{"x":7,"y":2,"removal_reason":"..."}]
    final stonesList = <String>[];
    for (final stone in removedStones) {
      if (stone is Map<String, dynamic>) {
        final x = stone['x'] as int?;
        final y = stone['y'] as int?;
        if (x != null && y != null) {
          // Convert to SGF coordinate format
          final point =
              (y, x); // Note: AI response uses (x,y) but our Point is (row,col)
          stonesList.add(point.toSgf());
        }
      }
    }

    final stonesString = stonesList.join('');

    // Sending two set messages is a bit strange, but it's the only way to reset
    // the board.  Compare with OGS code:
    // https://github.com/online-go/goban/blob/097d741f092387a2067ac40357e566038c3453ee/src/Goban/OGSConnectivity.ts#L1431-L1442
    // The first message clears any previously staged removed stones
    _webSocketManager.send('game/removed_stones/set', {
      'game_id': int.parse(id),
      'removed': false,
      'stones': _recentlyRemovedStonesString,
    });
    // The second message sends the new set of removed stones
    _webSocketManager.send('game/removed_stones/set', {
      'game_id': int.parse(id),
      'removed': true,
      'stones': stonesString,
    });
    _logger.fine('Sent removed stones to server for game $id: $stonesString');
  }

  /// Ensures that living stones are marked as owned by their respective colors in the ownership grid.
  ///
  /// OGS ownership may represent territory (stones are neutral) or area, depending on ruleset.
  /// WQHub ownership expects ownership to represent area regardless (stones belong to their color).
  void _ensureLivingStonesMarkedInOwnership(
      List<List<wq.Color?>> ownership, Set<wq.Point> deadStones) {
    // Reconstruct the current board state to identify living stones
    final currentBoardState = BoardState(size: boardSize);
    for (final move in _allMoves) {
      currentBoardState.move(move);
    }

    // Mark living stones as owned by their respective colors
    for (int i = 0; i < boardSize; i++) {
      for (int j = 0; j < boardSize; j++) {
        final point = (i, j);
        final stoneColor = currentBoardState[point];
        if (stoneColor != null && !deadStones.contains(point)) {
          // This point has a living stone (not removed), mark it as owned by the stone's color
          ownership[i][j] = stoneColor;
        }
      }
    }
  }

  void dispose() {
    _messageSubscription?.cancel();
    _presenceSubscription?.cancel();
    _blackTimer.dispose();
    _whiteTimer.dispose();
    _chatPresenceManager.dispose();
    _webSocketManager.leaveGame(id);
    _moveController.close();
    _countingResultController.close();
    _countingResultResponsesController.close();
    _aiHttpClient.dispose();

    // Complete the result future if not already completed
    if (!_resultCompleter.isCompleted) {
      _resultCompleter.completeError('Game disposed before completion');
    }
  }

  @override
  Future<GameResult> result() => _resultCompleter.future;
}
