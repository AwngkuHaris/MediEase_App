import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediease_app/backend%20code/services/firestore.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mediease_app/frontend%20code/pages/Admin/admin_page.dart';
import 'package:mediease_app/frontend%20code/pages/announcementDetails_page.dart';
import 'package:mediease_app/frontend%20code/pages/signin%20&%20signup/signin_page.dart';
import 'package:flutter/gestures.dart';

class HomePage extends StatefulWidget {
  final Function(int) onTabChange;

  const HomePage({super.key, required this.onTabChange});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference announcementsRef =
      FirebaseFirestore.instance.collection('announcements');
  final User? currentUser = FirebaseAuth.instance.currentUser;
  bool get isSignedIn => currentUser != null;

  final FirestoreService _userService = FirestoreService();
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final data = await _userService.getUserData();
    if (mounted) {
      // Check if the widget is still in the widget tree
      setState(() {
        userData = data;
      });
    }
  }

  Future<Map<String, dynamic>?> fetchClosestAppointment() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) return null;

    // Query appointments sorted by appointmentDateTime
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('appointments')
        .where('userId', isEqualTo: currentUser.uid)
        .where('appointmentDateTime',
            isGreaterThan: DateTime.now()) // Future appointments
        .orderBy('appointmentDateTime')
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      Map<String, dynamic> appointment =
          snapshot.docs.first.data() as Map<String, dynamic>;

      // Extract the appointmentDateTime (Timestamp)
      Timestamp appointmentTimestamp = appointment['appointmentDateTime'];
      DateTime appointmentDateTime = appointmentTimestamp.toDate();

      // Format the date as "Weekday, day Month"
      String formattedDate = DateFormat('EEEE, d MMMM')
          .format(appointmentDateTime); // e.g., "Wednesday, 20 November"
      String formattedTime =
          DateFormat('hh:mm a').format(appointmentDateTime); // e.g., "02:30 PM"

      // Add formatted date and time to the result map
      appointment['formattedDate'] = formattedDate;
      appointment['formattedTime'] = formattedTime;

      return appointment;
    }
    return null; // No appointments found
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff9AD4CC),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xff9AD4CC),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    isSignedIn
                        ? CircleAvatar(
                            backgroundImage: currentUser!.photoURL != null
                                ? NetworkImage(currentUser!.photoURL!)
                                : null,
                            radius: 40,
                            child: currentUser!.photoURL == null
                                ? Text(currentUser!.displayName?[0] ?? '')
                                : null,
                          )
                        : CircleAvatar(
                            child: Icon(Icons.person, size: 28),
                          ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isSignedIn
                                ? "Hello ${userData?['name'] ?? 'User'}"
                                : "Welcome, Guest",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "Welcome to MediEase",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    Text(
                      "Upcoming Appointments",
                      style: TextStyle(
                          color: Color(0xff2A3E66),
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                    Spacer(),
                    GestureDetector(
                      child: Text(
                        "See all",
                        style:
                            TextStyle(color: Color(0xff2A3E66), fontSize: 12),
                      ),
                      onTap: () {
                        widget.onTabChange(
                            2); // Switch to the HealthEd tab (index 1)
                      },
                    ),
                  ],
                ),
              ),
              isSignedIn
                  ? FutureBuilder(
                      future: fetchClosestAppointment(),
                      builder: (context,
                          AsyncSnapshot<Map<String, dynamic>?> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        }

                        final appointment = snapshot.data;

                        if (appointment == null) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                'No upcoming appointments.',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                          );
                        }

                        // Display the closest appointment in a card
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
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
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  appointment['title'],
                                  style: const TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: const Color(0xff279DA4),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Date:",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            appointment['formattedDate'],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Text(
                                        "|",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Time:",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            appointment['formattedTime'],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
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
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Log in ',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SigninPage(), // Replace with your SigninPage
                                      ),
                                    );
                                  },
                              ),
                              const TextSpan(
                                text: 'to view your upcoming appointments.',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors
                                      .black, // Normal text style for non-clickable part
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    Text(
                      "HealthEd",
                      style: TextStyle(
                          color: Color(0xff2A3E66),
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                    Spacer(),
                    GestureDetector(
                      child: Text(
                        "See all",
                        style:
                            TextStyle(color: Color(0xff2A3E66), fontSize: 12),
                      ),
                      onTap: () {
                        widget.onTabChange(
                            1); // Switch to the HealthEd tab (index 1)
                      },
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(0.2), // Shadow color (with opacity)
                      spreadRadius: 3, // How much the shadow spreads
                      blurRadius: 10, // How blurry the shadow is
                      offset: const Offset(
                          0, 3), // Shadow position (x and y offset)
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width,
                height: 280,
                margin: const EdgeInsets.all(
                    15.0), // Adds space around the container
                padding: const EdgeInsets.all(
                    16.0), // Adds space inside the container
                child: Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.asset(
                          'assets/images/physicalActivity.jpeg',
                          fit: BoxFit
                              .cover, // Ensures the image covers the container, cropping if needed
                          height: 240,
                          width: 160,
                        )),
                    Spacer(),
                    Container(
                      color: Colors.white,
                      height: 240,
                      width: 140,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Physical Activity Benefits",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "1. Strengthens heart & lungs.\n"
                            "2. Reduce symptoms of depression and anxiety.\n"
                            "3.Improves sleep quality.",
                            style: TextStyle(fontSize: 13),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 25, right: 20),
                child: Row(
                  children: [
                    Text(
                      "Announcements",
                      style: TextStyle(
                          color: Color(0xff2A3E66),
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ],
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: announcementsRef
                    .orderBy('postedAt', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Center(
                        child: Text("Error fetching announcements"));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: Text("No announcements available"));
                  }

                  final announcements = snapshot.data!.docs;

                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: announcements.length,
                          separatorBuilder: (context, index) => Divider(
                            color: Colors.grey.shade400,
                            thickness: 1,
                          ),
                          itemBuilder: (context, index) {
                            final data = announcements[index].data()
                                as Map<String, dynamic>;
                            final String title = data['title'] ?? 'Untitled';
                            final Timestamp timestamp =
                                data['postedAt'] ?? Timestamp.now();
                            final String formattedDate =
                                DateFormat('dd MMM yyyy')
                                    .format(timestamp.toDate());

                            return ListTile(
                              title: Text(
                                title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
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
                                          AnnouncementDetailsPage(
                                            announcementId:
                                                announcements[index].id,
                                          )),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
