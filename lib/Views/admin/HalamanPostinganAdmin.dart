import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hmtif/Animation/FadeAnimation.dart';

import '../../main.dart';
import 'HalamanAdminAspirasi.dart';
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
    home: PostinganAdmin(),
  ));
}

class PostinganAdmin extends StatefulWidget {
  @override
  _PostinganAdminState createState() => _PostinganAdminState();
}

class _PostinganAdminState extends State<PostinganAdmin> {
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
          title: Text("Halaman Postingan Admin"),
        ),
        drawer: Drawer(
          child: ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
    children: <Widget>[
      Padding(padding:EdgeInsets.only(top:20)),
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
          margin: EdgeInsets.all(10),
            child: new Column(
          children: <Widget>[
            SingleChildScrollView(
                controller: controller,
                scrollDirection: Axis.vertical,
                child: Column(children: <Widget>[
                  StreamBuilder(
                    stream: Firestore.instance
                        .collection("Aspirasi")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SingleChildScrollView(
                          child: ListView.builder(
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
                                  onTap: () {
                                   showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Yakin mau hapus?'),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    child: Text('Tidak'),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  FlatButton(
                                                    child: Text('Ya'),
                                                    onPressed: () {
                                                      documentSnapshot.reference
                                                          .delete();
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                  },
                                  child: InkWell(
                                    child: Container(
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
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ]
                )
                ),
          ],
        )),
      ),
    );
  }
}
