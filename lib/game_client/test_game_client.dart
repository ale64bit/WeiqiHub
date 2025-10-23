import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:wqhub/game_client/automatch_preset.dart';
import 'package:wqhub/game_client/game.dart';
import 'package:wqhub/game_client/game_client.dart';
import 'package:wqhub/game_client/game_record.dart';
import 'package:wqhub/game_client/game_result.dart';
import 'package:wqhub/game_client/rules.dart';
import 'package:wqhub/game_client/server_features.dart';
import 'package:wqhub/game_client/server_info.dart';
import 'package:wqhub/game_client/test_game.dart';
import 'package:wqhub/game_client/time_control.dart';
import 'package:wqhub/game_client/user_info.dart';
import 'package:wqhub/wq/rank.dart';
import 'package:wqhub/wq/wq.dart' as wq;

class TestGameClient extends GameClient {
  @override
  IList<AutomatchPreset> get automatchPresets => IList([
        AutomatchPreset(
          id: 'test',
          boardSize: 19,
          variant: Variant.standard,
          rules: Rules.chinese,
          timeControl: TimeControl(
            mainTime: Duration(minutes: 1),
            periodCount: 3,
            timePerPeriod: Duration(seconds: 30),
          ),
        )
      ]);

  @override
  Future<Game> findGame(String presetId) {
    final testGame = TestGame(
      id: 'test_game_id',
      boardSize: 19,
      rules: Rules.chinese,
      handicap: 0,
      komi: 7.5,
      myColor: wq.Color.black,
      timeControl: TimeControl(
        mainTime: Duration(minutes: 1),
        periodCount: 3,
        timePerPeriod: Duration(seconds: 30),
      ),
      previousMoves: [
        (col: wq.Color.black, p: (3, 3)),
        (col: wq.Color.black, p: (3, 4)),
        (col: wq.Color.black, p: (5, 4)),
        (col: wq.Color.white, p: (3, 15)),
        (col: wq.Color.black, p: (15, 3)),
        (col: wq.Color.white, p: (15, 15)),
        (col: wq.Color.black, p: (2, 5)),
        (col: wq.Color.white, p: (16, 13)),
      ],
    );
    testGame.black.value = UserInfo(
      userId: 'test_black_id',
      username: 'blackNick',
      rank: Rank.k15,
      online: true,
      winCount: 12,
      lossCount: 13,
      streak: 'WW?WLLLWL=WWWLWWWLWW',
      promotionRequirements: PromotionRequirements(
        up: 4,
        down: 9,
        doubleUp: null,
        doubleDown: 12,
      ),
    );
    testGame.white.value = UserInfo(
      userId: 'test_white_id',
      username: 'WhiTe12345',
      rank: Rank.d5,
      online: true,
      winCount: 2,
      lossCount: 0,
    );
    return Future.value(testGame);
  }

  @override
  Future<Game?> ongoingGame() => Future.value(null);

  @override
  Future<UserInfo> login(String username, String password) =>
      Future.value(UserInfo(
        userId: 'test_black_id',
        username: 'blackNick',
        rank: Rank.k15,
        online: true,
        winCount: 0,
        lossCount: 0,
      ));

  @override
  void logout() {}

  @override
  Future<ReadyInfo> ready() => Future.value(ReadyInfo());

  @override
  ServerFeatures get serverFeatures => ServerFeatures(
        manualCounting: false,
        automaticCounting: true,
        aiReferee: true,
        aiRefereeMinMoveCount: const IMapConst({
          19: 150,
        }),
        forcedCounting: true,
        forcedCountingMinMoveCount: const IMapConst({
          19: 350,
        }),
        localTimeControl: true,
      );

  @override
  ServerInfo get serverInfo => ServerInfo(
        id: 'test',
        name: (_) => 'Test Server',
        nativeName: 'Test Server',
        description: (_) =>
            'A dummy server to easily test layout changes, etc.',
        homeUrl: 'https://weiqihub.com',
      );

  @override
  void stopAutomatch() {}

  @override
  ValueNotifier<UserInfo?> get userInfo => ValueNotifier(UserInfo(
        userId: 'test_user_id',
        username: 'testUser123',
        rank: Rank.k15,
        online: true,
        winCount: 23,
        lossCount: 14,
        streak: 'WW?WLLLWL=WWWLWWWLWW',
        promotionRequirements: PromotionRequirements(
          up: 4,
          down: 9,
          doubleUp: null,
          doubleDown: 12,
        ),
      ));

  @override
  ValueNotifier<DateTime> get disconnected => ValueNotifier(DateTime.now());

  @override
  Future<List<GameSummary>> listGames() => Future.value([
        GameSummary(
          id: 'gid1',
          boardSize: 19,
          white: UserInfo(
              userId: 'uid1',
              username: 'dog123',
              rank: Rank.k18,
              online: true,
              winCount: 0,
              lossCount: 0),
          black: UserInfo(
              userId: 'uid2',
              username: 'cat4567',
              rank: Rank.k18,
              online: true,
              winCount: 0,
              lossCount: 0),
          dateTime: DateTime.now(),
          result: GameResult(winner: wq.Color.black, result: 'B+R'),
        ),
        GameSummary(
          id: 'gid2',
          boardSize: 19,
          white: UserInfo(
              userId: 'uid1',
              username: '黃龍士',
              rank: Rank.d9,
              online: true,
              winCount: 0,
              lossCount: 0),
          black: UserInfo(
              userId: 'uid2',
              username: 'RandomPerson32',
              rank: Rank.k2,
              online: true,
              winCount: 0,
              lossCount: 0),
          dateTime: DateTime.now(),
          result: GameResult(winner: wq.Color.white, result: 'W+12.5'),
        ),
      ]);

  @override
  Future<GameRecord> getGame(String gameId) {
    // TODO: implement getGame
    throw UnimplementedError();
  }
}
