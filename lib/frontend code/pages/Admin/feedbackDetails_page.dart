import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class FeedbackDetailsPage extends StatelessWidget {
  final String feedbackId;

  const FeedbackDetailsPage({Key? key, required this.feedbackId})
      : super(key: key);

  Future<Map<String, dynamic>?> fetchFeedbackDetails(String feedbackId) async {
    try {
      DocumentSnapshot feedbackDoc = await FirebaseFirestore.instance
          .collection('feedback')
          .doc(feedbackId)
          .get();

      if (feedbackDoc.exists) {
        return feedbackDoc.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching feedback details: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> fetchUserDetails(String userId) async {
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
      print("Error fetching user details: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 110, 193, 182),
      appBar: AppBar(
        title: const Text("Feedback Details"),
        backgroundColor: const Color(0xFF9ad4cc),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: fetchFeedbackDetails(feedbackId),
        builder: (context, feedbackSnapshot) {
          if (feedbackSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (feedbackSnapshot.hasError || !feedbackSnapshot.hasData) {
            return const Center(child: Text("Error fetching feedback details"));
          }

          final feedbackData = feedbackSnapshot.data!;
          final String userId = feedbackData['userId'] ?? 'Unknown User';
          final Timestamp submittedAt =
              feedbackData['submittedAt'] ?? Timestamp.now();
          final String formattedDate =
              DateFormat('dd/MM/yyyy').format(submittedAt.toDate());

          final appFeedback = feedbackData['appFeedback'] as Map<String, dynamic>;
          final hospitalFeedback =
              feedbackData['hospitalServiceFeedback'] as Map<String, dynamic>;

          return FutureBuilder<Map<String, dynamic>?>(
            future: fetchUserDetails(userId),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (userSnapshot.hasError || !userSnapshot.hasData) {
                return const Center(child: Text("Error fetching user details"));
              }

              final userData = userSnapshot.data!;
              final String userName = userData['name'] ?? 'Anonymous';
              final String? profilePicture = userData['profilePicture'];

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // User Info
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: profilePicture != null
                                    ? NetworkImage(profilePicture)
                                    : null,
                                child: profilePicture == null
                                    ? Text(
                                        userName[0],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24),
                                      )
                                    : null,
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Submitted on $formattedDate",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Divider(height: 30, thickness: 1),
                          // App Feedback
                          const Text(
                            "App Feedback",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text("Ease of Use: ${appFeedback['easeOfUse']}/5"),
                          Text(
                              "Feature Satisfaction: ${appFeedback['featureSatisfaction']}/5"),
                          Text("Speed & Reliability: ${appFeedback['speedReliability']}/5"),
                          Text("Design: ${appFeedback['design']}/5"),
                          const SizedBox(height: 8),
                          const Text(
                            "Comments",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("What they liked: ${appFeedback['comments']['likeMost']}"),
                          Text("Improvements: ${appFeedback['comments']['improvements']}"),
                          const Divider(height: 30, thickness: 1),
                          // Hospital Feedback
                          const Text(
                            "Hospital Service Feedback",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text("Ease of Access: ${hospitalFeedback['easeOfAccess']}/5"),
                          Text(
                              "Service Satisfaction: ${hospitalFeedback['serviceSatisfaction']}/5"),
                          Text("Efficiency & Reliability: ${hospitalFeedback['efficiencyReliability']}/5"),
                          Text("Environment Comfort: ${hospitalFeedback['environmentComfort']}/5"),
                          const SizedBox(height: 8),
                          const Text(
                            "Comments",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                              "Best Part: ${hospitalFeedback['comments']['bestPart']}"),
                          Text(
                              "Improvements: ${hospitalFeedback['comments']['improvements']}"),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
