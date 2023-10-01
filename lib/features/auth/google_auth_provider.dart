import 'dart:developer';

import 'package:clever_tech/features/auth/auth_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show AuthCredential, FirebaseAuth, GoogleAuthProvider;
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future signIn() async {
    try {
      final signedIn = await _googleSignIn.signIn();
      if (signedIn == null) {
        throw CouldNotSignInAuthException();
      }
      final googleAuth = await signedIn.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final userCredential = await _auth.signInWithCredential(credential);
        return (userCredential);
      }
    } catch (e) {
      log(e.toString());
      throw CouldNotSignInAuthException();
    }
  }
}
