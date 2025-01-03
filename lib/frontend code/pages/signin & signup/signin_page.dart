import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediease_app/backend%20code/services/auth_service.dart';
import 'package:mediease_app/frontend%20code/pages/main_page.dart';
import 'package:flutter/gestures.dart';
import 'package:mediease_app/frontend%20code/pages/signin%20&%20signup/signup_page.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SigninPage> {
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

      // Your authentication logic here
      UserCredential? userCredential = await _authService.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (userCredential != null) {
        // Navigate to the MainPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(isSignedIn: true),
          ),
        );
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
        body: Stack(children: [
      Positioned.fill(
        child: Image.asset(
          'assets/images/login.jpeg', // Path to your image
          fit:
              BoxFit.cover, // Ensures the image fills the screen proportionally
        ),
      ),
      // White Overlay
      Positioned.fill(
        child: Container(
          color: Colors.white.withAlpha(170), // Adjust opacity as needed
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height:30),
            Image.asset(
              'assets/images/mediease_logo.png', // Replace with your image asset path
              height: 70,
            ),
            SizedBox(height:30),
            Text(
              "Login",
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            const SizedBox(
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email Address",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            // Email TextField
            Container(
              width: 300,
              height: 40,
              padding:
                  const EdgeInsets.all(8.0), // Padding inside the container
              decoration: BoxDecoration(
                color: const Color(
                    0xff9AD4CC), // Background color of the container
                borderRadius: BorderRadius.circular(12.0), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    spreadRadius: 2, // Spread radius
                    blurRadius: 5, // Blur radius
                    offset: const Offset(0, 3), // Changes position of shadow
                  ),
                ],
              ),
              child: TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: "Enter your email address", // Placeholder text
                  hintStyle: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white), // Style of placeholder text
                  border: InputBorder.none, // Removes the default border
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            // Email TextField
            Container(
              width: 300,
              height: 40,
              padding:
                  const EdgeInsets.all(8.0), // Padding inside the container
              decoration: BoxDecoration(
                color: const Color(
                    0xff9AD4CC), // Background color of the container
                borderRadius: BorderRadius.circular(12.0), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    spreadRadius: 2, // Spread radius
                    blurRadius: 5, // Blur radius
                    offset: const Offset(0, 3), // Changes position of shadow
                  ),
                ],
              ),
              child: TextField(
                obscureText: true,
                controller: _passwordController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: "Password", // Placeholder text
                  hintStyle: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white), // Style of placeholder text
                  border: InputBorder.none, // Removes the default border
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Main Authentication Button
            MaterialButton(
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
              onPressed: _isLoading
                  ? null
                  : _handleAuth, // Disable button when loading
            ),
            const SizedBox(height: 20),
            const Text(
              "or login with",
              style: TextStyle(fontSize: 12),
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    try {
                      // Perform Google Sign-In
                      final userCredential =
                          await _authService.signInWithGoogle();

                      if (userCredential != null) {
                        // Show loading dialog after successful sign-in
                        showDialog(
                          context: context,
                          barrierDismissible:
                              false, // Prevents dismissing the dialog
                          builder: (context) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.teal,
                              ),
                            );
                          },
                        );

                        // Simulate loading delay (e.g., 2 seconds)
                        await Future.delayed(const Duration(seconds: 1));

                        // Navigate to the main page
                        Navigator.pop(context); // Close the loading dialog
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(isSignedIn: true),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Google Sign-In failed.')),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Google Sign-In failed: $e')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(5),
                    backgroundColor: Colors.white,
                    elevation: 5,
                  ),
                  child: Image.asset(
                    'assets/images/google_logo.png',
                    width: 35,
                    height: 35,
                  ),
                ),
                const SizedBox(width: 20),

                
                ElevatedButton(
                  onPressed: () async {
                    try {
                      final userCredential =
                          await _authService.signInWithFacebook();
                      if (userCredential != null) {
                        // Handle successful sign-in
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Facebook Sign-In failed: $e')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(), // Makes the button circular
                    padding: const EdgeInsets.all(5), // Adjust padding for size
                    backgroundColor: Colors.white, // Background color
                    elevation: 5, // Button elevation
                  ),
                  child: Image.asset(
                    'assets/images/facebook_logo.png', // Path to Facebook logo
                    width: 35, // Adjust the size of the logo
                    height: 35,
                  ),
                )
              ],
            ),

            Spacer(),

            SizedBox(
              width: 250,
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'By continuing, you agree to ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 10), // Color for first part
                    ),
                    TextSpan(
                      text: 'MediEase User Service Agreement ',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 10), // Color for second part
                    ),
                    TextSpan(
                      text: 'and ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 10), // Color for third part
                    ),
                    TextSpan(
                      text: 'Privacy Policy ',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 10), // Color for second part
                    ),
                    TextSpan(
                      text:
                          'and understand how we collect, use, and share your data. ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 10), // Color for first part
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Expanded(
              child: Container(
                height: 100, // Fixed height of the container at the bottom
                width: MediaQuery.of(context).size.width,
                color: const Color(0xffD9D9D9),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Have no account yet? ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        TextSpan(
                          text: 'Create an account',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpPage()),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ]));
  }

  // Dispose controllers to prevent memory leaks
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
