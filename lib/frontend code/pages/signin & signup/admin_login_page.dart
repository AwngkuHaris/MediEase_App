import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediease_app/backend%20code/services/auth_service.dart';
import 'package:mediease_app/frontend%20code/pages/Admin/admin_page.dart';
import 'package:mediease_app/frontend%20code/pages/main_page.dart';
import 'package:flutter/gestures.dart';
import 'package:mediease_app/frontend%20code/pages/signin%20&%20signup/signup_page.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  bool _isLoading = false; // State to track loading
  // Controllers for email and password text fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Create an instance of AuthService
  final AuthService _authService = AuthService();

  // Track whether user wants to sign in or sign up

  // Method to handle email/password authentication
  Future<void> _handleAuth() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });
    try {
      // Simulate a 1-second delay
      await Future.delayed(const Duration(seconds: 1));

      // Authenticate the user
      UserCredential? userCredential = await _authService.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (userCredential != null) {
        // Fetch the user's role from Firestore
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        if (!userDoc.exists) {
          throw Exception("User record not found in Firestore.");
        }

        final userData = userDoc.data();
        final role =
            userData?['role']; // Assumes 'role' field exists in Firestore

        // Navigate based on role
        if (role == 'admin') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AdminPage(), // Navigate to AdminPage
            ),
          );
        } else if (role == 'user') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  MainPage(isSignedIn: true), // Navigate to User MainPage
            ),
          );
        } else {
          throw Exception("Unknown role: $role");
        }
      }
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign in failed: $e'),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: [
        // Background Image
        Positioned.fill(
          child: Image.asset(
            'assets/images/login.jpeg',
            fit: BoxFit.cover, // Scale the image to cover the screen
          ),
        ),
        // Semi-transparent overlay
        Positioned.fill(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white.withAlpha(170),
          ),
        ),
        // Main content
        SingleChildScrollView(
          
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
              minWidth: MediaQuery.of(context).size.width,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Image.asset(
                    'assets/images/mediease_logo.png',
                    height: 70,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Admin Login",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 50),
                  _buildTextFieldSection("Email Address", _emailController, false, "Enter admin email address"),
                  const SizedBox(height: 16),
                  _buildTextFieldSection("Password", _passwordController, true,"Enter admin password"),
                  const SizedBox(height: 40),
                  _buildLoginButton(),
                  const SizedBox(height: 20),
                  
                 
                
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}


  Widget _buildTextFieldSection(
      String label, TextEditingController controller, bool isPassword, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ),
        const SizedBox(height: 5),
        Container(
          width: 300,
          height: 40,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: const Color(0xff9AD4CC),
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TextField(
            
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return MaterialButton(
      minWidth: 300,
      height: 50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: const Color(0xff05808C),
      child: _isLoading
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
            )
          : const Text(
              "LOGIN",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
      onPressed: _isLoading ? null : _handleAuth,
    );
  }

 

  Widget _buildAgreementText() {
    return SizedBox(
      width: 250,
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'By continuing, you agree to ',
              style: TextStyle(color: Colors.black, fontSize: 10),
            ),
            TextSpan(
              text: 'MediEase User Service Agreement ',
              style: TextStyle(color: Colors.blue, fontSize: 10),
            ),
            TextSpan(
              text: 'and ',
              style: TextStyle(color: Colors.black, fontSize: 10),
            ),
            TextSpan(
              text: 'Privacy Policy ',
              style: TextStyle(color: Colors.blue, fontSize: 10),
            ),
            TextSpan(
              text: 'and understand how we collect, use, and share your data. ',
              style: TextStyle(color: Colors.black, fontSize: 10),
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
