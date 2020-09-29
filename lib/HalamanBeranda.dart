
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'HalamanDetailAspirasi.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/detail': (context) => DetailAspirasi(),
    },
    theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        accentColor: Colors.cyan),
    home: Beranda(),
  ));
}

class Beranda extends StatelessWidget {
  // navigateToDetail(BuildContext context,DocumentSnapshot post) async{
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => DetailAspirasi(
  //                 MyStudent: post,
  //               )));
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Center(
        child: new Column(
          children: <Widget>[
            Text("Halaman Beranda"),
            // SingleChildScrollView(
            //   scrollDirection: Axis.vertical,
            //   child: StreamBuilder(
            //     stream: Firestore.instance.collection("MyStudents").snapshots(),
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData) {
            //         return SingleChildScrollView(
            //           scrollDirection: Axis.vertical,
            //           child: ListView.builder(
            //             shrinkWrap: true,
            //             itemCount: snapshot.data.documents.length,
            //             itemBuilder: (context, index) {
            //               // Firebase.initializeApp();
            //               DocumentSnapshot documentSnapshot =
            //                   snapshot.data.documents[index];
            //               return SingleChildScrollView(
            //                 scrollDirection: Axis.vertical,
            //                 child: Card(
            //                   child: ListTile(
            //                     title: Text(documentSnapshot.data()['name']),
            //                     subtitle:
            //                         Text(documentSnapshot.data()['studentId']),
            //                     leading: CircleAvatar(
            //                         child: Image(
            //                       image: AssetImage('img/akun.png'),
            //                     )),
            //                     trailing: Icon(Icons.more_vert),
            //                     isThreeLine: true,
            //                     onTap: () => navigateToDetail(context,
            //                         snapshot.data.documents[index]),
            //                   ),
            //                 ),
            //               );
            //             },
            //           ),
            //         );
            //       }
            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
