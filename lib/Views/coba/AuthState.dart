
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'AppTheme.dart';

class AuthState with ChangeNotifier {
  bool authProcess = false;
  bool autoValidate = false;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final key = GlobalKey<FormState>();
  final String argument;
  final BuildContext context;
  final AppTheme _theme = new AppTheme();

  AuthState(this.argument, this.context);

  auth() {
    if (key.currentState.validate()) {
      authProcess = true;
      notifyListeners();
      if (argument == "register")
        _register();
      else
        _login();
        _login2();
    } else {
      autoValidate = true;
      notifyListeners();
    }
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  _dialog(String message) {
    showDialog(
        context: context,
        child: AlertDialog(
          shape: _theme.buttonTheme(),
          content: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Auth Failed",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
                Padding(padding: EdgeInsets.only(top: 16)),
                Text(message),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  width: 150,
                  height: 40,
                  child: RaisedButton(
                    color: _theme.appColors[red],
                    textColor: _theme.appColors[white],
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK"),
                    shape: _theme.buttonTheme(),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  _login() {
    _auth
        .signInWithEmailAndPassword(email: email.text, password: password.text)
        .then((value) {
      authProcess = false;
      notifyListeners();
      print("hasil ${value.user.email}");
      Navigator.pushReplacementNamed(context, "/home");
    }).catchError((err) {
      authProcess = false;
      notifyListeners();
      print("hasil error $err");
      _dialog(err.toString());
    });
  }

  _register() {
    _auth
        .createUserWithEmailAndPassword(
            email: email.text, password: password.text)
        .then((value) {
      authProcess = false;
      notifyListeners();
      print("hasil ${value.user.email}");
      Navigator.pushReplacementNamed(context, "/home");
    }).catchError((err) {
      authProcess = false;
      notifyListeners();
      print("hasil error $err");
      _dialog(err.toString());
    });
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Email format is incorrect';
    else
      return null;
  }

  String passwordValidator(String value) {
    if (value.length < 6) return "Password minimal 6 character";
    return null;
  }
  _login2() {
    _auth
        .signInWithEmailAndPassword(email: "admin@gmail.com", password: "123456")
        .then((value) {
      authProcess = false;
      notifyListeners();
      print("hasil ${value.user.email}");
      Navigator.pushReplacementNamed(context, "/admin");
    }).catchError((err) {
      authProcess = false;
      notifyListeners();
      print("hasil error $err");
      _dialog(err.toString());
    });
  }
}

