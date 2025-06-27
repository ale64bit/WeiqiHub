import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wqhub/audio/audio_controller.dart';
import 'package:wqhub/game_client/time_state.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';

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
  late Duration _timeLeft;

  @override
  void initState() {
    super.initState();
    if (widget.tickerEnabled) {
      _timer = Timer.periodic(const Duration(seconds: 1), _onTick);
    }
    _timeLeft = (widget.timeState.mainTimeLeft > Duration.zero)
        ? widget.timeState.mainTimeLeft
        : widget.timeState.periodTimeLeft;
  }

  @override
  void didUpdateWidget(TimeDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.timeState != oldWidget.timeState ||
        widget.tickId != oldWidget.tickId) {
      _timeLeft = (widget.timeState.mainTimeLeft > Duration.zero)
          ? widget.timeState.mainTimeLeft
          : widget.timeState.periodTimeLeft;
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
    final colorScheme = ColorScheme.of(context);
    final containerColor = _timeLeft <= widget.warningDuration
        ? colorScheme.errorContainer
        : colorScheme.primaryContainer;
    final textStyle = TextTheme.of(context).headlineLarge?.copyWith(
      fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
    );
    final isMaintime = (widget.timeState.mainTimeLeft > Duration.zero) ||
        (widget.timeState.periodCount == 0);
    final hh = _formatUnit(_timeLeft.inHours);
    final mm = _formatUnit(_timeLeft.inMinutes.remainder(60));
    final ss = _formatUnit(_timeLeft.inSeconds.remainder(60));
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
              _UnitContainer(
                  value: '${widget.timeState.periodCount}x',
                  color: containerColor),
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

  void _onTick(Timer timer) {
    if (!widget.enabled) return;

    switch (widget.tickMode) {
      case TickMode.increase:
        setState(() {
          _timeLeft += Duration(seconds: 1);
        });
      case TickMode.decrease:
        if (_timeLeft > Duration.zero) {
          setState(() {
            _timeLeft -= Duration(seconds: 1);
            if (_timeLeft == Duration.zero) {
              widget.onTimeout?.call();
            }
          });
          _voiceCountdown();
        }
    }
  }

  void _voiceCountdown() {
    if (context.settings.sound &&
        widget.voiceCountdown &&
        widget.timeState.isOvertime &&
        Duration.zero < _timeLeft &&
        _timeLeft <= Duration(seconds: 9)) {
      AudioController().count(_timeLeft.inSeconds);
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
