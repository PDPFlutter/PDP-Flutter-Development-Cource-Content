import 'package:flutter/gestures.dart';
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
          onLongPress: () {
            debugPrint("Work onLongPress\n");
          },
          onLongPressDown: (LongPressDownDetails details) {
            debugPrint("Work onLongPressDown");
            debugPrint("Name: ${details.kind?.name}");
            debugPrint("Global Position: ${details.globalPosition}");
            debugPrint("Local Position: ${details.localPosition}\n");
          },
          onLongPressStart: (LongPressStartDetails details) {
            debugPrint("Work onLongPressStart");
            debugPrint("Global Position: ${details.globalPosition}");
            debugPrint("Local Position: ${details.localPosition}\n");
          },
          onLongPressMoveUpdate: (LongPressMoveUpdateDetails details) {
            debugPrint("Work onLongPressMoveUpdate");
            debugPrint("Global Position: ${details.globalPosition}");
            debugPrint("Local Position: ${details.localPosition}");
            debugPrint("Offset From Origin: ${details.offsetFromOrigin}");
            debugPrint("Local Offset FromOrigin: ${details.localOffsetFromOrigin}\n");
          },
          onLongPressEnd: (LongPressEndDetails details) {
            debugPrint("Work onLongPressEnd");
            debugPrint("Velocity => Pixels Per Second: ${details.velocity.pixelsPerSecond}");
            debugPrint("Global Position: ${details.globalPosition}");
            debugPrint("Local Position: ${details.localPosition}\n");
          },
          onLongPressUp: () {
            debugPrint("Work onLongPressUp");
          },
          onLongPressCancel: () {
            debugPrint("Work onLongPressCancel\n");
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
