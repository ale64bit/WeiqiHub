import 'package:flutter/material.dart';

abstract class Stone extends StatelessWidget {
  const Stone({super.key});
}

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

class ImageStone extends Stone {
  final AssetImage image;

  const ImageStone({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: image,
      fit: BoxFit.contain,
    );
  }
}