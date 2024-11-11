import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Home());
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center;
  Alignment alignment = Alignment.center;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/jellyfish.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 75,
            right: 20,
            left: 20,
            child: Container(
              height: 225,
              decoration: const BoxDecoration(color: Colors.white70, borderRadius: BorderRadius.all(Radius.circular(20))),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PhonePrototype(
                    onTap: (value) {
                      setState(() {
                        crossAxisAlignment = value;
                        alignment = Alignment.centerLeft;
                      });
                    },
                    isSelected: crossAxisAlignment == CrossAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  PhonePrototype(
                    onTap: (value) {
                      setState(() {
                        crossAxisAlignment = value;
                        alignment = Alignment.center;
                      });
                    },
                    isSelected: crossAxisAlignment == CrossAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                  PhonePrototype(
                    onTap: (value) {
                      setState(() {
                        crossAxisAlignment = value;
                        alignment = Alignment.centerRight;
                      });
                    },
                    isSelected: crossAxisAlignment == CrossAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
              alignment: alignment,
              child: Column(
                crossAxisAlignment: crossAxisAlignment,
                children: [
                  const SizedBox(height: 160),
                  Text(time(), style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 80, color: Colors.white)),
                  Text(date(), style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 24, color: Colors.white)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PhonePrototype extends StatelessWidget {
  final CrossAxisAlignment crossAxisAlignment;
  final bool isSelected;
  final void Function(CrossAxisAlignment crossAxisAlignment) onTap;

  const PhonePrototype({
    required this.crossAxisAlignment,
    required this.onTap,
    this.isSelected = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(crossAxisAlignment),
      child: Container(
        width: 110,
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue.shade500 : Colors.grey.shade700,
            width: 2,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            const SizedBox(height: 20),
            Text(
              time(),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: isSelected ? Colors.blue.shade500 : null,
              ),
            ),
            Text(
              date(),
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 8, color: isSelected ? Colors.blue.shade500 : null),
            ),
          ],
        ),
      ),
    );
  }
}

String time() {
  return DateFormat.Hm().format(DateTime.now());
}

String date() {
  return DateFormat.MMMMEEEEd().format(DateTime.now());
}
