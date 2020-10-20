import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hmtif/Animation/FadeAnimation.dart';

import 'HalamanDetailAspirasi.dart';
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

class Aspirasi extends StatefulWidget {
  @override
  _AspirasiState createState() => _AspirasiState();
}

class _AspirasiState extends State<Aspirasi> {
  final controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    SingleChildScrollView(
                      controller: controller,
                      child: StreamBuilder(
                        stream: Firestore.instance
                            .collection("Aspirasi")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                                controller : controller,
                              shrinkWrap: true,
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot documentSnapshot =
                                    snapshot.data.documents[index];
                                Map<String, dynamic> task =
                                    documentSnapshot.data();
                                return FadeAnimation(
                                  1.8,
                                  GestureDetector(
                                    onTap: () async {
                                      bool result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                          return DetailAspirasi(
                                            documentId:
                                                documentSnapshot.documentID,
                                            name: task['name'],
                                            deskripsi: task['deskripsi'],
                                            jumlahLike: task['jumlahLike'],
                                            status: task['status'],
                                          );
                                        }),
                                      );
                                    },
                                    child: InkWell(
                                      child: Container(
                                        margin: EdgeInsets.only(left:10,right:10,top:5),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Container(
                                            child: SizedBox(
                                              height: 50,
                                              child: Stack(
                                                alignment: Alignment.centerLeft,
                                                children: <Widget>[
                                                  Container(
                                                    height: 50,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          offset: Offset(0, 8),
                                                          blurRadius: 24,
                                                          color: Colors.grey,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 10,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 20,
                                                              vertical: 15),
                                                      height: 50,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              40,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                documentSnapshot
                                                                        .data()[
                                                                    'name'], style:TextStyle(fontWeight:FontWeight.bold)
                                                              ),
                                                              Text(
                                                                "Like " +
                                                                    documentSnapshot
                                                                        .data()[
                                                                            'jumlahLike']
                                                                        .toString(),
                                                               
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),

             
            ],
          ),
        ),
      ),
    );
  }
}


