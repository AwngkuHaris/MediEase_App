import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:mediease_app/frontend%20code/pages/Admin/appointmentDetails_page.dart';

class AppointmentsPage extends StatefulWidget {
  @override
  _AppointmentsPageState createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  final CollectionReference appointmentsRef =
      FirebaseFirestore.instance.collection('appointments');
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('users');

  Future<String> fetchPatientName(String userId) async {
    try {
      DocumentSnapshot userDoc = await usersRef.doc(userId).get();
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        return userData['name'] ?? 'No Name';
      }
    } catch (e) {
      print('Error fetching patient name: $e');
    }
    return 'No Name';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(bottom: 10, top: 30),
              child: const Text(
                "Today's Appointments",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 110, 193, 182),
                  borderRadius: BorderRadius.circular(15)),
              height: 600,
              padding: const EdgeInsets.all(16.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: appointmentsRef
                    .where('appointmentDateTime',
                        isGreaterThanOrEqualTo: DateTime.now().subtract(
                            Duration(
                                hours: DateTime.now().hour,
                                minutes: DateTime.now().minute)))
                    .where('appointmentDateTime',
                        isLessThanOrEqualTo: DateTime.now()
                            .add(Duration(hours: 24 - DateTime.now().hour)))
                    .orderBy('appointmentDateTime')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Center(
                        child: Text("Error fetching appointments"));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: Text("No appointments for today"));
                  }

                  final appointments = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: appointments.length,
                    itemBuilder: (context, index) {
                      final data =
                          appointments[index].data() as Map<String, dynamic>;
                      final String userId = data['userId'] ?? 'Unknown';
                      final String doctorName =
                          data['doctorName'] ?? 'Dr. Ali';
                      final DateTime appointmentTime =
                          (data['appointmentDateTime'] as Timestamp).toDate();
                      final String formattedTime =
                          DateFormat('hh:mm a').format(appointmentTime);

                      return FutureBuilder<String>(
                        future: fetchPatientName(userId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          final patientName = snapshot.data ?? 'No Name';

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AppointmentDetailsPage(
                                          appointmentData: {
                                            ...data,
                                            'patientName': patientName,
                                          },
                                        )),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              padding: const EdgeInsets.all(16),
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Patient: $patientName",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Doctor: $doctorName",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Time: $formattedTime",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
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
    );
  }
}
