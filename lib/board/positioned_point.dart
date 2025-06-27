import 'package:flutter/material.dart';
import 'package:wqhub/board/board_settings.dart';
import 'package:wqhub/board/board_geometry.dart';

class PositionedPoint extends StatelessWidget with BoardGeometry {
  const PositionedPoint({
    super.key,
    required this.size,
    required this.settings,
    required this.point,
    required this.child,
    this.extraSize = 0,
  });

  @override
  final double size;

  @override
  final BoardSettings settings;

  final (int, int) point;
  final Widget child;
  final double extraSize;

  @override
  Widget build(BuildContext context) {
    final offset = pointOrigin(point.$1, point.$2);
    return Positioned(
      width: pointSize + 2 * extraSize,
      height: pointSize + 2 * extraSize,
      left: offset.dx - extraSize,
      top: offset.dy - extraSize,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: child,
      ),
    );
  }
}
