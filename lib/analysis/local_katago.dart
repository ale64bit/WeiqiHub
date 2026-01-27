import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:logging/logging.dart';
import 'package:wqhub/analysis/katago.dart';
import 'package:wqhub/analysis/katago_request.dart';
import 'package:wqhub/analysis/katago_response.dart';

class LocalKataGoConfig {
  final String binaryPath;
  final String configPath;
  final String modelPath;
  final String? humanModelPath;

  const LocalKataGoConfig({
    required this.binaryPath,
    required this.configPath,
    required this.modelPath,
    this.humanModelPath,
  });
}

class LocalKataGo implements KataGo {
  final IOSink input;
  final Map<String, StreamController<KataGoResponse>> queries;
  final Function() kill;
  final bool hasHumanModel;

  LocalKataGo._({
    required this.input,
    required this.queries,
    required this.kill,
    required this.hasHumanModel,
  });

  static Future<LocalKataGo> create(LocalKataGoConfig config) async {
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

    return LocalKataGo._(
      input: proc.stdin,
      queries: queries,
      kill: () => proc.kill(),
      hasHumanModel: config.humanModelPath != null,
    );
  }

  @override
  Future<VersionResponse> version() =>
      throw UnimplementedError('Version not supported');

  @override
  Stream<KataGoResponse> query(KataGoRequest req) {
    input.writeln(jsonEncode(req.toJson()));
    final controller = StreamController<KataGoResponse>();
    queries[req.id] = controller;
    return controller.stream;
  }

  @override
  void terminate(TerminateRequest req) {
    input.writeln(jsonEncode(req.toJson()));
    queries.remove(req.terminateId);
  }

  @override
  void terminateAll(TerminateAllRequest req) {
    input.writeln(jsonEncode(req.toJson()));
    queries.clear();
  }

  @override
  void clearCache() {
    input.writeln(jsonEncode({
      'id': _randQueryId('clear_cache'),
      'action': 'clear_cache',
    }));
  }

  void dispose() {
    terminateAll(TerminateAllRequest(
      id: _randQueryId('terminate_all'),
    ));
    kill();
  }

  String _randQueryId(String prefix) =>
      '$prefix-${DateTime.now().millisecondsSinceEpoch}';

  static void _parseResponse(String line,
      Map<String, StreamController<KataGoResponse>> queries, Logger logger) {
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
