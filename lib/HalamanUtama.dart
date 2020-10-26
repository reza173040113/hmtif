import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'HalamanBeranda.dart';
import 'Login_Page.dart';
import 'Views/HalamanAspirasi.dart';

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

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final _widgetOptions = [
    Aspirasi(),
    // Beranda(),
    // Aspirasi(),
  ];
  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        color:  Color.fromARGB(255, 27, 67, 50),
        backgroundColor: Colors.white,
        buttonBackgroundColor: Color.fromARGB(225, 27, 67, 50),
        height: 50,
        items: <Widget>[
          Icon(
            Icons.menu_book_outlined,
            size: 20,
            color: Colors.white,
          ),
          // Icon(Icons.home, size: 20, color: Colors.white),
          // Icon(Icons.menu_book_outlined, size: 20, color: Colors.white),
        ],
        animationDuration: Duration(
          milliseconds: 200
        ),
        animationCurve: Curves.bounceInOut,
        onTap: (index) {
          setState((){
            _selectedIndex = index;
          });
        },
      ),
      body: _widgetOptions[_selectedIndex],backgroundColor: Colors.blueGrey[50],
    );
  }
}
