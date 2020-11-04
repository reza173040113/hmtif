import 'package:flutter/material.dart';

class AppTheme {
  static AppTheme _theme = AppTheme._singleTon();

  factory AppTheme() {
    return _theme;
  }

  AppTheme._singleTon();

  MaterialColor appColor = MaterialColor(0xFF2196F3, {
    50: Color(0xFFE3F2FD),
    100: Color(0xFFBBDEFB),
    200: Color(0xFF90CAF9),
    300: Color(0xFF64B5F6),
    400: Color(0xFF42A5F5),
    500: Color(0xFF2196F3),
    600: Color(0xFF1E88E5),
    700: Color(0xFF1976D2),
    800: Color(0xFF1565C0),
    900: Color(0xFF3549FB),
  });

  ColorSwatch appColors = ColorSwatch(0xFF2196F3, {
    tosca: Color(0xFF18FFFF),
    blue: Color(0xFF2196F3),
    black: Color(0xff000000),
    white: Color(0xffffffff),
    red: Color(0x1AFFFFFF),
  });

  Widget page(
      {@required BuildContext context,
      @required Widget content,
      ValueChanged onTapBack()}) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'img/bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'img/foreground.png',
              fit: BoxFit.cover,
            ),
          ),
          content,
          if (onTapBack != null)
            Positioned(
              child: GestureDetector(
                onTap: () {
                  onTapBack();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: appColors[white],
                ),
              ),
              top: 80,
              left: 16,
            )
        ],
      ),
    );
  }

  RoundedRectangleBorder buttonTheme() {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)));
  }
}

const String tosca = "tosca";
const String blue = "blue";
const String black = "black";
const String white = "white";
const String red = "red";