import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wqhub/game_client/rules.dart';
import 'package:wqhub/play/ai_bot.dart';
import 'package:wqhub/play/ai_game_page.dart';
import 'package:wqhub/wq/wq.dart' as wq;

class AILobbyPage extends StatelessWidget {
  static const routeName = '/play/ai';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bot game'),
      ),
      body: Center(
        child: ListView(
          children: <ListTile>[
            ListTile(
              leading: const Text('9×9'),
              title: const Text('Even game'),
              subtitle: const Text('Rules: chinese'),
              onTap: () {
                Navigator.pushNamed(context, AIGamePage.routeName,
                    arguments: AIGameRouteArguments(
                      rules: Rules.chinese,
                      boardSize: 9,
                      myColor:
                          Random().nextBool() ? wq.Color.black : wq.Color.white,
                      handicap: 0,
                      komi: 7.5,
                      moveSelection: MoveSelection.dist,
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
