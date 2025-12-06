import 'dart:async';
import 'package:clock/clock.dart';
import 'package:flutter/widgets.dart';
import 'package:wqhub/game_client/time_state.dart';

/// A timer that manages Byo-Yomi time and emits TimeState updates.
///
/// This class handles the countdown logic for both main time and overtime periods,
/// emitting updates once per second when active.
class GameTimer {
  Timer? _timer;
  TimeState _baseState;
  DateTime? _startTime;
  final ValueNotifier<(int, TimeState)> _notifier;

  GameTimer({
    required TimeState initialState,
  })  : _baseState = initialState,
        _notifier = ValueNotifier((0, initialState));

  /// The current time state and a tick counter.
  /// The tick counter increments each time the state changes, allowing listeners
  /// to detect updates even when the TimeState values might be identical.
  ValueNotifier<(int, TimeState)> get timeNotifier => _notifier;

  /// Whether the timer is currently running.
  bool get isRunning => _timer != null && _timer!.isActive;

  /// The current time state, calculated from elapsed time if running.
  TimeState get currentState {
    if (_startTime == null) {
      return _baseState;
    }
    final elapsed = clock.now().difference(_startTime!);
    return _calculateTimeState(_baseState, elapsed);
  }

  /// Start or restart the timer with a new time state.
  ///
  /// If the timer is already running, it will be stopped first.
  /// The new state becomes the base state and the timer starts counting down.
  void start(TimeState newState) {
    stop();
    _baseState = newState;
    _startTime = clock.now();
    _notifier.value = (_notifier.value.$1 + 1, newState);

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _tick();
    });
  }

  /// Stop the timer.
  ///
  /// The current calculated state becomes the new base state.
  void stop() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;

      // Update base state to current calculated state
      if (_startTime != null) {
        _baseState = currentState;
        _startTime = null;
      }
    }
  }

  void _tick() {
    if (_startTime == null) return;

    final elapsed = clock.now().difference(_startTime!);
    final newState = _calculateTimeState(_baseState, elapsed);

    _notifier.value = (_notifier.value.$1 + 1, newState);
  }

  /// Calculate the time state after a given duration has elapsed.
  TimeState _calculateTimeState(TimeState baseState, Duration elapsed) {
    var remainingElapsed = elapsed;
    var mainTimeLeft = baseState.mainTimeLeft;
    var periodTimeLeft = baseState.periodTimeLeft;
    var periodCount = baseState.periodCount;

    // First, consume main time
    if (mainTimeLeft > Duration.zero) {
      if (remainingElapsed <= mainTimeLeft) {
        mainTimeLeft -= remainingElapsed;
        remainingElapsed = Duration.zero;
      } else {
        remainingElapsed -= mainTimeLeft;
        mainTimeLeft = Duration.zero;
      }
    }

    // Then, consume byoyomi periods
    while (periodCount > 0 && remainingElapsed >= periodTimeLeft) {
      remainingElapsed -= periodTimeLeft;
      periodCount -= 1;
    }

    if (periodCount > 0) {
      periodTimeLeft -= remainingElapsed;
    } else {
      periodTimeLeft = Duration.zero;
    }

    return TimeState(
      mainTimeLeft: mainTimeLeft,
      periodTimeLeft: periodTimeLeft,
      periodCount: periodCount,
    );
  }

  /// Dispose of the timer and release resources.
  void dispose() {
    _timer?.cancel();
    _notifier.dispose();
  }
}
