import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hmtif/Model/ModelDatabase.dart';

class ControllerDatabase {
  ModelDatabase modelDatabase = new ModelDatabase();
  Future<DocumentSnapshot> createData(String name, String deskripsi) async {
    await Firebase.initializeApp();
    // DocumentReference documentReference =
    //     Firestore.instance.collection("AspirasiMahasiswa").document();

    //createMap
    Map<String, dynamic> aspirasi = {
      "name": name,
      "deskripsi": deskripsi,
    };
    modelDatabase.saveData(name, aspirasi);

    // documentReference.setData(aspirasi).whenComplete(() {
    //   print("$name created");
    // });
  }

  Future<DocumentSnapshot> post(String name, String deskripsi,String documentId) async {
    await Firebase.initializeApp();
    // DocumentReference documentReference =
    //     FirebaseFirestore.instance.collection("Aspirasi").document();
    Map<String, dynamic> postAspirasi = {
      "name": name,
      "deskripsi": deskripsi,
      "jumlahLike": 0,
      "documentId" : documentId,
    };
      modelDatabase.postData(name, postAspirasi);

    // documentReference.setData(postAspirasi).whenComplete(() {
    //   print("$name created");
    // });
  }
}
