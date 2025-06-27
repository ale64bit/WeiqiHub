import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:extension_type_unions/extension_type_unions.dart';
import 'package:wqhub/board/board.dart';
import 'package:wqhub/board/board_annotation.dart';
import 'package:wqhub/board/board_settings.dart';
import 'package:wqhub/board/coordinate_style.dart';
import 'package:wqhub/settings/appearance_settings_list.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/window_class_aware_state.dart';
import 'package:wqhub/wq/wq.dart' as wq;

class AppearanceSettingsPage extends StatefulWidget {
  final Function() reloadAppTheme;

  const AppearanceSettingsPage({super.key, required this.reloadAppTheme});

  @override
  State<AppearanceSettingsPage> createState() => _AppearanceSettingsPageState();
}

class _AppearanceSettingsPageState
    extends WindowClassAwareState<AppearanceSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final borderSize =
        1.5 * (Theme.of(context).textTheme.labelMedium?.fontSize ?? 0);
    final border = context.settings.showCoordinates
        ? BoardBorderSettings(
            size: borderSize,
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
            rowCoordinates: CoordinateStyle(
              labels: CoordinateLabels.numbers,
              reverse: true,
            ),
            columnCoordinates: CoordinateStyle(
              labels: CoordinateLabels.alphaNoI,
            ),
          )
        : null;
    final boardSettings = BoardSettings(
      size: 19,
      subBoard: SubBoard(
        topLeft: (0, 0),
        size: 5,
      ),
      theme: context.settings.boardTheme,
      edgeLine: context.settings.edgeLine,
      border: border,
      stoneShadows: context.settings.stoneShadows,
    );
    final previewBoard = LayoutBuilder(
      builder: (context, constraints) {
        final boardSize = constraints.biggest.shortestSide -
            2 * (boardSettings.border?.size ?? 0);
        return Board(
          size: boardSize,
          settings: boardSettings,
          turn: wq.Color.black,
          stones: IMap({
            (1, 2): wq.Color.black,
            (2, 1): wq.Color.black,
            (2, 3): wq.Color.black,
            (3, 2): wq.Color.black,
            (2, 0): wq.Color.white,
            (1, 1): wq.Color.white,
            (3, 1): wq.Color.white,
          }),
          annotations: IMapOfSets({
            (2, 1): ISet([
              (
                type: AnnotationShape.circle.u21,
                color: Colors.white,
              ),
            ]),
          }),
          confirmTap: false,
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appearance'),
      ),
      body: isWindowClassCompact
          ? Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: previewBoard,
                ),
                Expanded(
                  child: AppearanceSettingsList(
                    onChanged: () {
                      setState(() {});
                    },
                    onAppThemeChanged: widget.reloadAppTheme,
                  ),
                ),
              ],
            )
          : Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(child: previewBoard),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: AppearanceSettingsList(
                    onChanged: () {
                      setState(() {});
                    },
                    onAppThemeChanged: widget.reloadAppTheme,
                  ),
                ),
              ],
            ),
    );
  }
}
