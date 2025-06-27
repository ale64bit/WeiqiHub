import 'package:flutter/widgets.dart';

@immutable
class AutomaticCountingInfo {
  final Duration timeout;

  const AutomaticCountingInfo({required this.timeout});

  @override
  int get hashCode => timeout.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is AutomaticCountingInfo && other.timeout == timeout;
  }
}
