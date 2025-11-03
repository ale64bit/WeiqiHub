import 'dart:async';
import 'package:wqhub/game_client/game.dart';
import 'package:wqhub/game_client/game_result.dart';
import 'package:wqhub/game_client/automatic_counting_info.dart';
import 'package:wqhub/game_client/counting_result.dart';
import 'package:wqhub/wq/wq.dart' as wq;
import 'package:wqhub/game_client/time_control.dart';
import 'pandanet_tcp_manager.dart';
import 'package:wqhub/game_client/rules.dart';

class PandanetGame extends Game {
  final PandanetTcpManager tcp;

  final _moveController = StreamController<wq.Move?>.broadcast();
  final _automaticCountingController = StreamController<bool>.broadcast();
  final _countingResultController =
      StreamController<CountingResult>.broadcast();

  GameResult? _lastResult;

  PandanetGame({
    required String id,
    required int boardSize,
    required wq.Color myColor,
    required TimeControl timeControl,
    required this.tcp,
  }) : super(
          id: id,
          boardSize: boardSize,
          rules: Rules.japanese,
          handicap: 0,
          komi: 6.5,
          myColor: myColor,
          timeControl: timeControl,
          previousMoves: [],
        ) {
    tcp.messages.listen(_onMessage);
  }

  List<String> get _goLetters =>
      List.generate(19, (i) => String.fromCharCode(i + 65))
          .where((c) => c != 'I')
          .toList(growable: false);
  void _onMessage(String line) {
    final text = line.trim();

    final moveMatch =
        RegExp(r'\(\s*([BW])\s*\):\s*([A-Ta-t]\d{1,2})').firstMatch(text);
    if (moveMatch != null) {
      final color = moveMatch.group(1) == 'B' ? wq.Color.black : wq.Color.white;
      final coord = moveMatch.group(2)!;
      final parsed = parseCoordinate(coord);
      final move = (col: color, p: parsed);
      _moveController.add(move);
      return;
    }

    final resignMatch =
        RegExp(r'Game\s+\d+:\s+.+:\s+(Black|White)\s+resigns').firstMatch(text);
    if (resignMatch != null) {
      final color =
          resignMatch.group(1) == 'Black' ? wq.Color.black : wq.Color.white;
      _lastResult = GameResult(
        winner: color == wq.Color.black ? wq.Color.white : wq.Color.black,
        result: 'Resign',
        description: null,
      );
      _countingResultController.add(
        CountingResult(
          winner: _lastResult!.winner!,
          scoreLead: 0,
          ownership: List.generate(
            19,
            (_) => List<wq.Color?>.filled(19, null),
          ),
        ),
      );
      return;
    }

    if (text.contains('requested counting') ||
        text.contains('proposes counting')) {
      _automaticCountingController.add(true);
      return;
    }
    if (text.contains('agreed to counting') ||
        text.contains('counting started')) {
      _automaticCountingController.add(true);
      return;
    }

    final resultMatch =
        RegExp(r'The result is\s+([BW])\+([0-9.R]+)').firstMatch(text);
    if (resultMatch != null) {
      final color =
          resultMatch.group(1) == 'B' ? wq.Color.black : wq.Color.white;
      final desc = resultMatch.group(2)!;
      _lastResult = GameResult(
        winner: color,
        result: desc,
        description: null,
      );
      _countingResultController.add(
        CountingResult(
          winner: color,
          scoreLead: double.tryParse(desc.replaceAll('R', '0')) ?? 0,
          ownership: List.generate(
            19,
            (_) => List<wq.Color?>.filled(19, null),
          ),
        ),
      );
      return;
    }
  }

  (int, int) parseCoordinate(String coord) {
    final letter = coord[0].toUpperCase();
    final number = int.tryParse(coord.substring(1)) ?? 1;
    final col = _goLetters.indexOf(letter);
    final row = 19 - number;
    return (col, row);
  }

  String formatCoordinates((int x, int y) point) {
    final col = point.$1; // x
    final row = point.$2; // y

    if (col < 0 || col >= 19 || row < 0 || row >= 19) {
      throw ArgumentError('Invalid coordinates: $point');
    }

    final letter = _goLetters[col];
    final number = 19 - row;
    return '$letter$number';
  }

  @override
  Stream<wq.Move?> moves() => _moveController.stream;

  @override
  Future<void> move(wq.Move move) async {
    final coords = formatCoordinates(move.p);
    tcp.send(coords);
  }

  @override
  Future<void> pass() async => tcp.send('pass');

  @override
  Future<void> resign() async => tcp.send('resign');

  @override
  Future<void> manualCounting() async => tcp.send('score');

  @override
  Stream<bool> automaticCountingResponses() =>
      _automaticCountingController.stream;

  @override
  Stream<CountingResult> countingResults() => _countingResultController.stream;

  @override
  Stream<bool> countingResultResponses() => const Stream.empty();

  @override
  Future<AutomaticCountingInfo> automaticCounting() async {
    tcp.send('pass');
    await Future.delayed(const Duration(milliseconds: 500));
    tcp.send('done');
    return const AutomaticCountingInfo(timeout: Duration(seconds: 30));
  }

  @override
  Future<GameResult> result() async {
    return _lastResult ??
        const GameResult(winner: null, result: '', description: null);
  }

  @override
  Future<void> aiReferee() async {}

  @override
  Future<void> forceCounting() async {}

  @override
  Future<void> agreeToAutomaticCounting(bool agree) async {}

  @override
  Future<void> acceptCountingResult(bool agree) async {}

  void dispose() {
    _moveController.close();
    _automaticCountingController.close();
    _countingResultController.close();
  }
}
