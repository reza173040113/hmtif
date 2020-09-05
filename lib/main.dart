import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        accentColor: Colors.cyan),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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

  Future<DocumentSnapshot> createData() async {
    await Firebase.initializeApp();
    DocumentReference documentReference =
        Firestore.instance.collection("MyStudents").document(name);

    //createMap
    Map<String, dynamic> students = {
      "name": name,
      "studentId": studentId,
      "studyProgramId": studyProgramId,
      "studentGpa": studentGpa
    };

    documentReference.setData(students).whenComplete(() {
      print("$name created");
    });
  }

  Future readData() async {
    await Firebase.initializeApp();
    Future<DocumentSnapshot> documentReference =
        Firestore.instance.collection("MyStudents").document(name).get();

    // documentReference.then(( datasnapshot) => {
    //   print(datasnapshot.data(["name"]));
    // });
  }

  Future<DocumentSnapshot> updateData() async {
    await Firebase.initializeApp();
    DocumentReference documentReference =
        Firestore.instance.collection("MyStudents").document(name);

    //createMap
    Map<String, dynamic> students = {
      "name": name,
      "studentId": studentId,
      "studyProgramId": studyProgramId,
      "studentGpa": studentGpa
    };

    documentReference.setData(students).whenComplete(() {
      print("$name updated");
    });
  }

  Future<DocumentSnapshot> deleteData() async {
    await Firebase.initializeApp();
    DocumentReference documentReference =
        Firestore.instance.collection("MyStudents").document(name);

    documentReference.delete().whenComplete(() {
      print("$name deleted");
    });
  }

  @override
  void initState() {
    createData();
    readData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("My FLutter College"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Name",
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
                    decoration: InputDecoration(
                        labelText: "Student ID",
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0))),
                    onChanged: (String studentId) {
                      getStudentId(studentId);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Study Program ID",
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0))),
                    onChanged: (String studyProgramId) {
                      getStudyProgramId(studyProgramId);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "GPA",
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0))),
                    onChanged: (String gpa) {
                      getStudentGpa(gpa);
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
                      RaisedButton(
                          color: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Text("Read"),
                          textColor: Colors.white,
                          onPressed: () {
                            readData();
                          }),
                      RaisedButton(
                          color: Colors.yellow,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Text("Update"),
                          textColor: Colors.white,
                          onPressed: () {
                            updateData();
                          }),
                      RaisedButton(
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Text("Delete"),
                          textColor: Colors.white,
                          onPressed: () {
                            deleteData();
                          })
                    ],
                  ),
                )
              ]),
            ),
          ),
        ));
  }
}
