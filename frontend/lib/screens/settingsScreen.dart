import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Username'),
            subtitle: Text('Current username'), // TODO: Load the current username
            onTap: () {
              // TODO: Navigate to change username screen
            },
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Email'),
            subtitle: Text('Current email'), // TODO: Load the current email
            onTap: () {
              // TODO: Navigate to change email screen
            },
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Password'),
            onTap: () {
              // TODO: Navigate to change password screen
            },
          ),
          ListTile(
            leading: Icon(Icons.vpn_key),
            title: Text('Encryption Keys'),
            onTap: () {
              // TODO: Navigate to manage encryption keys screen
            },
          ),
        ],
      ),
    );
  }
}
