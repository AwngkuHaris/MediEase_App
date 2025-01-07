import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentDetailsPage extends StatelessWidget {
  final Map<String, dynamic> appointmentData;

  const AppointmentDetailsPage({Key? key, required this.appointmentData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String patientName = appointmentData['patientName'] ?? 'No Name';
    final String doctorName = appointmentData['doctorName'] ?? 'Dr. Ali';
    final DateTime appointmentTime =
        (appointmentData['appointmentDateTime'] as Timestamp).toDate();
    final String formattedDate =
        DateFormat('EEEE, MMM d, yyyy').format(appointmentTime);
    final String formattedTime =
        DateFormat('hh:mm a').format(appointmentTime);
    final String reason = appointmentData['reasonOfAppointment'] ?? 'No reason provided';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Details'),
        backgroundColor: const Color(0xFF9ad4cc),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(decoration: BoxDecoration(
              color: Color(0xFF9ad4cc),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Patient: $patientName",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Doctor: $doctorName",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Date: $formattedDate",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Time: $formattedTime",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Reason: $reason",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
