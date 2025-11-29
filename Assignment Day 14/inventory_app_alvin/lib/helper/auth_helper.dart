import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthHelper {
  final firebaseAuth = FirebaseAuth.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn.instance;
  final clientId =
      '770653682648-p04qv1nqopejv96bdemi7vjlm4i5ad22.apps.googleusercontent.com';
  final serverClientId =
      '770653682648-k6uj1g47gaq5e14me14qgn3jgi5uklel.apps.googleusercontent.com';

  Future<UserCredential> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    UserCredential userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    unawaited(
      googleSignIn.initialize(
        clientId: clientId,
        serverClientId: serverClientId,
      ),
    );

    final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    return await firebaseAuth.signInWithCredential(credential);
  }

  Stream<User?> checkUserSignInState() {
    final state = firebaseAuth.authStateChanges();
    return state;
  }

  signOutWithGoogle() {
    googleSignIn.signOut();
    firebaseAuth.signOut();
  }
}