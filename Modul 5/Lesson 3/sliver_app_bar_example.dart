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
                            Text('15', style: TextStyle(fontSize: 100, color: Colors.white.withOpacity(0.85), height: 1)),
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
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    for(int i = 0; i < 4; i++)
                      const Card(
                        color: Colors.transparent,
                        elevation: 0.1,
                        shadowColor: Colors.black45,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: SizedBox(
                          height: 300,
                          width: double.infinity,
                        ),
                      ),
                  ]
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
