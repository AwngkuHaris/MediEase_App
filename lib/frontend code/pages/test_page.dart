import 'package:flutter/material.dart';
import 'package:mediease_app/backend%20code/services/auth_service.dart';
import 'package:mediease_app/frontend%20code/pages/test_page2.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Testt"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  await AuthService()
                      .signInWithGoogle(); // Wait for the sign-in to complete
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TestPage2()),
                  );
                },
                child: const Text("Google")),
            ElevatedButton(
              onPressed: () async {
                try {
                  final userCredential =
                      await AuthService().signInWithFacebook();
                  if (userCredential != null) {
                    print("Successfully signed in with Facebook!");
                  }
                } catch (e) {
                  print("Error signing in with Facebook: $e");
                }

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const TestPage2()));
              },
              child: const Text("FB"),
            )
          ],
        ),
      ),
    );
  }
}
