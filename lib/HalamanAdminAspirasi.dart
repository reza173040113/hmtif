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
  // navigateToDetail(BuildContext context, DocumentSnapshot post) async {
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => EditAspirasi(
  //                 MyStudent: post,
  //               )));
  // }

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
                            
                            DocumentSnapshot documentSnapshot =
                                snapshot.data.documents[index];
                            Map<String, dynamic> task = documentSnapshot.data();

                            return FadeAnimation(
                                1.8,
                                Card(
                                  child: ListTile(
                                    title:
                                        Text(documentSnapshot.data()['name']),
                                    subtitle: Text("Like " +
                                        documentSnapshot.data()['jumlahLike'].toString()),
                                    leading: CircleAvatar(
                                        child: Image(
                                      image: AssetImage('img/akun.png'),
                                    )),
                                    trailing: Wrap(
                                      spacing: 12,
                                      children: <Widget>[
                                        new IconButton(
                                            icon: new Icon(Icons.edit),
                                            onPressed: () async {
                                              
                                              bool result = await Navigator.push(context, MaterialPageRoute(builder: (context){
                                                return EditAspirasi(
                                                  documentId: documentSnapshot.documentID,
                                                  name: task['name'],
                                                  deskripsi: task['deskripsi'],
                                                  jumlahLike: task['jumlahLike'],
                                                );
                                              }
                                              ),
                                              );
                                            }
                                            ),
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
