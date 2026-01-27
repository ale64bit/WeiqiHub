import 'package:flutter/material.dart';
import 'package:wqhub/wq/wq.dart' as wq;

sealed class BoardAnnotation extends StatelessWidget {
  const BoardAnnotation({super.key});

  String get annotationKey;
}

class TextAnnotation extends BoardAnnotation {
  final String text;
  final Color color;

  const TextAnnotation({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  String get annotationKey => 'text';

  @override
  Widget build(BuildContext context) => FittedBox(
        fit: BoxFit.contain,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: DefaultTextStyle.of(context).style.copyWith(color: color),
        ),
      );
}

class DotAnnotation extends BoardAnnotation {
  final Color color;

  const DotAnnotation({super.key, required this.color});

  @override
  String get annotationKey => 'dot';

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DotAnnotationPainter(color: color),
    );
  }
}

class _DotAnnotationPainter extends CustomPainter {
  final Color color;

  const _DotAnnotationPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;
    canvas.drawCircle(center, size.width / 6, paint);
  }

  @override
  bool shouldRepaint(_DotAnnotationPainter old) => old.color != color;
}

class CircleAnnotation extends BoardAnnotation {
  final Color color;

  const CircleAnnotation({super.key, required this.color});

  @override
  String get annotationKey => 'circle';

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CircleAnnotationPainter(color: color),
    );
  }
}

class _CircleAnnotationPainter extends CustomPainter {
  final Color color;

  const _CircleAnnotationPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 16
      ..color = color;
    canvas.drawCircle(center, size.width / 3.5, paint);
  }

  @override
  bool shouldRepaint(_CircleAnnotationPainter old) => old.color != color;
}

class CrossAnnotation extends BoardAnnotation {
  final Color color;

  const CrossAnnotation({super.key, required this.color});

  @override
  String get annotationKey => 'cross';

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CrossAnnotationPainter(color: color),
    );
  }
}

class _CrossAnnotationPainter extends CustomPainter {
  final Color color;

  const _CrossAnnotationPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 16
      ..color = color;
    final offset = size.width / 4;
    canvas.drawLine(Offset(offset, offset),
        Offset(size.width - offset, size.height - offset), paint);
    canvas.drawLine(Offset(size.width - offset, offset),
        Offset((offset), size.height - offset), paint);
  }

  @override
  bool shouldRepaint(_CrossAnnotationPainter old) => old.color != color;
}

class TriangleAnnotation extends BoardAnnotation {
  final Color color;

  const TriangleAnnotation({super.key, required this.color});

  @override
  String get annotationKey => 'triangle';

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _TriangleAnnotationPainter(color: color),
    );
  }
}

class _TriangleAnnotationPainter extends CustomPainter {
  final Color color;

  const _TriangleAnnotationPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
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
  }

  @override
  bool shouldRepaint(_TriangleAnnotationPainter old) => old.color != color;
}

class SquareAnnotation extends BoardAnnotation {
  final Color color;

  const SquareAnnotation({super.key, required this.color});

  @override
  String get annotationKey => 'square';

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _SquareAnnotationPainter(color: color),
    );
  }
}

class _SquareAnnotationPainter extends CustomPainter {
  final Color color;

  const _SquareAnnotationPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
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
  }

  @override
  bool shouldRepaint(_SquareAnnotationPainter old) => old.color != color;
}

class LastMoveAnnotation extends BoardAnnotation {
  final wq.Color turn;

  const LastMoveAnnotation({super.key, required this.turn});

  @override
  String get annotationKey => 'lastmove';

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _LastMoveAnnotationPainter(
          color: switch (turn) {
        wq.Color.black => Colors.white,
        wq.Color.white => Colors.black,
      }),
    );
  }
}

class _LastMoveAnnotationPainter extends CustomPainter {
  final Color color;

  const _LastMoveAnnotationPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 16
      ..color = color;
    canvas.drawCircle(center, size.width / 3.5, paint);
  }

  @override
  bool shouldRepaint(_LastMoveAnnotationPainter old) => old.color != color;
}

class TerritoryAnnotation extends BoardAnnotation {
  final Color color;

  const TerritoryAnnotation({super.key, required this.color});

  @override
  String get annotationKey => 'territory';

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _TerritoryAnnotationPainter(color: color),
    );
  }
}

class _TerritoryAnnotationPainter extends CustomPainter {
  final Color color;

  const _TerritoryAnnotationPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
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
  }

  @override
  bool shouldRepaint(_TerritoryAnnotationPainter old) => old.color != color;
}

class AnalysisAnnotation extends BoardAnnotation {
  static final winrateLossBands = <(double, Color)>[
    (1.0, Colors.lightBlueAccent),
    (0.03, Colors.green),
    (-0.01, Colors.lime),
    (-0.03, Colors.amberAccent),
    (-0.06, Colors.orange),
    (-0.12, Colors.red),
    (-0.24, Colors.purple),
  ];

  final int order;
  final int visits;
  final double winrateLoss;
  final double pointLoss;

  const AnalysisAnnotation({
    super.key,
    required this.order,
    required this.visits,
    required this.winrateLoss,
    required this.pointLoss,
  });

  @override
  String get annotationKey => 'analysis';

  @override
  Widget build(BuildContext context) {
    final annotationColor = _annotationColor().withAlpha(240);
    final textColor = order == 0 ? Colors.pink : Colors.black;
    final text = RichText(
      textAlign: TextAlign.center,
      strutStyle: StrutStyle(
        height: 0.8,
      ),
      text: TextSpan(
        text: '${(pointLoss * 10).toInt() / 10}\n',
        style: TextTheme.of(context).displayLarge!.copyWith(color: textColor),
        children: [
          TextSpan(
            text: visits < 1000 ? '$visits' : '${(visits / 1000).floor()}k',
            style:
                TextTheme.of(context).displaySmall!.copyWith(color: textColor),
          ),
        ],
      ),
    );
    return Stack(
      alignment: AlignmentGeometry.center,
      fit: StackFit.expand,
      children: [
        CustomPaint(
          painter: _AnalysisAnnotationPainter(
            color: annotationColor,
            borderColor:
                HSVColor.fromColor(annotationColor).withValue(0.8).toColor(),
          ),
        ),
        FittedBox(
          fit: BoxFit.contain,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: text,
          ),
        ),
      ],
    );
  }

  Color _annotationColor() {
    if (order == 0) {
      return winrateLossBands[0].$2;
    }
    for (final (loss, color) in winrateLossBands) {
      if (winrateLoss >= loss) {
        return color;
      }
    }
    return winrateLossBands.last.$2;
  }
}

class _AnalysisAnnotationPainter extends CustomPainter {
  final Color color;
  final Color borderColor;

  const _AnalysisAnnotationPainter(
      {required this.color, required this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 16
      ..color = borderColor;

    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, size.width / 2.1, fillPaint);
    canvas.drawCircle(center, size.width / 2.1, strokePaint);
  }

  @override
  bool shouldRepaint(_AnalysisAnnotationPainter old) =>
      old.color != color || old.borderColor != borderColor;
}

class VariationAnnotation extends BoardAnnotation {
  final int moveNumber;
  final wq.Color turn;

  const VariationAnnotation({
    super.key,
    required this.moveNumber,
    required this.turn,
  });

  @override
  String get annotationKey => 'variation';

  @override
  Widget build(BuildContext context) {
    final annotationColor = switch (turn) {
      wq.Color.black => Colors.red,
      wq.Color.white => Colors.blue,
    };
    final textColor = switch (turn) {
      wq.Color.black => Colors.white,
      wq.Color.white => Colors.black,
    };
    return Stack(
      alignment: AlignmentGeometry.center,
      fit: StackFit.expand,
      children: [
        FittedBox(
          fit: BoxFit.contain,
          child: Text(
            '$moveNumber',
            textAlign: TextAlign.center,
            style:
                DefaultTextStyle.of(context).style.copyWith(color: textColor),
          ),
        ),
        CustomPaint(
          painter: _VariationAnnotationPainter(color: annotationColor),
        ),
      ],
    );
  }
}

class _VariationAnnotationPainter extends CustomPainter {
  final Color color;

  const _VariationAnnotationPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;
    final side = size.height / 4;
    final path = Path();
    path.lineTo(0, side);
    path.lineTo(side, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_VariationAnnotationPainter old) => old.color != color;
}
