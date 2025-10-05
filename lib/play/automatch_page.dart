import 'package:flutter/material.dart';
import 'package:wqhub/audio/audio_controller.dart';
import 'package:wqhub/game_client/automatch_preset.dart';
import 'package:wqhub/game_client/game.dart';
import 'package:wqhub/game_client/game_client.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/play/game_page.dart';

class AutomatchRouteArguments {
  final GameClient gameClient;
  final AutomatchPreset preset;

  const AutomatchRouteArguments(
      {required this.gameClient, required this.preset});
}

class AutomatchPage extends StatefulWidget {
  static const routeName = '/play/automatch';

  final GameClient gameClient;
  final AutomatchPreset preset;

  const AutomatchPage(
      {super.key, required this.gameClient, required this.preset});

  @override
  State<AutomatchPage> createState() => _AutomatchPageState();
}

class _AutomatchPageState extends State<AutomatchPage> {
  late final Future<Game> _findGame =
      widget.gameClient.findGame(widget.preset.id);

  @override
  void initState() {
    _findGame.then((game) {
      if (context.mounted) {
        AudioController().startToPlay();
        Navigator.pushReplacementNamed(
          context,
          GamePage.routeName,
          arguments: GameRouteArguments(
            serverFeatures: widget.gameClient.serverFeatures,
            game: game,
            gameListener: null,
          ),
        );
      }
    }, onError: (err) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(err),
          showCloseIcon: true,
          behavior: SnackBarBehavior.floating,
        ));
        Navigator.pop(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.autoMatch),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: _findGame,
        builder: (context, snapshot) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(loc.msgSearchingForGame),
                SizedBox(height: 16),
                CircularProgressIndicator(),
                SizedBox(height: 16),
                ElevatedButton(
                    onPressed: () {
                      widget.gameClient.stopAutomatch();
                    },
                    child: Text(loc.cancel)),
              ],
            ),
          );
        },
      ),
    );
  }
}
