import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediease_app/frontend%20code/pages/profile/about%20app/about_page.dart';
import 'package:mediease_app/frontend%20code/pages/profile/account%20settings/accountSettings_page.dart';
import 'package:mediease_app/frontend%20code/pages/profile/medicalRecord_page.dart';
import 'package:mediease_app/frontend%20code/pages/signin%20&%20signup/signin_page.dart';
import 'package:mediease_app/backend%20code/services/firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
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
      backgroundColor: Color(0xff9AD4CC),
      body: Center(
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
                            child: currentUser!.photoURL == null
                                ? Text(currentUser!.displayName?[0] ?? '')
                                : null,
                            radius: 40,
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${userData?['name'] ?? 'Not set'}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  currentUser!.email ?? "Guest",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
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
                            // Feedback navigation
                          },
                        ),
                      ],
                    ),
                    Padding(
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
                            // Help navigation
                          },
                        ),
                        _buildListTile(
                          "About App",
                          "",
                          Icons.arrow_forward,
                          () {Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AboutPage()
                              ),
                            );
                            // About App navigation
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    MaterialButton(
                      onPressed: () async {
                        try {
                          // Firebase Sign-Out
                          await FirebaseAuth.instance.signOut();

                          // Google Sign-Out
                          final GoogleSignIn googleSignIn = GoogleSignIn();
                          await googleSignIn
                              .disconnect(); // Disconnect Google account
                          await googleSignIn
                              .signOut(); // Optional: Explicitly sign out

                          // Show confirmation or redirect to login screen
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Logged out successfully')),
                          );
                        } catch (e) {
                          // Handle any errors
                        }
                      },
                      minWidth: 300,
                      height: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Color(0xff00589F),
                      child: Text(
                        "LOGOUT",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    SizedBox(height: 25),
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
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: subtitle.isNotEmpty
          ? Text(subtitle, style: TextStyle(fontSize: 10))
          : null,
      trailing: GestureDetector(
        onTap: onTap,
        child: Icon(trailingIcon),
      ),
    );
  }
}
