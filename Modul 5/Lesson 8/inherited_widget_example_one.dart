import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class InheritedData extends InheritedWidget {
  final int value;

  const InheritedData({
    super.key,
    required this.value,
    required super.child,
  });

  static InheritedData of(BuildContext context) {
    final ref = context.dependOnInheritedWidgetOfExactType<InheritedData>();
    assert(ref != null, "No 'InheritedData' found above in the tree.");
    return ref!;
  }

  @override
  bool updateShouldNotify(InheritedData oldWidget) => value != oldWidget.value;
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: DataOwnerStateFull(),
        ),
      ),
    );
  }
}

class DataOwnerStateFull extends StatefulWidget {
  const DataOwnerStateFull({super.key});

  @override
  State<DataOwnerStateFull> createState() => _DataOwnerStateFullState();
}

class _DataOwnerStateFullState extends State<DataOwnerStateFull> {
  var _value = 0;

  void _increment() {
    _value += 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: _increment,
          child: const Text("Tap"),
        ),
        InheritedData(
          value: _value,
          child: const DataConsumerStateless(),
        ),
      ],
    );
  }
}

class DataConsumerStateless extends StatelessWidget {
  const DataConsumerStateless({super.key});

  @override
  Widget build(BuildContext context) {
    final value = InheritedData.of(context).value;
    return Text(
      "$value",
      style: const TextStyle(
        fontSize: 30,
      ),
    );
  }
}
