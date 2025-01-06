import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediease_app/frontend%20code/pages/main_page.dart';
import 'package:mediease_app/frontend%20code/pages/profile/about%20app/about_page.dart';
import 'package:mediease_app/frontend%20code/pages/profile/account%20settings/accountSettings_page.dart';
import 'package:mediease_app/frontend%20code/pages/profile/feedback_page.dart';
import 'package:mediease_app/frontend%20code/pages/profile/helpSupport.dart';
import 'package:mediease_app/frontend%20code/pages/profile/medicalRecord_page.dart';
import 'package:mediease_app/frontend%20code/pages/signin%20&%20signup/signin_page.dart';
import 'package:mediease_app/backend%20code/services/firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoggingOut = false; // Add a state variable to track logout status
  final User? currentUser = FirebaseAuth.instance.currentUser;
  bool get isSignedIn => currentUser != null;
  Map<String, dynamic>? userData;
  final FirestoreService _userService = FirestoreService();

  Future<void> _fetchUserData() async {
    final data = await _userService.getUserData();
    if (mounted) {
      // Check if the widget is still in the widget tree
      setState(() {
        userData = data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff9AD4CC),
      body: SafeArea(
        child: isSignedIn ? _buildSignedInUI() : _buildUnregisteredUserUI(),
      ),
    );
  }

  Widget _buildSection(BuildContext context, List<Widget> tiles) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(5.0),
      child: Column(children: tiles),
    );
  }

  Widget _buildListTile(
    String title,
    String subtitle,
    IconData trailingIcon,
    VoidCallback onTap,
  ) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: subtitle.isNotEmpty
          ? Text(subtitle, style: const TextStyle(fontSize: 10))
          : null,
      trailing: GestureDetector(
        onTap: onTap,
        child: Icon(trailingIcon),
      ),
    );
  }

  Widget _buildUnregisteredUserUI() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You are not logged in.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the sign-in page
                Navigator.pushNamed(
                    context, '/signin'); // Replace with your sign-in route
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff00589F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                'Log In to View Profile',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignedInUI() {
    return Center(
      child: currentUser != null
          ? SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: currentUser!.photoURL != null
                              ? NetworkImage(currentUser!.photoURL!)
                              : null,
                          radius: 40,
                          child: currentUser!.photoURL == null
                              ? Text(currentUser!.displayName?[0] ?? '')
                              : null,
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${userData?['name'] ?? 'Not set'}",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                currentUser!.email ?? "Guest",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  // First Section with ListTile
                  _buildSection(
                    context,
                    [
                      _buildListTile(
                        "Account Settings",
                        "Make changes to your account",
                        Icons.arrow_forward,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AccountsettingsPage(),
                            ),
                          );
                          // Navigate to AccountSettingsPage
                        },
                      ),
                      _buildListTile(
                        "Medical Records",
                        "View your medical records",
                        Icons.arrow_forward,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MedicalrecordPage(),
                            ),
                          );
                        },
                      ),
                      _buildListTile(
                        "Feedback",
                        "Send your feedback",
                        Icons.arrow_forward,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  FeedbackPage()),
                          );
                        },
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "More",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                  // Second Section with ListTile
                  _buildSection(
                    context,
                    [
                      _buildListTile(
                        "Help and Support",
                        "",
                        Icons.arrow_forward,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Helpsupport(),
                            ),
                          );
                        },
                      ),
                      _buildListTile(
                        "About App",
                        "",
                        Icons.arrow_forward,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AboutPage()),
                          );
                          // About App navigation
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  MaterialButton(
                    onPressed: _isLoggingOut
                        ? null // Disable the button while logging out
                        : () async {
                            setState(() {
                              _isLoggingOut = true; // Show loading indicator
                            });
                            try {
                              // Firebase Sign-Out
                              await FirebaseAuth.instance.signOut();

                              // Google Sign-Out
                              final GoogleSignIn googleSignIn = GoogleSignIn();
                              try {
                                await googleSignIn
                                    .disconnect(); // Attempt to disconnect Google account
                              } catch (e) {
                                print("Google disconnect failed: $e");
                                await googleSignIn
                                    .signOut(); // Fallback to sign-out
                              }

                              // Simulate a delay
                              await Future.delayed(const Duration(seconds: 1));

                              // Navigate to the homepage
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const MainPage(isSignedIn: false),
                                ),
                              );

                              // Show confirmation
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Logged out successfully')),
                              );
                            } catch (e) {
                              // Handle any errors
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Error logging out: $e')),
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
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.teal),
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

                  const SizedBox(height: 25),
                ],
              ),
            )
          : Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SigninPage(),
                    ),
                  );
                },
                child: const Text("Sign in"),
              ),
            ),
    );
  }
}
