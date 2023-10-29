import 'package:flutter/material.dart';
import 'screens/loginScreen.dart';
import 'screens/chatroomScreen.dart';
import 'screens/chatroomInterfaceScreen.dart';

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
