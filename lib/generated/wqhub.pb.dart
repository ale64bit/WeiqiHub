// This is a generated file - do not edit.
//
// Generated from wqhub.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class TestReq extends $pb.GeneratedMessage {
  factory TestReq({
    $core.String? msg,
  }) {
    final result = create();
    if (msg != null) result.msg = msg;
    return result;
  }

  TestReq._();

  factory TestReq.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TestReq.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TestReq',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wqhub'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TestReq clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TestReq copyWith(void Function(TestReq) updates) =>
      super.copyWith((message) => updates(message as TestReq)) as TestReq;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TestReq create() => TestReq._();
  @$core.override
  TestReq createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TestReq getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TestReq>(create);
  static TestReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get msg => $_getSZ(0);
  @$pb.TagNumber(1)
  set msg($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMsg() => $_has(0);
  @$pb.TagNumber(1)
  void clearMsg() => $_clearField(1);
}

class TestResp extends $pb.GeneratedMessage {
  factory TestResp({
    $core.String? respMsg,
  }) {
    final result = create();
    if (respMsg != null) result.respMsg = respMsg;
    return result;
  }

  TestResp._();

  factory TestResp.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TestResp.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TestResp',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wqhub'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'respMsg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TestResp clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TestResp copyWith(void Function(TestResp) updates) =>
      super.copyWith((message) => updates(message as TestResp)) as TestResp;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TestResp create() => TestResp._();
  @$core.override
  TestResp createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TestResp getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TestResp>(create);
  static TestResp? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get respMsg => $_getSZ(0);
  @$pb.TagNumber(1)
  set respMsg($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRespMsg() => $_has(0);
  @$pb.TagNumber(1)
  void clearRespMsg() => $_clearField(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
