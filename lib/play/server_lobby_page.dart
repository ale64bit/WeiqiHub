import 'package:flutter/material.dart';
import 'package:wqhub/audio/audio_controller.dart';
import 'package:wqhub/game_client/user_info.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/play/automatch_page.dart';
import 'package:wqhub/game_client/game_client.dart';
import 'package:wqhub/play/automatch_preset_list_tile.dart';
import 'package:wqhub/play/game_page.dart';
import 'package:wqhub/play/my_games_page.dart';
import 'package:wqhub/play/promotion_card.dart';
import 'package:wqhub/play/streak_card.dart';
import 'package:wqhub/play/user_info_card.dart';
import 'package:wqhub/pop_and_window_class_aware_state.dart';

class ServerLobbyRouteArguments {
  final GameClient gameClient;

  const ServerLobbyRouteArguments({required this.gameClient});
}

class ServerLobbyPage extends StatefulWidget {
  static const routeName = '/play/lobby';

  const ServerLobbyPage({super.key, required this.gameClient});

  final GameClient gameClient;

  @override
  State<ServerLobbyPage> createState() => _ServerLobbyPageState();
}

class _ServerLobbyPageState
    extends PopAndWindowClassAwareState<ServerLobbyPage> {
  @override
  void initState() {
    super.initState();
    widget.gameClient.disconnected.addListener(onDisconnected);
    widget.gameClient.ongoingGame().then((game) {
      if (context.mounted && game != null) {
        AudioController().startToPlay();
        Navigator.pushNamed(
          context,
          GamePage.routeName,
          arguments: GameRouteArguments(
            serverFeatures: widget.gameClient.serverFeatures,
            game: game,
            gameListener: null,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    widget.gameClient.disconnected.removeListener(onDisconnected);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final userInfoCard = ValueListenableBuilder(
      valueListenable: widget.gameClient.userInfo,
      builder: (context, info, child) {
        return UserInfoCard(userInfo: info ?? UserInfo.empty());
      },
    );
    final streakCard = ValueListenableBuilder(
      valueListenable: widget.gameClient.userInfo,
      builder: (context, value, child) {
        if (value?.streak != null) {
          return StreakCard(streak: value!.streak!);
        }
        return SizedBox();
      },
    );
    final promotionRequirementCard = ValueListenableBuilder(
      valueListenable: widget.gameClient.userInfo,
      builder: (context, value, child) {
        final req = value?.promotionRequirements;
        if (req != null) {
          return PromotionCard(requirements: req);
        }
        return SizedBox();
      },
    );

    final automatchPresetList = ListView(
      children: <Widget>[
        for (final preset in widget.gameClient.automatchPresets)
          AutomatchPresetListTile(
            preset: preset,
            onTap: () {
              Navigator.pushNamed(
                context,
                AutomatchPage.routeName,
                arguments: AutomatchRouteArguments(
                  gameClient: widget.gameClient,
                  preset: preset,
                ),
              );
            },
          )
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.gameClient.serverInfo.name(loc)),
        actions: [
          TextButton.icon(
            onPressed: () {
              widget.gameClient.logout();
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            icon: const Icon(Icons.logout),
            label: Text(loc.logout),
          ),
        ],
      ),
      body: isWindowClassCompact
          ? Column(
              children: [
                userInfoCard,
                streakCard,
                promotionRequirementCard,
                Divider(),
                Text(loc.autoMatch),
                Expanded(child: automatchPresetList),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  constraints: BoxConstraints(minWidth: 150, maxWidth: 400),
                  decoration: BoxDecoration(
                    color: ColorScheme.of(context).surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(loc.userInfo),
                      userInfoCard,
                      Text(loc.recentRecord),
                      streakCard,
                      Text(loc.promotionRequirements),
                      promotionRequirementCard,
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Text(
                        loc.autoMatch,
                        style: TextTheme.of(context).titleLarge,
                      ),
                      Expanded(child: automatchPresetList),
                    ],
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(loc.myGames),
        onPressed: () {
          Navigator.pushNamed(
            context,
            MyGamesPage.routeName,
            arguments: MyGamesRouteArguments(
              gameClient: widget.gameClient,
              gameList: widget.gameClient.listGames(),
            ),
          );
        },
      ),
    );
  }

  void onDisconnected() {
    widget.gameClient.disconnected.removeListener(onDisconnected);
    if (context.mounted) {
      Navigator.popUntil(context, (route) => route.isFirst);
    }
  }
}
