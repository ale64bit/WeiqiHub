import 'package:grpc/service_api.dart';
import 'package:logging/logging.dart';
import 'package:wqhub/analysis/katago.dart';
import 'package:wqhub/analysis/katago_request.dart';
import 'package:wqhub/analysis/katago_response.dart';
import 'package:wqhub/generated/katago.pbgrpc.dart' as pbgrpc;

class RemoteKataGo implements KataGo {
  final _logger = Logger('RemoteKataGo');
  final ClientChannel channel;
  final int boardSize;
  final pbgrpc.KataGoClient client;

  RemoteKataGo({required this.channel, required this.boardSize})
      : client = pbgrpc.KataGoClient(channel);

  @override
  Stream<KataGoResponse> query(KataGoRequest req) async* {
    await for (final resp in client.query(req.toProto())) {
      yield KataGoResponse.fromProto(resp, boardSize);
    }
  }

  @override
  void terminate(TerminateRequest req) async {
    await client.terminate(req.toProto());
  }

  @override
  void terminateAll(TerminateAllRequest req) async {
    await client.terminateAll(req.toProto());
  }

  @override
  Future<VersionResponse> version() {
    _logger.warning('query_version not supported');
    // TODO: implement version
    throw UnimplementedError();
  }
}
