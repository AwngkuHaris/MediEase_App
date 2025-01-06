import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:mediease_app/frontend%20code/pages/appointment/appointment_page.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:lottie/lottie.dart';

class BookappointmentPage extends StatefulWidget {
  final Function(int) onTabChange;
  const BookappointmentPage({super.key, required this.onTabChange});

  @override
  _BookappointmentPageState createState() => _BookappointmentPageState();
}

class _BookappointmentPageState extends State<BookappointmentPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? selectedTimeSlot;

  final List<String> timeSlots = [
    '8 AM',
    '9 AM',
    '10 AM',
    '11 AM',
    '12 PM',
    '2 PM',
    '3 PM',
    '4 PM'
  ];

  // Function to book an appointment
Future<void> _bookAppointment(BuildContext context) async {
  if (_selectedDay == null || selectedTimeSlot == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please select a date and a time slot')),
    );
    return;
  }

  try {
    // Convert selectedTimeSlot (e.g., '8 AM') into a 24-hour time
    final timeFormat = DateFormat('h a'); // Parse '8 AM', '12 PM', etc.
    DateTime time = timeFormat.parse(selectedTimeSlot!);

    // Combine the selectedDay and time into a single DateTime object
    DateTime combinedDateTime = DateTime(
      _selectedDay!.year,
      _selectedDay!.month,
      _selectedDay!.day,
      time.hour,
      time.minute,
    );

    // Format the combinedDateTime
    String formattedDate = DateFormat('EEEE, MMM d, yyyy').format(combinedDateTime);
    String formattedTime = DateFormat('h:mm a').format(combinedDateTime);

    // Get the current user
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to book an appointment')),
      );
      return;
    }

    // Save combinedDateTime to Firestore
    String appointmentId =
        FirebaseFirestore.instance.collection('appointments').doc().id;

    await FirebaseFirestore.instance
        .collection('appointments')
        .doc(appointmentId)
        .set({
      'appointmentId': appointmentId,
      'userId': currentUser.uid,
      'userName': currentUser.displayName ?? 'Unknown',
      'userEmail': currentUser.email ?? 'Unknown',
      'appointmentDateTime': combinedDateTime,
      'createdAt': FieldValue.serverTimestamp(),
      'status': 'scheduled',
      'title': 'Medical Check-up',
    });

    // Show success dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 100,
                child: Lottie.asset(
                  'assets/animations/success.json',
                  repeat: false,
                ),
              ),
              const Text(
                'Appointment booked successfully!',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),
              ),
              const SizedBox(height: 10),
              const Text(
                'Your appointment is as below:',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 10),
              Text(
                'Date: $formattedDate',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                'Time: $formattedTime',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                'Place: Pusat Kesihatan Prima, UNIMAS',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog box
                widget.onTabChange(2); // Switch to the "Appointments" tab
                Navigator.pop(context); // Close the booking screen
              },
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  } catch (e) {
    print('Error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to book appointment: $e')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff9AD4CC),
        title: const Text("Book Appointment"),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xff9AD4CC),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 18),
                child: Text(
                  "Choose Appointment Date",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff2A3E66),
                  ),
                ),
              ),
              // Date Selection
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    TableCalendar(
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      },
                      headerStyle: const HeaderStyle(
                        titleCentered: true,
                        formatButtonVisible: false,
                      ),
                      calendarStyle: const CalendarStyle(
                        isTodayHighlighted: false,
                        selectedDecoration: BoxDecoration(
                          color: Color(0XFF00589F),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                      firstDay: DateTime.utc(2023),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: _focusedDay,
                      enabledDayPredicate: (day) {
                        return !day.isBefore(
                            DateTime.now().subtract(const Duration(days: 1)));
                      },
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Selected Date: ${_selectedDay != null ? DateFormat('yyyy-MM-dd').format(_selectedDay!) : "None"}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 18),
                child: Text(
                  "Choose Appointment Time",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff2A3E66),
                  ),
                ),
              ),

              // Time Slot Selection
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(16.0),
                child: Wrap(
                  spacing: 16.0,
                  runSpacing: 16.0,
                  children: timeSlots.map((time) {
                    final bool isSelected = selectedTimeSlot == time;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTimeSlot = time;
                        });
                      },
                      child: SizedBox(
                        width: 100,
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.teal[700]
                                : Colors.teal[300],
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: isSelected
                                ? [
                                    const BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 6,
                                      offset: Offset(2, 2),
                                    )
                                  ]
                                : [],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            time,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 18),
                child: Text(
                  "Please state the reason of your appointment",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff2A3E66),
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Reason of appointment", // Placeholder text
                    hintStyle: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black), // Style of placeholder text
                  ),
                ),
              ),

              // Book Appointment Button
              const SizedBox(height: 40),
              MaterialButton(
                onPressed: () {
                  _bookAppointment(context);
                },
                minWidth: 300,
                height: 50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: const Color(0xff00589F),
                child: const Text(
                  "Confirm Appointment",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
