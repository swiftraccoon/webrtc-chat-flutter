import 'package:flutter/material.dart';

class ChatroomListScreen extends StatefulWidget {
  @override
  _ChatroomListScreenState createState() => _ChatroomListScreenState();
}

class _ChatroomListScreenState extends State<ChatroomListScreen> {
  List<String> chatrooms = ['Chatroom 1', 'Chatroom 2']; // Placeholder list

  void _createChatroom() async {
    final name = 'New Chatroom'; // Get this value from user input
    final result = await ApiService('http://localhost:3000').createChatroom(name);
    // Handle chatroom creation result
    }

  void _joinChatroom(String chatroomName) {
    // Logic to join a chatroom
    print('Joining $chatroomName');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chatrooms')),
      body: ListView.builder(
        itemCount: chatrooms.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(chatrooms[index]),
            onTap: () => _joinChatroom(chatrooms[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createChatroom,
        child: Icon(Icons.add),
      ),
    );
  }
}
