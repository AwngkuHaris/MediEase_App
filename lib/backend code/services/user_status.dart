import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediease_app/frontend%20code/pages/home_page.dart';
import 'package:mediease_app/frontend%20code/pages/main_page.dart';
import 'package:mediease_app/frontend%20code/pages/signin_page.dart';

class AuthStateListener extends StatelessWidget {
  const AuthStateListener({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While checking the authentication state, show a loading spinner
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          // User is signed in
          return MainPage(); // Navigate to the home page
        } else {
          // User is signed out
          return MainPage(); // Navigate to the sign-in page
        }
      },
    );
  }
}