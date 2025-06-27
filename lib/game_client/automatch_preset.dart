import 'package:flutter/widgets.dart';
import 'package:wqhub/game_client/game_client.dart';
import 'package:wqhub/game_client/rules.dart';
import 'package:wqhub/game_client/time_control.dart';

@immutable
class AutomatchPreset {
  final String id;
  final int boardSize;
  final Variant variant;
  final Rules rules;
  final TimeControl timeControl;
  final int? playerCount;

  const AutomatchPreset(
      {required this.id,
      required this.boardSize,
      required this.variant,
      required this.rules,
      required this.timeControl,
      this.playerCount});

  @override
  int get hashCode =>
      Object.hash(id, boardSize, variant, rules, timeControl, playerCount);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is AutomatchPreset &&
        other.id == id &&
        other.boardSize == boardSize &&
        other.variant == variant &&
        other.rules == rules &&
        other.timeControl == timeControl &&
        other.playerCount == playerCount;
  }
}
