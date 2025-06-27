import 'package:flutter/material.dart';
import 'package:wqhub/game_client/game_client.dart';
import 'package:wqhub/play/login_form.dart';
import 'package:wqhub/play/server_lobby_page.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';

class ServerLoginPage extends StatefulWidget {
  const ServerLoginPage({super.key, required this.gameClient});

  final GameClient gameClient;

  @override
  State<ServerLoginPage> createState() => _ServerLoginPageState();
}

class _ServerLoginPageState extends State<ServerLoginPage> {
  late final _serverReady = widget.gameClient.ready();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.gameClient.serverInfo.name),
      ),
      body: FutureBuilder(
        future: _serverReady,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 300),
                  child: LoginForm(
                    username: context.settings
                        .getUsername(widget.gameClient.serverInfo.id),
                    password: context.settings
                        .getPassword(widget.gameClient.serverInfo.id),
                    registerUrl: widget.gameClient.serverInfo.registerUrl,
                    enabled: !_isLoading,
                    onSubmit: (username, password) {
                      _doLogin(context, username, password);
                    },
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                  child: const Text(
                      'Something went wrong. Please try again later.'));
            }
          }
          return Center(child: const CircularProgressIndicator());
        },
      ),
    );
  }

  Future<void> _doLogin(
      BuildContext context, String username, String password) async {
    setState(() {
      _isLoading = true;
    });

    await widget.gameClient.login(username, password).then((info) {
      if (context.mounted) {
        context.settings.setUsername(widget.gameClient.serverInfo.id, username);
        context.settings.setPassword(widget.gameClient.serverInfo.id, password);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ServerLobbyPage(gameClient: widget.gameClient),
          ),
        );
      }
    }, onError: (err) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('Invalid username or password'),
            showCloseIcon: true,
          ),
        );
      }
    });

    if (context.mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
