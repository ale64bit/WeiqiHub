import 'dart:convert';

import 'package:wqhub/parse/parse_ext.dart';

class GibGameCmd {
  final String cmd;
  final List<String> args;

  GibGameCmd({required this.cmd, required this.args});
}

class Gib {
  static final commands = const {
    'BAC',
    'BEG',
    'BRT',
    'CRE',
    'CSP',
    'CST',
    'DEL',
    'DSC',
    'END',
    'FOR',
    'HLD',
    'IDX',
    'INI',
    'MOV',
    'PDT',
    'PSP',
    'PST',
    'REM',
    'REV',
    'SET',
    'SHO',
    'SKI',
    'STO',
    'STR',
    'SUR',
    'VST',
    'WIT',
  };

  final Map<String, Map<String, List<int>>> headers;
  final List<GibGameCmd> game;

  Gib._({required this.headers, required this.game});

  factory Gib.parse(List<int> gib) {
    final (it, headers) = _parseHeaders(gib);
    final (_, game) = _parseGame(it);
    final cmds = game.split('\n').map((s) {
      final parts = s.trim().split(' ');
      if (parts.isNotEmpty && commands.contains(parts.first)) {
        return GibGameCmd(cmd: parts.first, args: parts.sublist(1));
      }
      return GibGameCmd(cmd: '', args: parts);
    });
    return Gib._(
      headers: headers,
      game: cmds.toList(growable: false),
    );
  }

  static (Iterable<int>, Map<String, Map<String, List<int>>>) _parseHeaders(
      Iterable<int> it) {
    return it.skipSpace().tag(r'\HS', r'\HE', (it) {
      Map<String, Map<String, List<int>>> headers = {};
      while (utf8.decode(it.take(3).toList(), allowMalformed: true) != r'\HE') {
        final (nextIt, (name, hdr)) = _parseHeader(it);
        headers[name] = hdr;
        it = nextIt.skipSpace();
      }
      return (it, headers);
    });
  }

  static (Iterable<int>, (String, Map<String, List<int>>)) _parseHeader(
      Iterable<int> it) {
    return it.skipSpace().tag(r'\[', r'\]', (it) {
      final (itAfterName, name) = it.propName();
      it = itAfterName.matchEqual();
      Map<String, List<int>> header = {};
      while (!it.isBackslash()) {
        final (itAfterKey, key) = it.collectUntil(':'.codeUnitAt(0));
        it = itAfterKey.matchColon();
        final (itAfterValue, value) =
            it.collectUntilCond((it) => it.isComma() || it.isBackslash());
        it = itAfterValue;
        header[utf8.decode(key)] = value;
        if (it.isBackslash()) break;
        it = it.matchComma();
      }
      return (it, (name, header));
    });
  }

  static (Iterable<int>, String) _parseGame(Iterable<int> it) {
    return it.skipSpace().tag(r'\GS', r'\GE', (it) {
      final (itAfterGame, data) =
          it.skipSpace().collectUntil(r'\'.codeUnitAt(0));
      return (itAfterGame, utf8.decode(data).trim());
    });
  }
}
