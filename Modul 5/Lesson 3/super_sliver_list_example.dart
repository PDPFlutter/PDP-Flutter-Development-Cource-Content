import 'package:flutter/material.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _listController = ListController();
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Package: super_sliver_list"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CardButton(onTap: () => animateToItem(299), title: "Section 1"),
              CardButton(onTap: () => animateToItem(599), title: "Section 2"),
              CardButton(onTap: () => animateToItem(899), title: "Section 3"),
            ],
          ),
          const SizedBox(height: 10),
          Flexible(
            child: SuperListView.builder(
              itemCount: 900,
              listController: _listController,
              controller: _scrollController,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Icon(switch (index ~/ 300) {
                      0 => Icons.looks_one_rounded,
                      1 => Icons.looks_two_rounded,
                      _ => Icons.looks_3_rounded,
                    }),
                  ),
                  title: Text('Item ${index + 1}'),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          jumpToItem(0);
        },
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }

  void jumpToItem(int index) {
    _listController.jumpToItem(
      index: index,
      scrollController: _scrollController,
      alignment: 0,
    );
  }

  void animateToItem(int index) {
    _listController.animateToItem(
      index: index,
      scrollController: _scrollController,
      alignment: 0,
      duration: (estimatedDistance) => const Duration(seconds: 1),
      curve: (estimatedDistance) => Curves.easeInOut,
    );
  }
}

class CardButton extends StatelessWidget {
  final void Function()? onTap;
  final String title;

  const CardButton({
    required this.onTap,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(title),
        ),
      ),
    );
  }
}
