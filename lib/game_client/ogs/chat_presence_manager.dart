import 'dart:async';

import 'package:logging/logging.dart';
import 'package:wqhub/game_client/ogs/ogs_websocket_manager.dart';

/// Manages chat presence tracking for a specific channel.
///
/// The ChatPresenceManager serves two main roles:
///
/// 1. Join and leave the chat channel
///     - This is necessary for OGS to track online status of players in games
///      which it uses to allow or disallow participation in scoring.
/// 2. Track users joining and leaving the channel
class ChatPresenceManager {
  final Logger _logger = Logger('ChatPresenceManager');
  final String channel;
  final OGSWebSocketManager _webSocketManager;
  final Set<String> _presentUsers = {};
  final StreamController<Set<String>> _presenceController =
      StreamController<Set<String>>.broadcast();
  StreamSubscription<Map<String, dynamic>>? _messageSubscription;

  ChatPresenceManager({
    required this.channel,
    required OGSWebSocketManager webSocketManager,
  }) : _webSocketManager = webSocketManager {
    _messageSubscription = _webSocketManager.messages.listen(_handleMessage);
    _webSocketManager.send('chat/join', {'channel': channel});
    _logger
        .fine('ChatPresenceManager initialized and joined channel: $channel');
  }

  /// Returns true if the user with the given ID is currently present in the chat.
  bool isPresent(String userId) {
    return _presentUsers.contains(userId);
  }

  /// Stream of presence updates.
  ///
  /// Emits the current set of present user IDs whenever the presence changes.
  Stream<Set<String>> get presenceUpdates => _presenceController.stream;

  void _handleMessage(Map<String, dynamic> message) {
    final event = message['event'] as String;
    final data = message['data'] as Map<String, dynamic>;

    final messageChannel = data['channel'] as String?;
    if (messageChannel != channel) {
      return;
    }

    switch (event) {
      case 'chat-join':
        _handleChatJoin(data);
      case 'chat-part':
        _handleChatPart(data);
    }
  }

  void _handleChatJoin(Map<String, dynamic> data) {
    final users = data['users'] as List<dynamic>;

    var changed = false;
    for (final user in users) {
      if (user is Map<String, dynamic>) {
        final userId = user['id'].toString();
        if (_presentUsers.add(userId)) {
          changed = true;
          _logger.fine('User $userId joined channel $channel');
        }
      }
    }

    if (changed) {
      _presenceController.add(Set.unmodifiable(_presentUsers));
    }
  }

  void _handleChatPart(Map<String, dynamic> data) {
    final user = data['user'] as Map<String, dynamic>?;
    if (user == null) {
      return;
    }

    final userId = user['id'].toString();
    if (_presentUsers.remove(userId)) {
      _logger.fine('User $userId left channel $channel');
      _presenceController.add(Set.unmodifiable(_presentUsers));
    }
  }

  /// Cleans up resources and stops listening to messages.
  void dispose() {
    _messageSubscription?.cancel();
    _webSocketManager.send('chat/part', {'channel': channel});
    _presenceController.close();
    _presentUsers.clear();
    _logger.fine('ChatPresenceManager disposed and left channel: $channel');
  }
}
