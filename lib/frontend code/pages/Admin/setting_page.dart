import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediease_app/frontend%20code/pages/main_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _isLoggingOut = false; // Add a state variable to track logout status
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF9ad4cc),
      body: Center(
        child: MaterialButton(
          onPressed: _isLoggingOut
              ? null // Disable the button while logging out
              : () async {
                  setState(() {
                    _isLoggingOut = true; // Show loading indicator
                  });
                  try {
                    // Firebase Sign-Out
                    await FirebaseAuth.instance.signOut();

                    // Simulate a delay
                    await Future.delayed(const Duration(seconds: 1));

                    // Navigate to the homepage
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainPage(isSignedIn: false),
                      ),
                    );

                    // Show confirmation
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Logged out successfully')),
                    );
                  } catch (e) {
                    // Handle any errors
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error logging out: $e')),
                    );
                  } finally {
                    setState(() {
                      _isLoggingOut = false; // Hide loading indicator
                    });
                  }
                },
          minWidth: 300,
          height: 50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: const Color(0xff00589F),
          child: _isLoggingOut
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                )
              : const Text(
                  "LOGOUT",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
