import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediease_app/frontend%20code/pages/accountSettings_page.dart';
import 'package:mediease_app/frontend%20code/pages/signin_page.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final User? currentUser = FirebaseAuth.instance.currentUser;

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
                      height: 115,
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
                                  currentUser!.displayName ?? "Guest",
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
                                builder: (context) => AccountsettingsPage(),
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
                          () {
                            // About App navigation
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    MaterialButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut(); // Trigger logout
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
                            color: Colors.white),
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
