import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:mediease_app/frontend%20code/pages/Admin/announcement_page.dart';
import 'package:mediease_app/frontend%20code/pages/Admin/feedback_page.dart';
import 'package:mediease_app/frontend%20code/pages/Admin/userList_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mediease_app/frontend%20code/pages/main_page.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _selectedPageIndex = 0;

  // Define the pages for the admin dashboard
  final List<Widget> _pages = [
    DashboardPage(),
    AnnouncementsPage(),
    FeedbackManager(),
    UserListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Admin Dashboard"),
        backgroundColor: const Color(0xFF9ad4cc),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: const Color(0xFF9ad4cc),
              ),
              child: Center(
                child: Text(
                  'Admin Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.analytics),
              title: const Text("Dashboard"),
              onTap: () {
                setState(() {
                  _selectedPageIndex = 0; // Show Dashboard
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.announcement),
              title: const Text("Announcements"),
              onTap: () {
                setState(() {
                  _selectedPageIndex = 1; // Show Announcements
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text("Feedback"),
              onTap: () {
                setState(() {
                  _selectedPageIndex = 2; // Show Feedback
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text("Users"),
              onTap: () {
                setState(() {
                  _selectedPageIndex = 3; // Show User List
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedPageIndex],
    );
  }
}

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<FlSpot> lineChartData = [];
  List<String> xAxisLabels = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    try {
      // Fetch appointments from Firestore
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('appointments')
          .where(
            'appointmentDateTime',
            isGreaterThanOrEqualTo: DateTime.now().subtract(Duration(days: 7)),
          )
          .where('appointmentDateTime', isLessThanOrEqualTo: DateTime.now())
          .orderBy('appointmentDateTime')
          .get();

      // Initialize date range for the past 7 days
      List<DateTime> last7Days = List.generate(7, (index) {
        return DateTime.now().subtract(Duration(days: 6 - index));
      });

      // Initialize appointment counts for all days
      Map<String, int> appointmentCounts = {
        for (DateTime date in last7Days)
          DateFormat('yyyy-MM-dd').format(date): 0,
      };

      // Count appointments for each day
      for (var doc in snapshot.docs) {
        DateTime date = (doc['appointmentDateTime'] as Timestamp).toDate();
        String day = DateFormat('yyyy-MM-dd').format(date);
        appointmentCounts[day] = (appointmentCounts[day] ?? 0) + 1;
      }

      // Prepare data for the chart
      List<FlSpot> tempLineChartData = [];
      List<String> tempXAxisLabels = [];
      int index = 0; // X-axis index
      appointmentCounts.forEach((day, count) {
        tempLineChartData.add(FlSpot(index.toDouble(), count.toDouble()));

        // Format date to include year (e.g., "MM/dd/yyyy")
        tempXAxisLabels
            .add(DateFormat('MM/dd/yyyy').format(DateTime.parse(day)));
        index++;
      });

      setState(() {
        lineChartData = tempLineChartData;
        xAxisLabels = tempXAxisLabels;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching appointments: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            "Appointments in Last 7 Days",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _isLoading
              ? const CircularProgressIndicator()
              : lineChartData.isEmpty
                  ? const Text("No data available.")
                  : SizedBox(
                      height: 300,
                      width: 350,
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(
                            show: true,
                            drawHorizontalLine: true,
                            drawVerticalLine: false,
                            horizontalInterval: 1,
                            getDrawingHorizontalLine: (value) => FlLine(
                              color: Colors.grey.withOpacity(0.5),
                              strokeWidth: 1,
                            ),
                          ),
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                                getTitlesWidget: (value, meta) {
                                  int index = value.toInt();
                                  if (index < 0 ||
                                      index >= xAxisLabels.length) {
                                    return const Text('');
                                  }
                                  return Text(
                                    xAxisLabels[
                                        index], // Shows "MM/dd/yyyy" format
                                    style: const TextStyle(fontSize: 10),
                                  );
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    value.toInt().toString(),
                                    style: const TextStyle(fontSize: 10),
                                  );
                                },
                              ),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          borderData: FlBorderData(
                            show: true,
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              spots: lineChartData,
                              isCurved: true,
                              color: Colors.teal,
                              barWidth: 3,
                              belowBarData: BarAreaData(
                                show: true,
                                color: Colors.teal.withOpacity(0.3),
                              ),
                              dotData: FlDotData(show: true),
                            ),
                          ],
                          minX: 0,
                          maxX: lineChartData.length.toDouble() - 1,
                          minY: 0,
                        ),
                      ),
                    ),
        ],
      ),
    );
  }
}
