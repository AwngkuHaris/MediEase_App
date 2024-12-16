import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentPage extends StatefulWidget {
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
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
  Future<void> _bookAppointment() async {
    if (_selectedDay == null || selectedTimeSlot == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a date and a time slot')),
      );
      return;
    }

    // Combine date and time slot into a readable format
    String formattedDate =
        DateFormat('yyyy-MM-dd').format(_selectedDay!); // Format the date
    String appointmentDateTime = '$formattedDate - $selectedTimeSlot';

    // Get current user
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please log in to book an appointment')),
      );
      return;
    }

    try {
      // Store appointment in Firestore
      await FirebaseFirestore.instance.collection('appointments').add({
        'userId': currentUser.uid,
        'userName': currentUser.displayName ?? 'Unknown',
        'userEmail': currentUser.email ?? 'Unknown',
        'appointmentDate': formattedDate,
        'timeSlot': selectedTimeSlot,
        'createdAt': FieldValue.serverTimestamp(),
        'status': 'scheduled',
      });

      // Success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Appointment booked successfully!')),
      );

      // Clear selection after saving
      setState(() {
        _selectedDay = null;
        selectedTimeSlot = null;
      });
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
      backgroundColor: Color(0xff9AD4CC),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Date Selection
              Container(
                color: Colors.white,
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
                      headerStyle: HeaderStyle(
                        titleCentered: true,
                        formatButtonVisible: false,
                      ),
                      calendarStyle: CalendarStyle(
                        isTodayHighlighted: false,
                        selectedDecoration: BoxDecoration(
                          color: Color(0XFF00589F),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                      firstDay: DateTime.now(),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: _focusedDay,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Selected Date: ${_selectedDay != null ? DateFormat('yyyy-MM-dd').format(_selectedDay!) : "None"}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
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
                          padding: EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.teal[700]
                                : Colors.teal[300],
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
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
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              // Book Appointment Button
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _bookAppointment,
                child: Text(
                  "Book Appointment",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0XFF00589F),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
