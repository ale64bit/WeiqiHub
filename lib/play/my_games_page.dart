import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:wqhub/analysis/analysis_page.dart';
import 'package:wqhub/analysis/remote_katago.dart';
import 'package:wqhub/game_client/game_client.dart';
import 'package:wqhub/game_client/game_record.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/play/game_record_page.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/window_class_aware_state.dart';
import 'package:wqhub/wq/wq.dart' as wq;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share_plus/share_plus.dart';
import 'package:async/async.dart';

final _dateFormat = DateFormat('yyyy.MM.dd hh.mm');

class MyGamesRouteArguments {
  final GameClient gameClient;
  final Future<List<GameSummary>> gameList;

  const MyGamesRouteArguments(
      {required this.gameClient, required this.gameList});
}

class MyGamesPage extends StatefulWidget {
  static const routeName = '/play/my_games';

  const MyGamesPage(
      {super.key, required this.gameClient, required this.gameList});

  final GameClient gameClient;
  final Future<List<GameSummary>> gameList;

  @override
  State<MyGamesPage> createState() => _MyGamesPageState();
}

class _MyGamesPageState extends State<MyGamesPage> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(loc.myGames)),
      body: FutureBuilder(
        future: widget.gameList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final items = snapshot.data!;
            final first = items.firstOrNull;
            return ListView.builder(
              itemCount: items.length,
              prototypeItem: first == null
                  ? null
                  : _GameListTile(
                      summary: first,
                      won: true,
                      onTap: () {},
                      onDownload: () {},
                      onAISensei: () {},
                    ),
              itemBuilder: (context, index) {
                final username =
                    widget.gameClient.userInfo.value?.username ?? '';
                final summary = items[index];
                final won = (summary.result.winner == wq.Color.black &&
                        username == summary.black.username) ||
                    (summary.result.winner == wq.Color.white &&
                        username == summary.white.username);
                return _GameListTile(
                  summary: items[index],
                  won: won,
                  onTap: () => onTapGame(context, summary),
                  onDownload: () => onDownload(context, summary),
                  onAISensei: () => onAIAnalysis(context, summary),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(loc.errFailedToLoadGameList));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void onTapGame(BuildContext context, GameSummary summary) {
    final loc = AppLocalizations.of(context)!;
    final recordFut = widget.gameClient.getGame(summary.id);
    _GameLoadingDialog.show(
      context,
      loc.msgDownloadingGame,
      summary,
      recordFut,
      onRecord: (context, summary, record) {
        Navigator.pushNamed(
          context,
          GameRecordPage.routeName,
          arguments: GameRecordRouteArguments(
            summary: summary,
            record: record,
          ),
        );
      },
      onError: (err) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(loc.errFailedToDownloadGame),
            showCloseIcon: true,
            behavior: SnackBarBehavior.floating,
          ));
        }
      },
    );
  }

  void onDownload(BuildContext context, GameSummary summary) {
    final loc = AppLocalizations.of(context)!;
    final recordFut = widget.gameClient.getGame(summary.id);
    _GameLoadingDialog.show(context, loc.msgDownloadingGame, summary, recordFut,
        onRecord: (context, summary, record) async {
      final fileName =
          '${_dateFormat.format(summary.dateTime)} - ${summary.white.username} vs ${summary.black.username}.${record.type.name}';
      if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
        if (context.mounted) {
          final savePath = await FilePicker.platform.saveFile(
            fileName: fileName,
            initialDirectory: context.settings.getSaveDirectory(),
          );
          if (savePath != null) {
            final f = File(savePath);
            await f.writeAsBytes(record.rawData);
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(loc.msgGameSavedTo(savePath)),
              showCloseIcon: true,
              behavior: SnackBarBehavior.floating,
            ));
            context.settings.saveDirectory = dirname(savePath);
          }
        }
      } else {
        Rect? sharePositionOrigin;
        if (defaultTargetPlatform == TargetPlatform.iOS) {
          DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
          IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
          if (iosInfo.model.toLowerCase().contains('ipad')) {
            // see https://github.com/fluttercommunity/plus_plugins/issues/3645#issuecomment-3360156193
            sharePositionOrigin = Rect.fromLTWH(0, 0, 1, 1);
          }
        }
        final params = ShareParams(
          files: [
            XFile.fromData(
              Uint8List.fromList(record.rawData),
              mimeType: 'application/x-go-${record.type.name}',
            )
          ],
          fileNameOverrides: [fileName],
          sharePositionOrigin: sharePositionOrigin,
        );
        await SharePlus.instance.share(params);
      }
    }, onError: (err) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(loc.errFailedToDownloadGame),
          showCloseIcon: true,
          behavior: SnackBarBehavior.floating,
        ));
      }
    });
  }

  void onAIAnalysis(BuildContext context, GameSummary summary) {
    final loc = AppLocalizations.of(context)!;
    final recordFut = widget.gameClient.getGame(summary.id);
    _GameLoadingDialog.show(
      context,
      loc.msgDownloadingGame,
      summary,
      recordFut,
      onRecord: (context, summary, record) async {
        Navigator.pushNamed(context, AnalysisPage.routeName,
            arguments: AnalysisRouteArguments(
              kataGo: RemoteKataGo(
                channel: ClientChannel(
                  'api.weiqihub.com',
                  port: 32323,
                  options: const ChannelOptions(
                    credentials: ChannelCredentials.insecure(),
                  ),
                ),
                boardSize: summary.boardSize,
              ),
              summary: summary,
              record: record,
            ));
      },
      onError: (err) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(loc.errFailedToUploadGameToAISensei),
            showCloseIcon: true,
            behavior: SnackBarBehavior.floating,
          ));
        }
      },
    );
  }
}

class _GameListTile extends StatefulWidget {
  final GameSummary summary;
  final bool won;
  final Function() onTap;
  final Function() onDownload;
  final Function() onAISensei;

  const _GameListTile({
    required this.summary,
    required this.won,
    required this.onTap,
    required this.onDownload,
    required this.onAISensei,
  });

  @override
  State<_GameListTile> createState() => _GameListTileState();
}

class _GameListTileState extends WindowClassAwareState<_GameListTile> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    if (isWindowClassCompact) {
      return Slidable(
        key: ValueKey<String>(widget.summary.id),
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              backgroundColor: Colors.green,
              icon: Icons.download,
              label: loc.download,
              padding: EdgeInsets.all(8),
              onPressed: (context) => widget.onDownload(),
            ),
            SlidableAction(
              backgroundColor: Colors.blue,
              icon: Icons.smart_toy,
              label: loc.aiSensei,
              padding: EdgeInsets.all(8),
              onPressed: (context) => widget.onAISensei(),
            ),
          ],
        ),
        child: ListTile(
          leading: widget.won
              ? Icon(Icons.emoji_events, color: Colors.amber)
              : Icon(Icons.close, color: Colors.red),
          title: Text(
              '[${widget.summary.white.rank.toString()}] ${widget.summary.white.username} vs ${widget.summary.black.username} [${widget.summary.black.rank.toString()}]'),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_dateFormat.format(widget.summary.dateTime)),
              Text(widget.summary.result.result),
            ],
          ),
          dense: true,
          onTap: widget.onTap,
        ),
      );
    }
    return ListTile(
      leading: SizedBox(
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.won
                ? Icon(Icons.emoji_events, color: Colors.amber)
                : Icon(Icons.close, color: Colors.red),
            Text(widget.summary.result.result),
          ],
        ),
      ),
      title: Text(
          '[${widget.summary.white.rank.toString()}] ${widget.summary.white.username} vs ${widget.summary.black.username} [${widget.summary.black.rank.toString()}]'),
      subtitle: Text(DateFormat.yMd().add_Hm().format(widget.summary.dateTime)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          IconButton(
            icon: const Icon(Icons.download),
            tooltip: loc.tooltipDownloadGame,
            onPressed: widget.onDownload,
          ),
          IconButton(
            icon: const Icon(Icons.smart_toy),
            tooltip: loc.tooltipAnalyzeWithAISensei,
            onPressed: widget.onAISensei,
          ),
        ],
      ),
      onTap: widget.onTap,
    );
  }
}

class _GameLoadingDialog extends StatelessWidget {
  final String title;
  final GameSummary summary;
  final CancelableOperation<GameRecord> record;

  const _GameLoadingDialog(
      {required this.title, required this.summary, required this.record});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [CircularProgressIndicator()],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: <Widget>[
        TextButton(
          onPressed: () => record.cancel(),
          child: Text(loc.cancel),
        ),
      ],
    );
  }

  static void show(BuildContext context, String title, GameSummary summary,
      Future<GameRecord> recordFut,
      {required Function(BuildContext, GameSummary, GameRecord) onRecord,
      required Function(dynamic) onError}) {
    final recordOp = CancelableOperation.fromFuture(recordFut);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => _GameLoadingDialog(
              title: title,
              summary: summary,
              record: recordOp,
            ));
    recordOp.then((record) {
      if (context.mounted) {
        Navigator.of(context).pop();
      }
      onRecord(context, summary, record);
    }, onError: (err, trace) {
      if (context.mounted) {
        Navigator.of(context).pop();
      }
      onError(err);
    }, onCancel: () {
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    });
  }
}
