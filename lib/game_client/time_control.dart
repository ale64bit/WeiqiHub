import 'package:flutter/widgets.dart';

@immutable
class TimeControl {
  final Duration mainTime;
  final int periodCount;
  final Duration timePerPeriod;

  const TimeControl(
      {required this.mainTime,
      required this.periodCount,
      required this.timePerPeriod});

  @override
  int get hashCode => Object.hash(mainTime, periodCount, timePerPeriod);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is TimeControl &&
        other.mainTime == mainTime &&
        other.periodCount == periodCount &&
        other.timePerPeriod == timePerPeriod;
  }
}
