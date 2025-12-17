import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff9AD4CC),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "App purpose",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xff279DA4),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.2), // Shadow color (with opacity)
                    spreadRadius: 3, // How much the shadow spreads
                    blurRadius: 10, // How blurry the shadow is
                    offset: const Offset(0, 3), // Shadow position (x and y offset)
                  ),
                ],
              ),

              width: MediaQuery.of(context).size.width,

              margin:
                  const EdgeInsets.all(15.0), // Adds space around the container
              padding:
                  const EdgeInsets.all(25.0), // Adds space inside the container
              child: const Text(
                textAlign: TextAlign.center,
                "MediEase is a healthcare management application for patients and tailored specifically for UNIMAS students. The system is designed to address the diverse user requirements through functionalities such as appointment scheduling, enhanced communication and seamless access to medical records. The functionalities are tailored for three main user roles which are Patients, Healthcare Providers, and Administrators.",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Text(
              "Features",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xff279DA4),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.2), // Shadow color (with opacity)
                    spreadRadius: 3, // How much the shadow spreads
                    blurRadius: 10, // How blurry the shadow is
                    offset: const Offset(0, 3), // Shadow position (x and y offset)
                  ),
                ],
              ),

              width: MediaQuery.of(context).size.width,

              margin:
                  const EdgeInsets.all(15.0), // Adds space around the container
              padding:
                  const EdgeInsets.all(20.0), // Adds space inside the container
              child: const Text(
                textAlign: TextAlign.left,
                "- Appointment booking and management\n"
                "- Messaging with admins\n"
                "- Access to medical records\n"
                "- Health education library\n"
                "- Personalized notifications\n",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Text(
              "Privacy and Security Commitment",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xff279DA4),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.2), // Shadow color (with opacity)
                    spreadRadius: 3, // How much the shadow spreads
                    blurRadius: 10, // How blurry the shadow is
                    offset: const Offset(0, 3), // Shadow position (x and y offset)
                  ),
                ],
              ),

              width: MediaQuery.of(context).size.width,

              margin:
                  const EdgeInsets.all(15.0), // Adds space around the container
              padding:
                  const EdgeInsets.all(20.0), // Adds space inside the container
              child: const Text(
                textAlign: TextAlign.center,
                "We prioritize your privacy and security. All medical records and personal data are encrypted and accessible only to authorized individuals.",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
