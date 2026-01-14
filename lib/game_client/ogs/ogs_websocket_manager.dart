import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:stream_channel/stream_channel.dart';

class OGSWebSocketManager {
  final _log = Logger('OGSWebSocketManager');

  StreamChannel? _channel;
  final String serverUrl;
  final StreamChannel Function(Uri) createChannel;
  String? _deviceId;

  final ValueNotifier<bool> _connected = ValueNotifier(false);
  final StreamController<Map<String, dynamic>> _messageController =
      StreamController<Map<String, dynamic>>.broadcast();

  Timer? _pingTimer;
  Timer? _reconnectTimer;
  int _reconnectAttempts = 0;
  static const int maxReconnectAttempts = 10;
  bool _shouldReconnect = true;

  // For latency tracking
  double _latency = 0.0;
  double _clockDrift = 0.0;

  // For request/response tracking
  int _lastRequestId = 0;
  final Map<int, Completer<dynamic>> _pendingRequests = {};

  OGSWebSocketManager({
    required this.serverUrl,
    this.createChannel = WebSocketChannel.connect,
  }) {
    _generateDeviceId();
  }

  ValueNotifier<bool> get connected => _connected;
  Stream<Map<String, dynamic>> get messages => _messageController.stream;

  void _generateDeviceId() {
    // Generate a proper UUID for device ID like OGS frontend
    const uuid = Uuid();
    _deviceId = uuid.v4();
  }

  Future<void> connect() async {
    if (_channel != null) {
      await disconnect();
    }

    _shouldReconnect = true;
    try {
      // Convert HTTP(S) URL to WebSocket URL
      final wsUrl = serverUrl
          .replaceFirst('https://', 'wss://')
          .replaceFirst('http://', 'ws://');

      _log.fine('Connecting to OGS WebSocket: $wsUrl');

      _channel = createChannel(Uri.parse(wsUrl));

      _channel!.stream.listen(
        _handleMessage,
        onError: _handleError,
        onDone: _handleDisconnect,
      );

      _connected.value = true;
      _reconnectAttempts = 0;

      // Start ping timer
      _startPingTimer();

      _log.fine('Connected to OGS WebSocket');
    } catch (e) {
      _log.warning('Failed to connect to OGS WebSocket: $e');
      _scheduleReconnect();
    }
  }

  Future<void> disconnect() async {
    _shouldReconnect = false;
    _pingTimer?.cancel();
    _reconnectTimer?.cancel();

    _rejectPendingRequests();

    if (_channel != null) {
      // Check if this is a WebSocketChannel and close with proper code
      if (_channel is WebSocketChannel) {
        await (_channel as WebSocketChannel).sink.close(status.normalClosure);
      } else {
        // For generic StreamChannel (like in tests), just close normally
        await _channel!.sink.close();
      }
      _channel = null;
    }

    _connected.value = false;
  }

  Future<void> authenticate({required String jwtToken}) async {
    if (_channel != null && _connected.value) {
      final authData = {
        'jwt': jwtToken,
        'device_id': _deviceId,
        'user_agent': 'WeiqiHub/1.0',
        'language': 'en',
        'language_version': '1.0',
        'client_version': '1.0',
      };

      send('authenticate', authData);
      _log.fine('Sent authentication message');
    }
  }

  /// Send a fire-and-forget message (no response expected)
  void send(String command, [Map<String, dynamic>? data]) {
    if (_channel != null && _connected.value) {
      // OGS uses JSON array format: [command] or [command, data]
      final message = data != null ? [command, data] : [command];
      final messageStr = jsonEncode(message);
      _channel!.sink.add(messageStr);
      _log.fine('Sent: $messageStr');
    } else {
      _log.warning('Cannot send message: WebSocket not connected');
    }
  }

  /// Send a message and return a Future that completes when the server responds
  Future<dynamic> sendAndGetResponse(String command,
      [Map<String, dynamic>? data]) {
    final completer = Completer<dynamic>();

    if (_channel != null && _connected.value) {
      final requestId = ++_lastRequestId;
      _pendingRequests[requestId] = completer;

      final message = [command, data, requestId];
      final messageStr = jsonEncode(message);
      _channel!.sink.add(messageStr);
      _log.fine('Sent with response expected: $messageStr');
    } else {
      completer.completeError(StateError('WebSocket not connected'));
    }

    return completer.future;
  }

  void joinGame(String gameId) {
    send('game/connect', {'game_id': int.parse(gameId)});
    _log.fine('Joining game: $gameId');
  }

  void leaveGame(String gameId) {
    send('game/disconnect', {'game_id': int.parse(gameId)});
    _log.fine('Leaving game: $gameId');
  }

  void _handleMessage(dynamic message) {
    try {
      final String messageStr = message.toString();
      _log.fine('Received: $messageStr');

      // Parse JSON message - OGS uses plain JSON arrays
      final data = jsonDecode(messageStr);

      if (data is List && data.isNotEmpty) {
        final commandOrId = data[0];
        final payload = data.length > 1 ? data[1] : null;

        // Check if this is a response to a request (first element is numeric request ID)
        // This matches the OGS pattern: [requestId, responseData, errorData]
        if (commandOrId is int) {
          final requestId = commandOrId;
          final error = data.length > 2 ? data[2] : null;

          _log.fine('Handling response for request ID: $requestId');

          // Handle promise-based requests
          final completer = _pendingRequests.remove(requestId);
          if (completer != null) {
            if (error != null) {
              completer.completeError(error);
            } else {
              completer.complete(payload);
            }
          } else {
            _log.warning(
                'Received response for unknown request ID: $requestId');
          }

          return;
        }

        // Handle regular events (first element is string command)
        // Format: [command, data]
        final command = commandOrId as String;

        // Handle special ping/pong messages
        if (command == 'net/pong' && payload is Map<String, dynamic>) {
          _handlePong(payload);
          return;
        }

        // Emit the message to listeners
        _messageController.add({
          'event': command,
          'data': payload,
        });
      }
    } catch (e) {
      _log.warning('Error parsing message \'$message\': $e');
    }
  }

  void _handlePong(Map<String, dynamic> pongData) {
    if (pongData.containsKey('client') && pongData.containsKey('server')) {
      final now = DateTime.now().millisecondsSinceEpoch;
      final clientTime = pongData['client'] as int;
      final serverTime = pongData['server'] as int;

      _latency = (now - clientTime).toDouble();
      _clockDrift = now - _latency / 2 - serverTime;

      _log.fine('Latency: ${_latency}ms, Clock drift: ${_clockDrift}ms');
    }
  }

  void _handleError(error) {
    _log.warning('WebSocket error: $error');
    _connected.value = false;
    _scheduleReconnect();
  }

  void _handleDisconnect() {
    _log.info('WebSocket disconnected');
    _connected.value = false;
    if (_shouldReconnect) {
      _scheduleReconnect();
    }
  }

  void _startPingTimer() {
    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (_channel != null && _connected.value) {
        // Send ping in OGS format
        final pingData = {
          'client': DateTime.now().millisecondsSinceEpoch,
          'drift': _clockDrift,
          'latency': _latency,
        };
        send('net/ping', pingData);
        _log.fine('Sent ping');
      }
    });
  }

  void _scheduleReconnect() {
    if (_reconnectAttempts >= maxReconnectAttempts) {
      _log.warning('Max reconnection attempts reached');
      return;
    }

    _rejectPendingRequests();

    _reconnectTimer?.cancel();
    final delay = Duration(
        seconds: math.min(30, math.pow(2, _reconnectAttempts).toInt()));

    _log.info(
        'Scheduling reconnect in ${delay.inSeconds} seconds (attempt ${_reconnectAttempts + 1})');

    _reconnectTimer = Timer(delay, () {
      _reconnectAttempts++;
      connect();
    });
  }

  void _rejectPendingRequests() {
    // Reject all pending promises
    for (final completer in _pendingRequests.values) {
      if (!completer.isCompleted) {
        completer.completeError(StateError('WebSocket connection lost'));
      }
    }
    _pendingRequests.clear();
  }

  void dispose() {
    _pingTimer?.cancel();
    _reconnectTimer?.cancel();
    _rejectPendingRequests();
    _messageController.close();
    _connected.dispose();
    disconnect();
  }
}
