import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:logging/logging.dart';

// Connects to igs.joyjoy.net:6969 TCP server
class PandanetTcpManager {
  final _logger = Logger('PandanetTcpManager');
  Socket? _socket;
  final _incoming = StreamController<String>.broadcast();

  Stream<String> get messages => _incoming.stream;
  bool _connected = false;

  bool get isConnected => _connected;

  Future<void> connect(String username, String password) async {
    _logger.info('Connecting to igs.joyjoy.net:6969...');
    try {
      _socket = await Socket.connect('igs.joyjoy.net', 6969);
      _connected = true;
      _logger.info('Connected to server.');

      // Replace the UTF-8 decoder with custom byte handling
      _socket!.listen(
        (List<int> data) {
          // Convert bytes to string, replacing invalid UTF-8 sequences
          final String text = String.fromCharCodes(
              data.map((byte) => byte < 128 ? byte : 0xFFFD));

          for (final line in text.split('\n')) {
            _handleLine(line);
          }
        },
        onError: _onError,
        onDone: _onDone,
        cancelOnError: false,
      );

      _logger.info('Logging in as $username...');
      _socket!.writeln(username);
      await Future.delayed(const Duration(milliseconds: 300));
      _socket!.writeln(password);
    } catch (e, st) {
      _logger.severe('Connection error: $e\n$st');
      rethrow;
    }
  }

  void send(String command) {
    if (!_connected || _socket == null) {
      _logger.warning('Cannot send "$command" — not connected.');
      return;
    }
    _socket!.writeln(command);
    _logger.fine('>>> $command');
  }

  void sendWho() => send('who');
  void sendMatch(String opponent,
          {String color = 'B', int main = 60, int overtime = 5}) =>
      send('match $opponent $color 19 $main $overtime');
  void sendUnmatch(String opponent) => send('unmatch $opponent');
  void sendResign() => send('resign');
  void sendPass() => send('pass');
  void sendScore() => send('score');

  void _handleLine(String line) {
    final clean = line.replaceAll('\r', '').trim();
    if (clean.isEmpty) return;

    if (!_isNoise(clean)) {
      _incoming.add(clean);
      _logger.fine('<<< $clean');
    }
  }

  bool _isNoise(String text) {
    if (text.isEmpty) return true;
    final t = text.trim();

    if (t == '1 1' || t == '1 5' || t == '1 6') return true;

    if (t.startsWith('** ') ||
        t.startsWith('@@') ||
        t.contains('@@@@@@@@') ||
        t.contains('Copyright') ||
        t.contains('PANDANET Inc.') ||
        t.contains('Welcome to IGS') ||
        t.contains('Pbot') ||
        t.contains('IGS entry') ||
        t.contains('http://') ||
        t.contains('help ') ||
        t.contains('m( 00 )m') ||
        t.contains('Art:') ||
        t.contains('Lessons:') ||
        t.contains('glGo')) return true;

    if (t.contains('has connected') || t.contains('has disconnected'))
      return true;

    if (RegExp(r'^\d+\s+\{(Match|Game)\s+\d+:').hasMatch(t)) return true;

    if (t.startsWith('2 Game saved.') ||
        t.startsWith('51 Say') ||
        t.startsWith('19 *')) return true;

    return false;
  }

  void _onError(Object error, StackTrace st) {
    _logger.warning('Socket error: $error');
    _connected = false;
  }

  void _onDone() {
    _logger.info('Socket closed.');
    _connected = false;
  }

  void close() {
    _logger.info('Closing TCP connection.');
    _connected = false;
    _socket?.destroy();
    _incoming.close();
  }
}
