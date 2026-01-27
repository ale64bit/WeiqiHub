import 'dart:ui';

import 'package:wqhub/board/board_settings.dart';
import 'package:wqhub/wq/wq.dart' as wq;

mixin BoardGeometry {
  double get size;
  BoardSettings get settings;

  double get pointSize => size / settings.visibleSize;

  double get halfPointSize => pointSize / 2;

  bool isPointVisible(wq.Point p) {
    final (r, c) = p;
    final (r0, c0) = settings.topLeft;
    final (r1, c1) = settings.bottomRight;
    return r0 <= r && r <= r1 && c0 <= c && c <= c1;
  }

  Offset pointOrigin(int r, int c) => Offset(
      (c - (settings.subBoard?.topLeft.$2 ?? 0)) * pointSize,
      (r - (settings.subBoard?.topLeft.$1 ?? 0)) * pointSize);

  Offset pointCenter(int r, int c) =>
      pointOrigin(r, c) + Offset(halfPointSize, halfPointSize);

  wq.Point? offsetPoint(Offset offset) {
    final c = (offset.dx / pointSize).floor();
    final r = (offset.dy / pointSize).floor();
    if (0 <= r &&
        r < settings.visibleSize &&
        0 <= c &&
        c < settings.visibleSize) {
      final (dr, dc) = settings.subBoard?.topLeft ?? (0, 0);
      return (dr + r, dc + c);
    } else {
      return null;
    }
  }
}
