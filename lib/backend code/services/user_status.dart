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
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final bool isSignedIn = snapshot.hasData;
        return MainPage(isSignedIn: isSignedIn);
      },
    );
  }
}
