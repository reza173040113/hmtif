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
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        // appBar: AppBar(
        //   // title: Text("Halaman Aspirasi",
        //   //     style: TextStyle(color: Colors.grey[600])),
        //   backgroundColor: Colors.white,
        // ),
        body: SingleChildScrollView(
          child: new Container(
            child: new Column(
              children: <Widget>[
                Container(
                  height: 270,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('img/background-3.jpg'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      // Positioned(
                      //   left: 110,
                      //   width: 80,
                      //   height: 180,
                      //   child: FadeAnimation(
                      //       1,
                      //       Container(
                      //         decoration: BoxDecoration(
                      //             image: DecorationImage(
                      //                 image: AssetImage('img/light-1.png'))),
                      //       )),
                      // ),
                      // Positioned(
                      //   left: 200,
                      //   width: 80,
                      //   height: 130,
                      //   child: FadeAnimation(
                      //       1.3,
                      //       Container(
                      //         decoration: BoxDecoration(
                      //             image: DecorationImage(
                      //                 image: AssetImage('img/light-2.png'))),
                      //       )),
                      // ),
                      // Positioned(
                      //   right: 0,
                      //   top: -30,
                      //   width: 80,
                      //   height: 150,
                      //   child: FadeAnimation(
                      //       1.5,
                      //       Container(
                      //         decoration: BoxDecoration(
                      //             image: DecorationImage(
                      //                 image: AssetImage('img/clock.png'))),
                      //       )),
                      // ),
                      Positioned(
                        child: FadeAnimation(
                            1.6,
                            Container(
                              margin: EdgeInsets.only(top: 165,),
                              child: Center(
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    "Aspirasi dan Keluhan",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold ),
                                  ),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                new Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new TambahAspirasi()));
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 75, 71, 68),
                          Color.fromARGB(255, 75, 71, 68),
                        ])),
                    child: Center(
                      child: Text(
                        "Tambah Aspirasi",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
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
                            style: TextStyle(fontWeight: FontWeight.bold)))),
                StreamBuilder(
                  stream: Firestore.instance.collection("Aspirasi").snapshots(),
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
                            Map<String, dynamic> task = documentSnapshot.data();
                            if (documentSnapshot.data()['name'] == "a") {
                              return FadeAnimation(
                                  1.8,
                                  Card(
                                    color: Color.fromARGB(225, 192, 158, 112),
                                    child: ListTile(
                                        title: Text(
                                            documentSnapshot.data()['name'],
                                            style:
                                                TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                                        subtitle: Text(
                                            "Like " +
                                                documentSnapshot
                                                    .data()['jumlahLike']
                                                    .toString(),
                                            style:
                                                TextStyle(color: Colors.black)),
                                        
                                        trailing: PopupMenuButton(
                                          itemBuilder: (BuildContext context) {
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
                                          onSelected: (String value) async {
                                            if (value == 'edit') {
                                              bool result =
                                                  await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                                  return EditAspirasi(
                                                    documentId: documentSnapshot
                                                        .documentID,
                                                    name: task['name'],
                                                    deskripsi:
                                                        task['deskripsi'],
                                                    jumlahLike:
                                                        task['jumlahLike'],
                                                  );
                                                }),
                                              );
                                            } else if (value == 'delete') {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        'Yakin mau hapus?'),
                                                    actions: <Widget>[
                                                      FlatButton(
                                                        child: Text('Tidak'),
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
                                            color: Colors.white,
                                          ),
                                        ),
                                        isThreeLine: true,
                                        onTap: () async {
                                          bool result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                              return DetailAspirasi(
                                                documentId:
                                                    documentSnapshot.documentID,
                                                name: task['name'],
                                                deskripsi: task['deskripsi'],
                                                jumlahLike: task['jumlahLike'],
                                              );
                                            }),
                                          );
                                        }),
                                  ));
                            } else {
                              return FadeAnimation(
                                  1.8,
                                  Card(
                                    color: Color.fromARGB(225, 192, 158, 112),
                                    child: ListTile(
                                        title: Text(
                                            documentSnapshot.data()['name'],
                                            style:
                                                TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                                        subtitle: Text(
                                            "Like " +
                                                documentSnapshot
                                                    .data()['jumlahLike']
                                                    .toString(),
                                            style:
                                                TextStyle(color: Colors.black)),
                                        // leading: CircleAvatar(
                                        //     child: Image(
                                        //   image: AssetImage('img/akun.png'),
                                        // )),
                                        // trailing: PopupMenuButton(
                                        //   itemBuilder: (BuildContext context) {
                                        //     return List<PopupMenuEntry<String>>()
                                        //       ..add(PopupMenuItem<String>(
                                        //         value: 'edit',
                                        //         child: Text('Edit'),
                                        //       ))
                                        //       ..add(PopupMenuItem<String>(
                                        //         value: 'delete',
                                        //         child: Text('Delete'),
                                        //       ));
                                        //   },
                                        //   onSelected: (String value) async {
                                        //     if (value == 'edit') {
                                        //       bool result = await Navigator.push(
                                        //         context,
                                        //         MaterialPageRoute(
                                        //             builder: (context) {
                                        //           return EditAspirasi(
                                        //             documentId: documentSnapshot
                                        //                 .documentID,
                                        //             name: task['name'],
                                        //             deskripsi: task['deskripsi'],
                                        //             jumlahLike:
                                        //                 task['jumlahLike'],
                                        //           );
                                        //         }),
                                        //       );
                                        //     } else if (value == 'delete') {
                                        //       showDialog(
                                        //         context: context,
                                        //         builder: (BuildContext context) {
                                        //           return AlertDialog(
                                        //             title:
                                        //                 Text('Yakin mau hapus?'),
                                        //             actions: <Widget>[
                                        //               FlatButton(
                                        //                 child: Text('Tidak'),
                                        //                 onPressed: () {
                                        //                   Navigator.pop(context);
                                        //                 },
                                        //               ),
                                        //               FlatButton(
                                        //                 child: Text('Ya'),
                                        //                 onPressed: () {
                                        //                   documentSnapshot
                                        //                       .reference
                                        //                       .delete();
                                        //                   Navigator.pop(context);
                                        //                 },
                                        //               ),
                                        //             ],
                                        //           );
                                        //         },
                                        //       );
                                        //     }
                                        //   },
                                        //   child: Icon(
                                        //     Icons.more_vert,
                                        //     color: Colors.white,
                                        //   ),
                                        // ),
                                        isThreeLine: true,
                                        onTap: () async {
                                          bool result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                              return DetailAspirasi(
                                                documentId:
                                                    documentSnapshot.documentID,
                                                name: task['name'],
                                                deskripsi: task['deskripsi'],
                                                jumlahLike: task['jumlahLike'],
                                              );
                                            }),
                                          );
                                        }),
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
                new Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.blueGrey[50]);
  }
}
