// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChatAIModel {
  final String role;
  final String content;
  ChatAIModel({
    required this.role,
    required this.content,
  });

  ChatAIModel copyWith({
    String? role,
    String? content,
  }) {
    return ChatAIModel(
      role: role ?? this.role,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'role': role,
      'content': content,
    };
  }

  factory ChatAIModel.fromMap(Map<String, dynamic> map) {
    return ChatAIModel(
      role: map['role'] as String,
      content: map['content'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatAIModel.fromJson(String source) =>
      ChatAIModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ChatAIModel(role: $role, content: $content)';

  @override
  bool operator ==(covariant ChatAIModel other) {
    if (identical(this, other)) return true;

    return other.role == role && other.content == content;
  }

  @override
  int get hashCode => role.hashCode ^ content.hashCode;
}
