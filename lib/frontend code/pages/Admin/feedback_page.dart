import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:mediease_app/frontend%20code/pages/Admin/feedbackDetails_page.dart';

class FeedbackManager extends StatefulWidget {
  @override
  _FeedbackManagerState createState() => _FeedbackManagerState();
}

class _FeedbackManagerState extends State<FeedbackManager> {
  final CollectionReference feedbacksRef =
      FirebaseFirestore.instance.collection('feedback');
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('users');

  Future<Map<String, dynamic>?> fetchUserDetails(String userId) async {
    try {
      DocumentSnapshot userDoc = await usersRef.doc(userId).get();
      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      return null; // Fallback in case of error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 110, 193, 182), // Background color
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              "Feedback Manager",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff5CA4C7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: StreamBuilder<QuerySnapshot>(
                  stream: feedbacksRef
                      .orderBy('submittedAt', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return const Center(
                          child: Text("Error fetching feedbacks"));
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(
                          child: Text("No feedbacks available"));
                    }

                    final feedbacks = snapshot.data!.docs;

                    return ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: feedbacks.length,
                      itemBuilder: (context, index) {
                        final data =
                            feedbacks[index].data() as Map<String, dynamic>;
                        final String userId = data['userId'] ?? '';
                        final Timestamp submittedAt =
                            data['submittedAt'] ?? Timestamp.now();
                        final String formattedDate = DateFormat('dd/MM/yyyy')
                            .format(submittedAt.toDate());

                        return FutureBuilder<Map<String, dynamic>?>(
                          future: fetchUserDetails(userId),
                          builder: (context, userSnapshot) {
                            if (!userSnapshot.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            final userData = userSnapshot.data;
                            final userName = userData?['name'] ?? 'Anonymous';
                            final profilePicture = userData?['profilePicture'];

                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 25,
                                  backgroundImage: profilePicture != null &&
                                          profilePicture.isNotEmpty
                                      ? NetworkImage(profilePicture)
                                      : AssetImage(
                                              'assets/images/default_profile.JPG')
                                          as ImageProvider,
                                  child: profilePicture == null ||
                                          profilePicture.isEmpty
                                      ? Text(
                                          userName[
                                              0], // First letter of the name
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      : null,
                                ),
                                title: Text(
                                  userName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  "Feedback submitted on $formattedDate",
                                  style: const TextStyle(fontSize: 14),
                                ),
                                trailing: const Icon(
                                  Icons.chevron_right,
                                  color: Colors.black,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FeedbackDetailsPage(
                                              feedbackId: feedbacks[index].id,
                                            )),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
