import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:wqhub/p2p_battle/p2p_models.dart';

class P2PClient {
  final String serverUrl;
  WebSocketChannel? _channel;
  Function(P2PState)? onStateUpdate;
  Function(DateTime startTime, DateTime serverTime)? onBattleStarted;
  Function()? onBattleFinished;
  Function(P2PChatMessage)? onChatMessage;
  Function()? onKicked;
  Function()? onBattleRestarted;
  Function(dynamic)? onError;

  P2PClient(String url)
      : serverUrl = url.endsWith('/') ? url.substring(0, url.length - 1) : url;

  static Future<String> createRoom(String serverUrl) async {
    final normalizedUrl = serverUrl.endsWith('/')
        ? serverUrl.substring(0, serverUrl.length - 1)
        : serverUrl;
    final response = await http.post(Uri.parse('$normalizedUrl/create'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['roomId'];
    }
    throw Exception(
        'Failed to create room. Status: ${response.statusCode}. Body: ${response.body}');
  }

  void joinRoom(String roomId, String playerName) {
    try {
      final baseUri = Uri.parse(serverUrl);
      final wsScheme = baseUri.scheme == 'https' ? 'wss' : 'ws';
      final wsUri = baseUri.replace(
        scheme: wsScheme,
        path: baseUri.path.endsWith('/')
            ? '${baseUri.path}room/$roomId'
            : '${baseUri.path}/room/$roomId',
        queryParameters: {
          ...baseUri.queryParameters,
          'name': playerName,
        },
      );
      _channel = WebSocketChannel.connect(wsUri);

      _channel!.stream.listen((message) {
        final data = jsonDecode(message);
        switch (data['type']) {
          case 'STATE_UPDATE':
            onStateUpdate?.call(P2PState.fromJson(data));
            break;
          case 'BATTLE_STARTED':
            onBattleStarted?.call(
              DateTime.fromMillisecondsSinceEpoch(data['startTime']),
              DateTime.fromMillisecondsSinceEpoch(data['serverTime']),
            );
            break;
          case 'BATTLE_FINISHED':
            onBattleFinished?.call();
            break;
          case 'CHAT_MESSAGE':
            onChatMessage?.call(P2PChatMessage.fromJson(data));
            break;
          case 'KICKED':
            onKicked?.call();
            break;
          case 'BATTLE_RESTARTED':
            onBattleRestarted?.call();
            break;
        }
      }, onError: (error) {
        print('P2P WebSocket Error: $error');
        onError?.call(error);
      }, onDone: () {
        print('P2P WebSocket Closed');
      });
    } catch (e) {
      print('P2P Join Room Exception: $e');
      onError?.call(e);
    }
  }

  void setupTasks(P2PRoomSettings settings) {
    _channel?.sink.add(jsonEncode({
      'type': 'SETUP',
      'settings': settings.toJson(),
    }));
  }

  void setReady(bool ready) {
    _channel?.sink.add(jsonEncode({
      'type': 'READY',
      'ready': ready,
    }));
  }

  void startBattle() {
    _channel?.sink.add(jsonEncode({
      'type': 'START',
    }));
  }

  void requestState() {
    _channel?.sink.add(jsonEncode({
      'type': 'REQUEST_STATE',
    }));
  }

  void submitResults(Map<String, dynamic> results) {
    _channel?.sink.add(jsonEncode({
      'type': 'SUBMIT_RESULTS',
      'results': results,
    }));
  }

  void sendChat(String text) {
    _channel?.sink.add(jsonEncode({
      'type': 'CHAT',
      'text': text,
    }));
  }

  void kickPlayer(String playerName) {
    _channel?.sink.add(jsonEncode({
      'type': 'KICK',
      'playerName': playerName,
    }));
  }

  void restartBattle() {
    _channel?.sink.add(jsonEncode({
      'type': 'RESTART',
    }));
  }

  void disconnect() {
    _channel?.sink.close();
  }
}
