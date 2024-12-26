import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediease_app/frontend%20code/pages/main_page.dart';
import 'package:mediease_app/frontend%20code/pages/profile/profile_page.dart';
import 'package:mediease_app/frontend%20code/pages/signin%20&%20signup/signin_page.dart';
import 'package:mediease_app/frontend%20code/pages/signin%20&%20signup/signup_page.dart';

class AuthStateListener extends StatelessWidget {
  const AuthStateListener({super.key});

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
          return const MainPage(isSignedIn: true,); // Navigate to the home lpage
        } else {
          // User is signed out
          return const SignUpPage(); // Navigate to the sign-in page
        }
      },
    );
  }
}