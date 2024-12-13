import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediease_app/backend%20code/services/auth_service.dart';

class TestPage2 extends StatelessWidget {
  const TestPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AuthService().getCurrentUser()!.email.toString()),
            MaterialButton(onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            color: Colors.black,
            child: Text("Sign Out",style: TextStyle(color: Colors.white),),
            )
          ],
        ),
      ),
    );
  }
}
