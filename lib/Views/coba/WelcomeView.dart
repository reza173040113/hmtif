import 'package:flutter/material.dart';
import 'package:hmtif/Views/coba/AuthView.dart';

import 'AppTheme.dart';

class WelcomeView extends StatelessWidget {
  final AppTheme _theme = new AppTheme();

  @override
  Widget build(BuildContext context) {
    return _theme.page(
      context: context,
      content: Container(
        margin: EdgeInsets.only(left: 54, right: 54, bottom: 145),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              height: 33,
              child: RaisedButton(
                shape: _theme.buttonTheme(),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/auth',
                      arguments: "register");
                    //    Navigator.of(context).push(new MaterialPageRoute(
                    // builder: (BuildContext context) => new AuthView()));
                },
                child: Text("Register Account"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 44),
              width: double.infinity,
              height: 33,
              child: RaisedButton(
                shape: _theme.buttonTheme(),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/auth',
                      arguments: "login");
                    //   Navigator.of(context).push(new MaterialPageRoute(
                    // builder: (BuildContext context) => new AuthView()));
                },
                child: Text("Login"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}