import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 

class PasswordPrivacyPage extends StatefulWidget {
  const PasswordPrivacyPage({super.key});

  @override
  _PasswordPrivacyPageState createState() => _PasswordPrivacyPageState();
}

class _PasswordPrivacyPageState extends State<PasswordPrivacyPage> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final User? currentUser  = FirebaseAuth.instance.currentUser ;

  bool allowNotifications = false; // Moved to class level
  bool enableLocation = false; // Moved to class level

  void _changePassword() async {
    if (currentUser  == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User  is not signed in.')),
      );
      return;
    }

    final currentPassword = _currentPasswordController.text;
    final newPassword = _newPasswordController.text;

    if (currentPassword.isEmpty || newPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }

    try {
      // Re-authenticate the user
      final credential = EmailAuthProvider.credential(
        email: currentUser !.email!,
        password: currentPassword,
      );
      await currentUser !.reauthenticateWithCredential(credential);

      // Update password
      await currentUser !.updatePassword(newPassword);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password updated successfully.')),
      );

      Navigator.pop(context); // Close the dialog
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update password: $error')),
      );
    }
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _currentPasswordController,
                decoration:
                    const InputDecoration(labelText: 'Current Password'),
                obscureText: true,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _newPasswordController,
                decoration: const InputDecoration(labelText: 'New Password'),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _changePassword,
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showManagePermissionsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
 title: const Text('Manage Permissions'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwitchListTile(
                title: const Text('Allow Notifications'),
                value: allowNotifications,
                onChanged: (value) {
                  setState(() {
                    allowNotifications = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Enable Location Services'),
                value: enableLocation,
                onChanged: (value) {
                  setState(() {
                    enableLocation = value;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(currentUser ?.uid)
                      .update({
                    'notifications': allowNotifications,
                    'location': enableLocation,
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Permissions updated.')),
                  );
                  Navigator.pop(context); // Close dialog after updating permissions
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Failed to update permissions: $error')),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff9AD4CC),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff9AD4CC),
        elevation: 0,
        title: const Text(
          'Password & Privacy',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Change Password Option
            GestureDetector(
              onTap: _showChangePasswordDialog,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.lock_outline, color: Colors.black),
                        SizedBox(width: 12),
                        Text(
                          'Change Password',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const Icon(Icons.edit_outlined, color: Colors.black),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Manage Permissions Option
            GestureDetector(
              onTap: _showManagePermissionsDialog,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.security_outlined, color: Colors.black),
                        SizedBox(width: 12),
                        Text(
                          'Manage Permissions',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const Icon(Icons.edit_outlined, color: Colors.black),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}