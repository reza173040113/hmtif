import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AppTheme.dart';
import 'AuthState.dart';

class AuthView extends StatelessWidget {
  final AppTheme _theme = new AppTheme();

  Widget _loading() {
    return Platform.isAndroid
        ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Container(
            child: Center(child: CupertinoActivityIndicator()),
          );
  }

  @override
  Widget build(BuildContext context) {
    String argument = ModalRoute.of(context).settings.arguments;
    String title = argument == "login" ? "Login" : "Register new account";
    String buttonTitle = argument == "login" ? "Login" : "Create account";
    return _theme.page(
        context: context,
        content: Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 44, right: 54, left: 54, bottom: 70),
          decoration: BoxDecoration(
            color: _theme.appColors[white],
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(50),
              topLeft: Radius.circular(50),
            ),
          ),
          child: ChangeNotifierProvider(
            create: (c) => AuthState(argument, context),
            child: Consumer<AuthState>(
              builder: (c, state, _) => Form(
                key: state.key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 39, bottom: 39),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: "Email"),
                        validator: (value) => state.emailValidator(value),
                        controller: state.email,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 0, bottom: 55),
                      child: TextFormField(
                        controller: state.password,
                        obscureText: true,
                        validator: (value) => state.passwordValidator(value),
                        decoration: InputDecoration(labelText: "Password"),
                      ),
                    ),
                    state.authProcess
                        ? _loading()
                        : Container(
                            width: double.infinity,
                            child: RaisedButton(
                              shape: _theme.buttonTheme(),
                              color: _theme.appColor[900],
                              textColor: _theme.appColors[white],
                              onPressed: () {
                                state.auth();
                              },
                              child: Text(buttonTitle),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
        onTapBack: () {
          Navigator.pushReplacementNamed(context, '/welcome');
          return;
        });
  }
}