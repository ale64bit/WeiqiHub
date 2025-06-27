import 'package:flutter/material.dart';
import 'package:wqhub/game_client/game_client.dart';
import 'package:wqhub/play/server_lobby_page.dart';
import 'package:wqhub/play/server_login_page.dart';

class ServerCard extends StatelessWidget {
  final GameClient gameClient;

  const ServerCard({super.key, required this.gameClient});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => _onTap(context),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.videogame_asset),
              title: Text(
                  '${gameClient.serverInfo.name} (${gameClient.serverInfo.nativeName})'),
              subtitle: Text(gameClient.serverInfo.description),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return gameClient.userInfo.value == null
              ? ServerLoginPage(gameClient: gameClient)
              : ServerLobbyPage(gameClient: gameClient);
        },
      ),
    );
  }
}
