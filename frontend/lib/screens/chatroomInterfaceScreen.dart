import 'package:flutter/material.dart';
import '../services/encryptionService.dart';
import '../services/apiService.dart';

class ChatInterfaceScreen extends StatefulWidget {
  @override
  _ChatInterfaceScreenState createState() => _ChatInterfaceScreenState();
}

class _ChatInterfaceScreenState extends State<ChatInterfaceScreen> {
  final EncryptionService _encryptionService = EncryptionService();
  final TextEditingController _messageController = TextEditingController();
  List<String> messages = []; // Placeholder for messages
  RSAPublicKey otherUsersPublicKey;
  RSAPrivateKey myPrivateKey;

  void _sendMessage() async {
    final message = _messageController.text;
    final chatroomId = 'some_chatroom_id'; // Get this value from the selected chatroom
    final result = await ApiService('http://localhost:3000').sendMessage(message, chatroomId);
    // Handle message sending result
    }

  void _receiveMessage(String ciphertext) {
    final plaintext = _encryptionService.decryptMessage(ciphertext, myPrivateKey);
    // Display plaintext in the chat
    setState(() {
      messages.add(plaintext); // Placeholder
    });

    @override
    void initState() {
    super.initState();
    _joinChatroom();
    }

    void _joinChatroom() async {
    final chatroomId = 'some_chatroom_id'; // Get this value from the selected chatroom

    // Generate key pair and send public key to server
    final keyPair = _encryptionService.generateKeys();
    myPrivateKey = keyPair.privateKey as RSAPrivateKey;
    final myPublicKey = keyPair.publicKey as RSAPublicKey;
    final myPublicKeyString = _encryptionService.exportPublicKey(myPublicKey);
    await ApiService('http://localhost:3000').sendPublicKey(myPublicKeyString, chatroomId);

    // Receive other user's public key from server
    final otherUsersPublicKeyString = await ApiService('http://localhost:3000').receivePublicKey(chatroomId);
    otherUsersPublicKey = _encryptionService.importPublicKey(otherUsersPublicKeyString);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat Interface')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index]),
                );
              },
            ),
          ),
          TextField(
            controller: _messageController,
            decoration: InputDecoration(
              hintText: 'Enter your message',
            ),
          ),
          ElevatedButton(
            onPressed: _sendMessage,
            child: Text('Send'),
          ),
        ],
      ),
    );
  }
}

Widget _buildActionButtons(String role) {
  if (role == 'Global Admin' || role == 'Admin') {
    return Row(
      children: [
        ElevatedButton(onPressed: _kickUser, child: Text('Kick')),
        ElevatedButton(onPressed: _banUser, child: Text('Ban')),
        ElevatedButton(onPressed: _muteUser, child: Text('Mute')),
      ],
    );
  } else if (role == 'Moderator') {
    // Add conditional buttons based on moderator permissions
    return ElevatedButton(onPressed: _kickUser, child: Text('Kick'));
  }
  return Container();
}

void _kickUser() {
  // Implement kick logic
}

void _banUser() {
  // Implement ban logic
}

void _muteUser() {
  // Implement mute logic
}
