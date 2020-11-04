import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hmtif/Model/ModelDatabase.dart';

class ControllerDatabase {
  ModelDatabase modelDatabase = new ModelDatabase();
  Future<DocumentSnapshot> createData(String name, String deskripsi) async {
    await Firebase.initializeApp();

    Map<String, dynamic> aspirasi = {
      "name": name,
      "deskripsi": deskripsi,
    };
    modelDatabase.saveData(name, aspirasi);
  }

  Future<DocumentSnapshot> post(
      String name, String deskripsi, String documentId) async {
    await Firebase.initializeApp();

    Map<String, dynamic> postAspirasi = {
      "name": name,
      "deskripsi": deskripsi,
      "jumlahLike": 0,
    };
    modelDatabase.saveAspirasi(name,documentId, postAspirasi);
  }

  Future<DocumentSnapshot> updateJumlah(
      String name, String deskripsi, int jumlahLike, String documentId) async {
    await Firebase.initializeApp();

    Map<String, dynamic> updateJumlahLike = {
      "name": name,
      "deskripsi": deskripsi,
      "jumlahLike": jumlahLike + 1,
    };
    modelDatabase.saveAspirasi(name,documentId, updateJumlahLike);
  }
}
