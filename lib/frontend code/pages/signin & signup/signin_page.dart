import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediease_app/backend%20code/services/auth_service.dart';
import 'package:mediease_app/frontend%20code/pages/main_page.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SigninPage> {
  // Controllers for email and password text fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Create an instance of AuthService
  final AuthService _authService = AuthService();

  // Track whether user wants to sign in or sign up
  bool _isSignIn = true;

  // Method to handle email/password authentication
  Future<void> _handleAuth() async {
    try {
      UserCredential? userCredential;

      if (_isSignIn) {
        // Sign In
        userCredential = await _authService.signIn(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      } else {
        // Sign Up
        userCredential = await _authService.signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      }

      if (userCredential != null) {
        // Navigate to the next page if authentication is successful
        
      }
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text(_isSignIn ? 'Sign in failed: $e' : 'Sign up failed: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isSignIn ? "LogIn" : "Sign Up",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email Address",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            // Email TextField
            Container(
              width: 300,
              height: 40,
              padding: EdgeInsets.all(8.0), // Padding inside the container
              decoration: BoxDecoration(
                color: Color(0xff9AD4CC), // Background color of the container
                borderRadius: BorderRadius.circular(12.0), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    spreadRadius: 2, // Spread radius
                    blurRadius: 5, // Blur radius
                    offset: Offset(0, 3), // Changes position of shadow
                  ),
                ],
              ),
              child: TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                
                  hintText: "Enter your email address", // Placeholder text
                  hintStyle: TextStyle(
                    fontSize: 
                    13,
                    fontWeight: FontWeight.bold,
                      color: Colors.white), // Style of placeholder text
                  border: InputBorder.none, // Removes the default border
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            // Email TextField
            Container(
              width: 300,
              height: 40,
              padding: EdgeInsets.all(8.0), // Padding inside the container
              decoration: BoxDecoration(
                color: Color(0xff9AD4CC), // Background color of the container
                borderRadius: BorderRadius.circular(12.0), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    spreadRadius: 2, // Spread radius
                    blurRadius: 5, // Blur radius
                    offset: Offset(0, 3), // Changes position of shadow
                  ),
                ],
              ),
              child: TextField(
                obscureText: true,
                controller: _passwordController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  
                  hintText: "Password", // Placeholder text
                  hintStyle: TextStyle(
                    fontSize: 
                    13,
                    fontWeight: FontWeight.bold,
                      color: Colors.white), // Style of placeholder text
                  border: InputBorder.none, // Removes the default border
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Toggle between Sign In and Sign Up
            TextButton(
              onPressed: () {
                setState(() {
                  _isSignIn = !_isSignIn;
                });
              },
              child: Text(_isSignIn
                  ? "Don't have an account? Sign Up"
                  : "Already have an account? Sign In"),
            ),
            const SizedBox(height: 16),

            // Main Authentication Button
            ElevatedButton(
              onPressed: _handleAuth,
              child: Text(_isSignIn ? "Sign In" : "Sign Up"),
            ),
            const SizedBox(height: 16),

            // Existing Social Sign-In Buttons
            ElevatedButton(
              onPressed: () async {
                try {
                  final userCredential = await _authService.signInWithGoogle();
                  if (userCredential != null) {}
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Google Sign-In failed: $e')),
                  );
                }
              },
              child: const Text("Sign in with Google"),
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () async {
                try {
                  final userCredential =
                      await _authService.signInWithFacebook();
                  if (userCredential != null) {
                    
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Facebook Sign-In failed: $e')),
                  );
                }
              },
              child: const Text("Sign in with Facebook"),
            ),
          ],
        ),
      ),
    );
  }

  // Dispose controllers to prevent memory leaks
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
