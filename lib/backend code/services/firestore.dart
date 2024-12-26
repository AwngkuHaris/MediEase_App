import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Fetch user data
  Future<Map<String, dynamic>?> getUserData() async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) return null;

    try {
      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .get();

      return userDoc.exists ? userDoc.data() as Map<String, dynamic> : null;
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  Future<void> updateUserData({
  String? name,
  String? email,
  String? dateOfBirth,
  String? bloodType,
  String? allergies,
  String? chronicConditions,
  String? covidVaccine,
  String? tetanusVaccine,
  String? hpvVaccine,
  String? primaryContact,
  String? secondaryContact,
  String? notes,
}) async {
  User? currentUser = _auth.currentUser;
  if (currentUser == null) return;
  final userDoc = FirebaseFirestore.instance.collection('users').doc(currentUser.uid);
  final data = {
    if (name != null) 'name': name,
    if (dateOfBirth != null) 'dateOfBirth': dateOfBirth,
    if (bloodType != null) 'bloodType': bloodType,
    if (allergies != null) 'allergies': allergies,
    if (chronicConditions != null) 'chronicConditions': chronicConditions,
    if (covidVaccine != null) 'covidVaccine': covidVaccine,
    if (tetanusVaccine != null) 'tetanusVaccine': tetanusVaccine,
    if (hpvVaccine != null) 'hpvVaccine': hpvVaccine,
    if (primaryContact != null) 'primaryContact': primaryContact,
    if (secondaryContact != null) 'secondaryContact': secondaryContact,
    if (notes != null) 'notes': notes,
  };
  await userDoc.update(data);
}

}