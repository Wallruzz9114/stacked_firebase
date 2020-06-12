import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuthInstance = FirebaseAuth.instance;

  Future<dynamic> signIn({
    @required String email,
    @required String password,
  }) async {
    try {
      final AuthResult authResult =
          await _firebaseAuthInstance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future<dynamic> signUpWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      final AuthResult authResult =
          await _firebaseAuthInstance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future<bool> isUserLoggedIn() async {
    final FirebaseUser user = await _firebaseAuthInstance.currentUser();
    return user != null;
  }
}
