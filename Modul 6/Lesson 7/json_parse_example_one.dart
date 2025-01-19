import 'dart:convert';

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  // Constructor
  const Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  // Factory method to create a Post object from JSON
  factory Post.fromJson(Map<String, Object?> json) {
    return Post(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  // Method to convert a Post object to JSON
  Map<String, Object?> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }
}

void main() {
  // Example JSON string
  String jsonString = '{"userId": 1, "id": 1, "title": "Hello World!", "body": "Hello PDP IT Academy!!!"}';

  // Parse JSON string to Map
  Map<String, Object?> jsonMap = json.decode(jsonString);

  // Create Post object from JSON
  Post post = Post.fromJson(jsonMap);

  // Print Post object details
  print('UserId: \${post.userId}, Id: \${post.id}, Title: \${post.title}, Body: \${post.body}');

  // Convert Post object back to JSON
  String encodedJson = json.encode(post.toJson());
  print('Encoded JSON: \$encodedJson');
}
