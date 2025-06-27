import 'package:flutter/material.dart';
import 'package:wqhub/audio/audio_controller.dart';
import 'package:wqhub/game_client/automatch_preset.dart';
import 'package:wqhub/game_client/game.dart';
import 'package:wqhub/game_client/game_client.dart';
import 'package:wqhub/play/game_page.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';

class AutomatchPage extends StatefulWidget {
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
        if (context.settings.sound) AudioController().startToPlay();
        Navigator.pushReplacement(
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auto-Match'),
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
                Text('Searching for a game...'),
                SizedBox(height: 16),
                CircularProgressIndicator(),
                SizedBox(height: 16),
                ElevatedButton(
                    onPressed: () {
                      widget.gameClient.stopAutomatch();
                    },
                    child: const Text('Cancel')),
              ],
            ),
          );
        },
      ),
    );
  }
}
