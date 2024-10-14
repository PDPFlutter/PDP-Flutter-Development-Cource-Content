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
            mainAxisSize: MainAxisSize.min,
            children: [
              SelectableText(
                "PDP IT Academy: Flutter Development Group",
                style: const TextStyle(
                  fontSize: 27.5,
                ),
                textWidthBasis: TextWidthBasis.longestLine,
                showCursor: true,
                autofocus: true,
                onSelectionChanged: (textSelection, selectionChangedCause) {
                  debugPrint(textSelection.toString());
                  debugPrint(selectionChangedCause.toString());
                },
              ),
              const SizedBox(height: 15,),
            ],
          ),
        ),
      ),
    );
  }
}
