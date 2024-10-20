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
          onTap: () {
            debugPrint("Work onTap\n");
          },
          onTapCancel: () {
            debugPrint("Work onTapCancel\n");
          },
          onTapDown: (TapDownDetails details) {
            debugPrint("Work onTapDown");
            debugPrint("Name: ${details.kind?.name}");
            debugPrint("Global Position: ${details.globalPosition}");
            debugPrint("Local Position: ${details.localPosition}\n");

          },
          onTapUp: (TapUpDetails details) {
            debugPrint("Work onTapUp");
            debugPrint("Name: ${details.kind.name}");
            debugPrint("Global Position: ${details.globalPosition}");
            debugPrint("Local Position: ${details.localPosition}\n");
          },
          // The custom button
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
