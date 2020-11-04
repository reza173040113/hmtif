import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ModelDatabase{

  Future<DocumentSnapshot> saveData(String name,Map<String, dynamic> aspirasi) async {
    await Firebase.initializeApp();
    DocumentReference documentReference =
        Firestore.instance.collection("AspirasiMahasiswa").document();


    documentReference.setData(aspirasi).whenComplete(() {
      print("$name created");
    });
  }
  Future<DocumentSnapshot> saveAspirasi(String name,String documentId,Map<String, dynamic> aspirasi) async {
    await Firebase.initializeApp();
    DocumentReference documentReference =
        Firestore.instance.collection("Aspirasi").document(documentId);


    documentReference.setData(aspirasi).whenComplete(() {
      print("$name created");
    });
  }
}