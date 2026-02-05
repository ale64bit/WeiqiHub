// This is a generated file - do not edit.
//
// Generated from katago.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/struct.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class VersionRequest extends $pb.GeneratedMessage {
  factory VersionRequest({
    $core.String? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  VersionRequest._();

  factory VersionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VersionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VersionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'katago'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VersionRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VersionRequest copyWith(void Function(VersionRequest) updates) =>
      super.copyWith((message) => updates(message as VersionRequest))
          as VersionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VersionRequest create() => VersionRequest._();
  @$core.override
  VersionRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VersionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VersionRequest>(create);
  static VersionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class VersionResponse extends $pb.GeneratedMessage {
  factory VersionResponse({
    $core.String? version,
    $core.String? gitHash,
  }) {
    final result = create();
    if (version != null) result.version = version;
    if (gitHash != null) result.gitHash = gitHash;
    return result;
  }

  VersionResponse._();

  factory VersionResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VersionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VersionResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'katago'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'version')
    ..aOS(2, _omitFieldNames ? '' : 'gitHash')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VersionResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VersionResponse copyWith(void Function(VersionResponse) updates) =>
      super.copyWith((message) => updates(message as VersionResponse))
          as VersionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VersionResponse create() => VersionResponse._();
  @$core.override
  VersionResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VersionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VersionResponse>(create);
  static VersionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get version => $_getSZ(0);
  @$pb.TagNumber(1)
  set version($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get gitHash => $_getSZ(1);
  @$pb.TagNumber(2)
  set gitHash($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasGitHash() => $_has(1);
  @$pb.TagNumber(2)
  void clearGitHash() => $_clearField(2);
}

class Request_Move extends $pb.GeneratedMessage {
  factory Request_Move({
    $core.String? color,
    $core.String? point,
  }) {
    final result = create();
    if (color != null) result.color = color;
    if (point != null) result.point = point;
    return result;
  }

  Request_Move._();

  factory Request_Move.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Request_Move.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Request.Move',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'katago'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'color')
    ..aOS(2, _omitFieldNames ? '' : 'point')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Request_Move clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Request_Move copyWith(void Function(Request_Move) updates) =>
      super.copyWith((message) => updates(message as Request_Move))
          as Request_Move;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Request_Move create() => Request_Move._();
  @$core.override
  Request_Move createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Request_Move getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Request_Move>(create);
  static Request_Move? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get color => $_getSZ(0);
  @$pb.TagNumber(1)
  set color($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasColor() => $_has(0);
  @$pb.TagNumber(1)
  void clearColor() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get point => $_getSZ(1);
  @$pb.TagNumber(2)
  set point($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPoint() => $_has(1);
  @$pb.TagNumber(2)
  void clearPoint() => $_clearField(2);
}

class Request extends $pb.GeneratedMessage {
  factory Request({
    $core.String? id,
    $core.Iterable<Request_Move>? initialStones,
    $core.String? initialPlayer,
    $core.Iterable<Request_Move>? moves,
    $core.String? rules,
    $core.double? komi,
    $core.int? boardSize,
    $core.Iterable<$core.int>? analyzeTurns,
    $core.bool? includePolicy,
    $core.bool? includeOwnership,
    $core.bool? includeMovesOwnership,
    $core.int? maxVisits,
    $core.double? reportDuringSearchEvery,
    $core.Iterable<$core.MapEntry<$core.String, $1.Value>>? overrideSettings,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (initialStones != null) result.initialStones.addAll(initialStones);
    if (initialPlayer != null) result.initialPlayer = initialPlayer;
    if (moves != null) result.moves.addAll(moves);
    if (rules != null) result.rules = rules;
    if (komi != null) result.komi = komi;
    if (boardSize != null) result.boardSize = boardSize;
    if (analyzeTurns != null) result.analyzeTurns.addAll(analyzeTurns);
    if (includePolicy != null) result.includePolicy = includePolicy;
    if (includeOwnership != null) result.includeOwnership = includeOwnership;
    if (includeMovesOwnership != null)
      result.includeMovesOwnership = includeMovesOwnership;
    if (maxVisits != null) result.maxVisits = maxVisits;
    if (reportDuringSearchEvery != null)
      result.reportDuringSearchEvery = reportDuringSearchEvery;
    if (overrideSettings != null)
      result.overrideSettings.addEntries(overrideSettings);
    return result;
  }

  Request._();

  factory Request.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Request.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Request',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'katago'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..pPM<Request_Move>(2, _omitFieldNames ? '' : 'initialStones',
        subBuilder: Request_Move.create)
    ..aOS(3, _omitFieldNames ? '' : 'initialPlayer')
    ..pPM<Request_Move>(4, _omitFieldNames ? '' : 'moves',
        subBuilder: Request_Move.create)
    ..aOS(5, _omitFieldNames ? '' : 'rules')
    ..aD(6, _omitFieldNames ? '' : 'komi', fieldType: $pb.PbFieldType.OF)
    ..aI(7, _omitFieldNames ? '' : 'boardSize')
    ..p<$core.int>(8, _omitFieldNames ? '' : 'analyzeTurns', $pb.PbFieldType.K3)
    ..aOB(9, _omitFieldNames ? '' : 'includePolicy')
    ..aOB(10, _omitFieldNames ? '' : 'includeOwnership')
    ..aOB(11, _omitFieldNames ? '' : 'includeMovesOwnership')
    ..aI(12, _omitFieldNames ? '' : 'maxVisits')
    ..aD(13, _omitFieldNames ? '' : 'reportDuringSearchEvery',
        fieldType: $pb.PbFieldType.OF)
    ..m<$core.String, $1.Value>(14, _omitFieldNames ? '' : 'overrideSettings',
        entryClassName: 'Request.OverrideSettingsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $1.Value.create,
        valueDefaultOrMaker: $1.Value.getDefault,
        packageName: const $pb.PackageName('katago'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Request clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Request copyWith(void Function(Request) updates) =>
      super.copyWith((message) => updates(message as Request)) as Request;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Request create() => Request._();
  @$core.override
  Request createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Request getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Request>(create);
  static Request? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<Request_Move> get initialStones => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get initialPlayer => $_getSZ(2);
  @$pb.TagNumber(3)
  set initialPlayer($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasInitialPlayer() => $_has(2);
  @$pb.TagNumber(3)
  void clearInitialPlayer() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<Request_Move> get moves => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get rules => $_getSZ(4);
  @$pb.TagNumber(5)
  set rules($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRules() => $_has(4);
  @$pb.TagNumber(5)
  void clearRules() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get komi => $_getN(5);
  @$pb.TagNumber(6)
  set komi($core.double value) => $_setFloat(5, value);
  @$pb.TagNumber(6)
  $core.bool hasKomi() => $_has(5);
  @$pb.TagNumber(6)
  void clearKomi() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get boardSize => $_getIZ(6);
  @$pb.TagNumber(7)
  set boardSize($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBoardSize() => $_has(6);
  @$pb.TagNumber(7)
  void clearBoardSize() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbList<$core.int> get analyzeTurns => $_getList(7);

  @$pb.TagNumber(9)
  $core.bool get includePolicy => $_getBF(8);
  @$pb.TagNumber(9)
  set includePolicy($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasIncludePolicy() => $_has(8);
  @$pb.TagNumber(9)
  void clearIncludePolicy() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.bool get includeOwnership => $_getBF(9);
  @$pb.TagNumber(10)
  set includeOwnership($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasIncludeOwnership() => $_has(9);
  @$pb.TagNumber(10)
  void clearIncludeOwnership() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.bool get includeMovesOwnership => $_getBF(10);
  @$pb.TagNumber(11)
  set includeMovesOwnership($core.bool value) => $_setBool(10, value);
  @$pb.TagNumber(11)
  $core.bool hasIncludeMovesOwnership() => $_has(10);
  @$pb.TagNumber(11)
  void clearIncludeMovesOwnership() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.int get maxVisits => $_getIZ(11);
  @$pb.TagNumber(12)
  set maxVisits($core.int value) => $_setSignedInt32(11, value);
  @$pb.TagNumber(12)
  $core.bool hasMaxVisits() => $_has(11);
  @$pb.TagNumber(12)
  void clearMaxVisits() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.double get reportDuringSearchEvery => $_getN(12);
  @$pb.TagNumber(13)
  set reportDuringSearchEvery($core.double value) => $_setFloat(12, value);
  @$pb.TagNumber(13)
  $core.bool hasReportDuringSearchEvery() => $_has(12);
  @$pb.TagNumber(13)
  void clearReportDuringSearchEvery() => $_clearField(13);

  @$pb.TagNumber(14)
  $pb.PbMap<$core.String, $1.Value> get overrideSettings => $_getMap(13);
}

class Response_RootInfo extends $pb.GeneratedMessage {
  factory Response_RootInfo({
    $core.String? currentPlayer,
    $core.double? scoreLead,
    $core.double? winrate,
  }) {
    final result = create();
    if (currentPlayer != null) result.currentPlayer = currentPlayer;
    if (scoreLead != null) result.scoreLead = scoreLead;
    if (winrate != null) result.winrate = winrate;
    return result;
  }

  Response_RootInfo._();

  factory Response_RootInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Response_RootInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Response.RootInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'katago'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'currentPlayer')
    ..aD(2, _omitFieldNames ? '' : 'scoreLead')
    ..aD(3, _omitFieldNames ? '' : 'winrate')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Response_RootInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Response_RootInfo copyWith(void Function(Response_RootInfo) updates) =>
      super.copyWith((message) => updates(message as Response_RootInfo))
          as Response_RootInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Response_RootInfo create() => Response_RootInfo._();
  @$core.override
  Response_RootInfo createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Response_RootInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Response_RootInfo>(create);
  static Response_RootInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get currentPlayer => $_getSZ(0);
  @$pb.TagNumber(1)
  set currentPlayer($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCurrentPlayer() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentPlayer() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get scoreLead => $_getN(1);
  @$pb.TagNumber(2)
  set scoreLead($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasScoreLead() => $_has(1);
  @$pb.TagNumber(2)
  void clearScoreLead() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get winrate => $_getN(2);
  @$pb.TagNumber(3)
  set winrate($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasWinrate() => $_has(2);
  @$pb.TagNumber(3)
  void clearWinrate() => $_clearField(3);
}

class Response_MoveInfo extends $pb.GeneratedMessage {
  factory Response_MoveInfo({
    $core.String? move,
    $core.int? order,
    $core.double? scoreLead,
    $core.double? winrate,
    $core.int? visits,
    $core.Iterable<$core.String>? pv,
    $core.Iterable<$core.double>? ownership,
  }) {
    final result = create();
    if (move != null) result.move = move;
    if (order != null) result.order = order;
    if (scoreLead != null) result.scoreLead = scoreLead;
    if (winrate != null) result.winrate = winrate;
    if (visits != null) result.visits = visits;
    if (pv != null) result.pv.addAll(pv);
    if (ownership != null) result.ownership.addAll(ownership);
    return result;
  }

  Response_MoveInfo._();

  factory Response_MoveInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Response_MoveInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Response.MoveInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'katago'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'move')
    ..aI(2, _omitFieldNames ? '' : 'order')
    ..aD(3, _omitFieldNames ? '' : 'scoreLead')
    ..aD(4, _omitFieldNames ? '' : 'winrate')
    ..aI(5, _omitFieldNames ? '' : 'visits')
    ..pPS(6, _omitFieldNames ? '' : 'pv')
    ..p<$core.double>(7, _omitFieldNames ? '' : 'ownership', $pb.PbFieldType.KD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Response_MoveInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Response_MoveInfo copyWith(void Function(Response_MoveInfo) updates) =>
      super.copyWith((message) => updates(message as Response_MoveInfo))
          as Response_MoveInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Response_MoveInfo create() => Response_MoveInfo._();
  @$core.override
  Response_MoveInfo createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Response_MoveInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Response_MoveInfo>(create);
  static Response_MoveInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get move => $_getSZ(0);
  @$pb.TagNumber(1)
  set move($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMove() => $_has(0);
  @$pb.TagNumber(1)
  void clearMove() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get order => $_getIZ(1);
  @$pb.TagNumber(2)
  set order($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOrder() => $_has(1);
  @$pb.TagNumber(2)
  void clearOrder() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get scoreLead => $_getN(2);
  @$pb.TagNumber(3)
  set scoreLead($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasScoreLead() => $_has(2);
  @$pb.TagNumber(3)
  void clearScoreLead() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get winrate => $_getN(3);
  @$pb.TagNumber(4)
  set winrate($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasWinrate() => $_has(3);
  @$pb.TagNumber(4)
  void clearWinrate() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get visits => $_getIZ(4);
  @$pb.TagNumber(5)
  set visits($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasVisits() => $_has(4);
  @$pb.TagNumber(5)
  void clearVisits() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get pv => $_getList(5);

  @$pb.TagNumber(7)
  $pb.PbList<$core.double> get ownership => $_getList(6);
}

class Response extends $pb.GeneratedMessage {
  factory Response({
    $core.String? id,
    $core.bool? isDuringSearch,
    $core.int? turnNumber,
    Response_RootInfo? rootInfo,
    $core.Iterable<Response_MoveInfo>? moveInfos,
    $core.Iterable<$core.double>? policy,
    $core.Iterable<$core.double>? humanPolicy,
    $core.Iterable<$core.double>? ownership,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (isDuringSearch != null) result.isDuringSearch = isDuringSearch;
    if (turnNumber != null) result.turnNumber = turnNumber;
    if (rootInfo != null) result.rootInfo = rootInfo;
    if (moveInfos != null) result.moveInfos.addAll(moveInfos);
    if (policy != null) result.policy.addAll(policy);
    if (humanPolicy != null) result.humanPolicy.addAll(humanPolicy);
    if (ownership != null) result.ownership.addAll(ownership);
    return result;
  }

  Response._();

  factory Response.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Response',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'katago'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOB(2, _omitFieldNames ? '' : 'isDuringSearch')
    ..aI(3, _omitFieldNames ? '' : 'turnNumber')
    ..aOM<Response_RootInfo>(4, _omitFieldNames ? '' : 'rootInfo',
        subBuilder: Response_RootInfo.create)
    ..pPM<Response_MoveInfo>(5, _omitFieldNames ? '' : 'moveInfos',
        subBuilder: Response_MoveInfo.create)
    ..p<$core.double>(6, _omitFieldNames ? '' : 'policy', $pb.PbFieldType.KD)
    ..p<$core.double>(
        7, _omitFieldNames ? '' : 'humanPolicy', $pb.PbFieldType.KD)
    ..p<$core.double>(8, _omitFieldNames ? '' : 'ownership', $pb.PbFieldType.KD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Response clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Response copyWith(void Function(Response) updates) =>
      super.copyWith((message) => updates(message as Response)) as Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Response create() => Response._();
  @$core.override
  Response createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Response getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Response>(create);
  static Response? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get isDuringSearch => $_getBF(1);
  @$pb.TagNumber(2)
  set isDuringSearch($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIsDuringSearch() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsDuringSearch() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get turnNumber => $_getIZ(2);
  @$pb.TagNumber(3)
  set turnNumber($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTurnNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearTurnNumber() => $_clearField(3);

  @$pb.TagNumber(4)
  Response_RootInfo get rootInfo => $_getN(3);
  @$pb.TagNumber(4)
  set rootInfo(Response_RootInfo value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasRootInfo() => $_has(3);
  @$pb.TagNumber(4)
  void clearRootInfo() => $_clearField(4);
  @$pb.TagNumber(4)
  Response_RootInfo ensureRootInfo() => $_ensure(3);

  @$pb.TagNumber(5)
  $pb.PbList<Response_MoveInfo> get moveInfos => $_getList(4);

  @$pb.TagNumber(6)
  $pb.PbList<$core.double> get policy => $_getList(5);

  @$pb.TagNumber(7)
  $pb.PbList<$core.double> get humanPolicy => $_getList(6);

  @$pb.TagNumber(8)
  $pb.PbList<$core.double> get ownership => $_getList(7);
}

class TerminateRequest extends $pb.GeneratedMessage {
  factory TerminateRequest({
    $core.String? id,
    $core.String? terminateId,
    $core.Iterable<$core.int>? turnNumbers,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (terminateId != null) result.terminateId = terminateId;
    if (turnNumbers != null) result.turnNumbers.addAll(turnNumbers);
    return result;
  }

  TerminateRequest._();

  factory TerminateRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TerminateRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TerminateRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'katago'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'terminateId')
    ..p<$core.int>(3, _omitFieldNames ? '' : 'turnNumbers', $pb.PbFieldType.K3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TerminateRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TerminateRequest copyWith(void Function(TerminateRequest) updates) =>
      super.copyWith((message) => updates(message as TerminateRequest))
          as TerminateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TerminateRequest create() => TerminateRequest._();
  @$core.override
  TerminateRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TerminateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TerminateRequest>(create);
  static TerminateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get terminateId => $_getSZ(1);
  @$pb.TagNumber(2)
  set terminateId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTerminateId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTerminateId() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<$core.int> get turnNumbers => $_getList(2);
}

class TerminateResponse extends $pb.GeneratedMessage {
  factory TerminateResponse() => create();

  TerminateResponse._();

  factory TerminateResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TerminateResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TerminateResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'katago'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TerminateResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TerminateResponse copyWith(void Function(TerminateResponse) updates) =>
      super.copyWith((message) => updates(message as TerminateResponse))
          as TerminateResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TerminateResponse create() => TerminateResponse._();
  @$core.override
  TerminateResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TerminateResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TerminateResponse>(create);
  static TerminateResponse? _defaultInstance;
}

class TerminateAllRequest extends $pb.GeneratedMessage {
  factory TerminateAllRequest({
    $core.String? id,
    $core.Iterable<$core.int>? turnNumbers,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (turnNumbers != null) result.turnNumbers.addAll(turnNumbers);
    return result;
  }

  TerminateAllRequest._();

  factory TerminateAllRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TerminateAllRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TerminateAllRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'katago'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..p<$core.int>(3, _omitFieldNames ? '' : 'turnNumbers', $pb.PbFieldType.K3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TerminateAllRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TerminateAllRequest copyWith(void Function(TerminateAllRequest) updates) =>
      super.copyWith((message) => updates(message as TerminateAllRequest))
          as TerminateAllRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TerminateAllRequest create() => TerminateAllRequest._();
  @$core.override
  TerminateAllRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TerminateAllRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TerminateAllRequest>(create);
  static TerminateAllRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(3)
  $pb.PbList<$core.int> get turnNumbers => $_getList(1);
}

class TerminateAllResponse extends $pb.GeneratedMessage {
  factory TerminateAllResponse() => create();

  TerminateAllResponse._();

  factory TerminateAllResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TerminateAllResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TerminateAllResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'katago'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TerminateAllResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TerminateAllResponse copyWith(void Function(TerminateAllResponse) updates) =>
      super.copyWith((message) => updates(message as TerminateAllResponse))
          as TerminateAllResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TerminateAllResponse create() => TerminateAllResponse._();
  @$core.override
  TerminateAllResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TerminateAllResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TerminateAllResponse>(create);
  static TerminateAllResponse? _defaultInstance;
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
