import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

// ########### [Colors]  ########### //
const mainColor = Color.fromRGBO(74, 213, 86, 1.0);

const List<Color> borderColors = [
  Color(0xFF171006),
  Color(0xFF3C401A),
  Color(0xFF5F4B2A),
  Color(0xFF989491),
  Color(0xFFE5E3E1),
];

// ########### [Main]  ########### //
void main() {
  runApp(const MyApp());
}

// ########### [App]  ########### //
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

// ########### [Home Screen]  ########### //
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  final _listController = ListController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    _listController.addListener(() {
      if (_listController.visibleRange != null) {
        if ((_listController.visibleRange!.$1 != currentIndex ||
            _listController.visibleRange!.$2 != currentIndex) &&
            (_listController.visibleRange!.$1 == _listController.visibleRange!.$2)) {
          if(mounted) {
            WidgetsBinding.instance
                .addPostFrameCallback((_) => setState(() {
              currentIndex = _listController.visibleRange!.$1;
            }));
          }
        }
      }
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Title(
          date: data[currentIndex].date,
          taskNumber: data[currentIndex].tasks.length,
        ),
        leadingWidth: 64, // 12 + 16 + 20 + 16
        elevation: 10,
        shadowColor: Colors.black38,
        surfaceTintColor: Colors.white,
        leading: BackButton(onPressed: () {}),
        actions: [
          CalendarButton(onPressed: () {}),
          const SizedBox(width: 12),
        ],
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.sizeOf(context).width, 120),
          child: Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return DateCard(
                  date: data[index].date,
                  isSelected: currentIndex == index,
                  onTap: () => animateToItem(index),
                );
              },
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            sliver: SuperSliverList(
              listController: _listController,
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final dayTaskList = data[index];
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dayTaskList.tasks.length,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        title: dayTaskList.tasks[index].title,
                        category: dayTaskList.tasks[index].category,
                        startDate: dayTaskList.tasks[index].startTime,
                        endDate: dayTaskList.tasks[index].endTime,
                        borderColor: borderColors[index % borderColors.length],
                        usersImage: dayTaskList.tasks[index].users.map((user) => user.imageUrl).toList(),
                      );
                    },
                  );
                },
                childCount: data.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// ########### [Components]  ########### //
class TaskCard extends StatelessWidget {
  final String title;
  final String category;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> usersImage;
  final Color borderColor;

  const TaskCard({
    required this.title,
    required this.category,
    required this.startDate,
    required this.endDate,
    required this.usersImage,
    this.borderColor = Colors.brown,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        height: 144,
        child: Row(
          children: [
            // #time
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(time(startDate)),
                  Text(time(endDate)),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(16, 16),
                      blurRadius: 16,
                      spreadRadius: 0,
                      color: Colors.black12,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 144,
                      width: 16,
                      color: borderColor,
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("$category.\tDay: ${monthAndDate(startDate)}"),
                                const Icon(Icons.more_vert),
                              ],
                            ),
                            Text(
                              title,
                              style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("🕓 ${time(startDate)} - ${time(endDate)}"),
                                  Flexible(
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Stack(
                                        alignment: Alignment.bottomRight,
                                        fit: StackFit.loose,
                                        children: [
                                          if (usersImage.length >= 4)
                                            Positioned(
                                              right: 0,
                                              child: CircleAvatar(
                                                radius: 16,
                                                backgroundColor: Colors.white,
                                                child: Text("${usersImage.length - 3}+"),
                                              ),
                                            ),
                                          if (usersImage.isNotEmpty)
                                            Positioned(
                                              right: 30,
                                              child: CircleAvatar(
                                                radius: 16,
                                                // backgroundImage: NetworkImage("https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=2980&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                                                backgroundImage: CachedNetworkImageProvider(usersImage[0]),
                                              ),
                                            ),
                                          if (usersImage.length >= 2)
                                            Positioned(
                                              right: 54,
                                              child: CircleAvatar(
                                                radius: 16,
                                                // backgroundImage: NetworkImage("https://plus.unsplash.com/premium_photo-1689977807477-a579eda91fa2?q=80&w=2970&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                                                backgroundImage: CachedNetworkImageProvider(usersImage[1]),
                                              ),
                                            ),
                                          if (usersImage.length >= 3)
                                            Positioned(
                                              right: 78,
                                              child: CircleAvatar(
                                                radius: 16,
                                                // backgroundImage: NetworkImage("https://images.unsplash.com/photo-1599566147214-ce487862ea4f?q=80&w=3047&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                                                backgroundImage: CachedNetworkImageProvider(usersImage[2]),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DateCard extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final void Function()? onTap;

  const DateCard({
    required this.date,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        margin: const EdgeInsets.only(left: 8, right: 8, bottom: 16),
        decoration: BoxDecoration(
            color: isSelected ? mainColor : Colors.white, borderRadius: const BorderRadius.all(Radius.circular(8))),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              day(date),
              style: TextStyle(color: isSelected ? Colors.white : Colors.black54, fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            Text(weekDay(date), style: TextStyle(color: isSelected ? Colors.white : Colors.black54, fontSize: 12)),
            if (isSelected) const SizedBox(height: 4),
            if (isSelected)
              Container(
                height: 8,
                width: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              )
          ],
        ),
      ),
    );
  }
}

class CalendarButton extends StatelessWidget {
  final void Function()? onPressed;

  const CalendarButton({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton.outlined(
      onPressed: onPressed,
      iconSize: 24,
      icon: const Icon(
        Icons.calendar_month,
        color: mainColor,
      ),
      padding: const EdgeInsets.all(14),
    );
  }
}

class BackButton extends StatelessWidget {
  final void Function()? onPressed;

  const BackButton({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 12),
        IconButton.outlined(
          onPressed: onPressed,
          iconSize: 20,
          icon: const Icon(Icons.arrow_back_ios_new),
          padding: const EdgeInsets.all(16),
        ),
      ],
    );
  }
}

class Title extends StatelessWidget {
  final DateTime date;
  final int taskNumber;

  const Title({
    required this.date,
    required this.taskNumber,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          monthAndDate(date),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "$taskNumber task${taskNumber > 1 ? "s" : ""}${date.day == DateTime.now().day ? " today" : ""}",
          style: const TextStyle(color: Colors.black45, fontSize: 16),
        ),
      ],
    );
  }
}

// ########### [Time Formatter]  ########### //
String monthAndDate(DateTime dateTime) {
  return DateFormat.MMMMd().format(dateTime);
}

String day(DateTime dateTime) {
  return DateFormat.d().format(dateTime);
}

String weekDay(DateTime dateTime) {
  return DateFormat.E().format(dateTime);
}

String time(DateTime dateTime) {
  return DateFormat.Hm().format(dateTime);
}

// ########### [Models]  ########### //
class User {
  final String id;
  final String fullName;
  final String imageUrl;

  const User({
    required this.id,
    required this.fullName,
    required this.imageUrl,
  });
}

class Task {
  final String title;
  final String category;
  final DateTime startTime;
  final DateTime endTime;
  final List<User> users;

  const Task({
    required this.title,
    required this.category,
    required this.startTime,
    required this.endTime,
    required this.users,
  });
}

class DayTaskList {
  final DateTime date;
  final List<Task> tasks;

  const DayTaskList({
    required this.date,
    required this.tasks,
  });
}

// ########### [Data]  ########### //
final data = [
  for (int i = 1; i <= 31; i++)
    DayTaskList(
      date: DateTime(2024, 10, i),
      tasks: [
        Task(
            title: "Research process",
            category: "Project",
            startTime: DateTime(2024, 10, i, 7),
            endTime: DateTime(2024, 10, i, 9),
            users: const [
              User(
                  id: "01",
                  fullName: "John Doe",
                  imageUrl:
                      "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=2980&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
              User(
                  id: "01",
                  fullName: "John Doe",
                  imageUrl:
                      "https://plus.unsplash.com/premium_photo-1689977807477-a579eda91fa2?q=80&w=2970&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
              User(
                  id: "01",
                  fullName: "John Doe",
                  imageUrl:
                      "https://images.unsplash.com/photo-1599566147214-ce487862ea4f?q=80&w=3047&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
              User(
                  id: "01",
                  fullName: "John Doe",
                  imageUrl:
                      "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=2980&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
            ]),
        Task(
            title: "Moodboard Search",
            category: "Project",
            startTime: DateTime(2024, 10, i, 9),
            endTime: DateTime(2024, 10, i, 12),
            users: const [
              User(
                  id: "01",
                  fullName: "John Doe",
                  imageUrl:
                      "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=2980&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
              User(
                  id: "01",
                  fullName: "John Doe",
                  imageUrl:
                      "https://plus.unsplash.com/premium_photo-1689977807477-a579eda91fa2?q=80&w=2970&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
              User(
                  id: "01",
                  fullName: "John Doe",
                  imageUrl:
                      "https://images.unsplash.com/photo-1599566147214-ce487862ea4f?q=80&w=3047&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
              User(
                  id: "01",
                  fullName: "John Doe",
                  imageUrl:
                      "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=2980&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
            ]),
        Task(
            title: "Wireframing Design",
            category: "Project",
            startTime: DateTime(2024, 10, i, 13),
            endTime: DateTime(2024, 10, i, 16),
            users: const [
              User(
                  id: "01",
                  fullName: "John Doe",
                  imageUrl:
                      "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=2980&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
              User(
                  id: "01",
                  fullName: "John Doe",
                  imageUrl:
                      "https://plus.unsplash.com/premium_photo-1689977807477-a579eda91fa2?q=80&w=2970&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
              User(
                  id: "01",
                  fullName: "John Doe",
                  imageUrl:
                      "https://images.unsplash.com/photo-1599566147214-ce487862ea4f?q=80&w=3047&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
              User(
                  id: "01",
                  fullName: "John Doe",
                  imageUrl:
                      "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=2980&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
            ]),
        Task(
            title: "Landing Page",
            category: "Project",
            startTime: DateTime(2024, 10, i, 16),
            endTime: DateTime(2024, 10, i, 18),
            users: const [
              User(
                  id: "01",
                  fullName: "John Doe",
                  imageUrl:
                      "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=2980&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
              User(
                  id: "01",
                  fullName: "John Doe",
                  imageUrl:
                      "https://plus.unsplash.com/premium_photo-1689977807477-a579eda91fa2?q=80&w=2970&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
              User(
                  id: "01",
                  fullName: "John Doe",
                  imageUrl:
                      "https://images.unsplash.com/photo-1599566147214-ce487862ea4f?q=80&w=3047&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
              User(
                  id: "01",
                  fullName: "John Doe",
                  imageUrl:
                      "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=2980&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
            ]),
        Task(
            title: "Testing",
            category: "Project",
            startTime: DateTime(2024, 10, i, 19),
            endTime: DateTime(2024, 10, i, 21),
            users: const [
              User(
                  id: "01",
                  fullName: "John Doe",
                  imageUrl:
                      "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=2980&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
              User(
                  id: "01",
                  fullName: "John Doe",
                  imageUrl:
                      "https://plus.unsplash.com/premium_photo-1689977807477-a579eda91fa2?q=80&w=2970&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
              User(
                  id: "01",
                  fullName: "John Doe",
                  imageUrl:
                      "https://images.unsplash.com/photo-1599566147214-ce487862ea4f?q=80&w=3047&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
              User(
                  id: "01",
                  fullName: "John Doe",
                  imageUrl:
                      "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=2980&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
            ]),
      ],
    ),
];
