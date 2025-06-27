import 'package:flutter/material.dart';

abstract class BoardBackground extends StatelessWidget {
  const BoardBackground({super.key});
}

class SolidColorBoardBackground extends BoardBackground {
  final Color color;

  const SolidColorBoardBackground({super.key, required this.color});

  @override
  Widget build(BuildContext context) => Container(color: color);
}

class ImageBoardBackground extends BoardBackground {
  final AssetImage image;

  const ImageBoardBackground({super.key, required this.image});

  @override
  Widget build(BuildContext context) => Image(
        image: image,
        fit: BoxFit.contain,
        repeat: ImageRepeat.repeat,
      );
}
