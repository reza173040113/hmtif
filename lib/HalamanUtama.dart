import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'HalamanAspirasi.dart';
import 'HalamanBeranda.dart';
import 'Login_Page.dart';

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
    Beranda(),
    Aspirasi(),
  ];
  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        color: Colors.white,
        backgroundColor: Colors.blueGrey[50],
        buttonBackgroundColor: Colors.white,
        height: 50,
        items: <Widget>[
          Icon(
            Icons.menu_book_outlined,
            size: 20,
            color: Colors.black,
          ),
          Icon(Icons.home, size: 20, color: Colors.black),
          Icon(Icons.menu_book_outlined, size: 20, color: Colors.black),
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
