import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';
import 'package:wqhub/game_client/test_game_client.dart';

final gameClients = IList([
  if (kDebugMode) TestGameClient(),
]);
