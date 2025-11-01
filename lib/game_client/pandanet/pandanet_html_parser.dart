import 'package:wqhub/wq/rank.dart';
import 'package:wqhub/game_client/user_info.dart';
import 'package:wqhub/game_client/game_result.dart';
import 'package:wqhub/wq/wq.dart' as wq;
import 'package:wqhub/game_client/game_client.dart';

String parseKey(String html) {
  final match = RegExp(r'key=([A-Z0-9]{10,})').firstMatch(html);
  if (match == null) throw Exception('Failed to parse Key');
  return match.group(1)!;
}

({int wins, int losses, String rankStr}) parseUserInfo(String html) {
  final block = RegExp(r'<dd\s+class="dd-point"\s*>([\s\S]*?)</dd>',
          caseSensitive: false)
      .firstMatch(html)
      ?.group(1);
  if (block == null) return (wins: 0, losses: 0, rankStr: '');

  final wins =
      int.tryParse(RegExp(r'>(\d+)<[^>]*>\s*wins', caseSensitive: false)
              .firstMatch(block)
              ?.group(1) ??
          '') ??
          0;
  final losses =
      int.tryParse(RegExp(r'>(\d+)<[^>]*>\s*loss', caseSensitive: false)
              .firstMatch(block)
              ?.group(1) ??
          '') ??
          0;
  final rankStr = RegExp(r'/\s*<font[^>]*>([^<]+)</font>\s*\(',
          caseSensitive: false)
      .firstMatch(block)
      ?.group(1)
      ?.trim() ??
      '';

  return (wins: wins, losses: losses, rankStr: rankStr);
}

Rank parseRankString(String str) {
  if (str.isEmpty) return Rank.unknown;
  final cleaned = str.toLowerCase().trim().replaceAll(RegExp(r'[+?]'), '');
  final match = RegExp(r'(\d+)\s*([kdp])$').firstMatch(cleaned);
  if (match == null) return Rank.unknown;

  final number = match.group(1);
  final suffix = match.group(2);
  final name = '$suffix$number';
  return Rank.values.firstWhere(
    (r) => r.name.toLowerCase() == name,
    orElse: () => Rank.unknown,
  );
}

List<GameSummary> parseGameList(
    String html, Rank Function(String) rankParser) {
  final table = RegExp(r'<table[^>]*class="more"[^>]*>([\s\S]*?)<\/table>')
      .firstMatch(html)
      ?.group(1);
  if (table == null) return [];

  final rows = RegExp(r'<tr[^>]*bgcolor="#FFFFFF"[^>]*>([\s\S]*?)<\/tr>')
      .allMatches(table);

  final games = <GameSummary>[];
  for (final row in rows) {
    final game = _parseGameRow(row.group(1)!, rankParser);
    if (game != null) games.add(game);
  }
  return games;
}

GameSummary? _parseGameRow(String rowHtml, Rank Function(String) rankParser) {
  final tds = RegExp(r'<td[^>]*>([\s\S]*?)<\/td>')
      .allMatches(rowHtml)
      .map((m) => m.group(1)!.trim())
      .toList();
  if (tds.length < 9) return null;

  final dateStr = _stripTags(tds[1]);
  final whiteStr = _stripTags(tds[2]);
  final blackStr = _stripTags(tds[3]);
  final sizeStr = _stripTags(tds[4]);
  final komiStr = _stripTags(tds[6]);
  final resultText = _stripTags(tds[7]);

  final sgfLink =
      RegExp(r'href="([^"]+mode=sgf[^"]*)"').firstMatch(tds[8])?.group(1);

  final gameId = (sgfLink ?? '').replaceAll('&amp;', '&');
  final boardSize = int.tryParse(sizeStr) ?? 19;
  final dateTime = DateTime.tryParse(
          dateStr.replaceAll('/', '-').replaceAll(' ', 'T')) ??
      DateTime.now();

  final lower = resultText.toLowerCase();
  wq.Color? winner;
  if (lower.contains('white won')) {
    winner = wq.Color.white;
  } else if (lower.contains('black won')) {
    winner = wq.Color.black;
  }

  final outcome = resultText
      .replaceFirst(RegExp(r'^(White)\s+'), 'W ')
      .replaceFirst(RegExp(r'^(Black)\s+'), 'B ')
      .replaceFirst(RegExp(r'\bwon by\b', caseSensitive: false), '+')
      .trim();

  final result = GameResult(
    winner: winner,
    result: outcome,
    description: komiStr,
  );

  UserInfo parsePlayer(String s) {
    final parts = s.split(' ');
    final name = parts.first;
    final rankStr = parts.length > 1 ? parts[1] : '?';
    return UserInfo(
      userId: name,
      username: name,
      rank: rankParser(rankStr),
      online: false,
      winCount: 0,
      lossCount: 0,
    );
  }

  final white = parsePlayer(whiteStr);
  final black = parsePlayer(blackStr);

  return GameSummary(
    id: gameId,
    boardSize: boardSize,
    white: white,
    black: black,
    dateTime: dateTime,
    result: result,
  );
}

String cleanSgfContent(String sgf) {
  var text = sgf
      .replaceAll('\r', '')
      .replaceAll('\uFEFF', '')
      .replaceAll('\x00', '')
      .trim();

  final lastParen = text.lastIndexOf(')');
  if (lastParen != -1) text = text.substring(0, lastParen + 1);
  text = text.replaceFirst(RegExp(r'\(\s*;\s*'), '(;');

  return text;
}

String _stripTags(String html) =>
    html.replaceAll(RegExp(r'<[^>]*>'), '').trim();
