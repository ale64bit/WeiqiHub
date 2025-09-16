import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class OGSWebSocketManager {
  final _log = Logger('OGSWebSocketManager');

  WebSocketChannel? _channel;
  final String serverUrl;
  String? _deviceId;
  
  final ValueNotifier<bool> _connected = ValueNotifier(false);
  final StreamController<Map<String, dynamic>> _messageController = 
      StreamController<Map<String, dynamic>>.broadcast();
  
  Timer? _pingTimer;
  Timer? _reconnectTimer;
  int _reconnectAttempts = 0;
  static const int maxReconnectAttempts = 10;
  
  // For latency tracking
  double _latency = 0.0;
  double _clockDrift = 0.0;
  
  OGSWebSocketManager({required this.serverUrl}) {
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
    
    try {
      // Convert HTTP(S) URL to WebSocket URL
      final wsUrl = serverUrl
          .replaceFirst('https://', 'wss://')
          .replaceFirst('http://', 'ws://');
      
      _log.fine('Connecting to OGS WebSocket: $wsUrl');
      
      _channel = WebSocketChannel.connect(Uri.parse(wsUrl));
      
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
    _pingTimer?.cancel();
    _reconnectTimer?.cancel();
    
    if (_channel != null) {
      await _channel!.sink.close(status.goingAway);
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
  
  void send(String command, [Map<String, dynamic>? data]) {
    if (_channel != null && _connected.value) {
      // OGS uses JSON array format: [command] or [command, data]
      final List<dynamic> message = data != null ? [command, data] : [command];
      final messageStr = jsonEncode(message);
      _channel!.sink.add(messageStr);
      _log.fine('Sent: $messageStr');
    } else {
      _log.warning('Cannot send message: WebSocket not connected');
    }
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
        final command = data[0] as String;
        final payload = data.length > 1 ? data[1] : null;
        final requestId = data.length > 2 ? data[2] : null;
        
        // Handle special ping/pong messages
        if (command == 'net/pong' && payload is Map<String, dynamic>) {
          _handlePong(payload);
          return;
        }
        
        // Emit the message to listeners
        _messageController.add({
          'event': command,
          'data': payload,
          'request_id': requestId,
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
    _scheduleReconnect();
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
    
    _reconnectTimer?.cancel();
    final delay = Duration(seconds: math.min(30, math.pow(2, _reconnectAttempts).toInt()));
    
    _log.info(
        'Scheduling reconnect in ${delay.inSeconds} seconds (attempt ${_reconnectAttempts + 1})');
    
    _reconnectTimer = Timer(delay, () {
      _reconnectAttempts++;
      connect();
    });
  }
  
  void dispose() {
    _pingTimer?.cancel();
    _reconnectTimer?.cancel();
    _messageController.close();
    _connected.dispose();
    disconnect();
  }
}
