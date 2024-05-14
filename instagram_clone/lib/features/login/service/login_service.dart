import 'package:firebase_auth/firebase_auth.dart';

abstract class ILoginService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> login({required String email, required String password});
}

class LoginService extends ILoginService {
  @override
  Future<bool> login({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      return true;
    } on FirebaseException {
      return false;
    }
  }
}
