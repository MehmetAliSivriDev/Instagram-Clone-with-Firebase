import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../model/user_model.dart';
import '../../product/util/custom_exception.dart';

abstract class IBaseService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<UserModel> getUser();
  Future<String> uploadImageToStorage(
      {required String name, required File file});
}

class BaseService extends IBaseService {
  @override
  Future<UserModel> getUser() async {
    try {
      final user = await _fireStore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .get();

      final snapuser = user.data()!;
      return UserModel(
          bio: snapuser["bio"],
          email: snapuser["email"],
          followers: snapuser["followers"],
          following: snapuser["following"],
          profile: snapuser["profile"],
          username: snapuser["username"]);
    } on FirebaseException catch (e) {
      throw CustomException(e.message.toString());
    }
  }

  @override
  Future<String> uploadImageToStorage(
      {required String name, required File file}) async {
    if (file.existsSync()) {
      String fileName = _auth.currentUser!.uid + file.path.split('/').last;

      Reference ref = _storage.ref().child(name).child(fileName);
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } else {
      return "";
    }
  }
}
