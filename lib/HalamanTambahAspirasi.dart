import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'DatabaseManager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        accentColor: Colors.cyan),
    home: TambahAspirasi(),
  ));
}

class TambahAspirasi extends StatefulWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  _TambahAspirasiState createState() => _TambahAspirasiState();
}

class _TambahAspirasiState extends State<TambahAspirasi> {
  String name, deskripsi;
  int jumlahLike;
  getAspirasiName(name) {
    this.name = name;
  }

  getAspirasiDeskripsi(deskripsi) {
    this.deskripsi = deskripsi;
  }

 

  getAspirasiLike(jumlahLike) {
    this.jumlahLike = int.parse(jumlahLike);
  }

  Future<DocumentSnapshot> createData() async {
    await Firebase.initializeApp();
    DocumentReference documentReference =
        Firestore.instance.collection("Aspirasi").document();

    //createMap
    Map<String, dynamic> aspirasi = {
      "name": name,
      "deskripsi": deskripsi,
      "jumlahLike": 0,
    };

    documentReference.setData(aspirasi).whenComplete(() {
      print("$name created");
    });
  }

 

  @override
  void initState() {
    
    super.initState();
  }

  

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Halaman Tambah Aspirasi"),
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Aspirasi dan Keluhan",
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0))),
                    onChanged: (String name) {
                      getAspirasiName(name);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Deskripsi",
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0))),
                    onChanged: (String deskripsi) {
                      getAspirasiDeskripsi(deskripsi);
                    },
                  ),
                ),
                
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Text("Create"),
                          textColor: Colors.white,
                          onPressed: () {
                            createData();
                          }),
                      
                    ],
                  ),
                ),
               
              ]),
            ),
          ),
        ));
  }
}
