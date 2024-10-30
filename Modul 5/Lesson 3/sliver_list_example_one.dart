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
              delegate: SliverChildListDelegate(
                [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: ListTile(
                      tileColor: Color.fromRGBO(237, 237, 237, 1),
                      leading: Icon(CupertinoIcons.doc_on_doc),
                      trailing: Icon(CupertinoIcons.chevron_forward),
                      title: Text("Invoices", style: TextStyle(fontWeight: FontWeight.w600)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: ListTile(
                      tileColor: Color.fromRGBO(237, 237, 237, 1),
                      leading: Icon(CupertinoIcons.archivebox),
                      trailing: Icon(CupertinoIcons.chevron_forward),
                      title: Text("Archive", style: TextStyle(fontWeight: FontWeight.w600)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: ListTile(
                      tileColor: Color.fromRGBO(237, 237, 237, 1),
                      leading: Icon(CupertinoIcons.globe),
                      trailing: Icon(CupertinoIcons.chevron_forward),
                      title: Text("Language", style: TextStyle(fontWeight: FontWeight.w600)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: ListTile(
                      tileColor: Color.fromRGBO(237, 237, 237, 1),
                      leading: Icon(CupertinoIcons.question_circle),
                      trailing: Icon(CupertinoIcons.chevron_forward),
                      title: Text("Help", style: TextStyle(fontWeight: FontWeight.w600)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
