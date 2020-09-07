import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        accentColor: Colors.cyan),
    home: DetailAspirasi(),
  ));
}

class DetailAspirasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Center(
        child: new Column(
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: StreamBuilder(
                stream: Firestore.instance.collection("MyStudents").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        // Firebase.initializeApp();
                        DocumentSnapshot documentSnapshot =
                            snapshot.data.documents[index];
                        return Card(
                          child: ListTile(
                            title: Text(documentSnapshot.data()['name']),
                            subtitle:
                                Text(documentSnapshot.data()['studentId']),
                            leading: CircleAvatar(
                              child: Image(image: AssetImage('img/akun.png'),)
                            ),
                            
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
