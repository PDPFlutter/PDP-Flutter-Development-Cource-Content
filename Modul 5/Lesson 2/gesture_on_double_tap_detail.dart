import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onDoubleTap: () {
            debugPrint("Work onDoubleTap\n");
          },
          onDoubleTapCancel: () {
            debugPrint("Work onDoubleTapCancel\n");
          },
          onDoubleTapDown: (TapDownDetails details) {
            debugPrint("Work onDoubleTapDown");
            debugPrint("Name: ${details.kind?.name}");
            debugPrint("Global Position: ${details.globalPosition}");
            debugPrint("Local Position: ${details.localPosition}\n");

          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text('My Button', style: TextStyle(color: Colors.white),),
          ),
        ),
      ),
    );
  }
}
