import 'dart:math';
import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

class Bar {
  Bar(this.height, this.color);

  factory Bar.empty() => Bar(0.0, Colors.transparent);
  factory Bar.random(Random random) {
    return Bar(
      random.nextDouble() * 100.0,
      ColorPalette.primary.random(random),
    );
  }

  final Color color;
  final double height;

  static Bar lerp(Bar begin, Bar end, double t) {
    return Bar(lerpDouble(begin.height, end.height, t)!, Color.lerp(begin.color, end.color, t)!);
  }
}

class BarTween extends Tween<Bar> {
  BarTween(Bar begin, Bar end) : super(begin: begin, end: end);

  @override
  Bar lerp(double t) => Bar.lerp(begin!, end!, t);
}

class BarChartPainter extends CustomPainter {
  static const barWidth = 10.0;

  BarChartPainter(this.animation)
      : super(repaint: animation);

  final Animation<Bar> animation;

  @override
  void paint(Canvas canvas, Size size) {
    final bar = animation.value;
    final paint = Paint()
      ..color = bar.color
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTWH(
        (size.width - barWidth) / 2.0,
        size.height - bar.height,
        barWidth,
        bar.height,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(BarChartPainter old) => false;
}

class ColorPalette {
  static final ColorPalette primary = ColorPalette(<Color>[
    Colors.blue[400]!,
    Colors.red[400]!,
    Colors.green[400]!,
    Colors.yellow[400]!,
    Colors.purple[400]!,
    Colors.orange[400]!,
    Colors.teal[400]!,
  ]);
  ColorPalette(List<Color> colors) : _colors = colors {
    assert(colors.isNotEmpty);
  }
  final List<Color> _colors;
  Color operator [](int index) => _colors[index % length];
  int get length => _colors.length;
  Color random(Random random) => this[random.nextInt(length)];
}


void main() {
  runApp(const MaterialApp(home: ChartPage()));
}

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  ChartPageState createState() => ChartPageState();
}

class ChartPageState extends State<ChartPage> with TickerProviderStateMixin {
  final random = Random();
  late AnimationController animation;
  late BarTween tween;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    tween =  tween = BarTween(Bar.empty(), Bar.random(random));
    animation.forward();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  void changeData() {
    setState(() {
      tween = BarTween(tween.evaluate(animation), Bar.random(random));
      animation.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomPaint(
          size: const Size(200, 100.0),
          painter: BarChartPainter(tween.animate(animation)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: changeData,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
