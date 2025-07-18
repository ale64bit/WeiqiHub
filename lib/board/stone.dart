import 'package:flutter/material.dart';

abstract class Stone extends StatelessWidget {
  const Stone({super.key});
}

class SolidColorStone extends Stone {
  final Color color;

  const SolidColorStone({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
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
