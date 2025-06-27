import 'package:flutter/material.dart';

class BlinkingIcon extends StatefulWidget {
  final IconData icon;
  final Color color;
  final Duration duration;
  final Curve curve;

  const BlinkingIcon(
      {super.key,
      required this.icon,
      required this.color,
      required this.duration,
      required this.curve});

  @override
  State<BlinkingIcon> createState() => _BlinkingIconState();
}

class _BlinkingIconState extends State<BlinkingIcon>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: widget.duration,
    vsync: this,
  )..repeat(reverse: true);
  late final CurvedAnimation _animation =
      CurvedAnimation(parent: _controller, curve: widget.curve);

  @override
  void didUpdateWidget(covariant BlinkingIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller
        ..duration = widget.duration
        ..repeat(reverse: true);
    }
    if (oldWidget.curve != widget.curve) {
      _animation.curve = widget.curve;
    }
  }

  @override
  void dispose() {
    _animation.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Icon(widget.icon, color: widget.color),
    );
  }
}
