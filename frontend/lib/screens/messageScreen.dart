import 'package:flutter/material.dart';
import '../services/encryptionService.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final EncryptionService _encryptionService = EncryptionService();
  final TextEditingController _messageController = TextEditingController();
  RSAPublicKey otherUsersPublicKey;
  RSAPrivateKey myPrivateKey;

  void sendMessage() {
    final plaintext = _messageController.text;
    final ciphertext = _encryptionService.encryptMessage(plaintext, otherUsersPublicKey);
    // Send ciphertext to the server
  }

  void receiveMessage(String ciphertext) {
    final plaintext = _encryptionService.decryptMessage(ciphertext, myPrivateKey);
    // Display plaintext in the chat
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chatroom')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              // Messages go here
            ),
          ),
          TextField(
            controller: _messageController,
            decoration: InputDecoration(
              hintText: 'Enter your message',
            ),
          ),
          ElevatedButton(
            onPressed: sendMessage,
            child: Text('Send'),
          ),
        ],
      ),
    );
  }
}
