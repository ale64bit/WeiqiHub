import 'package:flutter/material.dart';

/// Base class for all stone types
abstract class Stone extends StatelessWidget {
  const Stone({super.key});
}

/// Solid color stone (for simple themes or testing)
class SolidColorStone extends Stone {
  final Color? color;
  final Gradient? gradient;
  final bool border;

  const SolidColorStone(
    {super.key, this.color, this.gradient, required this.border});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        gradient: gradient,
        border: border ? Border.all() : null,
      ),
    );
  }
}

/// Image-based stone (Fox, Tygem, etc.)
/// Scaling + overflow are integrated:
/// - scale controls relative size
/// - if the scaled size is larger than the board cell, it will overflow automatically
class ImageStone extends Stone {
  final AssetImage image;

  /// Multiplier relative to the parent cell size.
  /// 1.0 = normal fit, >1.0 = bigger, <1.0 = smaller.
  final double scale;
  final bool forceOverflow;

  const ImageStone({super.key, required this.image, this.scale = 1.0, this.forceOverflow = false});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cellSize = constraints.biggest.shortestSide;
        final stoneSize = cellSize * scale;

        final stoneImage = Image(
          image: image,
          fit: BoxFit.contain,
          width: stoneSize,
          height: stoneSize,
        );

        final needsOverflow = stoneSize > cellSize;

        if (needsOverflow || forceOverflow) {
          return Center(
            child: OverflowBox(
              maxWidth: double.infinity,
              maxHeight: double.infinity,
              child: stoneImage,
            ),
          );
        } else {
          return Center(child: stoneImage);
        }
      },
    );
  }
}
