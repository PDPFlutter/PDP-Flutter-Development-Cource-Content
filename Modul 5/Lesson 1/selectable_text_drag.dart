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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: DragStartBehavior.values.map((dragStartBehavior) {
              return  Column(
                children: [
                  SelectableText(
                    "dragStartBehavior: DragStartBehavior.${dragStartBehavior.name}",
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 27.5,
                    ),
                    dragStartBehavior: dragStartBehavior,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 15,),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
