import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser(String userId, String name, int age) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    await users.doc(userId).set({
      'name': name,
      'age': age,
      'createdAt': FieldValue.serverTimestamp(),
    }).then((_) {
      print("User Added");
    }).catchError((error) {
      print("Failed to add user:$error");
    });
  }

  Future<void> createUserDocument(User user) async {
    // Reference the "users" collection
    CollectionReference users = _firestore.collection('users');

    // Set the user's document ID as their Firebase uid
    await users.doc(user.uid).set({
      'email': user.email,
      'displayName': user.displayName ?? '',
      'createdAt': FieldValue.serverTimestamp(),
    }).then((_) {
      print("User document created for UID: ${user.uid}");
    }).catchError((error) {
      print("Failed to create user document: $error");
    });
  }

  Future<void> getUser(
    String userId,
  ) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (doc.exists) {
      print("User Data: ${doc.data()}");
    } else {
      print("User does not exist");
    }
  }
}
