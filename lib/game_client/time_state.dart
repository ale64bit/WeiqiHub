import 'package:flutter/widgets.dart';

@immutable
class TimeState {
  final Duration mainTimeLeft;
  final Duration periodTimeLeft;
  final int periodCount;

  const TimeState(
      {required this.mainTimeLeft,
      required this.periodTimeLeft,
      required this.periodCount});

  @override
  int get hashCode => Object.hash(mainTimeLeft, periodTimeLeft, periodCount);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is TimeState &&
        other.mainTimeLeft == mainTimeLeft &&
        other.periodTimeLeft == periodTimeLeft &&
        other.periodCount == periodCount;
  }

  static const TimeState zero = TimeState(
    mainTimeLeft: Duration.zero,
    periodTimeLeft: Duration.zero,
    periodCount: 0,
  );

  bool get isOvertime => mainTimeLeft == Duration.zero;

  @override
  String toString() => '($mainTimeLeft - ${periodCount}x $periodTimeLeft)';
}
