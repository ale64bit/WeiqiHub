import 'dart:async';
import 'package:wqhub/analysis/katago_request.dart';
import 'package:wqhub/analysis/katago_response.dart';
import 'package:wqhub/generated/katago.pb.dart' as katagopb;

class TerminateRequest {
  final String id;
  final String terminateId;
  final List<int>? turnNumbers;

  const TerminateRequest(
      {required this.id, required this.terminateId, this.turnNumbers});

  Map<String, dynamic> toJson() => {
        'id': id,
        'action': 'terminate',
        'terminateId': terminateId,
        if (turnNumbers != null) 'turnNumbers': turnNumbers,
      };

  katagopb.TerminateRequest toProto() => katagopb.TerminateRequest(
        id: id,
        terminateId: terminateId,
        turnNumbers: turnNumbers,
      );
}

class TerminateAllRequest {
  final String id;
  final List<int>? turnNumbers;

  const TerminateAllRequest({required this.id, this.turnNumbers});

  Map<String, dynamic> toJson() => {
        'id': id,
        'action': 'terminate_all',
        if (turnNumbers != null) 'turnNumbers': turnNumbers,
      };

  katagopb.TerminateAllRequest toProto() => katagopb.TerminateAllRequest(
        id: id,
        turnNumbers: turnNumbers,
      );
}

class VersionResponse {
  final String version;
  final String gitHash;

  const VersionResponse({required this.version, required this.gitHash});
}

abstract interface class KataGo {
  Future<VersionResponse> version();
  Stream<KataGoResponse> query(KataGoRequest req);
  void terminate(TerminateRequest req);
  void terminateAll(TerminateAllRequest req);
}
