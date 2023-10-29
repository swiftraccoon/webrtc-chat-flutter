class Chat {
  final String id;
  final String name;
  final List<String> members;

  Chat({required this.id, required this.name, required this.members});

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'],
      name: json['name'],
      members: List<String>.from(json['members']),
    );
  }
}
