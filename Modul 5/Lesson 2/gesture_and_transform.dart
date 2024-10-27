import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TaskPractice(),
    );
  }
}

class TaskPractice extends StatefulWidget {
  const TaskPractice({super.key});

  @override
  State<TaskPractice> createState() => _TaskPracticeState();
}

class _TaskPracticeState extends State<TaskPractice> {
  double _scale = 1.0;
  double _previousScale = 1.0;
  double _rotation = 0.0;
  double _previousRotation = 0.0;

  void _onScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      // Kattalashtirish va kichraytirish
      _scale = _previousScale * details.scale;

      // Aylantirish
      _rotation = _previousRotation + details.rotation;
    });
  }

  void _onScaleEnd(ScaleEndDetails details) {
    setState(() {
      // Kattalashtirishni saqlash
      _previousScale = _scale;

      // Yaqin burchakda to'xtash
      double quarterTurns = (_rotation / (pi / 2)).roundToDouble();
      _rotation = quarterTurns * (pi / 2);
      _previousRotation = _rotation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Transform and Gesture")),
      body: Center(
        child: GestureDetector(
          onScaleUpdate: _onScaleUpdate,
          onScaleEnd: _onScaleEnd,
          child: Transform(
            transform: Matrix4.identity()
              ..scale(_scale)
              ..rotateZ(_rotation),
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/img.png',
              width: 200,
              height: 200,
            ),
          ),
        ),
      ),
    );
  }
}
