import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  Future<List<Map<String, dynamic>>> fetchSpecificAppointments() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) return [];

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('appointments')
        .where('userId', isEqualTo: currentUser.uid)
        .get();

    // Map only the specific fields you need from the snapshot
    return snapshot.docs.map((doc) {
      var data = doc.data() as Map<String, dynamic>;
      return {
        'appointmentDate': data['appointmentDate'],
        'timeSlot': data['timeSlot'],
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Appointments"),
            FutureBuilder(
              future: fetchSpecificAppointments(),
              builder:
                  (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final appointments = snapshot.data ?? [];
                if (appointments.isEmpty) {
                  return Center(child: Text('No appointments found.'));
                }

                // Wrap the ListView.builder with Expanded to avoid layout issues
                return Expanded(
                  child: ListView.builder(
                    itemCount: appointments.length,
                    itemBuilder: (context, index) {
                      final appointment = appointments[index];
                      return ListTile(
                        title: Text('Date: ${appointment['appointmentDate']}'),
                        subtitle: Text('Time: ${appointment['timeSlot']}'),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
