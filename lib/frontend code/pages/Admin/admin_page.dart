import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:mediease_app/frontend%20code/pages/Admin/announcement_page.dart';
import 'package:mediease_app/frontend%20code/pages/Admin/appointment_page.dart';
import 'package:mediease_app/frontend%20code/pages/Admin/feedbackDetails_page.dart';
import 'package:mediease_app/frontend%20code/pages/Admin/feedback_page.dart';
import 'package:mediease_app/frontend%20code/pages/Admin/setting_page.dart';
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
    AppointmentsPage(),
    AnnouncementsPage(),
    FeedbackManager(),
    UserListPage(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
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
              leading: const Icon(Icons.schedule),
              title: const Text("Appointments"),
              onTap: () {
                setState(() {
                  _selectedPageIndex = 1; // Show User List
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.announcement),
              title: const Text("Announcements"),
              onTap: () {
                setState(() {
                  _selectedPageIndex = 2; // Show Announcements
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text("Feedback"),
              onTap: () {
                setState(() {
                  _selectedPageIndex = 3; // Show Feedback
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text("Users"),
              onTap: () {
                setState(() {
                  _selectedPageIndex = 4; // Show User List
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {
                setState(() {
                  _selectedPageIndex = 5; // Show Announcements
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

  final CollectionReference feedbacksRef =
      FirebaseFirestore.instance.collection('feedback');
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('users');

  Future<Map<String, dynamic>?> fetchUserDetails(String userId) async {
    try {
      DocumentSnapshot userDoc = await usersRef.doc(userId).get();
      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      return null; // Fallback in case of error
    }
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

        // Format date to display only day and month (e.g., "dd/MM")
        tempXAxisLabels.add(DateFormat('dd/MM').format(DateTime.parse(day)));
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
      child: Padding(
        padding: EdgeInsets.all(15),
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
                                          index], // Shows "dd/MM" format
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
            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 20),
              child: const Text(
                "Feedbacks",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff5CA4C7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: StreamBuilder<QuerySnapshot>(
                  stream: feedbacksRef
                      .orderBy('submittedAt', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return const Center(
                          child: Text("Error fetching feedbacks"));
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(
                          child: Text("No feedbacks available"));
                    }

                    final feedbacks = snapshot.data!.docs;

                    return ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: feedbacks.length,
                      itemBuilder: (context, index) {
                        final data =
                            feedbacks[index].data() as Map<String, dynamic>;
                        final String userId = data['userId'] ?? '';
                        final Timestamp submittedAt =
                            data['submittedAt'] ?? Timestamp.now();
                        final String formattedDate = DateFormat('dd/MM/yyyy')
                            .format(submittedAt.toDate());

                        return FutureBuilder<Map<String, dynamic>?>(
                          future: fetchUserDetails(userId),
                          builder: (context, userSnapshot) {
                            if (!userSnapshot.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            final userData = userSnapshot.data;
                            final userName = userData?['name'] ?? 'Anonymous';
                            final profilePicture = userData?['profilePicture'];

                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
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
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 25,
                                  backgroundImage: profilePicture != null &&
                                          profilePicture.isNotEmpty
                                      ? NetworkImage(profilePicture)
                                      : AssetImage(
                                              'assets/images/default_profile.JPG')
                                          as ImageProvider,
                                  child: profilePicture == null ||
                                          profilePicture.isEmpty
                                      ? Text(
                                          userName[
                                              0], // First letter of the name
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      : null,
                                ),
                                title: Text(
                                  userName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  "Feedback submitted on $formattedDate",
                                  style: const TextStyle(fontSize: 14),
                                ),
                                trailing: const Icon(
                                  Icons.chevron_right,
                                  color: Colors.black,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FeedbackDetailsPage(
                                              feedbackId: feedbacks[index].id,
                                            )),
                                  );
                                },
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
      ),
    );
  }
}
