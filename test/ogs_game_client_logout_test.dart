import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:wqhub/game_client/ogs/ogs_game_client.dart';

void main() {
  group('GameClient logout integration tests', () {
    // This test uses the actual OGS beta server to catch real-world crashes
    // that mocks might not reveal.  It's a slower test so we mark it as skipped.
    //
    // IMPORTANT: Skipped by default to avoid rate limiting.
    // Set credentials via environment variables:
    // OGS_TEST_USERNAME=your_username OGS_TEST_PASSWORD=your_password flutter test --run-skipped test/ogs_game_client_logout_test.dart
    final testUsername = Platform.environment['OGS_TEST_USERNAME'];
    final testPassword = Platform.environment['OGS_TEST_PASSWORD'];
    const serverUrl = 'https://beta.online-go.com';
    const aiServerUrl = 'https://beta-ai.online-go.com';

    if (testUsername == null || testPassword == null) {
      throw Exception(
          'OGS_TEST_USERNAME and OGS_TEST_PASSWORD environment variables must be set');
    }

    test('logout should properly clean up and allow subsequent login',
        () async {
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
    },
        timeout: Timeout(Duration(seconds: 30)),
        skip: 'Integration test - run manually with --run-skipped');

    test('logout should prevent WebSocket auto-reconnect', () async {
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
    },
        timeout: Timeout(Duration(seconds: 10)),
        skip: 'Integration test - run manually with --run-skipped');
  });
}
