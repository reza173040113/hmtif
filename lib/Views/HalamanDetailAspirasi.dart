// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hmtif/Animation/FadeAnimation.dart';

import 'HalamanAspirasi.dart';
import '../HalamanUtama.dart';

class DetailAspirasi extends StatefulWidget {
  // final DocumentSnapshot MyStudent;
  // DetailAspirasi({this.MyStudent});
  final String name, deskripsi, documentId, status;
  final int jumlahLike;
  DetailAspirasi({
    // @required this.isEdit,
    @required this.documentId,
    @required this.name,
    @required this.deskripsi,
    @required this.jumlahLike,
    @required this.status,
  });
  @override
  _DetailAspirasiState createState() => _DetailAspirasiState();
}

class _DetailAspirasiState extends State<DetailAspirasi> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;
    var delay = 1.5;
    final progress = widget.jumlahLike;
    return Scaffold(
      backgroundColor: Color.fromARGB(200, 27, 67, 50),
      appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new Home()));
              })),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  )),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 0),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Stack(children: <Widget>[
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Image.asset("img/orang.jpg"),
                                  Center(
                                    child: Text(
                                      "Detail Aspirasi dan Keluhan",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 27,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  new Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 15, 0, 0)),
                                          
                                  Row(
                                    children: <Widget>[
                                      Text(widget.name,
                                          style: TextStyle(
                                              color:
                                                  Color.fromRGBO(49, 39, 79, 1),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)),
                                      new Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 10, 0, 0)),
                                      //  Container(
                                      //     decoration: BoxDecoration(
                                      //         color: Colors.lightBlue,
                                      //         borderRadius: BorderRadius.only(
                                      //           bottomLeft: Radius.circular(5),
                                      //           bottomRight: Radius.circular(5),
                                      //           topLeft: Radius.circular(5),
                                      //           topRight: Radius.circular(5),
                                      //         )),
                                      //     child: Text(widget.status,
                                      //         style: TextStyle(
                                      //             color: Colors.white,
                                      //             fontSize: 11)))
                                    ],
                                  ),
                                  new Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 10, 0, 0)),
                                  FadeAnimation(
                                      1.5,
                                      Row(
                                        children: <Widget>[
                                          new Text(
                                            widget.jumlahLike.toString(),
                                            style:
                                                TextStyle(color: Colors.green,fontWeight: FontWeight.bold ),
                                          ),
                                          new Text(
                                            " mahasiswa telah menyetujui aspirasi dan keluhan ini",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10),
                                          ),
                                        ],
                                      )),
                                  new Padding(padding: EdgeInsets.all(3)),
                                  FadeAnimation(
                                      1.5,
                                      Stack(
                                        children: <Widget>[
                                          Container(
                                            width: 350,
                                            height: 10,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                          Material(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: AnimatedContainer(
                                              height: 10,
                                              width: progress*1.0,
                                              duration:
                                                  Duration(milliseconds: 100),
                                              decoration: BoxDecoration(
                                                  color: Colors.lightGreen,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                            ),
                                          )
                                        ],
                                      )),
                                  new Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 10, 0, 0)),
                                  FadeAnimation(
                                      1.5,
                                      Text(
                                        "Deskripsi",
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(49, 39, 79, 1),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )),
                                  FadeAnimation(
                                      1.5,
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        child: Text(
                                          widget.deskripsi,
                                          style: TextStyle(
                                              color:
                                                  Color.fromRGBO(49, 39, 79, 1),
                                              fontSize: 12),
                                        ),
                                      )),
                                ]))
                      ]),
                    )
                  ]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //
                    new Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),

                    FadeAnimation(
                        2,
                        GestureDetector(
                          onTap: () {
                            String documentId = widget.documentId;
                            String name = widget.name;
                            String deskripsi = widget.deskripsi;
                            String status = widget.status;

                            int jumlahLike =
                                int.parse(widget.jumlahLike.toString());
                            DocumentReference documentReference =
                                FirebaseFirestore.instance
                                    .collection("Aspirasi")
                                    .document(documentId);
                            Map<String, dynamic> students = {
                              "name": name,
                              "deskripsi": deskripsi,
                              "jumlahLike": jumlahLike + 1,
                              "status":status,
                            };

                            documentReference
                                .setData(students)
                                .whenComplete(() {
                              print("$name updated");
                            });
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                        'Terimakasih sudah menyetujui aspirasi dan keluhan ini'),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              new MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          new Home()));
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(colors: [
                                  Color.fromARGB(255, 255, 190, 11)
                                      .withOpacity(0.9),
                                  Color.fromARGB(255, 255, 190, 11)
                                      .withOpacity(0.9),
                                ])),
                            child: Center(
                              child: Text(
                                "Setuju",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
