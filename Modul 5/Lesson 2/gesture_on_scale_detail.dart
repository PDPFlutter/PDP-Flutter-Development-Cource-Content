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
          onScaleStart: (ScaleStartDetails details) {
            debugPrint("Work onScaleStart");
            debugPrint("Source Time Stamp: ${details.sourceTimeStamp}");
            debugPrint("Focal Point: ${details.focalPoint}");
            debugPrint("Local Focal Point: ${details.localFocalPoint}");
            debugPrint("Pointer Count: ${details.pointerCount}\n");
          },
          onScaleUpdate: (ScaleUpdateDetails details) {
            debugPrint("Work onScaleUpdate");
            debugPrint("Source Time Stamp: ${details.sourceTimeStamp}");
            debugPrint("Pointer Count: ${details.pointerCount}");
            debugPrint("Focal Point: ${details.focalPoint}");
            debugPrint("Local Focal Point: ${details.localFocalPoint}");
            debugPrint("Focal Point Delta: ${details.focalPointDelta}");
            debugPrint("Horizontal Scale: ${details.horizontalScale}");
            debugPrint("Vertical Scale: ${details.verticalScale}");
            debugPrint("Scale: ${details.scale}");
            debugPrint("Rotation: ${details.rotation}\n");
          },
          onScaleEnd: (ScaleEndDetails details) {
            debugPrint("Work onScaleEnd");
            debugPrint("Velocity => Pixels Per Second: ${details.velocity.pixelsPerSecond}");
            debugPrint("Scale Velocity: ${details.scaleVelocity}");
            debugPrint("Pointer Count: ${details.pointerCount}\n");
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
