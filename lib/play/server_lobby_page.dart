import 'package:flutter/material.dart';
import 'package:wqhub/audio/audio_controller.dart';
import 'package:wqhub/game_client/user_info.dart';
import 'package:wqhub/play/automatch_page.dart';
import 'package:wqhub/game_client/game_client.dart';
import 'package:wqhub/play/game_page.dart';
import 'package:wqhub/play/my_games_page.dart';
import 'package:wqhub/play/promotion_card.dart';
import 'package:wqhub/play/streak_card.dart';
import 'package:wqhub/play/user_info_card.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/window_class_aware_state.dart';

class ServerLobbyPage extends StatefulWidget {
  const ServerLobbyPage({super.key, required this.gameClient});

  final GameClient gameClient;

  @override
  State<ServerLobbyPage> createState() => _ServerLobbyPageState();
}

class _ServerLobbyPageState extends WindowClassAwareState<ServerLobbyPage> {
  @override
  void initState() {
    super.initState();
    widget.gameClient.disconnected.addListener(onDisconnected);
    widget.gameClient.ongoingGame().then((game) {
      if (context.mounted && game != null) {
        if (context.settings.sound) AudioController().startToPlay();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PopScope(
              canPop: false,
              child: GamePage(
                serverFeatures: widget.gameClient.serverFeatures,
                game: game,
              ),
            ),
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
          ListTile(
            leading: Text('${preset.boardSize}x${preset.boardSize}'),
            title: Text(
                '${preset.timeControl.mainTime.inMinutes}m ${preset.timeControl.periodCount}x${preset.timeControl.timePerPeriod.inSeconds}s'),
            subtitle: Text('Rules: ${preset.rules.toString()}'),
            trailing: (preset.playerCount != null)
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 4,
                    children: <Widget>[
                      Icon(Icons.people),
                      Text(preset.playerCount.toString()),
                    ],
                  )
                : null,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PopScope(
                    canPop: false,
                    child: AutomatchPage(
                        gameClient: widget.gameClient, preset: preset),
                  ),
                ),
              );
            },
          )
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.gameClient.serverInfo.name),
        actions: [
          TextButton.icon(
            onPressed: () {
              widget.gameClient.logout();
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
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
                const Text('Auto-Match'),
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
                      const Text('User info'),
                      userInfoCard,
                      const Text('Recent record'),
                      streakCard,
                      const Text('Promotion requirements'),
                      promotionRequirementCard,
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Text(
                        'Auto-Match',
                        style: TextTheme.of(context).titleLarge,
                      ),
                      Expanded(child: automatchPresetList),
                    ],
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('My games'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyGamesPage(
                gameClient: widget.gameClient,
                gameList: widget.gameClient.listGames(),
              ),
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
