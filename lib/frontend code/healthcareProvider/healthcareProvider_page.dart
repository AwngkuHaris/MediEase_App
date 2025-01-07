import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:mediease_app/frontend%20code/pages/Admin/announcement_page.dart';
import 'package:mediease_app/frontend%20code/pages/Admin/feedback_page.dart';
import 'package:mediease_app/frontend%20code/pages/Admin/userList_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mediease_app/frontend%20code/pages/main_page.dart';

class HealthcareproviderPage extends StatefulWidget {
  @override
  _HealthcareproviderPageState createState() => _HealthcareproviderPageState();
}

class _HealthcareproviderPageState extends State<HealthcareproviderPage> {
  int _selectedPageIndex = 0;

  // Define the pages for the admin dashboard
  final List<Widget> _pages = [
    DashboardPage(),
    AnnouncementsPage(),
    FeedbackManager(),
    UserListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Healthcare Provider Dashboard"),
        backgroundColor: const Color(0xFF9ad4cc),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: const Color(0xFF9ad4cc),
              ),
              child: Center(
                child: Text(
                  'Admin Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.analytics),
              title: const Text("Dashboard"),
              onTap: () {
                setState(() {
                  _selectedPageIndex = 0; // Show Dashboard
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.announcement),
              title: const Text("Announcements"),
              onTap: () {
                setState(() {
                  _selectedPageIndex = 1; // Show Announcements
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text("Feedback"),
              onTap: () {
                setState(() {
                  _selectedPageIndex = 2; // Show Feedback
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text("Users"),
              onTap: () {
                setState(() {
                  _selectedPageIndex = 3; // Show User List
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedPageIndex],
    );
  }
}

// Sample DashboardPage widget
class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _isLoggingOut = false; 
 // Add a state variable to track logout status
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            "Dashboard Content",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
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
          
        ],
      ),
    );
  }
}
