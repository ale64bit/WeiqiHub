import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:stream_channel/stream_channel.dart';
import 'package:wqhub/game_client/ogs/ogs_websocket_manager.dart';

void main() {
  group('OGSWebSocketManager sendAndGetResponse', () {
    test('success case - server responds with data', () async {
      // Create StreamControllers for bidirectional communication
      final serverToClient = StreamController<dynamic>();
      final clientToServer = StreamController<dynamic>();

      // Create a StreamChannel using the controllers
      final mockChannel =
          StreamChannel(serverToClient.stream, clientToServer.sink);

      // Create the manager and set the mock channel
      final manager = OGSWebSocketManager(serverUrl: 'wss://online-go.com');
      manager.setChannel(mockChannel);

      // Arrange
      const command = 'test/command';
      final data = {'test': 'data'};
      final expectedResponse = {'result': 'success', 'value': 42};

      // Start the request
      final responseFuture = manager.sendAndGetResponse(command, data);

      // Capture the sent message and extract request ID
      final sentMessage = await clientToServer.stream.first;
      final sentData = jsonDecode(sentMessage.toString());
      final requestId = sentData[2] as int;

      // Simulate server response - OGS format: [requestId, responseData, null]
      final serverResponse = [requestId, expectedResponse, null];
      serverToClient.add(jsonEncode(serverResponse));

      // Assert
      expect(await responseFuture, expectedResponse);

      // Clean up
      await manager.disconnect();
      await serverToClient.close();
      await clientToServer.close();
      manager.dispose();
    });

    test('error case - server responds with error', () async {
      // Create StreamControllers for bidirectional communication
      final serverToClient = StreamController<dynamic>();
      final clientToServer = StreamController<dynamic>();

      // Create a StreamChannel using the controllers
      final mockChannel =
          StreamChannel(serverToClient.stream, clientToServer.sink);

      // Create the manager and set the mock channel
      final manager = OGSWebSocketManager(serverUrl: 'wss://online-go.com');
      manager.setChannel(mockChannel);

      // Arrange
      const command = 'invalid/command';
      final data = {'invalid': 'data'};
      final expectedError = 'Command not found';

      // Start the request
      final responseFuture = manager.sendAndGetResponse(command, data);

      // Capture the sent message and extract request ID
      final sentMessage = await clientToServer.stream.first;
      final sentData = jsonDecode(sentMessage.toString());
      final requestId = sentData[2] as int;

      // Simulate server error response
      final serverResponse = [requestId, null, expectedError];
      serverToClient.add(jsonEncode(serverResponse));

      // Assert
      await expectLater(responseFuture, throwsA(equals(expectedError)));

      // Clean up
      await manager.disconnect();
      await serverToClient.close();
      await clientToServer.close();
      manager.dispose();
    });
  });
}
