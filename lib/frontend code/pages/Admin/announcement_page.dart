import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:mediease_app/frontend%20code/pages/Admin/addAnnouncement_page.dart';
import 'package:mediease_app/frontend%20code/pages/Admin/editAnnouncement_page.dart';

class AnnouncementsPage extends StatefulWidget {
  @override
  _AnnouncementsPageState createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  final CollectionReference announcementsRef =
      FirebaseFirestore.instance.collection('announcements');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9AD4CC), // Background color

      body: StreamBuilder<QuerySnapshot>(
        stream:
            announcementsRef.orderBy('postedAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Error fetching announcements"));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No announcements available"));
          }

          final announcements = snapshot.data!.docs;

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
                    // Title Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Announcement List",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddAnnouncementPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff5CA4C7),
                          ),
                          child: const Text(
                            "+ Add Announcement",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Table Header
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 1),
                        ),
                      ),
                      child: Row(
                        children: const [
                          Expanded(
                            flex: 3,
                            child: Text(
                              "Announcement",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Date Published",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Actions",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Table Content
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: announcements.length,
                      itemBuilder: (context, index) {
                        final data =
                            announcements[index].data() as Map<String, dynamic>;
                        final String title = data['title'] ?? 'Untitled';
                        final Timestamp timestamp =
                            data['postedAt'] ?? Timestamp.now();
                        final String formattedDate = DateFormat('dd MMMM yyyy')
                            .format(timestamp.toDate());

                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(color: Colors.grey, width: 0.5),
                            ),
                          ),
                          child: Row(
                            children: [
                              // Announcement Title
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(
                                    title,
                                    style: const TextStyle(fontSize: 14),
                                    softWrap:
                                        true, // Allow text to wrap to a new line
                                    maxLines:
                                        5, // Set maximum lines (adjust as needed)
                                    overflow: TextOverflow
                                        .ellipsis, // Add "..." if it exceeds maxLines
                                  ),
                                ),
                              ),

                              // Date Published
                              Expanded(
                                flex: 2,
                                child: Text(
                                  formattedDate,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              // Actions
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    // Edit Button
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditAnnouncementPage(
                                                announcementId: announcements[
                                                        index]
                                                    .id, // Pass the announcement ID)
                                              ),
                                            ));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        minimumSize: const Size(60, 30),
                                      ),
                                      child: const Text(
                                        "Edit",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    // Delete Button
                                    ElevatedButton(
                                      onPressed: () async {
                                        // Delete functionality
                                        await announcementsRef
                                            .doc(announcements[index].id)
                                            .delete();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        minimumSize: const Size(60, 30),
                                      ),
                                      child: const Text(
                                        "Delete",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
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
