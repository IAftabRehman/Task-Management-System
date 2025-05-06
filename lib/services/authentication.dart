import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationServices {
  Future<User?> registerUser(
      {required String email, required String password}) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    userCredential.user!.sendEmailVerification();
    return userCredential.user;
  }

  ///Login
  Future<User?> loginUser(
      {required String email, required String password}) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  ///Reset Password
  Future resetPassword(String email) async {
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  //LogOut
  Future<void> logoutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print("Logout Error: $e");
    }
  }

}
