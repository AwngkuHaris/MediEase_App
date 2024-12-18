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
      backgroundColor: Color(0xff9AD4CC),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff9AD4CC),
        title: Text("Profile Management"),
        titleTextStyle: TextStyle(
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
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    SizedBox(height: 10,),
                    CircleAvatar(
                            backgroundImage: currentUser!.photoURL != null
                                ? NetworkImage(currentUser!.photoURL!)
                                : null,
                            child: currentUser!.photoURL == null
                                ? Text(currentUser!.displayName?[0] ?? '')
                                : null,
                            radius: 40,
                          ),
                    
                    ListTile(
                      leading: Icon(Icons.person_outline),
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
                      trailing: GestureDetector(onTap: _showEditNameDialog,child: Icon(Icons.edit_outlined)),
                    ),
                    ListTile(
                      leading: Icon(Icons.email_outlined),
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
                      trailing: GestureDetector(onTap: _showEditEmailDialog,child: Icon(Icons.edit_outlined)),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone_outlined),
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
                      trailing: Icon(Icons.edit_outlined),
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
        title: Text("Edit Name"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "New Name"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel",style: TextStyle(color: Colors.black),),
          ),
          MaterialButton(
            color: Color(0xff9AD4CC),
            onPressed: () async {
              await _userService.updateUserData(
                name: nameController.text,
              );
              await _fetchUserData();
              Navigator.pop(context);
            },
            child: Text("Save"),
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
        title: Text("Edit Email"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "New Email"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              await _userService.updateUserData(
                email: emailController.text,
              );
              await _fetchUserData();
              Navigator.pop(context);
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

    
}
