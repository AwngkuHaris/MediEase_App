import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class BookappointmentPage extends StatefulWidget {
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
  Future<void> _bookAppointment() async {
    if (_selectedDay == null || selectedTimeSlot == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a date and a time slot')),
      );
      return;
    }

    // Combine date and time into a single DateTime object
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

      // Get the current user
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please log in to book an appointment')),
        );
        return;
      }

      // Save combinedDateTime to Firestore
      await FirebaseFirestore.instance.collection('appointments').add({
        'userId': currentUser.uid,
        'userName': currentUser.displayName ?? 'Unknown',
        'userEmail': currentUser.email ?? 'Unknown',
        'appointmentDateTime': combinedDateTime, // Save as DateTime
        'createdAt': FieldValue.serverTimestamp(),
        'status': 'scheduled',
        'title': 'Fever',
      });

      // Success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Appointment booked successfully!')),
      );

      // Clear selections after saving
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
      appBar: AppBar(
        backgroundColor: Color(0xff9AD4CC),
        title: Text("Book Appointment"),
        centerTitle: true,
      ),
      backgroundColor: Color(0xff9AD4CC),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18),
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
                      firstDay: DateTime.utc(2023),
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

              Padding(
                padding: const EdgeInsets.only(left: 18),
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
              MaterialButton(
                onPressed: () {
                  _bookAppointment();
                },
                minWidth: 300,
                height: 50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Color(0xff00589F),
                child: Text(
                  "Confirm Appointment",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
