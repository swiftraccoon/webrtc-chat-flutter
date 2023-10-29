import 'package:flutter/material.dart';
import 'auth_screen.dart';
import 'chatroom_list_screen.dart';
import 'chat_interface_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      initialRoute: '/',
      routes: {
        '/': (context) => AuthScreen(),
        '/chatrooms': (context) => ChatroomListScreen(),
        '/chatinterface': (context) => ChatInterfaceScreen(),
      },
    );
  }
}
