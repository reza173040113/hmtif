import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ModelDatabase{

  Future<DocumentSnapshot> saveData(String name,Map<String, dynamic> aspirasi) async {
    await Firebase.initializeApp();
    DocumentReference documentReference =
        Firestore.instance.collection("AspirasiMahasiswa").document();

    //createMap
    // Map<String, dynamic> aspirasi = {
    //   "name": name,
    //   "deskripsi": deskripsi,
    // };

    documentReference.setData(aspirasi).whenComplete(() {
      print("$name created");
    });
  }
  Future<DocumentSnapshot> postData(String name,Map<String, dynamic> aspirasi) async {
    await Firebase.initializeApp();
    DocumentReference documentReference =
        Firestore.instance.collection("Aspirasi").document();

    //createMap
    // Map<String, dynamic> aspirasi = {
    //   "name": name,
    //   "deskripsi": deskripsi,
    // };

    documentReference.setData(aspirasi).whenComplete(() {
      print("$name created");
    });
  }
}