import 'package:flutter/material.dart';
import 'package:wqhub/game_client/exceptions.dart';
import 'package:wqhub/game_client/game_client.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/play/login_form.dart';
import 'package:wqhub/play/server_lobby_page.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';

class ServerLoginRouteArguments {
  final GameClient gameClient;

  const ServerLoginRouteArguments({required this.gameClient});
}

class ServerLoginPage extends StatefulWidget {
  static const routeName = '/play/login';

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
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.gameClient.serverInfo.name(loc)),
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
        Navigator.pushReplacementNamed(
          context,
          ServerLobbyPage.routeName,
          arguments: ServerLobbyRouteArguments(gameClient: widget.gameClient),
        );
      }
    }).catchError((err) {
      if (context.mounted) {
        final loc = AppLocalizations.of(context)!;
        String errorMessage;

        // Determine the appropriate error message based on exception type
        if (err is LoginException) {
          errorMessage = switch (err.type) {
            LoginFailureType.invalidCredentials =>
              loc.errIncorrectUsernameOrPassword,
            LoginFailureType.network => loc.errNetworkError,
          };
        } else {
          // For unexpected exceptions, show the error message
          errorMessage = loc.errLoginFailedWithDetails(err.toString());
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(errorMessage),
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
