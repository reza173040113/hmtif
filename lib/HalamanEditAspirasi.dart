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
    home: EditAspirasi(),
  ));
}

class EditAspirasi extends StatefulWidget {
  final String name, studentId, studyProgramId, documentId;
  // final bool isEdit;

  final double studentGpa;
  EditAspirasi({
    // @required this.isEdit,
    @required this.documentId,
    @required this.name,
    @required this.studentId,
    @required this.studyProgramId,
    @required this.studentGpa,
  });
  // EditAspirasi(
  //     String name, String studentId, String studyProgramId, double studentGpa) {
  //   this.name = name;
  //   this.studentId = studentId;
  //   this.studyProgramId = studyProgramId;
  //   this.studentGpa = studentGpa;
  // }
  // EditAspirasi(this.name,this.studentId,this.studyProgramId,this.studentGpa);

  //final DocumentSnapshot MyStudent;
  // EditAspirasi({this.MyStudent});
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  _EditAspirasiState createState() => _EditAspirasiState();
}

class _EditAspirasiState extends State<EditAspirasi> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerStudentId = TextEditingController();
  TextEditingController controllerStudyProgramId = TextEditingController();
  TextEditingController controllerStudentGpa = TextEditingController();
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
        Firestore.instance.collection("MyStudents").document();

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
    // Firestore.instance.
    // }
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
    // controllerName = new TextEditingController(
    //     text: widget.MyStudent.data()["name"].toString());
    // controllerStudentId = new TextEditingController(
    //     text: widget.MyStudent.data()["studentId"].toString());
    // controllerStudyProgramId = new TextEditingController(
    //     text: widget.MyStudent.data()["studyProgramId"].toString());
    // controllerStudentGpa = new TextEditingController(
    //     text: widget.MyStudent.data()["studentGpa"].toString());
    controllerName.text = widget.name.toString();
    controllerStudentId.text = widget.studentId.toString();
    controllerStudyProgramId.text = widget.studyProgramId.toString();
    controllerStudentGpa.text = widget.studentGpa.toString();

    // controllerStudentId = new TextEditingController(
    //     text: widget.studentId
    // controllerStudyProgramId = new TextEditingController(
    //     text: widget.MyStudent.data()["studyProgramId"].toString());
    // controllerStudentGpa = new TextEditingController(
    //     text: widget.MyStudent.data()["studentGpa"].toString());

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
                    controller: controllerName,
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
                    controller: controllerStudentId,
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
                    controller: controllerStudyProgramId,
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
                    controller: controllerStudentGpa,
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
                          onPressed: () async {
                            FirebaseFirestore _firestore =
                                FirebaseFirestore.instance;

                            //updateData();
                            String documentId = widget.documentId;
                            String name = controllerName.text;
                            String studentId = controllerStudentId.text;
                            String studyProgramId =
                                controllerStudyProgramId.text;
                            double studentGpa = double.parse(
                                controllerStudentGpa.text.toString());

                            DocumentReference documentReference =
                                FirebaseFirestore.instance
                                    .collection("MyStudents")
                                    .document(
                                        documentId);
                            Map<String, dynamic> students = {
                              "name": name,
                              "studentId": studentId,
                              "studyProgramId": studyProgramId,
                              "studentGpa": studentGpa,
                            };

                            documentReference
                                .setData(students)
                                .whenComplete(() {
                              print("$name updated");
                            });
                            // FirebaseFirestore.instance.runTransaction((transaction) async {
                            //   DocumentSnapshot task =
                            //       await transaction.get(documentReference);
                            //   await transaction.update(task.reference, {
                            //     "name": name,
                            //     "studentId": studentId,
                            //     "studyProgramId": studyProgramId,
                            //     "studentGpa": studentGpa
                            //   });
                            // print(task);
                            // if (task.exists) {
                            //   await transaction.update(
                            //       documentReference, <String, dynamic>{
                            //     'name': name,
                            //     'studentId': studentId,
                            //     'studyProgramId': studyProgramId,
                            //     'studentGpa': studentGpa,
                            //   });
                            // }
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
