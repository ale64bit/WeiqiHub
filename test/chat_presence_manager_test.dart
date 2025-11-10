import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:stream_channel/stream_channel.dart';
import 'package:wqhub/game_client/ogs/chat_presence_manager.dart';
import 'package:wqhub/game_client/ogs/ogs_websocket_manager.dart';

void main() {
  group('ChatPresenceManager', () {
    late StreamController<dynamic> serverToClient;
    late StreamController<dynamic> clientToServer;
    late OGSWebSocketManager webSocketManager;

    setUp(() async {
      serverToClient = StreamController<dynamic>();
      clientToServer = StreamController<dynamic>();

      final mockChannel =
          StreamChannel(serverToClient.stream, clientToServer.sink);

      webSocketManager = OGSWebSocketManager(
        serverUrl: 'wss://test',
        createChannel: (_) => mockChannel,
      );

      await webSocketManager.connect();
    });

    tearDown(() async {
      await webSocketManager.disconnect();
      await serverToClient.close();
      await clientToServer.close();
      webSocketManager.dispose();
    });

    test('auto-joins on construction and auto-leaves on disposal', () async {
      final manager = ChatPresenceManager(
        channel: 'game-123',
        webSocketManager: webSocketManager,
      );

      expect(manager.isPresent('user1'), false);

      // Should auto-leave on dispose
      manager.dispose();

      // Verify both messages were sent in order
      await expectLater(
        clientToServer.stream.map((msg) => jsonDecode(msg.toString())),
        emitsInOrder([
          predicate((List data) =>
              data[0] == 'chat/join' && data[1]['channel'] == 'game-123'),
          predicate((List data) =>
              data[0] == 'chat/part' && data[1]['channel'] == 'game-123'),
        ]),
      );
    });

    test('tracks users joining and leaving the channel', () async {
      clientToServer.stream.listen((_) {});

      final manager = ChatPresenceManager(
        channel: 'game-123',
        webSocketManager: webSocketManager,
      );

      // Users join
      serverToClient.add(jsonEncode([
        'chat-join',
        {
          'channel': 'game-123',
          'users': [
            {'id': 1, 'username': 'alice'},
            {'id': 2, 'username': 'bob'},
          ],
        }
      ]));

      // One user leaves
      serverToClient.add(jsonEncode([
        'chat-part',
        {
          'channel': 'game-123',
          'user': {'id': 1, 'username': 'alice'},
        }
      ]));

      // Verify presence updates
      await expectLater(
        manager.presenceUpdates,
        emitsInOrder([
          {'1', '2'},
          {'2'},
        ]),
      );

      expect(manager.isPresent('1'), false);
      expect(manager.isPresent('2'), true);

      manager.dispose();
    });
  });
}
