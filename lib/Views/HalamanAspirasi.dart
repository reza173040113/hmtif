import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hmtif/Animation/FadeAnimation.dart';

import '../HalamanDetailAspirasi.dart';
import '../HalamanEditAspirasi.dart';
import '../HalamanTambahAspirasi.dart';

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
  @override
  Widget build(BuildContext context) {
    var child2 = null;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 27, 67, 50),
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: new Container(
          child: new Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: new Text("Dashboard",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20)))),
              new Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new TambahAspirasi()));
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white.withOpacity(0.4)),
                  child: Center(
                    child: Text(
                      "Tambah Aspirasi dan Keluhan",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              new Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
              Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: new Text("Aspirasi dan Keluhan",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)))),
              new Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),

              Container(
                margin: EdgeInsets.only(top: 10),
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    )),
                child: Stack(
                  children: <Widget>[
                    StreamBuilder(
                      stream:
                          Firestore.instance.collection("Aspirasi").snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (context, index) {
                                // Firebase.initializeApp();
                                DocumentSnapshot documentSnapshot =
                                    snapshot.data.documents[index];
                                Map<String, dynamic> task =
                                    documentSnapshot.data();
                                if (documentSnapshot.data()['name'] == "a") {
                                  return FadeAnimation(
                                      1.8,
                                      Card(
                                        margin: EdgeInsets.all(10),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        color: Colors.white.withOpacity(0.8),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: ListTile(
                                              title: Text(
                                                  documentSnapshot
                                                      .data()['name'],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              subtitle: Text(
                                                  "Like " +
                                                      documentSnapshot
                                                          .data()['jumlahLike']
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                              // leading: CircleAvatar(
                                              //     child: Image(
                                              //   image: AssetImage('img/akun.png'),
                                              // )),
                                              trailing: PopupMenuButton(
                                                itemBuilder:
                                                    (BuildContext context) {
                                                  return List<
                                                      PopupMenuEntry<String>>()
                                                    ..add(PopupMenuItem<String>(
                                                      value: 'edit',
                                                      child: Text('Edit'),
                                                    ))
                                                    ..add(PopupMenuItem<String>(
                                                      value: 'delete',
                                                      child: Text('Delete'),
                                                    ));
                                                },
                                                onSelected:
                                                    (String value) async {
                                                  if (value == 'edit') {
                                                    bool result =
                                                        await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                        return EditAspirasi(
                                                          documentId:
                                                              documentSnapshot
                                                                  .documentID,
                                                          name: task['name'],
                                                          deskripsi:
                                                              task['deskripsi'],
                                                          jumlahLike: task[
                                                              'jumlahLike'],
                                                        );
                                                      }),
                                                    );
                                                  } else if (value ==
                                                      'delete') {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              'Yakin mau hapus?'),
                                                          actions: <Widget>[
                                                            FlatButton(
                                                              child:
                                                                  Text('Tidak'),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            ),
                                                            FlatButton(
                                                              child: Text('Ya'),
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
                                                  }
                                                },
                                                child: Icon(
                                                  Icons.more_vert,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              isThreeLine: true,
                                              onTap: () async {
                                                bool result =
                                                    await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                    return DetailAspirasi(
                                                      documentId:
                                                          documentSnapshot
                                                              .documentID,
                                                      name: task['name'],
                                                      deskripsi:
                                                          task['deskripsi'],
                                                      jumlahLike:
                                                          task['jumlahLike'],
                                                    );
                                                  }),
                                                );
                                              }),
                                        ),
                                      ));
                                } else {
                                  return FadeAnimation(
                                      1.8,
                                      Card(
                                        margin: EdgeInsets.all(10),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        color: Colors.white.withOpacity(0.8),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: ListTile(
                                              title: Text(
                                                  documentSnapshot
                                                      .data()['name'],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              subtitle: Text(
                                                  "Like " +
                                                      documentSnapshot
                                                          .data()['jumlahLike']
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                              onTap: () async {
                                                bool result =
                                                    await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                    return DetailAspirasi(
                                                      documentId:
                                                          documentSnapshot
                                                              .documentID,
                                                      name: task['name'],
                                                      deskripsi:
                                                          task['deskripsi'],
                                                      jumlahLike:
                                                          task['jumlahLike'],
                                                    );
                                                  }),
                                                );
                                              }),
                                        ),
                                      ));
                                }
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

              // StreamBuilder(
              //   stream: Firestore.instance.collection("Aspirasi").snapshots(),
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData) {
              //       return SingleChildScrollView(
              //         scrollDirection: Axis.vertical,
              //         child: ListView.builder(
              //           scrollDirection: Axis.vertical,
              //           shrinkWrap: true,
              //           itemCount: snapshot.data.documents.length,
              //           itemBuilder: (context, index) {
              //             // Firebase.initializeApp();
              //             DocumentSnapshot documentSnapshot =
              //                 snapshot.data.documents[index];
              //             Map<String, dynamic> task = documentSnapshot.data();
              //             if (documentSnapshot.data()['name'] == "a") {
              //               return FadeAnimation(
              //                   1.8,
              //                   Card(
              //                     color: Colors.white.withOpacity(0.8),
              //                     child: ListTile(
              //                         title: Text(
              //                             documentSnapshot.data()['name'],
              //                             style: TextStyle(
              //                                 color: Colors.black,
              //                                 fontWeight: FontWeight.bold)),
              //                         subtitle: Text(
              //                             "Like " +
              //                                 documentSnapshot
              //                                     .data()['jumlahLike']
              //                                     .toString(),
              //                             style:
              //                                 TextStyle(color: Colors.black)),
              //                         // leading: CircleAvatar(
              //                         //     child: Image(
              //                         //   image: AssetImage('img/akun.png'),
              //                         // )),
              //                         trailing: PopupMenuButton(
              //                           itemBuilder: (BuildContext context) {
              //                             return List<PopupMenuEntry<String>>()
              //                               ..add(PopupMenuItem<String>(
              //                                 value: 'edit',
              //                                 child: Text('Edit'),
              //                               ))
              //                               ..add(PopupMenuItem<String>(
              //                                 value: 'delete',
              //                                 child: Text('Delete'),
              //                               ));
              //                           },
              //                           onSelected: (String value) async {
              //                             if (value == 'edit') {
              //                               bool result = await Navigator.push(
              //                                 context,
              //                                 MaterialPageRoute(
              //                                     builder: (context) {
              //                                   return EditAspirasi(
              //                                     documentId: documentSnapshot
              //                                         .documentID,
              //                                     name: task['name'],
              //                                     deskripsi: task['deskripsi'],
              //                                     jumlahLike:
              //                                         task['jumlahLike'],
              //                                   );
              //                                 }),
              //                               );
              //                             } else if (value == 'delete') {
              //                               showDialog(
              //                                 context: context,
              //                                 builder: (BuildContext context) {
              //                                   return AlertDialog(
              //                                     title:
              //                                         Text('Yakin mau hapus?'),
              //                                     actions: <Widget>[
              //                                       FlatButton(
              //                                         child: Text('Tidak'),
              //                                         onPressed: () {
              //                                           Navigator.pop(context);
              //                                         },
              //                                       ),
              //                                       FlatButton(
              //                                         child: Text('Ya'),
              //                                         onPressed: () {
              //                                           documentSnapshot
              //                                               .reference
              //                                               .delete();
              //                                           Navigator.pop(context);
              //                                         },
              //                                       ),
              //                                     ],
              //                                   );
              //                                 },
              //                               );
              //                             }
              //                           },
              //                           child: Icon(
              //                             Icons.more_vert,
              //                             color: Colors.white,
              //                           ),
              //                         ),
              //                         isThreeLine: true,
              //                         onTap: () async {
              //                           bool result = await Navigator.push(
              //                             context,
              //                             MaterialPageRoute(builder: (context) {
              //                               return DetailAspirasi(
              //                                 documentId:
              //                                     documentSnapshot.documentID,
              //                                 name: task['name'],
              //                                 deskripsi: task['deskripsi'],
              //                                 jumlahLike: task['jumlahLike'],
              //                               );
              //                             }),
              //                           );
              //                         }),
              //                   ));
              //             } else {
              //               return FadeAnimation(
              //                   1.8,
              //                   Card(
              //                     color: Colors.white.withOpacity(0.8),
              //                     child: ListTile(
              //                         title: Text(
              //                             documentSnapshot.data()['name'],
              //                             style: TextStyle(
              //                                 color: Colors.black,
              //                                 fontWeight: FontWeight.bold)),
              //                         subtitle: Text(
              //                             "Like " +
              //                                 documentSnapshot
              //                                     .data()['jumlahLike']
              //                                     .toString(),
              //                             style:
              //                                 TextStyle(color: Colors.black)),
              //                         onTap: () async {
              //                           bool result = await Navigator.push(
              //                             context,
              //                             MaterialPageRoute(builder: (context) {
              //                               return DetailAspirasi(
              //                                 documentId:
              //                                     documentSnapshot.documentID,
              //                                 name: task['name'],
              //                                 deskripsi: task['deskripsi'],
              //                                 jumlahLike: task['jumlahLike'],
              //                               );
              //                             }),
              //                           );
              //                         }),
              //                   ));
              //             }
              //           },
              //         ),
              //       );
              //     } else {
              //       return Container();
              //     }
              //   },
              // ),
              // new Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
            ],
          ),
        ),
      ),
    );
  }
}
