import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:wqhub/blinking_icon.dart';
import 'package:wqhub/game_client/user_info.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/turn_icon.dart';
import 'package:wqhub/wq/wq.dart' as wq;

enum PlayerCardAlignment {
  left,
  right,
}

class PlayerCard extends StatelessWidget {
  final UserInfo userInfo;
  final wq.Color color;
  final int captureCount;
  final Widget timeDisplay;
  final Function()? onTap;
  final bool showOnlineStatus;
  final PlayerCardAlignment alignment;

  const PlayerCard({
    super.key,
    required this.userInfo,
    required this.color,
    required this.captureCount,
    required this.timeDisplay,
    this.onTap,
    this.showOnlineStatus = false,
    this.alignment = PlayerCardAlignment.left,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final crossAxisAlignment = switch (alignment) {
      PlayerCardAlignment.left => CrossAxisAlignment.start,
      PlayerCardAlignment.right => CrossAxisAlignment.end,
    };
    final children = <Widget>[
      SizedBox(width: 4),
      TurnIcon(color: color),
      SizedBox(width: 4),
      Expanded(
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            Text(
              context.settings.hidePlayerRanks
                  ? userInfo.username
                  : '${userInfo.username} [${userInfo.rank}]',
              overflow: TextOverflow.fade,
              softWrap: false,
            ),
            Text('${loc.captures}: $captureCount',
                style: TextTheme.of(context).labelSmall),
          ],
        ),
      ),
      if (showOnlineStatus && userInfo.online)
        const Icon(Icons.wifi, color: Colors.green),
      if (showOnlineStatus && !userInfo.online)
        const BlinkingIcon(
          icon: Icons.wifi_off,
          color: Colors.red,
          duration: Duration(seconds: 1),
          curve: Curves.linear,
        ),
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: timeDisplay,
      ),
    ];
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: switch (alignment) {
            PlayerCardAlignment.left => children,
            PlayerCardAlignment.right => children.reversedView,
          },
        ),
      ),
    );
  }
}
