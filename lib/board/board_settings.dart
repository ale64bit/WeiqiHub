import 'package:flutter/widgets.dart';
import 'package:wqhub/board/board_theme.dart';
import 'package:wqhub/board/coordinate_style.dart';
import 'package:wqhub/wq/wq.dart' as wq;

enum BoardEdgeLine {
  single,
  thick,
}

@immutable
class BoardBorderSettings {
  const BoardBorderSettings({
    required this.size,
    required this.color,
    required this.rowCoordinates,
    required this.columnCoordinates,
  });

  final double size;
  final Color color;
  final CoordinateStyle? rowCoordinates;
  final CoordinateStyle? columnCoordinates;

  @override
  int get hashCode =>
      Object.hash(size, color, rowCoordinates, columnCoordinates);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is BoardBorderSettings &&
        other.size == size &&
        other.color == color &&
        other.rowCoordinates == rowCoordinates &&
        other.columnCoordinates == columnCoordinates;
  }
}

@immutable
class SubBoard {
  const SubBoard({required this.topLeft, required this.size});

  final wq.Point topLeft;
  final int size;

  @override
  int get hashCode => Object.hash(size, topLeft);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is SubBoard && other.topLeft == topLeft && other.size == size;
  }
}

@immutable
class BoardSettings {
  const BoardSettings({
    this.size = 19,
    this.subBoard,
    this.theme = BoardTheme.sabaki,
    this.edgeLine = BoardEdgeLine.single,
    this.border,
    this.stoneShadows = true,
    this.interactive = true,
  });

  final int size;
  final SubBoard? subBoard;
  final BoardTheme theme;
  final BoardEdgeLine edgeLine;
  final BoardBorderSettings? border;
  final bool stoneShadows;
  final bool interactive;

  int get visibleSize => subBoard?.size ?? size;
  (int, int) get topLeft => subBoard?.topLeft ?? (0, 0);
  (int, int) get bottomRight {
    final (r0, c0) = topLeft;
    return (r0 + visibleSize - 1, c0 + visibleSize - 1);
  }

  @override
  int get hashCode => Object.hash(
      size, subBoard, theme, edgeLine, border, stoneShadows, interactive);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is BoardSettings &&
        other.size == size &&
        other.subBoard == subBoard &&
        other.theme == theme &&
        other.edgeLine == edgeLine &&
        other.border == border &&
        other.stoneShadows == stoneShadows &&
        other.interactive == interactive;
  }
}
