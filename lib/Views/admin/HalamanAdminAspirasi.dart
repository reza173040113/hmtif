import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hmtif/Animation/FadeAnimation.dart';
import 'package:hmtif/Views/admin/HalamanPostinganAdmin.dart';

import '../../main.dart';
import 'HalamanEditAspirasiAdmin.dart';

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

class AdminAspirasi extends StatefulWidget {
  @override
  _AdminAspirasiState createState() => _AdminAspirasiState();
}

class _AdminAspirasiState extends State<AdminAspirasi> {
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
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Halaman Aspirasi Mahasiswa"),
        backgroundColor: Color.fromARGB(237, 8, 28, 21),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 20)),
            ListTile(
              title: Text('Postingan'),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new PostinganAdmin()));
              },
            ),
            ListTile(
              title: Text('Aspirasi Mahasiswa'),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new AdminAspirasi()));
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new LoginScreen()));
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: new Container(
            height: MediaQuery.of(context).size.height,
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(237, 8, 28, 21),
              Color.fromARGB(255, 116, 198, 157)
            ],
          )),
            child: new Column(
              children: <Widget>[
                SingleChildScrollView(
                    controller: controller,
                    scrollDirection: Axis.vertical,
                    child: Column(children: <Widget>[
                      StreamBuilder(
                        stream: Firestore.instance
                            .collection("AspirasiMahasiswa")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return SingleChildScrollView(
                              child: ListView.builder(
                                controller: controller,
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
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(documentSnapshot
                                                  .data()['name']),
                                              content: Text(documentSnapshot
                                                  .data()['deskripsi']),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text('Post'),
                                                  onPressed: () {
                                                    String documentId =
                                                        documentSnapshot
                                                            .documentID;
                                                    String name =
                                                        documentSnapshot
                                                            .data()['name'];
                                                    String deskripsi =
                                                        documentSnapshot.data()[
                                                            'deskripsi'];

                                                    DocumentReference
                                                        documentReference =
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "Aspirasi")
                                                            .document(
                                                                documentId);
                                                    Map<String, dynamic>
                                                        students = {
                                                      "name": name,
                                                      "deskripsi": deskripsi,
                                                      "jumlahLike": 0,
                                                    };

                                                    documentReference
                                                        .setData(students)
                                                        .whenComplete(() {
                                                      print("$name created");
                                                    });
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: Text(
                                                                'Aspirasi dan keluhan berhasil dipost!!!'),
                                                            actions: <Widget>[
                                                              FlatButton(
                                                                child:
                                                                    Text('Ok'),
                                                                onPressed: () {
                                                                  documentSnapshot
                                                                      .reference
                                                                      .delete();
                                                                  Navigator.of(
                                                                          context)
                                                                      .push(new MaterialPageRoute(
                                                                          builder: (BuildContext context) =>
                                                                              new AdminAspirasi()));
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        });
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: InkWell(
                                        child: Container(
                                          margin: EdgeInsets.all(5),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Container(
                                              child: SizedBox(
                                                height: 50,
                                                child: Stack(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  children: <Widget>[
                                                    Container(
                                                      height: 50,
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            offset:
                                                                Offset(0, 8),
                                                            blurRadius: 24,
                                                            color: Colors.grey,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 10,
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 20,
                                                                vertical: 15),
                                                        height: 50,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width -
                                                            170,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Text(
                                                              documentSnapshot
                                                                      .data()[
                                                                  'name'],
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
                              ),
                            );
                          } else if(snapshot.hasData == null){
                            return Container(
                              margin: EdgeInsets.all(50),
                              child: Column(children: <Widget>[
                                Text(
                                    "Belum ada aspirasi dan keluhan dari mahasiswa",
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.black))
                              ]),
                            );
                          }
                        },
                      ),
                    ])),
              ],
            )),
      ),
    );
  }
}
