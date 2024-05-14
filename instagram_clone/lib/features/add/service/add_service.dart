import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../core/service/base_service.dart';
import 'package:uuid/uuid.dart';

import '../../../core/model/user_model.dart';

abstract class IAddService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  IBaseService _baseService = BaseService();

  Future<bool> createPost(
      {required String postImage,
      required String caption,
      required String location});
}

class AddService extends IAddService {
  @override
  Future<bool> createPost(
      {required String postImage,
      required String caption,
      required String location}) async {
    var uid = Uuid().v4();
    DateTime date = DateTime.now();
    UserModel user = await _baseService.getUser();
    await _fireStore.collection("posts").doc(uid).set({
      "postImage": postImage,
      "username": user.username,
      "profileImage": user.profile,
      "caption": caption,
      "location": location,
      "uid": _auth.currentUser!.uid,
      "postId": uid,
      "like": [],
      "time": date
    });

    return true;
  }
}
