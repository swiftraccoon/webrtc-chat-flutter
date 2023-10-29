import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> createChatroom(String name) async {
    final response = await http.post(
      Uri.parse('$baseUrl/createChatroom'),
      body: jsonEncode({'name': name}),
      headers: {'Content-Type': 'application/json'},
    );
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> sendMessage(String message, String chatroomId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/sendMessage'),
      body: jsonEncode({'message': message, 'chatroomId': chatroomId}),
      headers: {'Content-Type': 'application/json'},
    );
    return jsonDecode(response.body);
  }

  Future<void> sendPublicKey(String publicKey, String chatroomId) async {
    await http.post(
        Uri.parse('$baseUrl/sendPublicKey'),
        body: jsonEncode({'publicKey': publicKey, 'chatroomId': chatroomId}),
        headers: {'Content-Type': 'application/json'},
    );
  }

    Future<String> receivePublicKey(String chatroomId) async {
    final response = await http.get(
        Uri.parse('$baseUrl/receivePublicKey?chatroomId=$chatroomId'),
    );
    final Map<String, dynamic> data = jsonDecode(response.body);
    return data['publicKey'];
  }

}
