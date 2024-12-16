import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff9AD4CC),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Welcome to MediEase!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "Login to book the appointment",
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Upcoming Appointments",
                    style: TextStyle(
                        color: Color(0xff2A3E66),
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ),
              ),
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
                height: 100,
                margin: const EdgeInsets.all(
                    15.0), // Adds space around the container
                padding: const EdgeInsets.all(
                    16.0), // Adds space inside the container
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      "No Upcoming Appointments",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    Text(
                      "HealthEd",
                      style: TextStyle(
                          color: Color(0xff2A3E66),
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                    Spacer(),
                    Text(
                      "See all",
                      style: TextStyle(color: Color(0xff2A3E66), fontSize: 12),
                    ),
                  ],
                ),
              ),
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
                height: 300,
                margin: const EdgeInsets.all(
                    15.0), // Adds space around the container
                padding: const EdgeInsets.all(
                    16.0), // Adds space inside the container
                child: Row(
                  children: [],
                ),
              ),
              SizedBox(
                height: 200,
              ),
              Text("You are signed in!"),
              ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: Text("Sign Out"))
            ],
          ),
        ),
      ),
    );
  }
}
