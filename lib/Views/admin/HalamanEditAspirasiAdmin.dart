import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        accentColor: Colors.cyan),
    home: EditAspirasiAdmin(),
  ));
}

class EditAspirasiAdmin extends StatefulWidget {
  final String name, deskripsi, documentId, status;
  // final bool isEdit;

  final int jumlahLike;
  EditAspirasiAdmin({
    // @required this.isEdit,
    @required this.documentId,
    @required this.name,
    @required this.deskripsi,
    @required this.jumlahLike,
    @required this.status,
  });

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  _EditAspirasiState createState() => _EditAspirasiState();
}

class _EditAspirasiState extends State<EditAspirasiAdmin> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerDeskripsi = TextEditingController();
  String name, studentId, studyProgramId;
  double studentGpa;
  getStudentName(name) {
    this.name = name;
  }

  getStudentId(studentId) {
    this.studentId = studentId;
  }

  getStudyProgramId(studyProgramId) {
    this.studyProgramId = studyProgramId;
  }

  getStudentGpa(studentGpa) {
    this.studentGpa = double.parse(studentGpa);
  }

  @override
  void initState() {
    super.initState();

    controllerName.text = widget.name.toString();
    controllerDeskripsi.text = widget.deskripsi.toString();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Halaman Edit Aspirasi"),
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextFormField(
                    controller: controllerName,
                    decoration: InputDecoration(
                        labelText: "Aspirasi dan Keluhan",
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0))),
                    onChanged: (String name) {
                      getStudentName(name);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextFormField(
                    controller: controllerDeskripsi,
                    decoration: InputDecoration(
                        labelText: "Deskripsi",
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0))),
                    onChanged: (String studentId) {
                      getStudentId(studentId);
                    },
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                          color: Colors.yellow,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Text("Update"),
                          textColor: Colors.white,
                          onPressed: () async {
                            FirebaseFirestore _firestore =
                                FirebaseFirestore.instance;

                            //updateData();
                            String documentId = widget.documentId;
                            String name = controllerName.text;
                            String deskripsi = controllerDeskripsi.text;
                            int jumlahLike = widget.jumlahLike;
                            String status = widget.status;
                            DocumentReference documentReference =
                                FirebaseFirestore.instance
                                    .collection("Aspirasi")
                                    .document(documentId);
                            Map<String, dynamic> students = {
                              "name": name,
                              "deskripsi": deskripsi+" Catatan: dirubah karena aspirasi dan keluhan terdapat kata-kata yang kurang berkenan.",
                              "jumlahLike": jumlahLike,
                              "status": status,
                            };

                            documentReference
                                .setData(students)
                                .whenComplete(() {
                              print("$name updated");
                            });
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
