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

  Future<Map> readData() async {
    await Firebase.initializeApp();
    Future<DocumentSnapshot> documentReference =
        Firestore.instance.collection("MyStudents").document(name).get();

    documentReference.then((datasnapshot) => {
          print(datasnapshot.data()['name']),
          print(datasnapshot.data()['studentId']),
          print(datasnapshot.data()['studyProgramId']),
          print(datasnapshot.data()['studentGpa'])

          // print(datasnapshot.data(["studentId"]));
        });
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

  // List studentList = [];

  @override
  void initState() {
    //createData();
    //readData();
    super.initState();
    //fetchDatabaseList();
  }

  // fetchDatabaseList() async {
  //   dynamic resultant = await DatabaseManager().getUsersList();

  //   if (resultant == null) {
  //     print('Unable to retrieve');
  //   } else {
  //     setState(() {
  //       studentList = resultant;
  //     });
  //   }
  // }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("My FLutter College"),
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
                ),
                StreamBuilder(
                  stream:
                      Firestore.instance.collection("MyStudents").snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          // Firebase.initializeApp();
                          DocumentSnapshot documentSnapshot =
                              snapshot.data.documents[index];
                          return Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(documentSnapshot.data()["name"]),
                              ),
                              Expanded(
                                child:
                                    Text(documentSnapshot.data()["studentId"]),
                              ),
                              Expanded(
                                child: Text(
                                    documentSnapshot.data()["studyProgramId"]),
                              ),
                              Expanded(
                                child: Text(documentSnapshot
                                    .data()["studentGpa"]
                                    .toString()),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                )
              ]),
            ),
          ),
        ));
  }
}
