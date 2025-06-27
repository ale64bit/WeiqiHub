import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wqhub/wq/annotated_game_tree.dart';

class GameNavigationBar extends StatelessWidget {
  const GameNavigationBar({
    super.key,
    required this.mainAxisAlignment,
    required this.gameTree,
    this.fastSkipMoveCount = 10,
    this.onMovesSkipped,
  });

  final MainAxisAlignment mainAxisAlignment;
  final AnnotatedGameTree gameTree;
  final int fastSkipMoveCount;
  final Function(int)? onMovesSkipped;

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        const SingleActivator(LogicalKeyboardKey.home): () {
          _onGoPrevMove(1 << 30);
        },
        const SingleActivator(LogicalKeyboardKey.pageDown): () {
          _onGoPrevMove(fastSkipMoveCount);
        },
        const SingleActivator(LogicalKeyboardKey.arrowLeft): () {
          _onGoPrevMove(1);
        },
        const SingleActivator(LogicalKeyboardKey.arrowRight): () {
          _onGoNextMove(1);
        },
        const SingleActivator(LogicalKeyboardKey.pageUp): () {
          _onGoNextMove(fastSkipMoveCount);
        },
        const SingleActivator(LogicalKeyboardKey.end): () {
          _onGoNextMove(1 << 30);
        },
      },
      child: Focus(
        autofocus: true,
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          children: [
            IconButton(
              onPressed: () {
                _onGoPrevMove(1 << 30);
              },
              icon: Icon(Icons.skip_previous),
            ),
            IconButton(
              onPressed: () {
                _onGoPrevMove(fastSkipMoveCount);
              },
              icon: Icon(Icons.fast_rewind),
            ),
            IconButton(
              onPressed: () {
                _onGoPrevMove(1);
              },
              icon: Transform.flip(
                flipX: true,
                child: Icon(Icons.play_arrow),
              ),
            ),
            if (gameTree.isVariation)
              IconButton(
                onPressed: _onGoMainline,
                icon: Icon(Icons.undo),
              ),
            if (!gameTree.isVariation)
              ConstrainedBox(
                constraints: BoxConstraints(minWidth: 24),
                child: Text(
                  '${gameTree.curNode.moveNumber}',
                  textAlign: TextAlign.center,
                ),
              ),
            IconButton(
              onPressed: () {
                _onGoNextMove(1);
              },
              icon: Icon(Icons.play_arrow),
            ),
            IconButton(
              onPressed: () {
                _onGoNextMove(fastSkipMoveCount);
              },
              icon: Icon(Icons.fast_forward),
            ),
            IconButton(
              onPressed: () {
                _onGoNextMove(1 << 30);
              },
              icon: Icon(Icons.skip_next),
            ),
          ],
        ),
      ),
    );
  }

  void _onGoPrevMove(int count) {
    int i = 0;
    while (i < count) {
      if (gameTree.undo() == null) break;
      i++;
    }
    if (i > 0) {
      onMovesSkipped?.call(i);
    }
  }

  void _onGoNextMove(int count) {
    int i = 0;
    while (i < count) {
      if (gameTree.redo() == null) break;
      i++;
    }
    if (i > 0) {
      onMovesSkipped?.call(i);
    }
  }

  void _onGoMainline() {
    int i = 0;
    while (gameTree.isVariation) {
      if (gameTree.undo() == null) break;
      i++;
    }
    if (i > 0) {
      onMovesSkipped?.call(i);
    }
  }
}
