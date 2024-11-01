import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const MediaQuery(data: MediaQueryData(), child: MaterialApp(home: MyApp())));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: CustomSliverPersistentHeader(),
            ),
            SliverList(delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text('text $index'),
                    ));
              },
            ))
          ],
        ));
  }
}

class CustomSliverPersistentHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(builder: (context, constraints) {
      return OverflowBox(
        maxHeight: constraints.biggest.height + 100,
        alignment: Alignment.topCenter,
        child: SizedBox.fromSize(
          size: constraints.biggest + Offset(0, max(0, 100 - shrinkOffset)),
          // The following Container can be replaced by a ClipPath with a
          // ShapeBorderClipper, albeit at the expense of not being able to add
          // shadows and other fancy "Container" stuff ;-)
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(shape: CustomShape(shrinkOffset)),
            child: Container(
              color: Colors.amber,
            ),
          ),
        ),
      );
    });
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  @override
  double get maxExtent => 400.0;

  @override
  double get minExtent => 100.0;
}

class CustomShape extends ShapeBorder {
  final double shrinkOffset;

  const CustomShape(this.shrinkOffset);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    double scrollOffset = 0.0;
    if (shrinkOffset <= 100) {
      scrollOffset = 100.00 - shrinkOffset;
    }

    Offset controllPoint1 = Offset(0, rect.size.height - scrollOffset);
    Offset endPoint1 = Offset(scrollOffset, rect.size.height - scrollOffset);
    Offset controllPoint2 = Offset(rect.size.width, rect.size.height - scrollOffset);
    Offset endPoint2 = Offset(rect.size.width, rect.size.height - scrollOffset * 2);

    return Path()
      ..lineTo(0, rect.size.height)
      ..quadraticBezierTo(controllPoint1.dx, controllPoint1.dy, endPoint1.dx, endPoint1.dy)
      ..lineTo(rect.size.width - scrollOffset, rect.size.height - scrollOffset)
      ..quadraticBezierTo(controllPoint2.dx, controllPoint2.dy, endPoint2.dx, endPoint2.dy)
      ..lineTo(rect.size.width, 0);
  }

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.only(bottom: 0);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
