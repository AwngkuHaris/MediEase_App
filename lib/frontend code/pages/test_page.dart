import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediease_app/backend%20code/services/auth_service.dart';
import 'package:mediease_app/frontend%20code/pages/test_page2.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TestPage2()),
        );
      }
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isSignIn 
            ? 'Sign in failed: $e' 
            : 'Sign up failed: $e'
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isSignIn ? "Sign In" : "Sign Up"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Email TextField
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),

            // Password TextField
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              obscureText: true,
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
                : "Already have an account? Sign In"
              ),
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
                  if (userCredential != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TestPage2()),
                    );
                  }
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
                  final userCredential = await _authService.signInWithFacebook();
                  if (userCredential != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TestPage2()),
                    );
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