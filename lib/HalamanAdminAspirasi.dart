import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Animation/FadeAnimation.dart';
import 'HalamanDetailAspirasi.dart';
import 'HalamanEditAspirasi.dart';
import 'HalamanTambahAspirasi.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        accentColor: Colors.cyan),
    home: AdminAspirasi(),
  ));
}

class AdminAspirasi extends StatelessWidget {
  String name;
  navigateToDetail(BuildContext context, DocumentSnapshot post) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditAspirasi(
                  MyStudent: post,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: new FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new TambahAspirasi()));
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.purple,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: new BottomAppBar(
          elevation: 20,
          color: Colors.purple,
          child: ButtonBar(
            children: <Widget>[],
          ),
        ),
        body: SingleChildScrollView(
          child: new Container(
            child: new Column(
              children: <Widget>[
                StreamBuilder(
                  stream:
                      Firestore.instance.collection("MyStudents").snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            // String name = snapshot.data.documents[index].data()['name'];
                            // String studentId = snapshot.data.documents[index].data()['studentId'];
                            // String studyProgramId = snapshot.data.documents[index].data()['studyProgramId'];
                            // double studentGpa = snapshot.data.documents[index].data()['studentGpa'];

                            // Firebase.initializeApp();
                            DocumentSnapshot documentSnapshot =
                                snapshot.data.documents[index];
                            return FadeAnimation(
                                1.8,
                                Card(
                                  child: ListTile(
                                    title:
                                        Text(documentSnapshot.data()['name']),
                                    subtitle: Text(
                                        documentSnapshot.data()['studentId']),
                                    leading: CircleAvatar(
                                        child: Image(
                                      image: AssetImage('img/akun.png'),
                                    )),
                                    trailing: Wrap(
                                      spacing: 12,
                                      children: <Widget>[
                                        new IconButton(
                                            icon: new Icon(Icons.edit),
                                            onPressed: () {
                                              // Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                                              //   var editAspirasi = new EditAspirasi(
                                              //   name:name,
                                              //   studentId:studentId,
                                              //   studyProgramId:studyProgramId,
                                              //   studentGpa:studentGpa,

                                              // );
                                              //   return editAspirasi;
                                              // }));
                                              navigateToDetail(
                                                  context,
                                                  snapshot
                                                      .data.documents[index]);
                                            }),
                                        new IconButton(
                                            icon: new Icon(Icons.delete),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        'Yakin Mau Hapus?'),
                                                    actions: <Widget>[
                                                      FlatButton(
                                                        child: Text('No'),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                      FlatButton(
                                                        child: Text('Delete'),
                                                        onPressed: () {
                                                          documentSnapshot
                                                              .reference
                                                              .delete();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                              
                                            })
                                      ],
                                    ),
                                    isThreeLine: true,
                                    // onTap: () => navigateToDetail(context,
                                    //     snapshot.data.documents[index]),
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
