import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hmtif/Controller/ControllerDatabase.dart';
import 'package:hmtif/HalamanUtama.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

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
  ControllerDatabase database = new ControllerDatabase();
  String name, deskripsi, status = "belum diproses";
  Timestamp tanggal = Timestamp.now();
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
        Firestore.instance.collection("AspirasiMahasiswa").document();

    //createMap
    Map<String, dynamic> aspirasi = {
      "name": name,
      "deskripsi": deskripsi,
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
          backgroundColor: Color.fromARGB(237, 8, 28, 21),
        ),
        backgroundColor: Colors.white,
        body: Container(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(children: <Widget>[
                Image.asset("img/6558.jpg"),
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
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Aspirasi dan Keluhan tidak boleh kosong!';
                      }
                      return null;
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
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Deskripsi tidak boleh kosong!';
                      }
                      return null;
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
                          child: Text("Tambah"),
                          textColor: Colors.white,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NetworkGiffyDialog(
                                  image: Image.asset("img/6558.jpg"),
                                  title: Text(
                                      "Yakin ingin menyampaikan aspirasi ini?",textAlign: TextAlign.center,),
                                  onOkButtonPressed: () {
                                    database.createData(name, deskripsi);
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return NetworkGiffyDialog(
                                            image: Image.asset("img/centang.jpg"),
                                            title: Text(
                                                'Aspirasi dan keluhan berhasil ditambahkan!!!',textAlign: TextAlign.center,),
                                            onlyOkButton: true,
                                            onOkButtonPressed: () {
                                              Navigator.of(context).push(
                                                  new MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          new Home()));
                                            },
                                          );
                                        });
                                  },
                                  onCancelButtonPressed: () {
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            );
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
