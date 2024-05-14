import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../product/util/custom_exception.dart';

abstract class ISignupService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  //Auth Methods
  Future<void> signup(
      {required String email,
      required String password,
      required String passwordConfirm,
      required String username,
      required String bio,
      required File profile});

  //Storage Methods
  Future<String> uploadImageToStorage(
      {required String name, required File file});

  //FireStore Methods
  Future<bool> createUser(
      {required String email,
      required String username,
      required String bio,
      required String profile});
}

class SignupService extends ISignupService {
  @override
  Future<void> signup(
      {required String email,
      required String password,
      required String passwordConfirm,
      required String username,
      required String bio,
      required File profile}) async {
    String URL;
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty) {
        if (password == passwordConfirm) {
          await _auth.createUserWithEmailAndPassword(
              email: email, password: password);

          if (profile != File("")) {
            URL = await uploadImageToStorage(name: 'Profile', file: profile);
          } else {
            URL = '';
          }

          await createUser(
              email: email,
              username: username,
              bio: bio,
              profile: URL == ''
                  ? "https://firebasestorage.googleapis.com/v0/b/instagramclone-bcd7d.appspot.com/o/Profile%2Fdefault_user.png?alt=media&token=08b3b867-1494-4b18-953b-fa0476b13111"
                  : URL);
        } else {
          throw CustomException("Password and confirm password should be same");
        }
      } else {
        throw CustomException("Enter all fields");
      }
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

  @override
  Future<bool> createUser(
      {required String email,
      required String username,
      required String bio,
      required String profile}) async {
    await _fireStore.collection('users').doc(_auth.currentUser!.uid).set({
      'email': email,
      'username': username,
      'bio': bio,
      'profile': profile,
      'followers': [],
      'following': []
    });

    return true;
  }
}
