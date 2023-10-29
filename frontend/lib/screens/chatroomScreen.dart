import 'package:flutter/material.dart';

class ChatroomListScreen extends StatefulWidget {
  @override
  _ChatroomListScreenState createState() => _ChatroomListScreenState();
}

class _ChatroomListScreenState extends State<ChatroomListScreen> {
  List<String> chatrooms = ['Chatroom 1', 'Chatroom 2']; // Placeholder list
  bool isTyping = false; // TODO: Determine if the other user is typing

  void _createChatroom() async {
    final name = 'New Chatroom'; // Get this value from user input
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
          return Column(
            children: [
              // Date separator
              Text(
                'Date here', // TODO: Load the date of the message
              ),
              ListTile(
                leading: CircleAvatar(
                  // TODO: Load the avatar image
                ),
                title: Text(chatrooms[index]),
                subtitle: Row(
                  children: [
                    Text('Time here'), // TODO: Load the time of the message
                    Icon(Icons.check), // Read status icon
                  ],
                ),
                onTap: () => _joinChatroom(chatrooms[index]),
              ),
              // Typing indicator
              if (isTyping) // TODO: Determine if the other user is typing
                Text('User is typing...'),
            ],
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
