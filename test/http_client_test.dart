import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:wqhub/game_client/ogs/http_client.dart';

void main() {
  const serverUrl = 'https://online-go.com';

  group('HttpClient', () {
    test('builds URL from serverUrl + path', () async {
      Uri? capturedUri;
      final mockClient = MockClient((request) async {
        capturedUri = request.url;
        return http.Response('{}', 200);
      });

      final client = HttpClient(serverUrl: serverUrl, httpClient: mockClient);
      await client.getJson('/api/v1/games/123');

      expect(capturedUri.toString(), '$serverUrl/api/v1/games/123');
      client.dispose();
    });

    test('appends query parameters', () async {
      Uri? capturedUri;
      final mockClient = MockClient((request) async {
        capturedUri = request.url;
        return http.Response('{}', 200);
      });

      final client = HttpClient(serverUrl: serverUrl, httpClient: mockClient);
      await client.getJson('/api/v1/games', queryParameters: {'page': '1'});

      expect(capturedUri.toString(), '$serverUrl/api/v1/games?page=1');
      client.dispose();
    });

    test('getJson returns parsed JSON', () async {
      final mockClient = MockClient((request) async {
        return http.Response('{"key": "value"}', 200);
      });

      final client = HttpClient(serverUrl: serverUrl, httpClient: mockClient);
      expect(await client.getJson('/test'), {'key': 'value'});
      client.dispose();
    });

    test('postJson sends JSON body', () async {
      final mockClient = MockClient((request) async {
        expect(request.method, 'POST');
        expect(jsonDecode(request.body), {'input': 'data'});
        return http.Response('{"ok": true}', 200);
      });

      final client = HttpClient(serverUrl: serverUrl, httpClient: mockClient);
      expect(await client.postJson('/test', {'input': 'data'}), {'ok': true});
      client.dispose();
    });

    test('throws HttpStatusException on error status', () async {
      final mockClient = MockClient((request) async {
        return http.Response('Not Found', 404);
      });

      final client = HttpClient(serverUrl: serverUrl, httpClient: mockClient);
      expect(
        () => client.getJson('/test'),
        throwsA(isA<HttpStatusException>()
            .having((e) => e.statusCode, 'statusCode', 404)),
      );
      client.dispose();
    });
  });
}
