import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfilePage extends StatelessWidget {
  final String userId;

  const UserProfilePage({Key? key, required this.userId}) : super(key: key);

  Future<Map<String, dynamic>?> fetchUserProfile(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching user profile: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff4299a1),
      appBar: AppBar(
        title: const Text("User Profile"),
        backgroundColor: const Color(0xFF9ad4cc),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: fetchUserProfile(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("User not found"));
          }

          final userData = snapshot.data!;
          final String name =
              (userData['name'] ?? '').isEmpty ? 'No Name' : userData['name'];
          final String email = (userData['email'] ?? '').isEmpty
              ? 'No Email'
              : userData['email'];
          final String? profilePicture =
              (userData['profilePicture'] ?? '').isEmpty
                  ? null
                  : userData['profilePicture'];
          final String dateOfBirth = (userData['dateOfBirth'] ?? '').isEmpty
              ? 'No Date of Birth'
              : userData['dateOfBirth'];
          final String bloodType = (userData['bloodType'] ?? '').isEmpty
              ? 'No Blood Type'
              : userData['bloodType'];
          final String allergies = (userData['allergies'] ?? '').isEmpty
              ? 'No Allergies'
              : userData['allergies'];
          final String chronicConditions =
              (userData['chronicConditions'] ?? '').isEmpty
                  ? 'No Chronic Conditions'
                  : userData['chronicConditions'];
          final String covidVaccine = (userData['covidVaccine'] ?? '').isEmpty
              ? 'No COVID-19 Vaccine Record'
              : userData['covidVaccine'];
          final String tetanusVaccine =
              (userData['tetanusVaccine'] ?? '').isEmpty
                  ? 'No Tetanus Vaccine Record'
                  : userData['tetanusVaccine'];
          final String hpvVaccine = (userData['hpvVaccine'] ?? '').isEmpty
              ? 'No HPV Vaccine Record'
              : userData['hpvVaccine'];
          final String primaryContact =
              (userData['primaryContact'] ?? '').isEmpty
                  ? 'No Primary Contact'
                  : userData['primaryContact'];
          final String secondaryContact =
              (userData['secondaryContact'] ?? '').isEmpty
                  ? 'No Secondary Contact'
                  : userData['secondaryContact'];
          final String additionalNotes =
              (userData['notes'] ?? '').isEmpty
                  ? 'No Additional Notes'
                  : userData['notes'];

          return Padding(
  padding: const EdgeInsets.all(16.0),
  child: Card(
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView( // Add SingleChildScrollView here
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: profilePicture != null
                    ? NetworkImage(profilePicture)
                    : null,
                child: profilePicture == null
                    ? Text(
                        name[0],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            // Name
            Center(
              child: Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Email
            Center(
              child: Text(
                email,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const Divider(),

            // Personal Information Section
            const Text(
              "Personal Information",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text("Date of Birth"),
              subtitle: Text(dateOfBirth),
            ),
            ListTile(
              leading: const Icon(Icons.bloodtype),
              title: const Text("Blood Type"),
              subtitle: Text(bloodType),
            ),
            ListTile(
              leading: const Icon(Icons.local_hospital),
              title: const Text("Allergies"),
              subtitle: Text(allergies),
            ),
            ListTile(
              leading: const Icon(Icons.health_and_safety),
              title: const Text("Chronic Conditions"),
              subtitle: Text(chronicConditions),
            ),

            // Vaccination History Section
            const SizedBox(height: 16),
            const Text(
              "Vaccination History",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.vaccines),
              title: const Text("COVID-19 Vaccine"),
              subtitle: Text(covidVaccine),
            ),
            ListTile(
              leading: const Icon(Icons.vaccines),
              title: const Text("Tetanus Vaccine"),
              subtitle: Text(tetanusVaccine),
            ),
            ListTile(
              leading: const Icon(Icons.vaccines),
              title: const Text("HPV Vaccine"),
              subtitle: Text(hpvVaccine),
            ),

            // Emergency Contacts Section
            const SizedBox(height: 16),
            const Text(
              "Emergency Contacts",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text("Primary Contact"),
              subtitle: Text(primaryContact),
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text("Secondary Contact"),
              subtitle: Text(secondaryContact),
            ),

            // Additional Notes Section
            const SizedBox(height: 16),
            const Text(
              "Additional Notes",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.note),
              title: const Text("Notes"),
              subtitle: Text(additionalNotes),
            ),
          ],
        ),
      ),
    ),
  ),
);

        },
      ),
    );
  }
}
