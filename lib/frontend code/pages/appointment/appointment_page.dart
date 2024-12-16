import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  Future<Map<String, dynamic>?> fetchClosestAppointment() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) return null;

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('appointments')
        .where('userId', isEqualTo: currentUser.uid)
        .get();

    // Parse and filter appointments
    final List<Map<String, dynamic>> upcomingAppointments = snapshot.docs
        .map((doc) {
          var data = doc.data() as Map<String, dynamic>;
          return {
            'title': data['title'] ?? 'Appointment',
            'appointmentDate': data['appointmentDate'],
            'timeSlot': data['timeSlot'],
            'dateTime': DateTime.parse(
                '${data['appointmentDate']} ${data['timeSlot']}'), // Combine date and time
          };
        })
        .where((appointment) => appointment['dateTime'].isAfter(DateTime.now()))
        .toList();

    // Sort appointments by time (closest first)
    upcomingAppointments.sort(
        (a, b) => a['dateTime'].compareTo(b['dateTime'])); // Ascending order

    // Return the closest appointment, or null if no appointments found
    return upcomingAppointments.isNotEmpty ? upcomingAppointments.first : null;
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
                    ));
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
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff2A3E66),
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
                                    appointment['appointmentDate'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
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
                                    appointment['timeSlot'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
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
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff2A3E66),
                                  minimumSize: const Size(120, 40),
                                ),
                                onPressed: () {
                                  // Reschedule logic
                                },
                                child: const Text(
                                  "Reschedule",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                  minimumSize: const Size(120, 40),
                                ),
                                onPressed: () {
                                  // Cancel appointment logic
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
            ],
          ),
        ),
      ),
    );
  }
}
