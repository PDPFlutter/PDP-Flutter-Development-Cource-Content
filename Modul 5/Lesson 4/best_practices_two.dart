import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter PDP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        brightness: Brightness.dark,
      ),
      home: const ArcWidget(),
    );
  }
}

class ArcWidget extends StatefulWidget {
  const ArcWidget({super.key});

  @override
  State<ArcWidget> createState() => _ArcWidgetState();
}

class _ArcWidgetState extends State<ArcWidget> {
  final double width = 200;
  final double height = 200;
  double baseAngle = 0;
  Offset? lastPosition;
  double lastBaseAngle = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: ArcPainter(100, baseAngle),
      ),
    );
  }
}

Paint createPaintForColor(Color color) {
  return Paint()
    ..color = color
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke
    ..strokeWidth = 15;
}

class ArcPainter extends CustomPainter {
  final double radius;
  double baseAngle;
  final Paint red = createPaintForColor(Colors.red);
  final Paint blue = createPaintForColor(Colors.blue);
  final Paint green = createPaintForColor(Colors.green);

  ArcPainter(this.radius, this.baseAngle);



  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: radius);
    canvas.drawArc(rect, baseAngle, sweepAngle(), false, blue);
    canvas.drawArc(rect, baseAngle + 2 / 3 * math.pi, sweepAngle(), false, red);
    canvas.drawArc(rect, baseAngle + 4 / 3 * math.pi, sweepAngle(), false, green);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  double sweepAngle() => 0.8 * 2 / 3 * math.pi;
}
