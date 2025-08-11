import 'package:flutter/material.dart';
import 'package:wqhub/board/board_settings.dart';
import 'package:wqhub/board/board_geometry.dart';
import 'package:wqhub/wq/wq.dart' as wq;

class BoardLines extends CustomPainter with BoardGeometry {
  static final _starPoints = const {
    9: [
      (2, 2),
      (2, 6),
      (4, 4),
      (6, 2),
      (6, 6),
    ],
    13: [
      (3, 3),
      (3, 9),
      (6, 6),
      (9, 3),
      (9, 9),
    ],
    19: [
      (3, 3),
      (3, 9),
      (3, 15),
      (9, 3),
      (9, 9),
      (9, 15),
      (15, 3),
      (15, 9),
      (15, 15),
    ],
  };

  const BoardLines({
    required this.size,
    required this.settings,
  });

  @override
  final double size;

  @override
  final BoardSettings settings;

  @override
  void paint(Canvas canvas, Size size) {
    final boardLineWidth = pointSize / 48;
    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = settings.theme.lineColor
      ..strokeWidth = boardLineWidth;
    final thickLinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = settings.theme.lineColor
      ..strokeWidth = 2 * boardLineWidth;
    final starPointPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = settings.theme.lineColor;
    final (r0, c0) = settings.topLeft;
    final (r1, c1) = settings.bottomRight;
    for (final (r, c) in _starPoints[settings.size] ?? <wq.Point>[]) {
      if (r0 < r && r < r1 && c0 < c && c < c1) {
        canvas.drawCircle(pointCenter(r, c), pointSize / 12, starPointPaint);
      }
    }
    for (int i = 1; i < settings.visibleSize - 1; ++i) {
      // Vertical lines
      canvas.drawLine(
          pointCenter(r0 + 0, c0 + i), pointCenter(r1, c0 + i), linePaint);
      // Horizontal lines
      canvas.drawLine(
          pointCenter(r0 + i, c0 + 0), pointCenter(r0 + i, c1), linePaint);
    }

    // Draw board edge line
    // If full board is visible, we can draw a rect once
    if (settings.size == settings.visibleSize) {
      switch (settings.edgeLine) {
        case BoardEdgeLine.single:
          canvas.drawRect(
              Rect.fromPoints(pointCenter(0, 0),
                  pointCenter(settings.size - 1, settings.size - 1)),
              linePaint);
        case BoardEdgeLine.thick:
          canvas.drawRect(
              Rect.fromPoints(pointCenter(0, 0),
                  pointCenter(settings.size - 1, settings.size - 1)),
              thickLinePaint);
      }
    } else {
      // Otherwise, we need to draw each edge line individually
      switch (settings.edgeLine) {
        case BoardEdgeLine.single:
          final dx = Offset(boardLineWidth / 2, 0);
          final dy = Offset(0, boardLineWidth / 2);
          linePaint.strokeCap = StrokeCap.butt;
          if (r0 == 0) {
            canvas.drawLine(
                pointCenter(r0, c0) - dx, pointCenter(r0, c1) + dx, linePaint);
          }
          if (r1 == settings.size - 1) {
            canvas.drawLine(
                pointCenter(r1, c0) - dx, pointCenter(r1, c1) + dx, linePaint);
          }
          if (c0 == 0) {
            canvas.drawLine(
                pointCenter(r0, c0) - dy, pointCenter(r1, c0) + dy, linePaint);
          }
          if (c1 == settings.size - 1) {
            canvas.drawLine(
                pointCenter(r0, c1) - dy, pointCenter(r1, c1) + dy, linePaint);
          }
        case BoardEdgeLine.thick:
          final dx = Offset(boardLineWidth, 0);
          final dy = Offset(0, boardLineWidth);
          thickLinePaint.strokeWidth = 2 * boardLineWidth;
          thickLinePaint.strokeCap = StrokeCap.butt;
          if (r0 == 0) {
            canvas.drawLine(pointCenter(r0, c0) - dx, pointCenter(r0, c1) + dx,
                thickLinePaint);
          }
          if (r1 == settings.size - 1) {
            canvas.drawLine(pointCenter(r1, c0) - dx, pointCenter(r1, c1) + dx,
                thickLinePaint);
          }
          if (c0 == 0) {
            canvas.drawLine(pointCenter(r0, c0) - dy, pointCenter(r1, c0) + dy,
                thickLinePaint);
          }
          if (c1 == settings.size - 1) {
            canvas.drawLine(pointCenter(r0, c1) - dy, pointCenter(r1, c1) + dy,
                thickLinePaint);
          }
      }
    }
  }

  @override
  bool shouldRepaint(BoardLines oldDelegate) => false;
}
