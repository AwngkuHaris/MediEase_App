import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediease_app/backend%20code/services/firestore.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  FirestoreService _firestoreService = FirestoreService();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff9AD4CC),
        body: Column(children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withOpacity(0.2), // Shadow color (with opacity)
                  spreadRadius: 3, // How much the shadow spreads
                  blurRadius: 10, // How blurry the shadow is
                  offset: Offset(0, 3), // Shadow position (x and y offset)
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width,
            height: 150,
            margin:
                const EdgeInsets.all(15.0), // Adds space around the container
            padding:
                const EdgeInsets.all(16.0), // Adds space inside the container
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(children: [
                  Text(
                    textAlign: TextAlign.center,
                    "No Upcoming",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: [
                      Text("Name"),
                      Text("Student"),
                      Text("Email"),
                    ],
                  )
                ]),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              height: 65,
              minWidth: MediaQuery.of(context).size.width,
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              color: Color(0xff00589F),
              child: Text(
                "LOGOUT",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              height: 65,
              minWidth: MediaQuery.of(context).size.width,
              onPressed: () {
                _firestoreService.addUser("12345", "awangku", 21);
              },
              color: Color(0xff00589F),
              child: Text(
                "add user",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              height: 65,
              minWidth: MediaQuery.of(context).size.width,
              onPressed: () {
                _firestoreService.getUser("12345");
              },
              color: Color(0xff00589F),
              child: Text(
                "get user",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ]));
  }
}
