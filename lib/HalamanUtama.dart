import 'package:flutter/material.dart';
import 'HalamanAspirasi.dart' as aspirasi;

void main() {
  runApp(new MaterialApp(
    title: "Halaman Utama",
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController controller;
  @override
  void initState() {
    controller = new TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green[900],
        title: new Text("Halaman Utama"),
        bottom: new TabBar(
          controller: controller,
          tabs: <Widget>[
            new Tab(
              text: "Aspirasi",
            ),
            new Tab(
              text: "Beranda",
            ),
            new Tab(
              text: "Donasi",
            ),
            
          ],
        ),
      ),
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          new aspirasi.Aspirasi(),
          new aspirasi.Aspirasi(),
          new aspirasi.Aspirasi(),
        ],
      ),
    );
  }
}
