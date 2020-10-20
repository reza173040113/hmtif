// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:hmtif/Views/admin/HalamanEditAspirasiAdmin.dart';
// import 'Animation/FadeAnimation.dart';
// import 'HalamanDetailAspirasi.dart';
// import 'HalamanEditAspirasi.dart';
// import 'HalamanTambahAspirasi.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp();
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     theme: ThemeData(
//         brightness: Brightness.light,
//         primaryColor: Colors.blue,
//         accentColor: Colors.cyan),
//     home: AdminAspirasi(),
//   ));
// }

// class AdminAspirasi extends StatelessWidget {
//   final controller = ScrollController();
//   double offset = 0;

//   @override
//   void initState() {
//     super.initState();
//     controller.addListener(onScroll);
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   void onScroll() {
//     setState(() {
//       offset = (controller.hasClients) ? controller.offset : 0;
//     });
//   }
//   // navigateToDetail(BuildContext context, DocumentSnapshot post) async {
//   //   Navigator.push(
//   //       context,
//   //       MaterialPageRoute(
//   //           builder: (context) => EditAspirasi(
//   //                 MyStudent: post,
//   //               )));
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         floatingActionButton: new FloatingActionButton(
//           onPressed: () {
//             Navigator.of(context).push(new MaterialPageRoute(
//                 builder: (BuildContext context) => new TambahAspirasi()));
//           },
//           child: Icon(Icons.add),
//           backgroundColor: Colors.purple,
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         bottomNavigationBar: new BottomAppBar(
//           elevation: 20,
//           color: Colors.purple,
//           child: ButtonBar(
//             children: <Widget>[],
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: new Container(
//             child: new Column(
//               children: <Widget>[
//                 SingleChildScrollView(
//                    controller : controller,
//                         scrollDirection : Axis.vertical,
                        
//                         child: Column(
//                           children: <Widget>[
//                               StreamBuilder(
//                                 stream:
//                                     Firestore.instance.collection("AspirasiMahasiswa").snapshots(),
//                                 builder: (context, snapshot) {
//                                     if (snapshot.hasData) {
//                                       return SingleChildScrollView(
                                        
//                                             child: ListView.builder(
//                                                 controller : controller,
//                                                 shrinkWrap: true,
//                                                 itemCount: snapshot.data.documents.length,
//                                                 itemBuilder: (context, index) {
                                                  
//                                                       DocumentSnapshot documentSnapshot =
//                                                           snapshot.data.documents[index];
//                                                       Map<String, dynamic> task = documentSnapshot.data();

//                                                     InkWell(
//                                                      child:  Container(
//                                                       child: Padding(
//                                                       padding: const EdgeInsets.only(bottom: 10),
//                                                         child: Container(
//                                                         child: SizedBox(
//                                                           height: 156,
//                                                           child: Stack(
//                                                         alignment: Alignment.centerLeft,
//                                                       children: <Widget>[
//                                                         Container(
                                                   
//                                                     height: 136,
//                                                     width: double.infinity,
//                                                     decoration : BoxDecoration(
//                                                         borderRadius: BorderRadius.circular(20),
//                                                         color : Colors.white,
//                                                         boxShadow: [
//                                                         BoxShadow(
//                                                           offset: Offset(0,8),
//                                                           blurRadius: 24,
//                                                           color : Colors.grey,
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Image.asset("assets/images/wear_mask.png"),
//                                                   Positioned(
//                                                     left: 130,
//                                                     child: Container(
//                                                       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                                                       height: 136,
//                                                       width: MediaQuery.of(context).size.width - 170,
//                                                       child : Column (
//                                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                         children : <Widget>[
//                                                           Text(
//                                                             documentSnapshot.data()['namaDonasi'],
//                                                             // style: kTitleTextstyle.copyWith(
//                                                             //   fontSize: 16,
//                                                             // ),
//                                                           ),
//                                                           Expanded(
//                                                             child: Text(
//                                                               documentSnapshot.data()['shortDeskripsi'],
//                                                               //  documentSnapshot.data()['danaDonasi'].toString(),
//                                                               maxLines : 4,
//                                                               overflow: TextOverflow.ellipsis,
//                                                               style: TextStyle(
//                                                                 fontSize: 12,
//                                                               ),
//                                                             ),
//                                                           ),
                                                          
                                                        
//                                                             Row(
//                                                               children: <Widget>[

//                                                                 new Text(
//                                                                   "Dana yang terkumpul",
//                                                                   style:
//                                                                       TextStyle(color: Colors.grey, fontSize: 10),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           Text(
//                                                               documentSnapshot.data()['danaDonasi'].toString(),
//                                                               //  documentSnapshot.data()['danaDonasi'].toString(),
//                                                               maxLines : 4,
//                                                               overflow: TextOverflow.ellipsis,
//                                                               style: TextStyle(color: Colors.green,
//                                                                 fontSize: 12,
//                                                             ), ), 
//                                                              new Padding(padding: EdgeInsets.all(3)),
//                                                             Stack(
//                                                               children: <Widget>[
//                                                                 Container(
//                                                                   width: 350,
//                                                                   height: 10,
//                                                                   decoration: BoxDecoration(
//                                                                       color: Colors.grey[200],
//                                                                       borderRadius: BorderRadius.circular(5)),
//                                                                 ),
//                                                                 Material(
//                                                                   borderRadius: BorderRadius.circular(5),
//                                                                   child: AnimatedContainer(
//                                                                     height: 10,
//                                                                     width: 350 * 0.5,
//                                                                     duration: Duration(milliseconds: 500),
//                                                                     decoration: BoxDecoration(
//                                                                         color: Colors.lightGreen,
//                                                                         borderRadius: BorderRadius.circular(5)),
//                                                                   ),
//                                                                 )
//                                                               ],
//                                                             ),
//                                                          SizedBox(height: 10),
//                                                         Align(
//                                                           alignment: Alignment.topRight,
//                                                                       // child: SvgPicture.asset("assets/icons/forward.svg"),
//                                                                     ),
                                                                    
//                                                       ],
//                                                             ),
//                                                     ),
                                                    
//                                                         ),
                                                        
//                                                       ],
                                                      
//                                                        ),
                                                       
//                                                   ),
//                                                   ),
                                                
                                                      
//                                                   ),
//                                           //         onTap: () async {
//                                           //           bool result = await Navigator.push(
//                                           //             context,
//                                           //               MaterialPageRoute(
//                                           //                   builder: (context) {
//                                           //     //             return DetailDonasi(
//                                           //     //               documentId:
//                                           //     //                   documentSnapshot.documentID,
//                                           //     //               namaDonasi: task['namaDonasi'],
//                                           //     //               shortDeskripsi: task['shortDeskripsi'],
//                                           //     //               danaDonasi: task['danaDonasi'],
//                                           //     // );
//                                           //   }), 
//                                           // );
//                                           //         }
//                                                   ),);
                                              
//                                                 },
                                                
//                                               ),
                                              
//                                           );
//                 // StreamBuilder(
//                 //   stream: Firestore.instance
//                 //       .collection("AspirasiMahasiswa")
//                 //       .snapshots(),
//                 //   builder: (context, snapshot) {
//                 //     if (snapshot.hasData) {
//                 //       return SingleChildScrollView(
//                 //         scrollDirection: Axis.vertical,
//                 //         child: ListView.builder(
//                 //           scrollDirection: Axis.vertical,
//                 //           shrinkWrap: true,
//                 //           itemCount: snapshot.data.documents.length,
//                 //           itemBuilder: (context, index) {
//                 //             DocumentSnapshot documentSnapshot =
//                 //                 snapshot.data.documents[index];
//                 //             Map<String, dynamic> task = documentSnapshot.data();

//                 //             return FadeAnimation(
//                 //                 1.8,
//                 //                 Card(
//                 //                   child: ListTile(
//                 //                     title:
//                 //                         Text(documentSnapshot.data()['name']),
//                 //                     // subtitle: Text("Like " +
//                 //                     //     documentSnapshot
//                 //                     //         .data()['jumlahLike']
//                 //                     //         .toString()),
//                 //                     leading: CircleAvatar(
//                 //                         child: Image(
//                 //                       image: AssetImage('img/akun.png'),
//                 //                     )),
//                 //                     trailing: PopupMenuButton(
//                 //                       itemBuilder: (BuildContext context) {
//                 //                         return List<PopupMenuEntry<String>>()
//                 //                           ..add(PopupMenuItem<String>(
//                 //                             value: 'edit',
//                 //                             child: Text('Edit'),
//                 //                           ))
//                 //                           ..add(PopupMenuItem<String>(
//                 //                             value: 'delete',
//                 //                             child: Text('Delete'),
//                 //                           ))
//                 //                           ..add(PopupMenuItem<String>(
//                 //                             value: 'post',
//                 //                             child: Text('Ubah Status'),
//                 //                           ));
//                 //                       },
//                 //                       onSelected: (String value) async {
//                 //                         if (value == 'edit') {
//                 //                           bool result = await Navigator.push(
//                 //                             context,
//                 //                             MaterialPageRoute(
//                 //                                 builder: (context) {
//                 //                               return EditAspirasiAdmin(
//                 //                                 documentId:
//                 //                                     documentSnapshot.documentID,
//                 //                                 name: task['name'],
//                 //                                 deskripsi: task['deskripsi'],
//                 //                                 jumlahLike: task['jumlahLike'],
//                 //                               );
//                 //                             }),
//                 //                           );
//                 //                         } else if (value == 'post') {
//                 //                           showDialog(
//                 //                             context: context,
//                 //                             builder: (BuildContext context) {
//                 //                               return AlertDialog(
//                 //                                 title: Text(documentSnapshot
//                 //                                     .data()['name']),
//                 //                                 content: Text(documentSnapshot
//                 //                                     .data()['deskripsi']),
//                 //                                 actions: <Widget>[
//                 //                                   FlatButton(
//                 //                                     child: Text('Post'),
//                 //                                     onPressed: () {
//                 //                                       String documentId =
//                 //                                           documentSnapshot
//                 //                                               .documentID;
//                 //                                       String name =
//                 //                                           documentSnapshot
//                 //                                               .data()['name'];
//                 //                                       String deskripsi =
//                 //                                           documentSnapshot
//                 //                                                   .data()[
//                 //                                               'deskripsi'];

//                 //                                       DocumentReference
//                 //                                           documentReference =
//                 //                                           FirebaseFirestore
//                 //                                               .instance
//                 //                                               .collection(
//                 //                                                   "Aspirasi")
//                 //                                               .document(
//                 //                                                   documentId);
//                 //                                       Map<String, dynamic>
//                 //                                           students = {
//                 //                                         "name": name,
//                 //                                         "deskripsi": deskripsi,
//                 //                                         "jumlahLike": 0,
//                 //                                       };

//                 //                                       documentReference
//                 //                                           .setData(students)
//                 //                                           .whenComplete(() {
//                 //                                         print("$name created");
//                 //                                       });
                                                     
//                 //                                     },
//                 //                                   ),
//                 //                                 ],
//                 //                               );
//                 //                                showDialog(
//                 //                             context: context,
//                 //                             builder: (BuildContext context) {return AlertDialog(
//                 //                                 title: Text('Aspirasi dan keluhan berhasil dipost!!!'),
//                 //                                 actions: <Widget>[
                                                  
//                 //                                   FlatButton(
//                 //                                     child: Text('Ok'),
//                 //                                     onPressed: () {
//                 //                                       documentSnapshot.reference
//                 //                                           .delete();
//                 //                                       Navigator.pop(context);
//                 //                                     },
//                 //                                   ),
//                 //                                 ],
//                 //                               );
//                 //                             }
//                 //                                );
//                 //                             },
//                 //                           );
//                 //                         } else if (value == 'delete') {
//                 //                           showDialog(
//                 //                             context: context,
//                 //                             builder: (BuildContext context) {
//                 //                               return AlertDialog(
//                 //                                 title: Text('Yakin mau hapus?'),
//                 //                                 actions: <Widget>[
//                 //                                   FlatButton(
//                 //                                     child: Text('Tidak'),
//                 //                                     onPressed: () {
//                 //                                       Navigator.pop(context);
//                 //                                     },
//                 //                                   ),
//                 //                                   FlatButton(
//                 //                                     child: Text('Ya'),
//                 //                                     onPressed: () {
//                 //                                       documentSnapshot.reference
//                 //                                           .delete();
//                 //                                       Navigator.pop(context);
//                 //                                     },
//                 //                                   ),
//                 //                                 ],
//                 //                               );
//                 //                             },
//                 //                           );
//                 //                         }
//                 //                       },
//                 //                       child: Icon(
//                 //                         Icons.more_vert,
//                 //                         color: Colors.black,
//                 //                       ),
//                 //                     ),
//                 //                     // onTap: () => navigateToDetail(context,
//                 //                     //     snapshot.data.documents[index]),
//                 //                   ),
//                 //                 ));
//                 //           },
//                 //         ),
//                 //       );
//                 //     } else {
//                 //       return Container();
//                 //     }
//                 //   },
//                 // ),
//               ],
//             ),
//           ),
//         ));
//   }
// }
