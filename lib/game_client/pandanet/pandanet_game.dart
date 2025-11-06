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

  late final Completer<GameResult> _resultCompleter;
  final _moveController = StreamController<wq.Move?>.broadcast();
  final _automaticCountingController = StreamController<bool>.broadcast();
  final _countingResultController =
      StreamController<CountingResult>.broadcast();

  GameResult? _lastResult;
  StreamSubscription<String>? _sub;
  bool _handicapApplied = false;
  static List<(int, int)> handicapPoints19(int n) {
    final pts = <(int, int)>[
      (3, 15), // BL
      (15, 3), // TR
      (15, 15), // BR
      (3, 3), // TL
      (9, 9), // Center
      (3, 9), // ML
      (15, 9), // MR
      (9, 3), // TM
      (9, 15), // BM
    ];
    if (n <= 0) return const [];
    if (n >= pts.length) return pts;
    return pts.sublist(0, n);
  }

  PandanetGame({
    required String id,
    required int boardSize,
    required wq.Color myColor,
    required TimeControl timeControl,
    required this.tcp,
    int handicap = 0,
    double komi = 6.5,
    List<wq.Move> previousMoves = const [],
  }) : super(
          id: id,
          boardSize: boardSize,
          rules: Rules.japanese,
          handicap: handicap,
          komi: komi,
          myColor: myColor,
          timeControl: timeControl,
          previousMoves: previousMoves,
        ) {
    _resultCompleter = Completer<GameResult>();
    _sub = tcp.messages.listen(_onMessage, onError: (_) {
      if (!_resultCompleter.isCompleted) {
        _resultCompleter.completeError('Connection lost before game finished');
      }
    });
    if (handicap >= 2) {
      final pts = handicapPoints19(handicap.clamp(2, 9));
      for (final p in pts) {
        _moveController.add((col: wq.Color.black, p: p));
      }
      _handicapApplied = true;
    }
  }

  List<String> get _goLetters =>
      List.generate(19, (i) => String.fromCharCode(i + 65))
          .where((c) => c != 'I')
          .toList(growable: false);

  void _onMessage(String line) {
    final text = line.trim();

    final handiMatch = RegExp(r'\(B\):\s*Handicap\s+(\d+)').firstMatch(text);
    if (handiMatch != null) {
      final handiCount = int.parse(handiMatch.group(1)!);
      print('Detected handicap: $handiCount (emitting stones)');

      if (handiCount >= 2) {
        final pts = handicapPoints19(handiCount.clamp(2, 9));
        for (final p in pts) {
          _moveController.add((col: wq.Color.black, p: p));
        }
      }
      return;
    }

    final isThisGame = RegExp(r'Game\s+$id\b').hasMatch(text) ||
        RegExp(r'\{Game\s+$id\b').hasMatch(text);
    final isMoveLine = RegExp(r'^\s*15\s+\d+\s*\([BW]\):').hasMatch(text) ||
        RegExp(r'\(\s*[BW]\s*\):\s*[A-Ta-t]\d{1,2}').hasMatch(text);

    if (!_handicapApplied && isThisGame) {
      final h = RegExp(r'\bHandicap\s+(\d+)\b').firstMatch(text);
      if (h != null) {
        final hCount = int.parse(h.group(1)!);
        if (hCount >= 2) {
          final pts = handicapPoints19(hCount.clamp(2, 9));
          for (final p in pts) {
            _moveController.add((col: wq.Color.black, p: p));
          }
        }
        _handicapApplied = true;
        return;
      }
    }

    if (!isThisGame && !isMoveLine) return;

    final mv =
        RegExp(r'\(\s*([BW])\s*\):\s*([A-Ta-t]\d{1,2})').firstMatch(text);
    if (mv != null) {
      final col = mv.group(1) == 'B' ? wq.Color.black : wq.Color.white;
      final parsed = parseCoordinate(mv.group(2)!);
      _moveController.add((col: col, p: parsed));
      return;
    }

    final rz =
        RegExp(r'Game\s+$id:.*:\s+(Black|White)\s+resigns').firstMatch(text);
    if (rz != null && _lastResult == null) {
      final loser = rz.group(1) == 'Black' ? wq.Color.black : wq.Color.white;
      _finalizeResult(GameResult(
        winner: loser == wq.Color.black ? wq.Color.white : wq.Color.black,
        result: 'Resign',
        description: null,
      ));
      return;
    }

    final fin = RegExp(r'The result is\s+([BW])\+([0-9.R]+)').firstMatch(text);
    if (fin != null && _lastResult == null) {
      final winner = fin.group(1) == 'B' ? wq.Color.black : wq.Color.white;
      final desc = fin.group(2)!;
      _finalizeResult(GameResult(
        winner: winner,
        result: desc,
        description: null,
      ));
      return;
    }
  }

  void _finalizeResult(GameResult r) {
    if (_lastResult != null) return;
    _lastResult = r;

    _countingResultController.add(
      CountingResult(
        winner: r.winner!,
        scoreLead: double.tryParse(r.result.replaceAll('R', '0')) ?? 0,
        ownership: List.generate(19, (_) => List<wq.Color?>.filled(19, null)),
      ),
    );

    if (!_resultCompleter.isCompleted) {
      _resultCompleter.complete(r);
    }
  }

(int, int) parseCoordinate(String coord) {
  final letter = coord[0].toUpperCase();
  final number = int.tryParse(coord.substring(1)) ?? 1;

  final col = _goLetters.indexOf(letter);
  final row = boardSize - number;

  return (row, col);
}

String formatCoordinates((int x, int y) point) {
  final col = point.$2;
  final row = boardSize - point.$1;
  final letter = _goLetters[col];
  final number = row;
  return '$letter$number';
}


  @override
  Stream<wq.Move?> moves() => _moveController.stream;

  @override
  Future<void> move(wq.Move move) async {
    final coords = formatCoordinates(move.p);
    tcp.send(coords);
    _moveController.add(move);
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
  Future<GameResult> result() async => _resultCompleter.future;

  @override
  Future<void> aiReferee() async {}

  @override
  Future<void> forceCounting() async {}

  @override
  Future<void> agreeToAutomaticCounting(bool agree) async {}

  @override
  Future<void> acceptCountingResult(bool agree) async {}

  void dispose() {
    _sub?.cancel();
    _moveController.close();
    _automaticCountingController.close();
    _countingResultController.close();
    if (!_resultCompleter.isCompleted) {
      _resultCompleter.completeError('Disposed before game finished');
    }
  }
}
