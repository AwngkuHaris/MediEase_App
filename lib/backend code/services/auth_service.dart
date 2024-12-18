import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter/foundation.dart'; // Required for kIsWeb check

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  

  //sign in method with google
Future<UserCredential?> signInWithGoogle() async {
  if (kIsWeb) {
    // Use signInWithPopup for web
    final GoogleAuthProvider googleProvider = GoogleAuthProvider();
    return await _firebaseAuth.signInWithPopup(googleProvider);
  } else {
    // Mobile flow
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    if (gUser == null) return null;

    final GoogleSignInAuthentication gAuth = await gUser.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);

    return await _firebaseAuth.signInWithCredential(credential);
  }
}

  //sign in method with Facebook
  Future<UserCredential?> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Check the status of the login result
      if (loginResult.status == LoginStatus.success) {
        // Make sure we have an access token
        final AccessToken? accessToken = loginResult.accessToken;

        if (accessToken == null) {
          throw FirebaseAuthException(
            code: 'ERROR_FACEBOOK_LOGIN_FAILED',
            message: 'Facebook access token is null',
          );
        }

        // Create a credential from the access token
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(accessToken.tokenString);

        // Once signed in, return the UserCredential
        return await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);
      } else {
        throw FirebaseAuthException(
          code: 'ERROR_FACEBOOK_LOGIN_FAILED',
          message: 'Facebook login failed with status: ${loginResult.status}',
        );
      }
    } catch (e) {
      print('Facebook sign in error: $e');
      rethrow;
    }
  }

  //sign up method with email and password
  Future<UserCredential?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // Handle specific sign-up errors
      print('Sign up error: ${e.message}');
      rethrow;
    }
  }

  //sign in method with email and password
  Future<UserCredential?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
    } on FirebaseAuthException catch (e) {
      // Handle specific sign-in errors
      print('Sign in error: ${e.message}');
      rethrow;
    }
  }
}

