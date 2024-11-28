import 'dart:math';
import 'package:flutter/material.dart';

class UniqueColorGenerator {
  static List colorOptions = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.indigo,
    Colors.amber,
    Colors.black,
  ];
  static Random random = Random();

  static Color getColor() {
    if (colorOptions.isNotEmpty) {
      return colorOptions.removeAt(random.nextInt(colorOptions.length));
    } else {
      return Color.fromARGB(random.nextInt(256), random.nextInt(256), random.nextInt(256), random.nextInt(256));
    }
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: PositionedTiles());
  }
}

class PositionedTiles extends StatefulWidget {
  const PositionedTiles({super.key});

  @override
  State<StatefulWidget> createState() => PositionedTilesState();
}

class PositionedTilesState extends State<PositionedTiles> {
  List<Widget> tiles = [
    StatelessColorfulTile(),
    StatelessColorfulTile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Row(mainAxisSize: MainAxisSize.min, children: tiles)),
      floatingActionButton: FloatingActionButton(
        onPressed: swapTiles,
        backgroundColor: Colors.white,
        child: const Icon(Icons.sentiment_very_satisfied),
      ),
    );
  }

  void swapTiles() {
    setState(() {
      tiles.insert(1, tiles.removeAt(0));
    });
  }
}

class StatelessColorfulTile extends StatelessWidget {
  final Color myColor = UniqueColorGenerator.getColor();

  StatelessColorfulTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: myColor,
      child: const Padding(
        padding: EdgeInsets.all(70.0),
      ),
    );
  }
}
