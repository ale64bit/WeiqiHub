// This is a generated file - do not edit.
//
// Generated from katago.proto.

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

import 'katago.pb.dart' as $0;

export 'katago.pb.dart';

@$pb.GrpcServiceName('katago.KataGo')
class KataGoClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  KataGoClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.VersionResponse> version(
    $0.VersionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$version, request, options: options);
  }

  $grpc.ResponseStream<$0.Response> query(
    $0.Request request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(_$query, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.TerminateResponse> terminate(
    $0.TerminateRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$terminate, request, options: options);
  }

  $grpc.ResponseFuture<$0.TerminateAllResponse> terminateAll(
    $0.TerminateAllRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$terminateAll, request, options: options);
  }

  // method descriptors

  static final _$version =
      $grpc.ClientMethod<$0.VersionRequest, $0.VersionResponse>(
          '/katago.KataGo/Version',
          ($0.VersionRequest value) => value.writeToBuffer(),
          $0.VersionResponse.fromBuffer);
  static final _$query = $grpc.ClientMethod<$0.Request, $0.Response>(
      '/katago.KataGo/Query',
      ($0.Request value) => value.writeToBuffer(),
      $0.Response.fromBuffer);
  static final _$terminate =
      $grpc.ClientMethod<$0.TerminateRequest, $0.TerminateResponse>(
          '/katago.KataGo/Terminate',
          ($0.TerminateRequest value) => value.writeToBuffer(),
          $0.TerminateResponse.fromBuffer);
  static final _$terminateAll =
      $grpc.ClientMethod<$0.TerminateAllRequest, $0.TerminateAllResponse>(
          '/katago.KataGo/TerminateAll',
          ($0.TerminateAllRequest value) => value.writeToBuffer(),
          $0.TerminateAllResponse.fromBuffer);
}

@$pb.GrpcServiceName('katago.KataGo')
abstract class KataGoServiceBase extends $grpc.Service {
  $core.String get $name => 'katago.KataGo';

  KataGoServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.VersionRequest, $0.VersionResponse>(
        'Version',
        version_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.VersionRequest.fromBuffer(value),
        ($0.VersionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Request, $0.Response>(
        'Query',
        query_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.Request.fromBuffer(value),
        ($0.Response value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TerminateRequest, $0.TerminateResponse>(
        'Terminate',
        terminate_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TerminateRequest.fromBuffer(value),
        ($0.TerminateResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.TerminateAllRequest, $0.TerminateAllResponse>(
            'TerminateAll',
            terminateAll_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.TerminateAllRequest.fromBuffer(value),
            ($0.TerminateAllResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.VersionResponse> version_Pre($grpc.ServiceCall $call,
      $async.Future<$0.VersionRequest> $request) async {
    return version($call, await $request);
  }

  $async.Future<$0.VersionResponse> version(
      $grpc.ServiceCall call, $0.VersionRequest request);

  $async.Stream<$0.Response> query_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.Request> $request) async* {
    yield* query($call, await $request);
  }

  $async.Stream<$0.Response> query($grpc.ServiceCall call, $0.Request request);

  $async.Future<$0.TerminateResponse> terminate_Pre($grpc.ServiceCall $call,
      $async.Future<$0.TerminateRequest> $request) async {
    return terminate($call, await $request);
  }

  $async.Future<$0.TerminateResponse> terminate(
      $grpc.ServiceCall call, $0.TerminateRequest request);

  $async.Future<$0.TerminateAllResponse> terminateAll_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.TerminateAllRequest> $request) async {
    return terminateAll($call, await $request);
  }

  $async.Future<$0.TerminateAllResponse> terminateAll(
      $grpc.ServiceCall call, $0.TerminateAllRequest request);
}
