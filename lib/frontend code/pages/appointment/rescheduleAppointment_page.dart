import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mediease_app/frontend%20code/pages/appointment/bookAppointment_page.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:table_calendar/table_calendar.dart';

class RescheduleAppointmentPage extends StatefulWidget {
  final String appointmentId;
  final DateTime currentDateTime;
  final Function(int) onTabChange;

  const RescheduleAppointmentPage({
    super.key,
    required this.appointmentId,
    required this.currentDateTime,
    required this.onTabChange,
  });

  @override
  _RescheduleAppointmentPageState createState() =>
      _RescheduleAppointmentPageState();
}

class _RescheduleAppointmentPageState extends State<RescheduleAppointmentPage> {
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

  Future<void> _rescheduleAppointment(BuildContext context) async {
    if (_selectedDay == null || selectedTimeSlot == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a new date and time slot')),
      );
      return;
    }

    try {
      final timeFormat = DateFormat('h a');
      DateTime time = timeFormat.parse(selectedTimeSlot!);

      DateTime combinedDateTime = DateTime(
        _selectedDay!.year,
        _selectedDay!.month,
        _selectedDay!.day,
        time.hour,
        time.minute,
      );

      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(widget.appointmentId)
          .update(
              {'appointmentDateTime': Timestamp.fromDate(combinedDateTime)});

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
                  child: Lottie.asset('assets/animations/success.json',
                      repeat: false),
                ),
                const Text(
                  'Appointment rescheduled successfully!',
                  textAlign: TextAlign.center,
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
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to reschedule appointment: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.currentDateTime; // Pre-select the passed date
    _focusedDay = widget.currentDateTime; // Focus on the passed date
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff9AD4CC),
      appBar: AppBar(
        backgroundColor: const Color(0xff9AD4CC),
        title: const Text("Reschedule Appointment"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 22),
                child: Text(
                  "Select a New Date",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff2A3E66),
                  ),
                ),
              ),
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
              const SizedBox(height: 20),
              const Text(
                "Select a New Time Slot",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
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
              const SizedBox(height: 20),
              MaterialButton(
                onPressed: () {
                  _rescheduleAppointment(context);
                },
                minWidth: 300,
                height: 50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: const Color(0xff00589F),
                child: const Text(
                  "Confirm Reschedule",
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
