// This is a generated file - do not edit.
//
// Generated from wqhub.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'wqhub.pb.dart' as $0;

export 'wqhub.pb.dart';

@$pb.GrpcServiceName('wqhub.Test')
class TestClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  TestClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.TestResp> testCall(
    $0.TestReq request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$testCall, request, options: options);
  }

  // method descriptors

  static final _$testCall = $grpc.ClientMethod<$0.TestReq, $0.TestResp>(
      '/wqhub.Test/TestCall',
      ($0.TestReq value) => value.writeToBuffer(),
      $0.TestResp.fromBuffer);
}

@$pb.GrpcServiceName('wqhub.Test')
abstract class TestServiceBase extends $grpc.Service {
  $core.String get $name => 'wqhub.Test';

  TestServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.TestReq, $0.TestResp>(
        'TestCall',
        testCall_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TestReq.fromBuffer(value),
        ($0.TestResp value) => value.writeToBuffer()));
  }

  $async.Future<$0.TestResp> testCall_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.TestReq> $request) async {
    return testCall($call, await $request);
  }

  $async.Future<$0.TestResp> testCall(
      $grpc.ServiceCall call, $0.TestReq request);
}
