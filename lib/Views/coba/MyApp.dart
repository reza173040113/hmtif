import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hmtif/Views/HalamanAspirasi.dart';
import 'package:hmtif/Views/admin/HalamanAdminAspirasi.dart';

import 'AppTheme.dart';
import 'AuthView.dart';
import 'HomewView.dart';
import 'WelcomeView.dart';

class MyApp extends StatelessWidget {
  final AppTheme _theme = new AppTheme();
  final routes = {
    "/welcome": (_) => WelcomeView(),
    "/auth": (_) => AuthView(),
    "/home": (_) => Aspirasi(),
    "/admin": (_) => AdminAspirasi(),
  };

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return MaterialApp(
      routes: routes,
      title: 'Abersoft Test',
      theme: ThemeData(
        primarySwatch: _theme.appColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: auth.currentUser == null ? "/welcome" : "/home",
    );
  }
}

class CheckUser extends StatefulWidget {
  @override
  _CheckUserState createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (c, i) => Container(
          child: Row(
            children: [FlutterLogo(), Text("Data ke-$i")],
          ),
        ),
        itemCount: 4000,
      ),
    );
  }
}
