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

  Future<void> insertContact(Contact contact) async {
    await database.insert(
      'contacts',
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Contact>> contacts() async {
    final List<Map<String, Object?>> contactMaps = await database.query('contacts');

    return [
      for (final {'id': id as int, 'name': name as String, 'phone': phone as String} in contactMaps)
        Contact(id: id, name: name, phone: phone),
    ];
  }

  Future<void> updateContact(Contact contact) async {
    await database.update(
      'contacts',
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

  Future<void> deleteContact(int id) async {
    await database.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () async {
                print(await contacts());
              },
              child: const Text("Read"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                const pdp = Contact(id: 0, name: 'PDP', phone: '+998 (78) 777 47 47');
                await insertContact(pdp);
              },
              child: const Text("Create"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                const pdp = Contact(id: 0, name: 'PDP Academy', phone: '+998 (78) 777 47 47');
                await updateContact(pdp);
              },
              child: const Text("Update"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                await deleteContact(0);
              },
              child: const Text("Delete"),
            ),
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
