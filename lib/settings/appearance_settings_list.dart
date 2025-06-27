import 'package:flutter/material.dart';
import 'package:wqhub/board/board_settings.dart';
import 'package:wqhub/board/board_theme.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';

class AppearanceSettingsList extends StatelessWidget {
  final Function() onChanged;
  final Function() onAppThemeChanged;

  const AppearanceSettingsList(
      {super.key, required this.onChanged, required this.onAppThemeChanged});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text('Theme'),
          trailing: DropdownButton<ThemeMode>(
            value: context.settings.themeMode,
            items: ThemeMode.values.map((mode) {
              return DropdownMenuItem<ThemeMode>(
                value: mode,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(mode.name),
                ),
              );
            }).toList(),
            borderRadius: BorderRadius.circular(8),
            onChanged: (ThemeMode? mode) {
              context.settings.themeMode = mode!;
              onAppThemeChanged();
            },
          ),
        ),
        ListTile(
          title: const Text('Board theme'),
          trailing: DropdownButton<BoardTheme>(
            value: context.settings.boardTheme,
            borderRadius: BorderRadius.circular(8),
            items: BoardTheme.themes.values.map((theme) {
              return DropdownMenuItem<BoardTheme>(
                value: theme,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(theme.id),
                ),
              );
            }).toList(),
            onChanged: (BoardTheme? theme) {
              context.settings.boardTheme = theme!;
              onChanged();
            },
          ),
        ),
        ListTile(
          title: const Text('Show coordinates'),
          trailing: Switch(
            value: context.settings.showCoordinates,
            onChanged: (value) {
              context.settings.showCoordinates = value;
              onChanged();
            },
          ),
        ),
        ListTile(
          title: const Text('Stone shadows'),
          trailing: Switch(
            value: context.settings.stoneShadows,
            onChanged: (value) {
              context.settings.stoneShadows = value;
              onChanged();
            },
          ),
        ),
        ListTile(
          title: const Text('Edge line'),
          trailing: SegmentedButton<BoardEdgeLine>(
            selected: <BoardEdgeLine>{context.settings.edgeLine},
            segments: [
              ButtonSegment<BoardEdgeLine>(
                value: BoardEdgeLine.single,
                label: Text('Simple'),
              ),
              ButtonSegment<BoardEdgeLine>(
                value: BoardEdgeLine.thick,
                label: Text('Thick'),
              ),
            ],
            onSelectionChanged: (value) {
              context.settings.edgeLine = value.first;
              onChanged();
            },
          ),
        ),
      ],
    );
  }
}
