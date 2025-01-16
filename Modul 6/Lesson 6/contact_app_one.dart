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

  @override
  void initState() {
    super.initState();
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
