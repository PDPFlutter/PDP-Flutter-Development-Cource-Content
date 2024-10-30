import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: seasons.length,
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: ListTile(
                      tileColor: seasons[index].color,
                      leading: Icon(seasons[index].icon, color: CupertinoColors.white,),
                      subtitle: Text(seasons[index].day.toString(), style: const TextStyle(fontWeight: FontWeight.w500, color: CupertinoColors.white)),
                      title: Text(seasons[index].name, style: const TextStyle(fontWeight: FontWeight.w600, color: CupertinoColors.white)),
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const seasons = [
  Season(name: "Autumn", day: 91, icon: CupertinoIcons.cloud_drizzle_fill, color: CupertinoColors.activeOrange),
  Season(name: "Winter", day: 90, icon: CupertinoIcons.snow, color: CupertinoColors.activeBlue),
  Season(name: "Spring", day: 92, icon: CupertinoIcons.cloud_sun_bolt_fill, color: CupertinoColors.activeGreen),
  Season(name: "Summer", day: 92, icon: CupertinoIcons.sun_max_fill, color: CupertinoColors.systemYellow),
];

class Season {
  final String name;
  final int day;
  final IconData icon;
  final Color color;

  const Season({
    required this.name,
    required this.day,
    required this.icon,
    required this.color,
  });
}
