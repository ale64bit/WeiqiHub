import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';
import 'package:wqhub/game_client/ogs/ogs_game_client.dart';
import 'package:wqhub/game_client/test_game_client.dart';

final gameClients = IList([
  // OGS prefers that developers use the beta server for testing
  OGSGameClient(
      serverUrl:
          kDebugMode ? "https://beta.online-go.com" : "https://online-go.com",
      aiServerUrl: kDebugMode
          ? "https://beta-ai.online-go.com"
          : "https://ai.online-go.com"),
  if (kDebugMode) TestGameClient(),
]);
