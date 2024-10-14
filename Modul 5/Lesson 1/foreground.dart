import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "LinearGradient",
                style: TextStyle(
                  fontSize: 40,
                  foreground: Paint()
                    ..shader = const LinearGradient(
                      colors: <Color>[
                        Colors.red,
                        Colors.yellow,
                      ],
                    ).createShader(
                      const Rect.fromLTWH(0.0, 0.0, 400.0, 30.0),
                    ),
                ),
              ),

              const SizedBox(
                height: 50,
              ),

              Text(
                'Greetings, planet!',
                style: TextStyle(
                  fontSize: 40,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 3
                    ..color = Colors.blue[700]!,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
