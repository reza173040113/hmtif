import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager{
  final CollectionReference studentList = Firestore.instance.collection("MyStudents");

  // Future getUsersList() async {
  //   List itemsList= [];
  //   try{
  //     await studentList.getDocuments().then((querySnapshot) {
  //       querySnapshot.documents.forEach((element){
  //         itemsList.add(element.data);
  //       });
  //     });
  //     return itemsList;
  //   }catch(e){
  //     print(e.toString());
  //     return null;
  //   }
  // }
}