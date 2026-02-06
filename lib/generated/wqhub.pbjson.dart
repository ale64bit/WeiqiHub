// This is a generated file - do not edit.
//
// Generated from wqhub.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use testReqDescriptor instead')
const TestReq$json = {
  '1': 'TestReq',
  '2': [
    {'1': 'msg', '3': 1, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `TestReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List testReqDescriptor =
    $convert.base64Decode('CgdUZXN0UmVxEhAKA21zZxgBIAEoCVIDbXNn');

@$core.Deprecated('Use testRespDescriptor instead')
const TestResp$json = {
  '1': 'TestResp',
  '2': [
    {'1': 'resp_msg', '3': 1, '4': 1, '5': 9, '10': 'respMsg'},
  ],
};

/// Descriptor for `TestResp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List testRespDescriptor = $convert
    .base64Decode('CghUZXN0UmVzcBIZCghyZXNwX21zZxgBIAEoCVIHcmVzcE1zZw==');
