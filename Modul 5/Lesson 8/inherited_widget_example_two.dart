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

class DataProviderInherit extends InheritedWidget {
  final int value;

  const DataProviderInherit({
    super.key,
    required this.value,
    required super.child,
  });

  @override
  bool updateShouldNotify(DataProviderInherit oldWidget) => value != oldWidget.value;
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
        DataProviderInherit(
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
    //! first method
    final value = context.dependOnInheritedWidgetOfExactType<DataProviderInherit>()?.value ?? 0;
    return Column(
      children: [
        Text(
          "$value",
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
        const DataConsumerStateFull(),
      ],
    );
  }
}

class DataConsumerStateFull extends StatefulWidget {
  const DataConsumerStateFull({super.key});

  @override
  State<DataConsumerStateFull> createState() => _DataConsumerStateFullState();
}

class _DataConsumerStateFullState extends State<DataConsumerStateFull> {
  @override
  Widget build(BuildContext context) {
    //! second method
    final element = context.getElementForInheritedWidgetOfExactType<DataProviderInherit>();
    if (element != null) {
      context.dependOnInheritedElement(element);
    }
    final dataProvider = element?.widget as DataProviderInherit;
    final value = dataProvider.value;

    return Text(
      "$value",
      style: const TextStyle(
        fontSize: 30,
      ),
    );
  }
}
