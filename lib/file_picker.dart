import 'dart:io';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class FilePicker extends StatefulWidget {
  const FilePicker(
      {super.key,
      required this.initialDirectory,
      required this.title,
      this.okText = 'OK',
      this.cancelText = 'Cancel'});

  final Directory initialDirectory;
  final String title;
  final String okText;
  final String cancelText;

  @override
  State<FilePicker> createState() => _FilePickerState();
}

class _FilePickerState extends State<FilePicker> {
  late Directory currentDir;
  late Future<List<FileSystemEntity>> entries;

  @override
  void initState() {
    super.initState();
    setDir(widget.initialDirectory);
  }

  setDir(Directory dir) {
    setState(() {
      currentDir = dir;
      entries = Future(() {
        final entries = dir.listSync();
        entries.retainWhere(
            (e) => e.statSync().type == FileSystemEntityType.directory);
        entries.sortOrdered((e1, e2) => e1.path.compareTo(e2.path));
        return entries;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Text(widget.title, style: TextTheme.of(context).titleLarge),
          SizedBox(height: 8),
          Text(currentDir.path),
          Expanded(
            flex: 12,
            child: FutureBuilder(
              future: entries,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: [
                      if (currentDir.path != currentDir.parent.path)
                        ListTile(
                          leading: const Icon(Icons.folder),
                          title: const Text('..'),
                          onTap: () => setDir(currentDir.parent),
                        ),
                      ...[
                        for (final e in snapshot.data ?? <FileSystemEntity>[])
                          ListTile(
                            leading: const Icon(Icons.folder),
                            title: Text(basename(e.path)),
                            onTap: () {
                              setDir(Directory(e.path));
                            },
                          )
                      ]
                    ],
                  );
                }
                // TODO handle future error
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 8,
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  label: Text(widget.cancelText),
                  icon: const Icon(Icons.cancel),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context, currentDir);
                  },
                  label: Text(widget.okText),
                  icon: const Icon(Icons.save),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
