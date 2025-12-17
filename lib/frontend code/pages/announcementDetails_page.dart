import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AnnouncementDetailsPage extends StatelessWidget {
  final String announcementId;

  const AnnouncementDetailsPage({Key? key, required this.announcementId}) : super(key: key);

  Future<Map<String, dynamic>?> fetchAnnouncementDetails(String id) async {
    try {
      DocumentSnapshot announcementDoc = await FirebaseFirestore.instance
          .collection('announcements')
          .doc(id)
          .get();

      if (announcementDoc.exists) {
        return announcementDoc.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching announcement details: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Announcement Details"),
        backgroundColor: const Color(0xff9AD4CC),
        centerTitle: true,
      ),
      backgroundColor: Color.fromARGB(255, 106, 172, 163),
      body: FutureBuilder<Map<String, dynamic>?> (
        future: fetchAnnouncementDetails(announcementId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text("Error fetching announcement details"));
          }

          final announcement = snapshot.data!;
          final String title = announcement['title'] ?? 'No Title';
          final String content = announcement['content'] ?? 'No Content';
          final Timestamp timestamp = announcement['postedAt'] ?? Timestamp.now();
          final String formattedDate =
              DateFormat('dd MMMM yyyy').format(timestamp.toDate());

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
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
                    // Title
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Date
                    Text(
                      "Published on $formattedDate",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const Divider(height: 30, thickness: 1),
                    // Content
                    Text(
                      content,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
