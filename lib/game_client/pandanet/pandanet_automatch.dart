import 'dart:async';
import 'package:logging/logging.dart';
import 'pandanet_tcp_manager.dart';

class PandanetMatchMaker {
  final PandanetTcpManager tcp;
  final String myRank;
  final Logger _logger = Logger('PandanetMatchMaker');

  final int range;
  final Duration refreshInterval;

  final Set<String> _pendingMatches = {};
  Timer? _loop;

  PandanetMatchMaker(
    this.tcp,
    this.myRank, {
    this.range = 2,
    this.refreshInterval = const Duration(seconds: 10),
  });

  void start() {
    _logger.info('Starting Pandanet matchmaker (my rank: $myRank)...');
    _loop = Timer.periodic(refreshInterval, (_) => _requestWho());
    tcp.messages.listen(_onMessage);
    _requestWho();
  }

  void stop() {
    _logger.info('Stopping Pandanet matchmaker.');
    _loop?.cancel();
    _pendingMatches.clear();
  }

  void _requestWho() {
    _logger.fine('Requesting player list via "who".');
    tcp.send('who');
  }

  void _onMessage(String line) {
    final text = line.trim();

    final accept =
        RegExp(r'Match\s*\[\d+\].*with\s+(\w+).*accepted', caseSensitive: false)
            .firstMatch(text);
    if (accept != null) {
      final opponent = accept.group(1)!;
      _logger.info('Matched successfully with $opponent.');
      _cancelOtherRequests(except: opponent);
      return;
    }

    if (text.contains('Players') && text.contains('********')) {
      return;
    }

    final match =
        RegExp(r'([A-Za-z0-9_]+)\s+(\d+[dk])', caseSensitive: false).firstMatch(text);
    if (match != null) {
      final name = match.group(1)!;
      final rank = match.group(2)!;

      if (_isEligible(rank)) {
        if (!_pendingMatches.contains(name)) {
          _pendingMatches.add(name);
          tcp.send('match $name B 19 60 5');
          _logger.fine('Sent match request to $name ($rank).');
        }
      }
    }
  }

  bool _isEligible(String rank) {
    final myVal = _rankToNumber(myRank);
    final otherVal = _rankToNumber(rank);
    return (otherVal - myVal).abs() <= range;
  }

  void _cancelOtherRequests({required String except}) {
    for (final name in _pendingMatches) {
      if (name != except) {
        tcp.send('unmatch $name');
        _logger.fine('Cancelled pending match with $name.');
      }
    }
    _pendingMatches.clear();
  }

  int _rankToNumber(String rank) {
    final match = RegExp(r'(\d+)([dk])', caseSensitive: false).firstMatch(rank);
    if (match == null) return 0;
    final n = int.parse(match.group(1)!);
    final suffix = match.group(2)!.toLowerCase();
    return suffix == 'd' ? 30 + n : 30 - n;
  }
}
