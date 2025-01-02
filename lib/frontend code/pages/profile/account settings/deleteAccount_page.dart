import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeleteaccountPage extends StatelessWidget {
  const DeleteaccountPage({super.key});

  Future<void> _deleteAccount(
      BuildContext context, String confirmationText) async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (confirmationText != "DELETE") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please type "DELETE" to confirm.'),
        ),
      );
      return;
    }

    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No user is currently signed in.'),
        ),
      );
      return;
    }

    try {
      // Delete user data from Firestore
      await FirebaseFirestore.instance
          .collection('users') // Replace 'users' with your collection name
          .doc(currentUser.uid)
          .delete();

      // Delete user authentication account
      await currentUser.delete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account deleted successfully.'),
        ),
      );

      // Navigate to the login screen or another page
      Navigator.pushReplacementNamed(
          context, '/login'); // Update route as needed
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete account: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController confirmationController =
        TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Delete Account',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF9AD4CC),
      ),
      backgroundColor: const Color(0xFF9AD4CC),
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Deleting account',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Deleting your account will remove all your data from our database. This action cannot be undone.',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 20),
                const Text(
                  'To confirm this, type "DELETE"',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: confirmationController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          hintText: 'Type "DELETE"',
                          hintStyle: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black54,
                          ),
                        ),
                        textInputAction:
                            TextInputAction.done, // Set the action to 'Done'
                        onSubmitted: (value) {
                          // Close the keyboard when the user presses 'Enter' or 'Done'
                          FocusScope.of(context).unfocus();

                          // Perform validation after keyboard closes
                          if (value != "DELETE") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Please type "DELETE" to confirm.')),
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        _deleteAccount(context, confirmationController.text);
                      },
                      child: const Text(
                        'Delete account',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
