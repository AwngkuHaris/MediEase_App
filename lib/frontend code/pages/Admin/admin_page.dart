import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:mediease_app/frontend%20code/pages/Admin/announcement_page.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<FlSpot> lineChartData = [];
  List<DateTime> fetchedDates = [];

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

    // Convert grouped data to line chart data
    List<FlSpot> tempLineChartData = [];
    List<DateTime> tempFetchedDates = [];
    int index = 0; // X-axis value starts from 0
    appointmentCounts.forEach((day, count) {
      tempLineChartData.add(FlSpot(
        index.toDouble(),
        count.toDouble(),
      ));
      tempFetchedDates.add(DateTime.parse(day));
      index++;
    });

    setState(() {
      lineChartData = tempLineChartData;
      fetchedDates = tempFetchedDates;
    });
  } catch (e) {
    print('Error fetching appointments: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Weekly Appointments Chart")),
      body: Column(children: [ lineChartData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Container(
            width: 300,
            height: 300,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(
                      show: true,
                      drawHorizontalLine: true,
                      horizontalInterval: 1,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Colors.grey.withOpacity(0.5),
                          strokeWidth: 1,
                        );
                      },
                      drawVerticalLine: false,
                    ),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            // Check if the index is within range
                            int index = value.toInt();
                            if (index < 0 || index >= lineChartData.length) {
                              return const Text('');
                            }
            
                            // Get the actual date corresponding to this index
                            DateTime date = fetchedDates[
                                index]; // Use the actual fetched date
                            String formattedDate =
                                DateFormat('MM/dd').format(date);
            
                            return Text(
                              formattedDate,
                              style: const TextStyle(fontSize: 10),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          interval: 1,
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style: TextStyle(fontSize: 10),
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
                        isCurved: true, // Makes the line curved
                        color: Colors.teal, // Line color
                        barWidth: 3, // Line thickness
                        belowBarData: BarAreaData(
                          show: true,
                          color: Colors.teal.withOpacity(0.3), // Fill color
                        ),
                        dotData: FlDotData(show: true), // Dots on points
                      ),
                    ],
                    minX: 0,
                    maxX: lineChartData.length.toDouble() - 1,
                    minY: 0,
                  ),
                ),
              ),
          ),
          ElevatedButton(onPressed: (){
            Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AnnouncementsPage(), // Replace with your target page
                        ),
                      );

          }, child: Text("Announcement"))],)
    );
  }
}
