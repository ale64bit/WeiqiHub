import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:logging/logging.dart';

class ReconnectingSocket {
  final Logger _log;
  final String id;
  final dynamic address;
  final int port;
  final Function(Uint8List) onData;
  final Function() onConnected;
  final Function() onDisconnected;
  final Duration reconnectionDelay;

  Socket? _socket;
  StreamSubscription<List<int>>? _subscription;
  bool _isReconnecting = false;
  bool _isDisposed = false;

  ReconnectingSocket({
    required this.id,
    required this.address,
    required this.port,
    required this.onData,
    required this.onConnected,
    required this.onDisconnected,
    this.reconnectionDelay = const Duration(seconds: 5),
  }) : _log = Logger(id) {
    _connect();
  }

  void dispose() {
    _isDisposed = true;
    try {
      _subscription?.cancel();
      _socket?.destroy();
      _socket = null;
    } catch (err) {
      _log.severe('dispose: $err');
    }
  }

  void send(Uint8List data) {
    if (_socket != null) {
      try {
        _socket!.add(data);
      } catch (e) {
        _log.severe('send: exception: $e');
      }
    } else {
      _log.severe('send: null socket');
    }
  }

  void _connect() async {
    if (_isDisposed) return;
    if (_isReconnecting) return;
    _isReconnecting = true;

    try {
      _socket = await Socket.connect(address, port);
      _socket!.setOption(SocketOption.tcpNoDelay, true);
      onConnected();
      _subscription = _socket!.listen(
        onData,
        onError: (err) {
          _log.severe('listen: $err');
          _reconnect();
        },
        onDone: () {
          _log.fine('listen: done');
          _reconnect();
        },
        cancelOnError: false,
      );
    } catch (e) {
      _log.severe('_connect: exception: $e');
      _reconnect();
    } finally {
      _isReconnecting = false;
    }
  }

  void _reconnect() {
    if (_isDisposed) return;
    try {
      _subscription?.cancel();
      _socket?.destroy();
    } catch (err) {
      _log.severe('_reconnect: $err');
    }

    onDisconnected();
    Future.delayed(reconnectionDelay, _connect);
  }
}
