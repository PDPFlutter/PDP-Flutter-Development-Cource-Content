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
      body: Stack(
        children: [
          // #background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color(0xff62cff4),
                  Color(0xff2c67f2),
                ],
              ),
            ),
          ),

          // #slivers:
          CustomScrollView(
            slivers: [
              // #sliver_app_bar
              SliverAppBar(
                // #app_bar_elements:
                leading: const Icon(Icons.add, color: Colors.white, size: 30),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert, color: Colors.white, size: 30),
                  ),
                ],
                title: const Text('Tashkent'),
                titleTextStyle: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
                backgroundColor: Colors.transparent,

                // #sliver_elements:
                expandedHeight: 400,
                stretch: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  // #sliver_app_bar_content:
                  background: Container(
                    alignment: const Alignment(0, 0.5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('  ', style: TextStyle(fontSize: 30, color: Colors.white.withOpacity(0.85))),
                            Text('16', style: TextStyle(fontSize: 100, color: Colors.white.withOpacity(0.85), height: 1)),
                            Text('\u2103',
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white.withOpacity(0.85), fontWeight: FontWeight.w700)),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text("Clear 16\u00B0/6\u00B0",
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 20, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 15),
                        const Card(
                          color: Colors.transparent,
                          elevation: 0.1,
                          shadowColor: Colors.black45,
                          shape: StadiumBorder(),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            child: Text(
                              "☁️ AQI 33",
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  stretchModes: const [
                    StretchMode.fadeTitle, // fades out the title
                    StretchMode.blurBackground, // blur out the background
                    StretchMode.zoomBackground // zoom the background
                  ],
                ),
              ),

              // #body
              SliverToBoxAdapter(
                child: Card(
                  color: Colors.transparent,
                  elevation: 0.1,
                  shadowColor: Colors.black45,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DefaultTextStyle(
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Icon(CupertinoIcons.calendar_circle_fill, color: Color.fromRGBO(255, 255, 255, 0.85)),
                              SizedBox(width: 10),
                              Text(
                                "5-Day Forecast",
                                style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.85)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("🌕   Today: clear"),
                              Text("16\u00B0 / 6\u00B0"),
                            ],
                          ),
                          const SizedBox(height: 15),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("✨   Tomorrow: clear"),
                              Text("17\u00B0 / 5\u00B0"),
                            ],
                          ),
                          const SizedBox(height: 15),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("⛅️   Friday: cloudy"),
                              Text("20\u00B0 / 9\u00B0"),
                            ],
                          ),
                          const SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              elevation: 0.1,
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.white38,
                              overlayColor: Colors.blueAccent,
                              shape: const StadiumBorder(),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              minimumSize: const Size(double.infinity, 0),
                            ),
                            child: const Text(
                              "5-Day Forecast",
                              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SliverFillRemaining(
                child: SizedBox(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
