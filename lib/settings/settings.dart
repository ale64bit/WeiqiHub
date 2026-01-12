import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wqhub/audio/audio_controller.dart';
import 'package:wqhub/board/board_settings.dart';
import 'package:wqhub/board/board_theme.dart';
import 'package:wqhub/board/board_sizes.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/train/custom_exam_presets.dart';
import 'package:wqhub/train/response_delay.dart';
import 'package:wqhub/wq/wq.dart' as wq;

class Settings {
  final SharedPreferencesWithCache prefs;

  const Settings(this.prefs);

  static const _versionPatch = 'internal.version_patch';
  static const _localBoardSize = 'internal.local_board.size';
  static const _localBoardHandicap = 'internal.local_board.handicap';
  static const _localBoardMoves = 'internal.local_board.moves';
  static const _customExamPresets = 'internal.custom_exam_presets';
  static const _themeKey = 'settings.theme';
  static const _behaviourKeyPrefix = 'settings.behaviour';
  static const _soundStoneKey = 'settings.sound.stone';
  static const _soundVoiceKey = 'settings.sound.voice';
  static const _soundUIKey = 'settings.sound.ui';
  static const _credentialsPrefix = 'settings.auth';
  static const _boardTheme = 'settings.board.theme';
  static const _boardShowCoordinatesKey = 'settings.board.show_coordinates';
  static const _boardStoneShadowsKey = 'settings.board.stone_shadows';
  static const _boardEdgeLine = 'settings.board.edge_line';
  static const _hidePlayerRanks = 'settings.appearance.hide_player_ranks';
  static const _fullscreen = 'settings.appearance.fullscreen';
  static const _saveDirectory = 'settings.save_dir';
  static const _locale = 'settings.language.locale';
  static const _helpDialogPrefix = 'settings.help';

  // Internal preferences
  bool getVersionPatchStatus(String version) =>
      prefs.getBool('$_versionPatch.$version.status') ?? false;
  void setVersionPatchStatus(String version, bool status) =>
      prefs.setBool('$_versionPatch.$version.status', status);
  String? getSaveDirectory() => prefs.getString(_saveDirectory);
  set saveDirectory(String dir) => prefs.setString(_saveDirectory, dir);
  int get localBoardSize => prefs.getInt(_localBoardSize) ?? 19;
  set localBoardSize(int value) => prefs.setInt(_localBoardSize, value);
  int get localBoardHandicap => prefs.getInt(_localBoardHandicap) ?? 0;
  set localBoardHandicap(int value) => prefs.setInt(_localBoardHandicap, value);

  CustomExamPresets get customExamPresets {
    final val = prefs.getString(_customExamPresets);
    if (val == null) {
      return CustomExamPresets.empty();
    }
    return CustomExamPresets.fromJson(jsonDecode(val));
  }

  set customExamPresets(CustomExamPresets presets) {
    prefs.setString(_customExamPresets, jsonEncode(presets.toJson()));
  }

  Iterable<wq.Point> get localBoardMoves =>
      (prefs.getStringList(_localBoardMoves) ?? []).map(wq.parseSgfPoint);

  void pushLocalBoardMoves(Iterable<wq.Point?> ps) {
    final moves = prefs.getStringList(_localBoardMoves) ?? [];
    moves.addAll(ps.map((p) => p?.toSgf() ?? ''));
    prefs.setStringList(_localBoardMoves, moves);
  }

  void popLocalBoardMoves({int count = 1}) {
    final moves = prefs.getStringList(_localBoardMoves) ?? [];
    for (int i = 0; i < count && moves.isNotEmpty; ++i) {
      moves.removeLast();
    }
    prefs.setStringList(_localBoardMoves, moves);
  }

  void clearLocalBoardState() => prefs.setStringList(_localBoardMoves, []);

  // General
  ThemeMode get themeMode =>
      ThemeMode.values[prefs.getInt(_themeKey) ?? ThemeMode.system.index];
  set themeMode(ThemeMode mode) => prefs.setInt(_themeKey, mode.index);

  // Appearance
  BoardTheme get boardTheme =>
      BoardTheme.themes[prefs.getString(_boardTheme)] ?? BoardTheme.plain;
  bool get showCoordinates => prefs.getBool(_boardShowCoordinatesKey) ?? false;
  bool get stoneShadows => prefs.getBool(_boardStoneShadowsKey) ?? true;
  BoardEdgeLine get edgeLine =>
      BoardEdgeLine.values[prefs.getInt(_boardEdgeLine) ?? 0];
  bool get hidePlayerRanks => prefs.getBool(_hidePlayerRanks) ?? false;
  bool get fullscreen => prefs.getBool(_fullscreen) ?? true;

  set boardTheme(BoardTheme theme) => prefs.setString(_boardTheme, theme.id);
  set showCoordinates(bool val) => prefs.setBool(_boardShowCoordinatesKey, val);
  set stoneShadows(bool val) => prefs.setBool(_boardStoneShadowsKey, val);
  set edgeLine(BoardEdgeLine edgeLine) =>
      prefs.setInt(_boardEdgeLine, edgeLine.index);
  set hidePlayerRanks(bool val) => prefs.setBool(_hidePlayerRanks, val);
  set fullscreen(bool val) => prefs.setBool(_fullscreen, val);

  // Behaviour
  bool get confirmMoves =>
      prefs.getBool('$_behaviourKeyPrefix.confirm_moves') ??
      (Platform.isAndroid || Platform.isIOS);

  set confirmMoves(bool val) =>
      prefs.setBool('$_behaviourKeyPrefix.confirm_moves', val);

  int get confirmMovesBoardSize =>
      prefs.getInt('$_behaviourKeyPrefix.confirm_moves_board_size') ??
      BoardSizes.size_9.value;

  set confirmMovesBoardSize(int boardSize) =>
      prefs.setInt('$_behaviourKeyPrefix.confirm_moves_board_size', boardSize);

  ResponseDelay get responseDelay => ResponseDelay.values[
      prefs.getInt('$_behaviourKeyPrefix.response_delay') ??
          ResponseDelay.short.index];

  set responseDelay(ResponseDelay delay) =>
      prefs.setInt('$_behaviourKeyPrefix.response_delay', delay.index);

  bool get alwaysBlackToPlay =>
      prefs.getBool('$_behaviourKeyPrefix.always_black_to_play') ?? true;

  set alwaysBlackToPlay(bool val) =>
      prefs.setBool('$_behaviourKeyPrefix.always_black_to_play', val);

  bool get randomizeTaskOrientation =>
      prefs.getBool('$_behaviourKeyPrefix.randomize_task_orientation') ?? false;

  set randomizeTaskOrientation(bool val) =>
      prefs.setBool('$_behaviourKeyPrefix.randomize_task_orientation', val);

  bool get showMoveErrorsAsCrosses =>
      prefs.getBool('$_behaviourKeyPrefix.show_move_errors_as_crosses') ??
      false;

  set showMoveErrorsAsCrosses(bool val) =>
      prefs.setBool('$_behaviourKeyPrefix.show_move_errors_as_crosses', val);

  bool get trackTimeFrenzyMistakes =>
      prefs.getBool('$_behaviourKeyPrefix.track_time_frenzy_mistakes') ?? false;

  set trackTimeFrenzyMistakes(bool val) =>
      prefs.setBool('$_behaviourKeyPrefix.track_time_frenzy_mistakes', val);

  // Sound
  double get soundStone => prefs.getDouble(_soundStoneKey) ?? 1.0;
  set soundStone(double val) => prefs.setDouble(_soundStoneKey, val).then((_) {
        AudioController().stoneVolume = val;
      });

  double get soundVoice => prefs.getDouble(_soundVoiceKey) ?? 1.0;
  set soundVoice(double val) => prefs.setDouble(_soundVoiceKey, val).then((_) {
        AudioController().voiceVolume = val;
      });

  double get soundUI => prefs.getDouble(_soundUIKey) ?? 1.0;
  set soundUI(double val) => prefs.setDouble(_soundUIKey, val).then((_) {
        AudioController().uiVolume = val;
      });

  // Locale
  Locale get locale => Locale(prefs.getString(_locale) ?? _defaultLocale());
  set locale(Locale loc) => prefs.setString(_locale, loc.languageCode);

  String _defaultLocale() {
    final platformLoc = Locale(Platform.localeName);
    for (final loc in AppLocalizations.supportedLocales) {
      if (loc.languageCode == platformLoc.languageCode) {
        return loc.languageCode;
      }
    }
    return 'en';
  }

  // Auth
  String? getUsername(String serverId) =>
      prefs.getString('$_credentialsPrefix.$serverId.username');

  String? getPassword(String serverId) =>
      prefs.getString('$_credentialsPrefix.$serverId.password');

  void setUsername(String serverId, String username) {
    prefs.setString('$_credentialsPrefix.$serverId.username', username);
  }

  void setPassword(String serverId, String password) {
    prefs.setString('$_credentialsPrefix.$serverId.password', password);
  }

  // Help
  bool get showCollectionsHelp =>
      prefs.getBool('$_helpDialogPrefix.collections') ?? true;
  set showCollectionsHelp(bool b) =>
      prefs.setBool('$_helpDialogPrefix.collections', b);
  bool get showGradingExamHelp =>
      prefs.getBool('$_helpDialogPrefix.grading_exam') ?? true;
  set showGradingExamHelp(bool b) =>
      prefs.setBool('$_helpDialogPrefix.grading_exam', b);
  bool get showEndgameExamHelp =>
      prefs.getBool('$_helpDialogPrefix.endgame_exam') ?? true;
  set showEndgameExamHelp(bool b) =>
      prefs.setBool('$_helpDialogPrefix.endgame_exam', b);
  bool get showTimeFrenzyHelp =>
      prefs.getBool('$_helpDialogPrefix.time_frenzy') ?? true;
  set showTimeFrenzyHelp(bool b) =>
      prefs.setBool('$_helpDialogPrefix.time_frenzy', b);
  bool get showRankedModeHelp =>
      prefs.getBool('$_helpDialogPrefix.ranked_mode') ?? true;
  set showRankedModeHelp(bool b) =>
      prefs.setBool('$_helpDialogPrefix.ranked_mode', b);
}
