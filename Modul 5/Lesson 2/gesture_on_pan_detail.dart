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
          onPanDown: (DragDownDetails details) {
            debugPrint("Work onPanDown");
            debugPrint("Global Position: ${details.globalPosition}");
            debugPrint("Local Position: ${details.localPosition}\n");
          },
          onPanStart: (DragStartDetails details) {
            debugPrint("Work onPanStart");
            debugPrint("Name: ${details.kind?.name}");
            debugPrint("Source Time Stamp: ${details.sourceTimeStamp}");
            debugPrint("Global Position: ${details.globalPosition}");
            debugPrint("Local Position: ${details.localPosition}\n");
          },
          onPanUpdate: (DragUpdateDetails details) {
            debugPrint("Work onPanUpdate");
            debugPrint("Global Position: ${details.globalPosition}");
            debugPrint("Local Position: ${details.localPosition}");
            debugPrint("Source Time Stamp: ${details.sourceTimeStamp}");
            debugPrint("Primary Delta: ${details.primaryDelta}");
            debugPrint("Delta: ${details.delta}\n");
          },
          onPanEnd: (DragEndDetails details) {
            debugPrint("Work onPanEnd");
            debugPrint("Velocity => Pixels Per Second: ${details.velocity.pixelsPerSecond}");
            debugPrint("Primary Velocity: ${details.primaryVelocity}");
            debugPrint("Global Position: ${details.globalPosition}");
            debugPrint("Local Position: ${details.localPosition}\n");
          },
          onPanCancel: () {
            debugPrint("Work onPanCancel\n");
          },
          child: Container(
            height: 250,
            width: 250,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
