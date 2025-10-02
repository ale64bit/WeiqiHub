import 'package:flutter/material.dart';
import 'package:wqhub/board/board_settings.dart';
import 'package:wqhub/board/board_theme.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';

extension on ThemeMode {
  String toLocalizedString(AppLocalizations loc) => switch (this) {
        ThemeMode.system => loc.system,
        ThemeMode.light => loc.light,
        ThemeMode.dark => loc.dark,
      };
}

class AppearanceSettingsList extends StatelessWidget {
  final Function() onChanged;
  final Function() onAppThemeChanged;

  const AppearanceSettingsList(
      {super.key, required this.onChanged, required this.onAppThemeChanged});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return ListView(
      children: [
        ListTile(
          title: Text(loc.theme),
          trailing: DropdownButton<ThemeMode>(
            value: context.settings.themeMode,
            items: ThemeMode.values.map((mode) {
              return DropdownMenuItem<ThemeMode>(
                value: mode,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(mode.toLocalizedString(loc)),
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
          title: Text(loc.boardTheme),
          trailing: DropdownButton<BoardTheme>(
            value: context.settings.boardTheme,
            borderRadius: BorderRadius.circular(8),
            items: BoardTheme.themes.values.map((theme) {
              return DropdownMenuItem<BoardTheme>(
                value: theme,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(theme.displayName),
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
          title: Text(loc.showCoordinates),
          trailing: Switch(
            value: context.settings.showCoordinates,
            onChanged: (value) {
              context.settings.showCoordinates = value;
              onChanged();
            },
          ),
        ),
        ListTile(
          title: Text(loc.stoneShadows),
          trailing: Switch(
            value: context.settings.stoneShadows,
            onChanged: (value) {
              context.settings.stoneShadows = value;
              onChanged();
            },
          ),
        ),
        ListTile(
          title: Text(loc.edgeLine),
          trailing: SegmentedButton<BoardEdgeLine>(
            selected: <BoardEdgeLine>{context.settings.edgeLine},
            segments: [
              ButtonSegment<BoardEdgeLine>(
                value: BoardEdgeLine.single,
                label: Text(loc.simple),
              ),
              ButtonSegment<BoardEdgeLine>(
                value: BoardEdgeLine.thick,
                label: Text(loc.thick),
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
