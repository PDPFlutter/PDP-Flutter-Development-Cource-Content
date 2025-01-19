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

  void _deletePost(int id) async {
    final response = await Network.request(
      method: RequestMethod.delete,
      api: Network.apiPost,
      id: "$id",
    );

    if (response != null) {
      _items.removeWhere((item) => item.id == id);
      setState(() {});
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Network problem!")),
        );
      }
    }
  }

  void _postDialog({Post? post}) async {
    final titleController = TextEditingController(text: post?.title);
    final bodyController = TextEditingController(text: post?.body);

    void save(BuildContext context) {
      final title = titleController.text;
      final body = bodyController.text;

      if (title.isEmpty || body.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Inputs must not be empty!")),
        );
        return;
      }

      final content = Post(
        userId: post?.userId ?? 1,
        id: post?.id ?? (_items.length + 1),
        title: title,
        body: body,
      );

      Navigator.pop<Post>(context, content);
    }

    final Post? item = await showDialog<Post>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(post != null ? "Edit" : "Create"),
          actions: [
            ElevatedButton(
              onPressed: () => save(context),
              child: const Text("Save"),
            )
          ],
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: "Title"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: bodyController,
                decoration: const InputDecoration(hintText: "Body"),
              ),
            ],
          ),
        );
      },
    );

    if (item != null) _execute(item, post);
  }

  void _execute(Post item, Post? post) async {
    final response = await Network.request(
      method: post != null ? RequestMethod.put : RequestMethod.post,
      api: Network.apiPost,
      id: post?.id.toString(),
      data: item.toJson(),
    );

    if (response != null) {
      if (post != null) {
        final index = _items.indexWhere((element) => element.id == item.id);
        _items[index] = item;
      } else {
        // or _fetchAll();
        _items.add(item);
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Post App")),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (_, i) => Dismissible(
          key: ValueKey<int>(_items[i].id),
          onDismissed: (_) => _deletePost(_items[i].id),
          background: const Icon(Icons.delete),
          child: PostCard(
            post: _items[i],
            onEdit: (post) => _postDialog(post: post),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _postDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final Post post;
  final void Function(Post) onEdit;

  const PostCard({required this.post, required this.onEdit, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text(post.id.toString()),
        ),
        title: Text(post.title.toUpperCase()),
        subtitle: Text(post.body),
        trailing: IconButton(
          onPressed: () => onEdit(post),
          icon: const Icon(Icons.edit),
        ),
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
    return json.map((item) => Post.fromJson(item)).toList();
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
