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
  int acceptedData = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Draggable")),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Draggable<int>(
              data: 10,
              feedback: Container(
                color: Colors.deepOrange,
                height: 100,
                width: 100,
                child: const Icon(Icons.directions_run),
              ),
              childWhenDragging: Container(
                height: 100.0,
                width: 100.0,
                color: Colors.pinkAccent,
                child: const Center(
                  child: Text('Child When Dragging'),
                ),
              ),
              child: Container(
                height: 100.0,
                width: 100.0,
                color: Colors.lightGreenAccent,
                child: const Center(
                  child: Text('Draggable'),
                ),
              ),
            ),
            DragTarget<int>(
              builder: (BuildContext context, List<int?> accepted, List<dynamic> rejected) {
                return Container(
                  height: 100.0,
                  width: 100.0,
                  color: Colors.cyan,
                  child: Center(
                    child: Text('Value is updated to: $acceptedData'),
                  ),
                );
              },
              onAcceptWithDetails: (DragTargetDetails<int> details) {
                setState(() {
                  acceptedData += details.data;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
