import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Animation/FadeAnimation.dart';
import 'HalamanDetailAspirasi.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/detail': (context) => DetailAspirasi(),
    },
    theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        accentColor: Colors.cyan),
    home: Aspirasi(),
  ));
}

class Aspirasi extends StatelessWidget {
  navigateToDetail(BuildContext context, DocumentSnapshot post) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailAspirasi(
                  MyStudent: post,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: new Container(
        child: new Column(
          children: <Widget>[
            Container(
              height: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('img/background.png'),
                      fit: BoxFit.fill)),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 30,
                    width: 80,
                    height: 200,
                    child: FadeAnimation(
                        1,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('img/light-1.png'))),
                        )),
                  ),
                  Positioned(
                    left: 140,
                    width: 80,
                    height: 150,
                    child: FadeAnimation(
                        1.3,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('img/light-2.png'))),
                        )),
                  ),
                  Positioned(
                    right: 40,
                    top: 40,
                    width: 80,
                    height: 150,
                    child: FadeAnimation(
                        1.5,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('img/clock.png'))),
                        )),
                  ),
                  Positioned(
                    child: FadeAnimation(
                        1.6,
                        Container(
                          margin: EdgeInsets.only(top: 85),
                          child: Center(
                            child: Text(
                              "Aspirasi dan Keluhan",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )),
                  )
                ],
              ),
            ),
            StreamBuilder(
              stream: Firestore.instance.collection("MyStudents").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        // Firebase.initializeApp();
                        DocumentSnapshot documentSnapshot =
                            snapshot.data.documents[index];
                        return FadeAnimation(
                            1.8,
                            Card(
                              child: ListTile(
                                title: Text(documentSnapshot.data()['name']),
                                subtitle:
                                    Text(documentSnapshot.data()['studentId']),
                                leading: CircleAvatar(
                                    child: Image(
                                  image: AssetImage('img/akun.png'),
                                )),
                                trailing: Icon(Icons.more_vert),
                                isThreeLine: true,
                                onTap: () => navigateToDetail(
                                    context, snapshot.data.documents[index]),
                              ),
                            ));
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    ));
  }
}
