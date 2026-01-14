@Tags(['integration'])
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:wqhub/game_client/ogs/ogs_game_client.dart';

void main() {
  group('GameClient logout integration tests', () {
    // This test uses the actual OGS beta server to catch real-world crashes
    // that mocks might not reveal.
    //
    // To run these integration tests:
    // OGS_TEST_USERNAME=your_username OGS_TEST_PASSWORD=your_password flutter test --tags=integration
    const serverUrl = 'https://beta.online-go.com';
    const aiServerUrl = 'https://beta-ai.online-go.com';

    (String, String) getCredentials() {
      final username = Platform.environment['OGS_TEST_USERNAME'];
      final password = Platform.environment['OGS_TEST_PASSWORD'];

      if (username == null || password == null) {
        fail(
            'OGS_TEST_USERNAME and OGS_TEST_PASSWORD environment variables must be set');
      }

      return (username, password);
    }

    test('logout should properly clean up and allow subsequent login',
        () async {
      final (testUsername, testPassword) = getCredentials();

      final gameClient = OGSGameClient(
        serverUrl: serverUrl,
        aiServerUrl: aiServerUrl,
      );

      try {
        final userInfo = await gameClient.login(testUsername, testPassword);
        expect(userInfo.username, testUsername);
        expect(gameClient.userInfo.value, isNotNull);

        await Future.delayed(Duration(milliseconds: 500));

        gameClient.logout();

        await Future.delayed(Duration(milliseconds: 500));

        expect(gameClient.userInfo.value, isNull);

        final userInfo2 = await gameClient.login(testUsername, testPassword);
        expect(userInfo2.username, testUsername);
        expect(gameClient.userInfo.value, isNotNull);

        gameClient.logout();
        await Future.delayed(Duration(milliseconds: 500));
      } finally {
        gameClient.dispose();
      }
    }, timeout: Timeout(Duration(seconds: 30)));

    test('logout should prevent WebSocket auto-reconnect', () async {
      final (testUsername, testPassword) = getCredentials();

      final gameClient = OGSGameClient(
        serverUrl: serverUrl,
        aiServerUrl: aiServerUrl,
      );

      try {
        await gameClient.login(testUsername, testPassword);
        await Future.delayed(Duration(milliseconds: 500));

        int disconnectCount = 0;
        void countDisconnects() {
          disconnectCount++;
        }

        gameClient.disconnected.addListener(countDisconnects);

        gameClient.logout();

        await Future.delayed(Duration(seconds: 3));

        expect(disconnectCount, equals(1),
            reason: 'Should only disconnect once, not auto-reconnect');

        gameClient.disconnected.removeListener(countDisconnects);
      } finally {
        gameClient.dispose();
      }
    }, timeout: Timeout(Duration(seconds: 10)));
  });
}
