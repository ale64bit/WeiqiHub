import 'package:flutter/material.dart';
import 'package:wqhub/game_client/user_info.dart';
import 'package:wqhub/settings/settings.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';

class UserInfoCard extends StatelessWidget {
  final UserInfo userInfo;

  const UserInfoCard({super.key, required this.userInfo});

  @override
  Widget build(BuildContext context) {
    final winCount = userInfo.winCount;
    final lossCount = userInfo.lossCount;
    final showWinLoss = winCount != null &&
        lossCount != null &&
        context.settings.rankVisibility != PlayerRankVisibility.focusMode;

    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person),
            title: Text(userInfo.username),
            subtitle: showWinLoss ? Text('${winCount}W  ${lossCount}L') : null,
            trailing: context.settings.rankVisibility !=
                    PlayerRankVisibility.visible
                ? null
                : Text(userInfo.rank.toString(),
                    style: TextTheme.of(context).displaySmall),
          )
        ],
      ),
    );
  }
}
