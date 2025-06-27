import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/widgets.dart';

@immutable
class ServerFeatures {
  final bool manualCounting;
  final bool automaticCounting;
  final bool aiReferee;
  final IMap<int, int> aiRefereeMinMoveCount;
  final bool forcedCounting;
  final IMap<int, int> forcedCountingMinMoveCount;
  final bool localTimeControl;

  const ServerFeatures({
    required this.manualCounting,
    required this.automaticCounting,
    required this.aiReferee,
    required this.aiRefereeMinMoveCount,
    required this.forcedCounting,
    required this.forcedCountingMinMoveCount,
    required this.localTimeControl,
  });

  @override
  int get hashCode => Object.hash(
      manualCounting,
      automaticCounting,
      aiReferee,
      aiRefereeMinMoveCount,
      forcedCounting,
      forcedCountingMinMoveCount,
      localTimeControl);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is ServerFeatures &&
        other.manualCounting == manualCounting &&
        other.automaticCounting == automaticCounting &&
        other.aiReferee == aiReferee &&
        other.aiRefereeMinMoveCount == aiRefereeMinMoveCount &&
        other.forcedCounting == forcedCounting &&
        other.forcedCountingMinMoveCount == forcedCountingMinMoveCount &&
        other.localTimeControl == localTimeControl;
  }
}
