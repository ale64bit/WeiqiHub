import 'dart:math';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wqhub/board/board_annotation.dart';
import 'package:wqhub/board/board_lines.dart';
import 'package:wqhub/board/board_settings.dart';
import 'package:wqhub/board/board_geometry.dart';
import 'package:wqhub/board/coordinate_style.dart';
import 'package:wqhub/board/positioned_point.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/wq/wq.dart' as wq;

class Board extends StatefulWidget with BoardGeometry {
  const Board({
    super.key,
    required this.size,
    this.settings = const BoardSettings(),
    this.cursor = SystemMouseCursors.precise,
    this.onPointClicked,
    this.onPointHovered,
    required this.turn,
    required this.stones,
    required this.annotations,
    required this.confirmTap,
  });

  @override
  final double size;

  @override
  final BoardSettings settings;

  final MouseCursor cursor;
  final void Function(wq.Point)? onPointClicked;
  final void Function(wq.Point?)? onPointHovered;
  final IMap<wq.Point, wq.Color> stones;
  final IMap<wq.Point, BoardAnnotation> annotations;
  final wq.Color? turn;
  final bool confirmTap;

  @override
  // ignore: library_private_types_in_public_api
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  wq.Point? lastHoverPoint;
  wq.Point? confirmPoint;

  @override
  void didUpdateWidget(covariant Board oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (lastHoverPoint != null && widget.stones.containsKey(lastHoverPoint)) {
      setState(() {
        lastHoverPoint = null;
      });
    }
    if (confirmPoint != null && widget.stones.containsKey(confirmPoint)) {
      setState(() {
        confirmPoint = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final background = SizedBox.square(
      key: const ValueKey('board-bg'),
      dimension: widget.size,
      child: CustomPaint(
        foregroundPainter:
            BoardLines(size: widget.size, settings: widget.settings),
        child: widget.settings.theme.background,
      ),
    );
    final stoneShadow = const DecoratedBox(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0.05, 0.05),
          radius: 0.85,
          colors: <Color>[
            Colors.black,
            Colors.transparent,
          ],
          stops: <double>[0.3, 0.5],
        ),
      ),
    );
    final List<Widget> objects = [
      // Stone shadows
      if (widget.settings.stoneShadows)
        for (final e in widget.stones.entries)
          if (widget.isPointVisible(e.key))
            PositionedPoint(
              key: _keyStoneShadow(e.key),
              size: widget.size,
              settings: widget.settings,
              point: e.key,
              extraSize: widget.pointSize / 7,
              child: stoneShadow,
            ),
      // Stone widgets
      for (final e in widget.stones.entries)
        if (widget.isPointVisible(e.key))
          PositionedPoint(
            key: _keyStone(e.value, e.key),
            size: widget.size,
            settings: widget.settings,
            point: e.key,
            child: e.value == wq.Color.black
                ? widget.settings.theme.blackStone
                : widget.settings.theme.whiteStone,
          ),
      // Annotation widgets
      for (final e in widget.annotations.entries)
        if (widget.isPointVisible(e.key))
          PositionedPoint(
            key: _annotationKey(e.value, e.key),
            size: widget.size,
            settings: widget.settings,
            point: e.key,
            child: e.value,
          ),
      // Highlighted point marker
      if (widget.turn != null && lastHoverPoint != null)
        PositionedPoint(
          key: _keyHoverStone(widget.turn!, lastHoverPoint!),
          size: widget.size,
          settings: widget.settings,
          point: lastHoverPoint!,
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.turn == wq.Color.black
                    ? const Color.fromRGBO(0, 0, 0, 0.5)
                    : const Color.fromRGBO(255, 255, 255, 0.5)),
          ),
        ),
      if (widget.turn != null && confirmPoint != null)
        PositionedPoint(
          key: _keyConfirmStone(widget.turn!, confirmPoint!),
          size: widget.size,
          settings: widget.settings,
          point: confirmPoint!,
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.turn == wq.Color.black
                    ? const Color.fromRGBO(0, 0, 0, 0.5)
                    : const Color.fromRGBO(255, 255, 255, 0.5)),
          ),
        ),
    ];
    Widget board = SizedBox.square(
      key: const ValueKey('board-container'),
      dimension: widget.size,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          background,
          ...objects,
        ],
      ),
    );
    if (widget.settings.interactive) {
      board = MouseRegion(
        cursor: widget.cursor,
        onExit: _onPointerExit,
        onHover: _onPointerHover,
        child: GestureDetector(
          onTapDown: _onTapDown,
          child: board,
        ),
      );
    }

    if (widget.settings.border != null) {
      return Container(
        key: const ValueKey('board-border'),
        width: widget.size + widget.settings.border!.size * 2,
        height: widget.size + widget.settings.border!.size * 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: widget.settings.border!.color,
        ),
        child: Stack(alignment: Alignment.center, children: [
          if (widget.settings.border!.rowCoordinates != null)
            ..._rowCoords(widget.settings.border!.rowCoordinates!,
                widget.settings.border!.size, widget.size),
          if (widget.settings.border!.columnCoordinates != null)
            ..._columnCoords(widget.settings.border!.columnCoordinates!,
                widget.size, widget.settings.border!.size),
          board,
        ]),
      );
    }

    return board;
  }

  List<Widget> _coordLabelWidgets(CoordinateStyle coordStyle, int fullSize,
          int visibleSize, int offset) =>
      coordStyle
          .labelsFor(fullSize, visibleSize, offset)
          .map(
            (label) => Expanded(
              child: Center(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
          .toList(growable: false);

  List<Widget> _rowCoords(
      CoordinateStyle coordStyle, double width, double height) {
    final children = _coordLabelWidgets(coordStyle, widget.settings.size,
        widget.settings.visibleSize, widget.settings.subBoard?.topLeft.$1 ?? 0);
    return [
      Align(
        alignment: Alignment.centerLeft,
        child: _BoardRowCoordinates(
          width: width,
          height: height,
          children: children,
        ),
      ),
      Align(
        alignment: Alignment.centerRight,
        child: _BoardRowCoordinates(
          width: width,
          height: height,
          children: children,
        ),
      ),
    ];
  }

  List<Widget> _columnCoords(
      CoordinateStyle coordStyle, double width, double height) {
    final children = _coordLabelWidgets(coordStyle, widget.settings.size,
        widget.settings.visibleSize, widget.settings.subBoard?.topLeft.$2 ?? 0);
    return [
      Align(
        alignment: Alignment.topCenter,
        child: _BoardColumnCoordinates(
          width: width,
          height: height,
          children: children,
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: _BoardColumnCoordinates(
          width: width,
          height: height,
          children: children,
        ),
      ),
    ];
  }

  void _onTapDown(TapDownDetails details) {
    final p = widget.offsetPoint(details.localPosition);
    if (p == null) return;
    if (widget.confirmTap && boardIsLarge()) {
      if (widget.stones.containsKey(p)) {
        setState(() {
          confirmPoint = null;
        });
      } else if (confirmPoint == null) {
        setState(() {
          confirmPoint = p;
        });
      } else {
        if (p == confirmPoint) {
          widget.onPointClicked?.call(p);
          setState(() {
            confirmPoint = null;
          });
        } else {
          setState(() {
            confirmPoint = p;
          });
        }
      }
    } else {
      widget.onPointClicked?.call(p);
    }
  }

  bool boardIsLarge() {
    final int confirmMoveboardSize = context.settings.confirmMovesBoardSize;
    final int currentBoardSize = widget.settings.visibleSize;
    return confirmMoveboardSize <= currentBoardSize;
  }

  void _onPointerHover(PointerHoverEvent event) {
    final p = widget.offsetPoint(event.localPosition);
    if (p == lastHoverPoint || p == confirmPoint) return;
    if (p != null && widget.stones.containsKey(p)) {
      if (lastHoverPoint != null) {
        setState(() {
          lastHoverPoint = null;
        });
      }
      return;
    }
    widget.onPointHovered?.call(p);
    setState(() {
      lastHoverPoint = p;
    });
  }

  void _onPointerExit(PointerExitEvent event) {
    if (lastHoverPoint != null) {
      setState(() {
        lastHoverPoint = null;
      });
    }
  }

  Key _keyStone(wq.Color col, wq.Point p) => ValueKey('$col$p');
  Key _keyStoneShadow(wq.Point p) => ValueKey('ss$p');
  Key _keyHoverStone(wq.Color col, wq.Point p) => ValueKey('h$col$p');
  Key _keyConfirmStone(wq.Color col, wq.Point p) => ValueKey('c$col$p');
  Key _annotationKey(BoardAnnotation annotation, wq.Point p) =>
      ValueKey('${annotation.annotationKey}@$p');
}

class _BoardColumnCoordinates extends StatelessWidget {
  const _BoardColumnCoordinates({
    required this.width,
    required this.height,
    required this.children,
  });

  final double width;
  final double height;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Row(
        textDirection: TextDirection.ltr,
        children: children,
      ),
    );
  }
}

class _BoardRowCoordinates extends StatelessWidget {
  const _BoardRowCoordinates({
    required this.width,
    required this.height,
    required this.children,
  });

  final double width;
  final double height;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        textDirection: TextDirection.ltr,
        children: children,
      ),
    );
  }
}
