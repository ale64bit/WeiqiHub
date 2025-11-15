import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:wqhub/analysis/katago_request.dart';
import 'package:wqhub/analysis/katago_response.dart';

class KataGoConfig {
  final String binaryPath;
  final String configPath;
  final String modelPath;
  final String? humanModelPath;

  const KataGoConfig({
    required this.binaryPath,
    required this.configPath,
    required this.modelPath,
    this.humanModelPath,
  });
}

class KataGo {
  final IOSink input;
  final Map<String, StreamController<KataGoResponse>> queries;
  final Function() kill;
  final bool hasHumanModel;

  KataGo._({
    required this.input,
    required this.queries,
    required this.kill,
    required this.hasHumanModel,
  });

  static Future<KataGo> create(KataGoConfig config) async {
    final proc = await Process.start(config.binaryPath, [
      'analysis',
      '-config',
      config.configPath,
      '-model',
      config.modelPath,
      if (config.humanModelPath != null) ...[
        '-human-model',
        config.humanModelPath!
      ],
    ]);

    final logger = Logger('KataGo');
    final queries = <String, StreamController<KataGoResponse>>{};
    proc.stdout
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .forEach((line) => _parseResponse(line, queries, logger));
    proc.stderr
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .forEach((line) {
      logger.fine('stderr: $line');
    });
    proc.exitCode.then((code) {
      logger.fine('exit code: $code');
    });

    return KataGo._(
      input: proc.stdin,
      queries: queries,
      kill: () => proc.kill(),
      hasHumanModel: config.humanModelPath != null,
    );
  }

  Stream<KataGoResponse> query(KataGoRequest req) {
    input.writeln(jsonEncode(req.toJson()));
    final controller = StreamController<KataGoResponse>.new();
    queries[req.id] = controller;
    return controller.stream;
  }

  void cancelPendingQueries() {
    input.writeln(jsonEncode({
      'id': 'terminate_all-${DateTime.now().millisecondsSinceEpoch}',
      'action': 'terminate_all',
    }));
    queries.clear();
  }

  void dispose() {
    cancelPendingQueries();
    kill();
  }

  static void _parseResponse(String line,
      Map<String, StreamController<KataGoResponse>> queries, Logger logger) {
    logger.fine('line: "$line"');
    final json = jsonDecode(line);
    switch (json['action']) {
      case 'terminate_all':
        break;
      case null:
        final resp =
            KataGoResponse.fromJson(json, 19); // TODO fix board size injection
        final controller = queries[resp.id];
        if (controller != null) {
          controller.add(resp);
          if (!resp.isDuringSearch) {
            controller.close();
            queries.remove(resp.id);
          }
        }
    }
  }
}
