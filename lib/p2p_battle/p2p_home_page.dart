import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wqhub/p2p_battle/p2p_client.dart';
import 'package:wqhub/p2p_battle/p2p_lobby_page.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';

class P2PHomePage extends StatefulWidget {
  static const routeName = '/p2p/home';

  const P2PHomePage({super.key});

  @override
  State<P2PHomePage> createState() => _P2PHomePageState();
}

class _P2PHomePageState extends State<P2PHomePage> {
  final _roomIdController = TextEditingController();
  final _nameController = TextEditingController();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadName();
  }

  void _loadName() async {
    final prefs = await SharedPreferences.getInstance();
    _nameController.text = prefs.getString('p2p_player_name') ?? '';
  }

  void _saveName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('p2p_player_name', _nameController.text);
  }

  @override
  Widget build(BuildContext context) {
    final serverUrl = context.settings.p2pServerUrl;

    return Scaffold(
      appBar: AppBar(
        title: Text('P2P Tsumego Battle'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              spacing: 16.0,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Your Name',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) => _saveName(),
                ),
                Divider(),
                if (serverUrl.isEmpty)
                  Text(
                    'Please configure P2P Server URL in Settings first.',
                    style: TextStyle(color: Colors.red),
                  )
                else ...[
                  ElevatedButton(
                    onPressed: _loading ? null : () => _createRoom(serverUrl),
                    child: _loading
                        ? CircularProgressIndicator()
                        : Text('Create New Room'),
                  ),
                  Row(
                    spacing: 8.0,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _roomIdController,
                          decoration: InputDecoration(
                            labelText: 'Room ID',
                            border: OutlineInputBorder(),
                          ),
                          textCapitalization: TextCapitalization.characters,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _loading ? null : () => _joinRoom(serverUrl),
                        child: Text('Join'),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _createRoom(String serverUrl) async {
    if (_nameController.text.isEmpty) {
      _showError('Please enter your name');
      return;
    }
    setState(() => _loading = true);
    try {
      final roomId = await P2PClient.createRoom(serverUrl);
      if (mounted) {
        Navigator.pushNamed(
          context,
          P2PLobbyPage.routeName,
          arguments: P2PLobbyArguments(
            roomId: roomId,
            playerName: _nameController.text,
            serverUrl: serverUrl,
          ),
        );
      }
    } catch (e) {
      _showError('Failed to create room: $e');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _joinRoom(String serverUrl) {
    if (_nameController.text.isEmpty) {
      _showError('Please enter your name');
      return;
    }
    final roomId = _roomIdController.text.trim().toUpperCase();
    if (roomId.length != 6) {
      _showError('Invalid Room ID');
      return;
    }
    Navigator.pushNamed(
      context,
      P2PLobbyPage.routeName,
      arguments: P2PLobbyArguments(
        roomId: roomId,
        playerName: _nameController.text,
        serverUrl: serverUrl,
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
