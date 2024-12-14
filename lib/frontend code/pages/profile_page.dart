import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MaterialButton(onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            color: Colors.black,
            child: Text("Sign Out",style: TextStyle(color: Colors.white),),
            )
    );
  }
}