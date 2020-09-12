// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Animation/FadeAnimation.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp();
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     theme: ThemeData(
//         brightness: Brightness.light,
//         primaryColor: Colors.blue,
//         accentColor: Colors.cyan),
//     home: DetailAspirasi(),
//   ));
// }

// class DetailAspirasi extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: new Center(
//         child: new Column(
//           children: <Widget>[
//             SingleChildScrollView(
//               scrollDirection: Axis.vertical,
//               child: StreamBuilder(
//                 stream: Firestore.instance.collection("MyStudents").snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     return ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: snapshot.data.documents.length,
//                       itemBuilder: (context, index) {
//                         // Firebase.initializeApp();
//                         DocumentSnapshot documentSnapshot =
//                             snapshot.data.documents[index];
//                         return Card(
//                           child: ListTile(
//                             title: Text(documentSnapshot.data()['name']),
//                             subtitle:
//                                 Text(documentSnapshot.data()['studentId']),
//                             leading: CircleAvatar(
//                               child: Image(image: AssetImage('img/akun.png'),)
//                             ),

//                           ),
//                         );
//                       },
//                     );
//                   }
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
class DetailAspirasi extends StatefulWidget {
  final DocumentSnapshot MyStudent;
  DetailAspirasi({this.MyStudent});
  @override
  _DetailAspirasiState createState() => _DetailAspirasiState();
}

class _DetailAspirasiState extends State<DetailAspirasi> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 400,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -40,
                    height: 400,
                    width: width,
                    child: FadeAnimation(
                        1,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('img/background-1.png'),
                                  fit: BoxFit.fill)),
                        )),
                  ),
                  Positioned(
                    height: 400,
                    width: width + 20,
                    child: FadeAnimation(
                        1.3,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('img/background-2.png'),
                                  fit: BoxFit.fill)),
                        )),
                  ),
                  Positioned(
                    child: FadeAnimation(
                        1.6,
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text(
                              "Detail Aspirasi dan Keluhan",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimation(
                        1.5,
                        Text(
                          "Deskripsi",
                          style: TextStyle(
                              color: Color.fromRGBO(49, 39, 79, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                        ),
                        new Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                        FadeAnimation(
                        1.5,
                        Text(
                          widget.MyStudent.data()["name"],
                          style: TextStyle(
                              color: Color.fromRGBO(49, 39, 79, 1),
                              fontSize: 12),
                        )
                        ),
                  ]),
            ),
            // FadeAnimation(
            //     1.8,
            //     Card(
            //         child: ListTile(
            //             title: Text(widget.MyStudent.data()["name"])))),
          ],
        ),
      ),
    );
  }
}
