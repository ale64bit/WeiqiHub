import 'dart:convert';
import 'package:petitparser/petitparser.dart';

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

  final Map<String, Map<String, String>> headers;
  final List<GibGameCmd> game;

  Gib._({required this.headers, required this.game});

  static final _parser = _GibDefinition().build();

  factory Gib.parse(List<int> gib) {
    final str = utf8.decode(gib, allowMalformed: true);
    return _parser.parse(str).value;
  }
}

class _GibDefinition extends GrammarDefinition {
  @override
  Parser<Gib> start() => (ref0(headersSection) & ref0(gameSection))
      .map((tuple) => Gib._(
            headers: tuple[0],
            game: tuple[1],
          ));

  // Whitespace helpers  
  Parser<void> ws() => (whitespace() | newline()).star();

  // Headers section: \HS ... \HE
  Parser<Map<String, Map<String, String>>> headersSection() =>
      ref0(header)
          .star()
          .skip(before: string(r'\HS') & ref0(ws), after: string(r'\HE') & ref0(ws))
          .map((list) => {for (final (name, hdr) in list) name: hdr});

  // Single header: \[HEADERNAME=key1:value1,key2:value2,simplevalue\]
  Parser<(String, Map<String, String>)> header() =>
      ref0(headerContent)
          .skip(
            before: string(r'\[') & ref0(ws),
            after: string(r'\]') & ref0(ws),
          )
          .cast<(String, Map<String, String>)>();

  Parser<(String, Map<String, String>)> headerContent() =>
      (ref0(headerName) & char('=') & ref0(headerValues)).map((tuple) {
        return (tuple[0] as String, tuple[2] as Map<String, String>);
      });

  Parser<String> headerName() => uppercase().plus().flatten();

  // Header values: can be key:value pairs OR just plain values
  Parser<Map<String, String>> headerValues() =>
      ref0(headerValue)
          .separatedBy(char(','), includeSeparators: false)
          .map((list) {
        final map = <String, String>{};
        for (int i = 0; i < list.length; i++) {
          final entry = list[i];
          if (entry is MapEntry<String, String>) {
            map[entry.key] = entry.value;
          } else {
            // Plain value without key - use index as key
            map[i.toString()] = entry as String;
          }
        }
        return map;
      });

  Parser<dynamic> headerValue() =>
      ref0(keyValuePair) | ref0(plainValue);

  Parser<MapEntry<String, String>> keyValuePair() =>
      (ref0(keyName) & char(':') & ref0(valueName)).map((tuple) {
        return MapEntry(tuple[0] as String, tuple[2] as String);
      });

  Parser<String> plainValue() =>
      pattern(r'^:,\]\\').plus().flatten();

  // Key name: any chars except :,\]
  Parser<String> keyName() =>
      pattern(r'^:,\]\\').plus().flatten();

  // Value name: any chars except ,\] (can be empty, can contain colons for URLs)
  Parser<String> valueName() =>
      pattern(r'^,\]\\').star().flatten();

  // Game section: \GS ... \GE
  Parser<List<GibGameCmd>> gameSection() {
    final rawContent = pattern(r'^\').star().flatten();
    return rawContent
        .skip(before: string(r'\GS'), after: string(r'\GE'))
        .map((content) {
          return content
              .split('\n')
              .map((line) => line.trim())
              .where((line) => line.isNotEmpty)
              .map((line) {
                final parts = line.split(RegExp(r'\s+'));
                if (parts.isNotEmpty && Gib.commands.contains(parts.first)) {
                  return GibGameCmd(cmd: parts.first, args: parts.sublist(1));
                }
                return GibGameCmd(cmd: '', args: parts);
              })
              .toList(growable: false);
        });
  }
}
