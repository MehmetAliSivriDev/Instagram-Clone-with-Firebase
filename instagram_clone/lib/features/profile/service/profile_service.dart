import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IProfileService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<int> getCurrentUserPostCount();
}

class ProfileService extends IProfileService {
  @override
  Future<int> getCurrentUserPostCount() async {
    QuerySnapshot postSnapshot = await _fireStore
        .collection("posts")
        .where("uid", isEqualTo: _auth.currentUser!.uid)
        .get();

    int postCount = postSnapshot.docs.length;

    return postCount;
  }
}
