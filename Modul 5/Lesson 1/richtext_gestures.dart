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
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 24),
              children: [
                TextSpan(
                  text: 'Single tap',
                  style: TextStyle(color: Colors.red[300]),
                  recognizer: TapGestureRecognizer()..onTap = () {
                    debugPrint("Single tapped.");
                  },
                ),
                TextSpan(
                    text: ' Double tap',
                    style: TextStyle(color: Colors.green[300]),
                    recognizer:  DoubleTapGestureRecognizer()..onDoubleTap = () {
                      debugPrint("Double tapped.");
                    }
                ),
                TextSpan(
                  text: ' Long press',
                  style: TextStyle(color: Colors.blue[300]),
                  recognizer: LongPressGestureRecognizer()..onLongPress = () {
                    debugPrint("Long Pressed.");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
