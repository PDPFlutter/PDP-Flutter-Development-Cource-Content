import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Lesson());
  }
}

class Lesson extends StatelessWidget {
  const Lesson({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: CustomPaint(
            size: const Size(200, 200),
            painter: SmileyPainter(),
          ),
        ),
      ),
    );
  }
}

class SmileyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Yuz
    final facePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.yellow;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2, facePaint);

    // Ko'zlar
    final eyePaint = Paint()..color = Colors.black;
    final highlightPaint = Paint()..color = Colors.white;

    // Chap ko'z
    var leftEyeCenter = Offset(size.width / 3, size.height / 3);
    canvas.drawCircle(leftEyeCenter, 15, eyePaint);
    canvas.drawCircle(leftEyeCenter.translate(5, -5), 4, highlightPaint);

    // O'ng ko'z
    var rightEyeCenter = Offset(2 * size.width / 3, size.height / 3);
    canvas.drawCircle(rightEyeCenter, 15, eyePaint);
    canvas.drawCircle(rightEyeCenter.translate(5, -5), 4, highlightPaint);

    // Tabassum
    final smilePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;
    final smilePath = Path();
    smilePath.moveTo(size.width / 4, 7 * size.height / 12);
    smilePath.quadraticBezierTo(size.width / 2, 5 * size.height / 6, 3 * size.width / 4, 7 * size.height / 12);
    canvas.drawPath(smilePath, smilePaint);
  }

  @override
  bool shouldRepaint(SmileyPainter oldDelegate) => false;
}
