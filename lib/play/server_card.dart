import 'package:flutter/material.dart';
import 'package:wqhub/game_client/game_client.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/play/server_lobby_page.dart';
import 'package:wqhub/play/server_login_page.dart';

class ServerCard extends StatelessWidget {
  final GameClient gameClient;

  const ServerCard({super.key, required this.gameClient});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Card(
      child: InkWell(
        onTap: () => _onTap(context),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.videogame_asset),
              title: Text(
                  '${gameClient.serverInfo.name(loc)} (${gameClient.serverInfo.nativeName})'),
              subtitle: Text(gameClient.serverInfo.description(loc)),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    if (gameClient.userInfo.value == null) {
      Navigator.pushNamed(
        context,
        ServerLoginPage.routeName,
        arguments: ServerLoginRouteArguments(gameClient: gameClient),
      );
    } else {
      Navigator.pushNamed(
        context,
        ServerLobbyPage.routeName,
        arguments: ServerLobbyRouteArguments(gameClient: gameClient),
      );
    }
  }
}
