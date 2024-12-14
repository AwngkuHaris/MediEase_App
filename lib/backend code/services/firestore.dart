import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
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

    Future<void> getUser(
      String userId,
    ) async {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (doc.exists) {
        print("User Data: ${doc.data()}");
      } else {
        print("User does not exist");
      }
  }
}