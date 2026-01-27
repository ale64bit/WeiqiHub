import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:wqhub/analysis/katago.dart';
import 'package:wqhub/analysis/katago_request.dart';
import 'package:wqhub/analysis/katago_response.dart';

class RemoteKataGo implements KataGo {
  final _logger = Logger('RemoteKataGo');
  final http.Client httpClient;
  final Uri endpoint;
  final int boardSize;

  RemoteKataGo(
      {required this.httpClient,
      required this.endpoint,
      required this.boardSize});

  @override
  Future<VersionResponse> version() {
    _logger.warning('query_version not supported');
    throw UnimplementedError();
  }

  @override
  Stream<KataGoResponse> query(KataGoRequest req) async* {
    final httpReq = http.Request(
      'POST',
      endpoint.replace(pathSegments: ['query']),
    );
    httpReq.body = jsonEncode(req.toJson());
    final httpResp = await httpClient.send(httpReq);
    final lines =
        httpResp.stream.transform(utf8.decoder).transform(const LineSplitter());
    await for (final line in lines) {
      if (line.startsWith('data:')) {
        yield KataGoResponse.fromJson(jsonDecode(line.substring(5)), boardSize);
        await Future.delayed(Duration.zero);
      }
    }
  }

  @override
  void terminate(TerminateRequest req) {
    _logger.warning('terminate not supported');
  }

  @override
  void terminateAll(TerminateAllRequest req) {
    _logger.warning('terminate_all not supported');
  }

  @override
  void clearCache() {
    _logger.warning('clear_cache not supported');
  }
}
