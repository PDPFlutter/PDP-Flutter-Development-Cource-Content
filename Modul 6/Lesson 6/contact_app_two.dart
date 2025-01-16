import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final Database database;
  @override
  void initState() {
    super.initState();
    initDB();
  }

  void initDB() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'contact_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE contacts(id INTEGER PRIMARY KEY, name TEXT, phone TEXT)',
        );
      },
      version: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(onPressed: () {}, child: const Text("Read")),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: () {}, child: const Text("Create")),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: () {}, child: const Text("Update")),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: () {}, child: const Text("Delete")),
          ],
        ),
      ),
    );
  }
}

class Contact {
  final int id;
  final String name;
  final String phone;

  const Contact({
    required this.id,
    required this.name,
    required this.phone,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
    };
  }

  @override
  String toString() {
    return 'Contact{id: $id, name: $name, phone: $phone}';
  }
}
