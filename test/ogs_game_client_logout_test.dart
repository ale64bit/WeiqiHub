import 'package:flutter_test/flutter_test.dart';
import 'package:wqhub/game_client/ogs/ogs_game_client.dart';

void main() {
  group('GameClient logout integration tests', () {
    // This test uses the actual OGS beta server to catch real-world crashes
    // that mocks might not reveal.  It's a slower test so we mark it as skipped.
    //
    // IMPORTANT: Skipped by default to avoid rate limiting.
    // Run with: flutter test --run-skipped test/ogs_game_client_logout_test.dart
    const testUsername = 'asdf';
    const testPassword = 'asdf';

    test('logout should properly clean up and allow subsequent login',
        () async {
      final gameClient = OGSGameClient(
        serverUrl: 'https://beta.online-go.com',
        aiServerUrl: 'https://beta-ai.online-go.com',
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
  });
}
