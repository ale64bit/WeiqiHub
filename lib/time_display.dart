import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wqhub/audio/audio_controller.dart';
import 'package:wqhub/game_client/time_state.dart';

enum TickMode {
  increase,
  decrease,
}

class TimeDisplay extends StatefulWidget {
  final int tickId;
  final TimeState timeState;
  final Duration warningDuration;
  final bool enabled;
  final bool tickerEnabled;
  final bool voiceCountdown;
  final TickMode tickMode;
  final Function()? onTimeout;

  const TimeDisplay(
      {super.key,
      this.tickId = 0,
      required this.timeState,
      required this.warningDuration,
      required this.enabled,
      required this.tickerEnabled,
      required this.voiceCountdown,
      this.tickMode = TickMode.decrease,
      this.onTimeout});

  @override
  State<TimeDisplay> createState() => _TimeDisplayState();
}

class _TimeDisplayState extends State<TimeDisplay> {
  late Timer _timer;
  DateTime? _startTime;
  int? _lastAnnouncedSecond;

  @override
  void initState() {
    super.initState();
    if (widget.tickerEnabled) {
      _startTime = DateTime.now();
      _timer = Timer.periodic(const Duration(milliseconds: 100), _onTick);
    }
  }

  @override
  void didUpdateWidget(TimeDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.timeState != oldWidget.timeState ||
        widget.tickId != oldWidget.tickId) {
      _startTime = DateTime.now();
      _lastAnnouncedSecond = null;
      if (widget.timeState != oldWidget.timeState) _voiceCountdown();
    }
  }

  @override
  void dispose() {
    if (widget.tickerEnabled) _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final (timeLeft, isMainTime, periodCount) = _calculateTimeState();

    final colorScheme = ColorScheme.of(context);
    final containerColor = timeLeft <= widget.warningDuration
        ? colorScheme.errorContainer
        : colorScheme.primaryContainer;
    final textStyle = TextTheme.of(context).headlineLarge?.copyWith(
      fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
    );
    final isMaintime = isMainTime || (periodCount == 0);
    final hh = _formatUnit(timeLeft.inHours);
    final mm = _formatUnit(timeLeft.inMinutes.remainder(60));
    final ss = _formatUnit(timeLeft.inSeconds.remainder(60));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: isMaintime
          ? <Widget>[
              // Maintime
              if (hh != '00') _UnitContainer(value: hh, color: containerColor),
              if (hh != '00') Text(':', style: textStyle),
              _UnitContainer(value: mm, color: containerColor),
              Text(':', style: textStyle),
              _UnitContainer(value: ss, color: containerColor)
            ]
          : <Widget>[
              // Overtime
              _UnitContainer(value: '${periodCount}x', color: containerColor),
              Text(':', style: textStyle),
              if (hh != '00') _UnitContainer(value: hh, color: containerColor),
              if (hh != '00') Text(':', style: textStyle),
              if (mm != '00') _UnitContainer(value: mm, color: containerColor),
              if (mm != '00') Text(':', style: textStyle),
              _UnitContainer(value: ss, color: containerColor)
            ],
    );
  }

  String _formatUnit(int u) => u.toString().padLeft(2, '0');

  Duration _getElapsed() {
    if (_startTime == null) return Duration.zero;
    return DateTime.now().difference(_startTime!);
  }

  (Duration, bool, int) _calculateTimeState() {
    final elapsed = widget.enabled ? _getElapsed() : Duration.zero;

    switch (widget.tickMode) {
      case TickMode.increase:
        final timeLeft = (widget.timeState.mainTimeLeft > Duration.zero)
            ? widget.timeState.mainTimeLeft
            : widget.timeState.periodTimeLeft;
        return (
          timeLeft + elapsed,
          widget.timeState.mainTimeLeft > Duration.zero,
          widget.timeState.periodCount
        );
      case TickMode.decrease:
        var remainingElapsed = elapsed;
        var mainTimeLeft = widget.timeState.mainTimeLeft;
        var periodCount = widget.timeState.periodCount;

        // First, consume main time
        if (mainTimeLeft > Duration.zero) {
          if (remainingElapsed <= mainTimeLeft) {
            return (mainTimeLeft - remainingElapsed, true, periodCount);
          }
          remainingElapsed -= mainTimeLeft;
        }

        // Then, consume byo-yomi periods
        final periodTime = widget.timeState.periodTimeLeft;
        while (periodCount > 0 && remainingElapsed >= periodTime) {
          remainingElapsed -= periodTime;
          periodCount--;
        }

        if (periodCount > 0) {
          return (periodTime - remainingElapsed, false, periodCount);
        }

        // Time expired
        return (Duration.zero, false, 0);
    }
  }

  void _onTick(Timer timer) {
    if (!widget.enabled) return;

    setState(() {
      final (timeLeft, _, _) = _calculateTimeState();
      if (timeLeft == Duration.zero) {
        widget.onTimeout?.call();
      }
    });
    _voiceCountdown();
  }

  void _voiceCountdown() {
    final (timeLeft, isMainTime, _) = _calculateTimeState();
    if (widget.voiceCountdown &&
        !isMainTime &&
        Duration.zero < timeLeft &&
        timeLeft <= Duration(seconds: 9)) {
      final secondsLeft = timeLeft.inSeconds;
      if (secondsLeft != _lastAnnouncedSecond) {
        _lastAnnouncedSecond = secondsLeft;
        AudioController().count(secondsLeft);
      }
    }
  }
}

class _UnitContainer extends StatelessWidget {
  final String value;
  final Color color;

  const _UnitContainer({required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextTheme.of(context).headlineLarge?.copyWith(
      fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
    );
    return Container(
      padding: EdgeInsets.only(left: 4, right: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: Text(value, style: textStyle),
    );
  }
}
