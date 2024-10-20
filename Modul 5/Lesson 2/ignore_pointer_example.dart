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
  bool ignoring = false;
  void setIgnoring(bool newValue) {
    setState(() {
      ignoring = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ignore Pointer")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('Ignoring: $ignoring'),
            IgnorePointer(
              ignoring: ignoring,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(24.0),
                ),
                onPressed: () {},
                child: const Text('Click me!'),
              ),
            ),
            FilledButton(
              onPressed: () {
                setIgnoring(!ignoring);
              },
              child: Text(
                ignoring ? 'Set ignoring to false' : 'Set ignoring to true',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
