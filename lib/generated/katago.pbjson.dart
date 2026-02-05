// This is a generated file - do not edit.
//
// Generated from katago.proto.

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

@$core.Deprecated('Use versionRequestDescriptor instead')
const VersionRequest$json = {
  '1': 'VersionRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `VersionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List versionRequestDescriptor =
    $convert.base64Decode('Cg5WZXJzaW9uUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQ=');

@$core.Deprecated('Use versionResponseDescriptor instead')
const VersionResponse$json = {
  '1': 'VersionResponse',
  '2': [
    {'1': 'version', '3': 1, '4': 1, '5': 9, '10': 'version'},
    {'1': 'git_hash', '3': 2, '4': 1, '5': 9, '10': 'gitHash'},
  ],
};

/// Descriptor for `VersionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List versionResponseDescriptor = $convert.base64Decode(
    'Cg9WZXJzaW9uUmVzcG9uc2USGAoHdmVyc2lvbhgBIAEoCVIHdmVyc2lvbhIZCghnaXRfaGFzaB'
    'gCIAEoCVIHZ2l0SGFzaA==');

@$core.Deprecated('Use requestDescriptor instead')
const Request$json = {
  '1': 'Request',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'initial_stones',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.katago.Request.Move',
      '10': 'initialStones'
    },
    {'1': 'initial_player', '3': 3, '4': 1, '5': 9, '10': 'initialPlayer'},
    {
      '1': 'moves',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.katago.Request.Move',
      '10': 'moves'
    },
    {'1': 'rules', '3': 5, '4': 1, '5': 9, '10': 'rules'},
    {'1': 'komi', '3': 6, '4': 1, '5': 2, '10': 'komi'},
    {'1': 'board_size', '3': 7, '4': 1, '5': 5, '10': 'boardSize'},
    {'1': 'analyze_turns', '3': 8, '4': 3, '5': 5, '10': 'analyzeTurns'},
    {'1': 'include_policy', '3': 9, '4': 1, '5': 8, '10': 'includePolicy'},
    {
      '1': 'include_ownership',
      '3': 10,
      '4': 1,
      '5': 8,
      '10': 'includeOwnership'
    },
    {
      '1': 'include_moves_ownership',
      '3': 11,
      '4': 1,
      '5': 8,
      '10': 'includeMovesOwnership'
    },
    {'1': 'max_visits', '3': 12, '4': 1, '5': 5, '10': 'maxVisits'},
    {
      '1': 'report_during_search_every',
      '3': 13,
      '4': 1,
      '5': 2,
      '10': 'reportDuringSearchEvery'
    },
    {
      '1': 'override_settings',
      '3': 14,
      '4': 3,
      '5': 11,
      '6': '.katago.Request.OverrideSettingsEntry',
      '10': 'overrideSettings'
    },
  ],
  '3': [Request_Move$json, Request_OverrideSettingsEntry$json],
};

@$core.Deprecated('Use requestDescriptor instead')
const Request_Move$json = {
  '1': 'Move',
  '2': [
    {'1': 'color', '3': 1, '4': 1, '5': 9, '10': 'color'},
    {'1': 'point', '3': 2, '4': 1, '5': 9, '10': 'point'},
  ],
};

@$core.Deprecated('Use requestDescriptor instead')
const Request_OverrideSettingsEntry$json = {
  '1': 'OverrideSettingsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Value',
      '10': 'value'
    },
  ],
  '7': {'7': true},
};

/// Descriptor for `Request`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestDescriptor = $convert.base64Decode(
    'CgdSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZBI7Cg5pbml0aWFsX3N0b25lcxgCIAMoCzIULmthdG'
    'Fnby5SZXF1ZXN0Lk1vdmVSDWluaXRpYWxTdG9uZXMSJQoOaW5pdGlhbF9wbGF5ZXIYAyABKAlS'
    'DWluaXRpYWxQbGF5ZXISKgoFbW92ZXMYBCADKAsyFC5rYXRhZ28uUmVxdWVzdC5Nb3ZlUgVtb3'
    'ZlcxIUCgVydWxlcxgFIAEoCVIFcnVsZXMSEgoEa29taRgGIAEoAlIEa29taRIdCgpib2FyZF9z'
    'aXplGAcgASgFUglib2FyZFNpemUSIwoNYW5hbHl6ZV90dXJucxgIIAMoBVIMYW5hbHl6ZVR1cm'
    '5zEiUKDmluY2x1ZGVfcG9saWN5GAkgASgIUg1pbmNsdWRlUG9saWN5EisKEWluY2x1ZGVfb3du'
    'ZXJzaGlwGAogASgIUhBpbmNsdWRlT3duZXJzaGlwEjYKF2luY2x1ZGVfbW92ZXNfb3duZXJzaG'
    'lwGAsgASgIUhVpbmNsdWRlTW92ZXNPd25lcnNoaXASHQoKbWF4X3Zpc2l0cxgMIAEoBVIJbWF4'
    'VmlzaXRzEjsKGnJlcG9ydF9kdXJpbmdfc2VhcmNoX2V2ZXJ5GA0gASgCUhdyZXBvcnREdXJpbm'
    'dTZWFyY2hFdmVyeRJSChFvdmVycmlkZV9zZXR0aW5ncxgOIAMoCzIlLmthdGFnby5SZXF1ZXN0'
    'Lk92ZXJyaWRlU2V0dGluZ3NFbnRyeVIQb3ZlcnJpZGVTZXR0aW5ncxoyCgRNb3ZlEhQKBWNvbG'
    '9yGAEgASgJUgVjb2xvchIUCgVwb2ludBgCIAEoCVIFcG9pbnQaWwoVT3ZlcnJpZGVTZXR0aW5n'
    'c0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EiwKBXZhbHVlGAIgASgLMhYuZ29vZ2xlLnByb3RvYn'
    'VmLlZhbHVlUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use responseDescriptor instead')
const Response$json = {
  '1': 'Response',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'is_during_search', '3': 2, '4': 1, '5': 8, '10': 'isDuringSearch'},
    {'1': 'turn_number', '3': 3, '4': 1, '5': 5, '10': 'turnNumber'},
    {
      '1': 'root_info',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.katago.Response.RootInfo',
      '10': 'rootInfo'
    },
    {
      '1': 'move_infos',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.katago.Response.MoveInfo',
      '10': 'moveInfos'
    },
    {'1': 'policy', '3': 6, '4': 3, '5': 1, '10': 'policy'},
    {'1': 'human_policy', '3': 7, '4': 3, '5': 1, '10': 'humanPolicy'},
    {'1': 'ownership', '3': 8, '4': 3, '5': 1, '10': 'ownership'},
  ],
  '3': [Response_RootInfo$json, Response_MoveInfo$json],
};

@$core.Deprecated('Use responseDescriptor instead')
const Response_RootInfo$json = {
  '1': 'RootInfo',
  '2': [
    {'1': 'current_player', '3': 1, '4': 1, '5': 9, '10': 'currentPlayer'},
    {'1': 'score_lead', '3': 2, '4': 1, '5': 1, '10': 'scoreLead'},
    {'1': 'winrate', '3': 3, '4': 1, '5': 1, '10': 'winrate'},
  ],
};

@$core.Deprecated('Use responseDescriptor instead')
const Response_MoveInfo$json = {
  '1': 'MoveInfo',
  '2': [
    {'1': 'move', '3': 1, '4': 1, '5': 9, '10': 'move'},
    {'1': 'order', '3': 2, '4': 1, '5': 5, '10': 'order'},
    {'1': 'score_lead', '3': 3, '4': 1, '5': 1, '10': 'scoreLead'},
    {'1': 'winrate', '3': 4, '4': 1, '5': 1, '10': 'winrate'},
    {'1': 'visits', '3': 5, '4': 1, '5': 5, '10': 'visits'},
    {'1': 'pv', '3': 6, '4': 3, '5': 9, '10': 'pv'},
    {'1': 'ownership', '3': 7, '4': 3, '5': 1, '10': 'ownership'},
  ],
};

/// Descriptor for `Response`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List responseDescriptor = $convert.base64Decode(
    'CghSZXNwb25zZRIOCgJpZBgBIAEoCVICaWQSKAoQaXNfZHVyaW5nX3NlYXJjaBgCIAEoCFIOaX'
    'NEdXJpbmdTZWFyY2gSHwoLdHVybl9udW1iZXIYAyABKAVSCnR1cm5OdW1iZXISNgoJcm9vdF9p'
    'bmZvGAQgASgLMhkua2F0YWdvLlJlc3BvbnNlLlJvb3RJbmZvUghyb290SW5mbxI4Cgptb3ZlX2'
    'luZm9zGAUgAygLMhkua2F0YWdvLlJlc3BvbnNlLk1vdmVJbmZvUgltb3ZlSW5mb3MSFgoGcG9s'
    'aWN5GAYgAygBUgZwb2xpY3kSIQoMaHVtYW5fcG9saWN5GAcgAygBUgtodW1hblBvbGljeRIcCg'
    'lvd25lcnNoaXAYCCADKAFSCW93bmVyc2hpcBpqCghSb290SW5mbxIlCg5jdXJyZW50X3BsYXll'
    'chgBIAEoCVINY3VycmVudFBsYXllchIdCgpzY29yZV9sZWFkGAIgASgBUglzY29yZUxlYWQSGA'
    'oHd2lucmF0ZRgDIAEoAVIHd2lucmF0ZRqzAQoITW92ZUluZm8SEgoEbW92ZRgBIAEoCVIEbW92'
    'ZRIUCgVvcmRlchgCIAEoBVIFb3JkZXISHQoKc2NvcmVfbGVhZBgDIAEoAVIJc2NvcmVMZWFkEh'
    'gKB3dpbnJhdGUYBCABKAFSB3dpbnJhdGUSFgoGdmlzaXRzGAUgASgFUgZ2aXNpdHMSDgoCcHYY'
    'BiADKAlSAnB2EhwKCW93bmVyc2hpcBgHIAMoAVIJb3duZXJzaGlw');

@$core.Deprecated('Use terminateRequestDescriptor instead')
const TerminateRequest$json = {
  '1': 'TerminateRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'terminate_id', '3': 2, '4': 1, '5': 9, '10': 'terminateId'},
    {'1': 'turn_numbers', '3': 3, '4': 3, '5': 5, '10': 'turnNumbers'},
  ],
};

/// Descriptor for `TerminateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List terminateRequestDescriptor = $convert.base64Decode(
    'ChBUZXJtaW5hdGVSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZBIhCgx0ZXJtaW5hdGVfaWQYAiABKA'
    'lSC3Rlcm1pbmF0ZUlkEiEKDHR1cm5fbnVtYmVycxgDIAMoBVILdHVybk51bWJlcnM=');

@$core.Deprecated('Use terminateResponseDescriptor instead')
const TerminateResponse$json = {
  '1': 'TerminateResponse',
};

/// Descriptor for `TerminateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List terminateResponseDescriptor =
    $convert.base64Decode('ChFUZXJtaW5hdGVSZXNwb25zZQ==');

@$core.Deprecated('Use terminateAllRequestDescriptor instead')
const TerminateAllRequest$json = {
  '1': 'TerminateAllRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'turn_numbers', '3': 3, '4': 3, '5': 5, '10': 'turnNumbers'},
  ],
};

/// Descriptor for `TerminateAllRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List terminateAllRequestDescriptor = $convert.base64Decode(
    'ChNUZXJtaW5hdGVBbGxSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZBIhCgx0dXJuX251bWJlcnMYAy'
    'ADKAVSC3R1cm5OdW1iZXJz');

@$core.Deprecated('Use terminateAllResponseDescriptor instead')
const TerminateAllResponse$json = {
  '1': 'TerminateAllResponse',
};

/// Descriptor for `TerminateAllResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List terminateAllResponseDescriptor =
    $convert.base64Decode('ChRUZXJtaW5hdGVBbGxSZXNwb25zZQ==');
