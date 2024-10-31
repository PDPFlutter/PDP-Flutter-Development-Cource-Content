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
      backgroundColor: const Color.fromRGBO(119, 156, 250, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Task",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Stack(
        children: [
          // #slivers:
          CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                  ),
                  delegate: SliverChildListDelegate(
                    [
                      const TaskCard(title: "Design", date: "September 17", icon: Icons.color_lens, iconColor: Colors.pink, iconBackgroundColor: Colors.pinkAccent,),
                      const TaskCard(title: "Work", date: "September 20", icon: Icons.monitor_rounded, iconColor: Colors.blue, iconBackgroundColor: Colors.blueAccent,),
                      const TaskCard(title: "Learning", date: "September 25", icon: Icons.book, iconColor: Colors.purple, iconBackgroundColor: Colors.purpleAccent,),
                      const TaskCard(title: "Shopping", date: "October 01", icon: Icons.shopping_bag_rounded, iconColor: Colors.red, iconBackgroundColor: Colors.redAccent,),
                      const TaskCard(title: "Dinner", date: "October 02", icon: Icons.dinner_dining_rounded, iconColor: Colors.deepOrange, iconBackgroundColor: Colors.deepOrangeAccent,),
                      const TaskCard(title: "Fitness", date: "October 03", icon: Icons.directions_run_rounded, iconColor: Colors.green, iconBackgroundColor: Colors.greenAccent,),
                      const TaskCard(title: "Movie", date: "October 04", icon: Icons.local_movies_rounded, iconColor: Colors.deepPurple, iconBackgroundColor: Colors.deepPurpleAccent,),
                      const AddCard(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String title;
  final String date;

  const TaskCard({
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.title,
    required this.date,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: iconBackgroundColor.withOpacity(0.175),
            child: Icon(icon, size: 40, color: iconColor),
          ),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(date, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey)),
        ],
      ),
    );
  }
}

class AddCard extends StatelessWidget {
  const AddCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      alignment: Alignment.center,
      child: const Icon(Icons.add, size: 60, color: Colors.blueAccent),
    );
  }
}
