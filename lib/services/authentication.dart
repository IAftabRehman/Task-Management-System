import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationServices {
  Future<User?> registerUser({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    userCredential.user!.sendEmailVerification();
    return userCredential.user;
  }
}
