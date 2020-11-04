import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(23),
        child: Stack(
          children: [
            Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(),
                        flex: 1,
                      ),
                      Expanded(
                        flex: 6,
                        child: GestureDetector(
                          onTap: () {
                            _auth.signOut().then((value) {
                              Navigator.pushReplacementNamed(
                                  context, "/welcome");
                            });
                          },
                          child: Image.asset(
                            'img/home.png',
                            height: 201,
                            width: 281.51,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                        flex: 2,
                      )
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "Welcome to the app",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 28)),
                  Container(
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Egestas scelerisque porttitor turpis viverra lobortis convallis. Libero tristique donec turpis elit adipiscing sit faucibus tincidunt. Erat porttitor amet, nibh id lorem. Volutpat quam vestibulum egestas ut odio odio. Nunc non, feugiat a diam at lacus augue. Sit lacus pharetra eget feugiat aliquam enim adipiscing. Purus nec tortor tellus, neque montes. Gravida ornare eu viverra libero. Vulputate massa turpis posuere nibh dolor pulvinar bibendum. Viverra scelerisque ut dignissim at sit s",
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
                mainAxisSize: MainAxisSize.min,
              ),
            )
          ],
        ),
      ),
    );
  }
}