import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wqhub/file_picker.dart';
import 'package:wqhub/game_client/game_client.dart';
import 'package:wqhub/game_client/game_record.dart';
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
    return Scaffold(
      appBar: AppBar(title: const Text('My games')),
      body: FutureBuilder(
        future: widget.gameList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final items = snapshot.data!;
            return ListView.builder(
              itemCount: items.length,
              prototypeItem: _GameListTile(
                summary: items.first,
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
                  onAISensei: () => onAISensei(context, summary),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Failed to load game list. Please try again.'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void onTapGame(BuildContext context, GameSummary summary) {
    final recordFut = widget.gameClient.getGame(summary.id);
    _GameLoadingDialog.show(
      context,
      'Downloading game',
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
            content: Text('Failed to download game'),
            showCloseIcon: true,
            behavior: SnackBarBehavior.floating,
          ));
        }
      },
    );
  }

  void onDownload(BuildContext context, GameSummary summary) {
    final recordFut = widget.gameClient.getGame(summary.id);
    _GameLoadingDialog.show(context, 'Downloading game', summary, recordFut,
        onRecord: (context, summary, record) async {
      final filename =
          '${_dateFormat.format(summary.dateTime)} - ${summary.white.username} vs ${summary.black.username}.${record.type.name}';
      if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
        if (context.mounted) {
          showDialog<Directory>(
            context: context,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: FilePicker(
                  initialDirectory: Directory(context.settings.saveDirectory),
                  title: 'Select directory',
                ),
              );
            },
          ).then((Directory? dir) async {
            if (dir != null) {
              final f = File(join(dir.path, filename));
              await f.writeAsBytes(record.rawData);
              if (context.mounted) {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Game saved to ${dir.path}'),
                  showCloseIcon: true,
                  behavior: SnackBarBehavior.floating,
                ));
                context.settings.saveDirectory = dir.path;
              }
            }
          });
        }
      } else {
        Rect? sharePositionOrigin;
        if (defaultTargetPlatform == TargetPlatform.iOS) {
          DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
          IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
          if (iosInfo.model.toLowerCase().contains('ipad')) {
            final box = context.findRenderObject() as RenderBox?;
            sharePositionOrigin = box!.localToGlobal(Offset.zero) & box.size;
          }
        }
        final params = ShareParams(
          files: [
            XFile.fromData(
              Uint8List.fromList(record.rawData),
              mimeType: 'application/x-go-${record.type.name}',
            )
          ],
          fileNameOverrides: [filename],
          sharePositionOrigin: sharePositionOrigin,
        );
        await SharePlus.instance.share(params);
      }
    }, onError: (err) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to download game'),
          showCloseIcon: true,
          behavior: SnackBarBehavior.floating,
        ));
      }
    });
  }

  void onAISensei(BuildContext context, GameSummary summary) {
    final recordFut = widget.gameClient.getGame(summary.id);
    _GameLoadingDialog.show(
      context,
      'Downloading game',
      summary,
      recordFut,
      onRecord: (context, summary, record) async {
        final uri = Uri.https(
          'ai-sensei.com',
          'upload',
          {
            'sgf': utf8.decode(record.rawData, allowMalformed: true),
          },
        );
        await launchUrl(uri);
      },
      onError: (err) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Failed to upload game to AI Sensei'),
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

  const _GameListTile(
      {required this.summary,
      required this.won,
      required this.onTap,
      required this.onDownload,
      required this.onAISensei});

  @override
  State<_GameListTile> createState() => _GameListTileState();
}

class _GameListTileState extends WindowClassAwareState<_GameListTile> {
  @override
  Widget build(BuildContext context) {
    if (isWindowClassCompact) {
      return Slidable(
        key: ValueKey<String>(widget.summary.id),
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              backgroundColor: Colors.green,
              icon: Icons.download,
              label: 'Download',
              padding: EdgeInsets.all(8),
              onPressed: (context) => widget.onDownload(),
            ),
            SlidableAction(
              backgroundColor: Colors.blue,
              icon: Icons.smart_toy,
              label: 'AI Sensei',
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
            tooltip: 'Download game',
            onPressed: widget.onDownload,
          ),
          IconButton(
            icon: const Icon(Icons.smart_toy),
            tooltip: 'Analyze with AI Sensei',
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
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  static show(BuildContext context, String title, GameSummary summary,
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
