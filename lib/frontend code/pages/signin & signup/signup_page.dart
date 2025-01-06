import 'package:flutter/material.dart';
import 'package:mediease_app/backend%20code/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mediease_app/frontend%20code/pages/signin%20&%20signup/signin_page.dart';
import 'package:flutter/gestures.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Controllers for email and password text fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Create an instance of AuthService
  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Dispose controllers to prevent memory leaks
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/login.jpeg', // Path to your image
              fit: BoxFit
                  .cover, // Ensures the image fills the screen proportionally
            ),
          ),
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
                SizedBox(height: 20),
                Image.asset(
                  'assets/images/mediease_logo.png', // Replace with your image asset path
                  height: 70,
                ),
                SizedBox(height: 20),
                const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),

                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Email Address",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
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
                    borderRadius:
                        BorderRadius.circular(12.0), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Shadow color
                        spreadRadius: 2, // Spread radius
                        blurRadius: 5, // Blur radius
                        offset:
                            const Offset(0, 3), // Changes position of shadow
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
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
                    borderRadius:
                        BorderRadius.circular(12.0), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Shadow color
                        spreadRadius: 2, // Spread radius
                        blurRadius: 5, // Blur radius
                        offset:
                            const Offset(0, 3), // Changes position of shadow
                      ),
                    ],
                  ),
                  child: TextField(
                    obscureText: true,
                    controller: _passwordController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Enter Your Password", // Placeholder text
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
                      "Confirm Password",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
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
                    borderRadius:
                        BorderRadius.circular(12.0), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Shadow color
                        spreadRadius: 2, // Spread radius
                        blurRadius: 5, // Blur radius
                        offset:
                            const Offset(0, 3), // Changes position of shadow
                      ),
                    ],
                  ),
                  child: TextField(
                    obscureText: true,
                    controller: _confirmPasswordController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Confirm Your Password", // Placeholder text
                      hintStyle: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white), // Style of placeholder text
                      border: InputBorder.none, // Removes the default border
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                MaterialButton(
                  onPressed: () async {
                    final scaffoldMessenger = ScaffoldMessenger.of(context);

                    try {
                      // Get user input
                      final email = _emailController.text.trim();
                      final password = _passwordController.text.trim();
                      final confirmPassword =
                          _confirmPasswordController.text.trim();

                      // Validate input
                      if (email.isEmpty ||
                          password.isEmpty ||
                          confirmPassword.isEmpty) {
                        scaffoldMessenger.showSnackBar(
                          const SnackBar(
                              content: Text('Please fill in all fields.')),
                        );
                        return;
                      }

                      if (password != confirmPassword) {
                        scaffoldMessenger.showSnackBar(
                          const SnackBar(
                              content: Text('Passwords do not match.')),
                        );
                        return;
                      }

                      // Call sign-up method
                      final userCredential = await _authService.signUp(
                        email: email,
                        password: password,
                      );

                      final user = userCredential?.user;

                      if (user != null) {
                        // Save user details to Firestore
                        final userDocRef =
                            _firestore.collection('users').doc(user.uid);

                        await userDocRef.set({
                          'name': "user",
                          'email': user.email,
                          'profilePicture': user.photoURL ?? '',
                          'dateOfBirth': "",
                          'bloodType': "",
                          'allergies': "",
                          'chronicConditions': "None",
                          'covidVaccine': "",
                          'tetanusVaccine': "",
                          'hpvVaccine': "",
                          'primaryContact': "",
                          'secondaryContact': "",
                          'notes': "",
                          'createdAt': FieldValue.serverTimestamp(),
                          'role': "user",
                        });

                        scaffoldMessenger.showSnackBar(
                          const SnackBar(content: Text('Sign-up successful!')),
                        );
                      } else {
                        scaffoldMessenger.showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Sign-up failed. Please try again.')),
                        );
                      }
                    } catch (e) {
                      scaffoldMessenger.showSnackBar(
                        SnackBar(content: Text('An error occurred: $e')),
                      );
                      print('Sign-up error: $e');
                    }
                  },
                  minWidth: 300,
                  height: 50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: const Color(0xff05808C),
                  child: const Text(
                    "SIGN UP",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  "or sign up with",
                  style: TextStyle(fontSize: 12),
                ),

                const SizedBox(
                  height: 16,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          final scaffoldMessenger = ScaffoldMessenger.of(
                              context); // Store the reference early

                          // Sign in with Google
                          final userCredential =
                              await _authService.signInWithGoogle();
                          final user = userCredential?.user;

                          if (user != null) {
                            final userDocRef =
                                _firestore.collection('users').doc(user.uid);

                            // Check if user document already exists
                            final userDoc = await userDocRef.get();

                            if (!userDoc.exists) {
                              // If user document does not exist, create it
                              await userDocRef.set({
                                'name': user.displayName,
                                'email': user.email,
                                'profilePicture': user.photoURL,
                                'dateOfBirth': "",
                                'bloodType': "",
                                'allergies': "",
                                'chronicConditions': "None",
                                'covidVaccine': "",
                                'tetanusVaccine': "",
                                'hpvVaccine': "",
                                'primaryContact': "",
                                'secondaryContact': "",
                                'notes': "",
                                'createdAt': FieldValue.serverTimestamp(),
                                'role': "user",
                              });
                            }

                            // Safely show a snackbar
                            if (mounted) {
                              scaffoldMessenger.showSnackBar(
                                const SnackBar(
                                    content: Text('Sign-up successful!')),
                              );
                            }
                          } else {
                            if (mounted) {
                              scaffoldMessenger.showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Sign-up failed. Please try again.')),
                              );
                            }
                          }
                        } catch (e) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('An error occurred: $e')),
                            );
                          }
                          print('Error: $e');
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
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle the sign-in logic here
                      },
                      style: ElevatedButton.styleFrom(
                        shape:
                            const CircleBorder(), // Makes the button circular
                        padding:
                            const EdgeInsets.all(5), // Adjust padding for size
                        backgroundColor: Colors.white, // Background color
                        elevation: 5, // Button elevation
                      ),
                      child: Image.asset(
                        'assets/images/facebook_logo.png', // Path to Facebook logo
                        width: 35, // Adjust the size of the logo
                        height: 35,
                      ),
                    ),
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
                              text: 'Already have an account? ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            TextSpan(
                              text: 'Login',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Navigate to the SignInPage
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SigninPage(),
                                    ),
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
        ],
      )),
    );
  }
}
