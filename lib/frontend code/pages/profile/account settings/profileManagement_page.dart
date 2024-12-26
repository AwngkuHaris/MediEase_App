import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediease_app/backend%20code/services/firestore.dart';

class ProfilemanagementPage extends StatefulWidget {
  const ProfilemanagementPage({super.key});

  @override
  _ProfilemanagementPageState createState() => _ProfilemanagementPageState();
}

class _ProfilemanagementPageState extends State<ProfilemanagementPage> {
  final FirestoreService _userService = FirestoreService();
  Map<String, dynamic>? userData;
  final User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() { 
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final data = await _userService.getUserData();
    setState(() {
      userData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff9AD4CC),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff9AD4CC),
        title: const Text("Profile Management"),
        titleTextStyle: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Container(
          
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(16.0),
          child: userData == null
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    const SizedBox(height: 10,),
                    CircleAvatar(
                            backgroundImage: currentUser!.photoURL != null
                                ? NetworkImage(currentUser!.photoURL!)
                                : null,
                            radius: 40,
                            child: currentUser!.photoURL == null
                                ? Text(currentUser!.displayName?[0] ?? '')
                                : null,
                          ),
                    
                    ListTile(
                      leading: const Icon(Icons.person_outline),
                      title: Text(
                        "Name",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 11,
                        ),
                      ),
                      subtitle: Text("${userData?['name'] ?? 'Not set'}",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black.withOpacity(1),
                          )),
                      trailing: GestureDetector(onTap: _showEditNameDialog,child: const Icon(Icons.edit_outlined)),
                    ),
                    ListTile(
                      leading: const Icon(Icons.email_outlined),
                      title: Text(
                        "Email Address",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 11,
                        ),
                      ),
                      subtitle: Text("${userData?['email'] ?? 'Not set'}",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black.withOpacity(1),
                          )),
                      trailing: GestureDetector(onTap: _showEditEmailDialog,child: const Icon(Icons.edit_outlined)),
                    ),
                    ListTile(
                      leading: const Icon(Icons.phone_outlined),
                      title: Text(
                        "Phone Number",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 11,
                        ),
                      ),
                      subtitle: Text("${userData?['number'] ?? 'Not set'}",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black.withOpacity(1),
                          )),
                      trailing: const Icon(Icons.edit_outlined),
                    ),
                    
                  ],
                ),
        ),
      ),
    );
  }

  void _showEditNameDialog() {
    final nameController = TextEditingController(text: userData?['name']);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Name"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "New Name"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel",style: TextStyle(color: Colors.black),),
          ),
          MaterialButton(
            color: const Color(0xff9AD4CC),
            onPressed: () async {
              await _userService.updateUserData(
                name: nameController.text,
              );
              await _fetchUserData();
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

    void _showEditEmailDialog() {
    final emailController = TextEditingController(text: userData?['email']);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Email"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "New Email"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              await _userService.updateUserData(
                email: emailController.text,
              );
              await _fetchUserData();
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

    
}
