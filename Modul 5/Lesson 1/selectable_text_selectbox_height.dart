import 'dart:ui';
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
            children: BoxHeightStyle.values.map((boxHeightStyle) {
              return  Column(
                children: [
                  SelectableText(
                    "$boxHeightStyle",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      height: 2.5,
                      fontWeight: FontWeight.bold,
                      fontSize: 27.5,
                    ),
                    selectionHeightStyle: boxHeightStyle,
                  ),
                  const SizedBox(height: 5,),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
