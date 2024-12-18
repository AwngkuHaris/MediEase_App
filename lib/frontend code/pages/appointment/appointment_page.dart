import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mediease_app/frontend%20code/pages/appointment/bookAppointment_page.dart';
import 'package:intl/intl.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
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

  Future<List<Map<String, dynamic>>> fetchAppointmentHistory() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) return [];

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('appointments')
        .where('userId', isEqualTo: currentUser.uid)
        .where('appointmentDateTime',
            isLessThan: DateTime.now()) // Past appointments
        .orderBy('appointmentDateTime', descending: true) // Sort by most recent
        .get();

    List<Map<String, dynamic>> appointments = [];

    for (var doc in snapshot.docs) {
      Map<String, dynamic> appointment = doc.data() as Map<String, dynamic>;

      // Extract the appointmentDateTime (Timestamp)
      Timestamp appointmentTimestamp = appointment['appointmentDateTime'];
      DateTime appointmentDateTime = appointmentTimestamp.toDate();

      // Format the date and time
      String formattedDate =
          DateFormat('EEEE, d MMMM').format(appointmentDateTime);
      String formattedTime = DateFormat('hh:mm a').format(appointmentDateTime);

      appointment['formattedDate'] = formattedDate;
      appointment['formattedTime'] = formattedTime;

      appointments.add(appointment);
    }

    return appointments;
  }

  Future<void> deleteAppointment(String appointmentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(appointmentId)
          .delete();
      print('Appointment deleted successfully');
    } catch (e) {
      print('Error deleting appointment: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff9AD4CC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    const Text(
                      "Upcoming Appointments",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff2A3E66),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        // Action for "See all"
                      },
                      child: const Text(
                        "See all",
                        style: TextStyle(
                          color: Color(0xff2A3E66),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: fetchClosestAppointment(),
                builder:
                    (context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Date:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  Text(
                                    appointment['formattedDate'],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              Text("|"),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Time:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  Text(
                                    appointment['formattedTime'],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MaterialButton(
                                height: 50,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                color: Color(0xff2A3E66),
                                onPressed: () {
                                  // Reschedule logic
                                },
                                child: const Text(
                                  "Reschedule",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                              MaterialButton(
                                height: 50,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                color: Color(0xffD9534F),
                                onPressed: () async {
                                  final String appointmentId = appointment[
                                      'appointmentId']; // Ensure this key is available
                                  await deleteAppointment(appointmentId);

                                  // Refresh the UI
                                  setState(() {});
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Appointment canceled successfully!')),
                                  );
                                },
                                child: const Text(
                                  "Cancel Appointment",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    const Text(
                      "Appointments History",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff2A3E66),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        // Action for "See all"
                      },
                      child: const Text(
                        "See all",
                        style: TextStyle(
                          color: Color(0xff2A3E66),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Display Appointment History
              FutureBuilder<List<Map<String, dynamic>>>(
                future: fetchAppointmentHistory(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final appointments = snapshot.data;

                  if (appointments == null || appointments.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'No appointment history available.',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                    );
                  }
                  List<Widget> appointmentTiles =
                      appointments.map((appointment) {
                    return _buildListTile(
                      appointment['title'],
                      appointment['formattedDate'],
                      () {
                        // Action for tapping on a past appointment
                      },
                    );
                  }).toList();

                  return _buildSection(context, appointmentTiles);
                },
              ),

              MaterialButton(
                minWidth: 300,
                height: 50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Color(0xff00589F),
                child: Text(
                  "Book New Appointment",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookappointmentPage(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, List<Widget> tiles) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(5.0),
      child: Column(children: tiles),
    );
  }

  Widget _buildListTile(
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: subtitle.isNotEmpty
          ? Text(subtitle, style: TextStyle(fontSize: 12))
          : null,
    );
  }
}
