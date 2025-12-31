import 'package:flutter/material.dart';
import 'package:extension_type_unions/extension_type_unions.dart';

enum AnnotationShape {
  dot,
  circle,
  square,
  cross,
  triangle,
  territory,
  variation,
  fill,
  filledCircle,
}

typedef Annotation = ({Union2<AnnotationShape, String> type, Color color});

extension AnnotationChecks on Annotation {
  bool get isShape => this.type.split((shape) => true, (text) => false);
  bool get isText => this.type.split((shape) => false, (text) => true);
}

class BoardAnnotation extends StatelessWidget {
  const BoardAnnotation({super.key, required this.annotation});

  final Annotation annotation;

  @override
  Widget build(BuildContext context) => annotation.type.split(
      (shape) => CustomPaint(
            painter:
                _AnnotationShapePainter(shape: shape, color: annotation.color),
          ),
      (text) => FittedBox(
            fit: BoxFit.fitHeight,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: annotation.color,
                // use height: for spacing in between lines
              ),
              maxLines: 3,
            ),
          ));
}

class _AnnotationShapePainter extends CustomPainter {
  _AnnotationShapePainter({required this.shape, required this.color});

  final AnnotationShape shape;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    switch (shape) {
      case AnnotationShape.dot:
        final center = Offset(size.width / 2, size.height / 2);
        final paint = Paint()
          ..style = PaintingStyle.fill
          ..color = color;
        canvas.drawCircle(center, size.width / 6, paint);
      case AnnotationShape.circle:
        final center = Offset(size.width / 2, size.height / 2);
        final paint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width / 16
          ..color = color;
        canvas.drawCircle(center, size.width / 3.5, paint);
      case AnnotationShape.square:
        final center = Offset(size.width / 2, size.height / 2);
        final paint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width / 16
          ..color = color;
        canvas.drawRect(
            Rect.fromCenter(
              center: center,
              width: size.width / 2,
              height: size.height / 2,
            ),
            paint);
      case AnnotationShape.cross:
        final paint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width / 16
          ..color = color;
        final offset = size.width / 4;
        canvas.drawLine(Offset(offset, offset),
            Offset(size.width - offset, size.height - offset), paint);
        canvas.drawLine(Offset(size.width - offset, offset),
            Offset((offset), size.height - offset), paint);
      case AnnotationShape.triangle:
        final paint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width / 16
          ..color = color;
        final offset = size.width / 4;
        final path = Path();
        path.moveTo(size.width / 2, offset);
        path.lineTo(size.width - offset, size.height - offset);
        path.lineTo(offset, size.height - offset);
        path.close();
        canvas.drawPath(path, paint);
      case AnnotationShape.territory:
        final center = Offset(size.width / 2, size.height / 2);
        final borderPaint = Paint()
          ..style = PaintingStyle.stroke
          ..color = Colors.grey;
        final fillPaint = Paint()
          ..style = PaintingStyle.fill
          ..color = color;
        final rect = Rect.fromCenter(
          center: center,
          width: size.width / 2.5,
          height: size.height / 2.5,
        );
        canvas.drawRect(rect, fillPaint);
        canvas.drawRect(rect, borderPaint);
      case AnnotationShape.variation:
        final paint = Paint()
          ..style = PaintingStyle.fill
          ..color = color;
        final side = size.height / 4;
        final path = Path();
        path.lineTo(0, side);
        path.lineTo(side, 0);
        path.close();
        canvas.drawPath(path, paint);
      case AnnotationShape.fill:
        final paint = Paint()
          ..style = PaintingStyle.fill
          ..color = color;
        canvas.drawRect(
            Rect.fromLTWH(
              0,
              0,
              size.width,
              size.height,
            ),
            paint);
      case AnnotationShape.filledCircle:
        final fillPaint = Paint()
          ..style = PaintingStyle.fill
          ..color = color;
        final center = Offset(size.width / 2, size.height / 2);
        canvas.drawCircle(center, size.width / 2, fillPaint);
    }
  }

  @override
  bool shouldRepaint(_AnnotationShapePainter oldDelegate) => false;
}
