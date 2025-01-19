import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Post> _items = [];

  @override
  void initState() {
    super.initState();
    _fetchAll();
  }

  void _fetchAll() async {
    final response = await Network.request(api: Network.apiPost);
    if (response != null) {
      setState(() => _items = Network.parsePostList(response));
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Network problem!")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Post App")),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (_, i) => PostCard(post: _items[i]),
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text(post.id.toString()),
        ),
        title: Text(post.title.toUpperCase()),
        subtitle: Text(post.body),
      ),
    );
  }
}

enum RequestMethod { get, post, put, patch, delete }

sealed class Network {
  static const String baseUrl = "jsonplaceholder.typicode.com";
  static const apiPost = "/posts";

  static const Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8",
  };

  static Future<String?> request({
    required String api,
    String? id,
    RequestMethod method = RequestMethod.get,
    Map<String, Object?>? data,
    Map<String, String>? headers,
    Map<String, String>? queryParams,
  }) async {
    Uri url = Uri.https(baseUrl, "$api${id != null ? "/$id" : ""}", queryParams);
    final String body = jsonEncode(data);

    final Response response = await switch (method) {
      RequestMethod.get => get(url, headers: headers),
      RequestMethod.post => post(url, headers: headers, body: body),
      RequestMethod.put => put(url, headers: headers, body: body),
      RequestMethod.patch => patch(url, headers: headers, body: body),
      RequestMethod.delete => delete(url, headers: headers),
    };

    if (response.statusCode == 200 || response.statusCode == 201) {
      return utf8.decoder.convert(response.bodyBytes);
    }
    return null;
  }

  static List<Post> parsePostList(String data) {
    final json = jsonDecode(data) as List;

    /// String => json(Map, List, ...)
    return json.map((item) => Post.fromJson(item)).toList();

    /// json => object
  }

  static Post parsePost(String data) {
    final json = jsonDecode(data);
    return Post.fromJson(json);
  }
}

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
