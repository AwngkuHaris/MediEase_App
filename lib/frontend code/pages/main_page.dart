import 'package:flutter/material.dart';
import 'package:mediease_app/frontend%20code/pages/healthEd/HealthEd_page.dart';
import 'package:mediease_app/frontend%20code/pages/appointment/appointment_page.dart';
import 'package:mediease_app/frontend%20code/pages/chat/chat_page.dart';
import 'package:mediease_app/frontend%20code/pages/home_page.dart';
import 'package:mediease_app/frontend%20code/pages/profile/profile_page.dart';

class MainPage extends StatefulWidget {
  final bool isSignedIn;
  const MainPage({super.key, required this.isSignedIn});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0; // Track the selected tab

  // Define pages for each tab
  final List<Widget> _pages = [
    HomePage(),
    HealthEdPage(),
    AppointmentPage(),
    ChatPage(),
    ProfilePage(),
  ];
  // Update the selected tab index
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes the back button
        title: Image.asset(
          'assets/images/mediease_logo.png', // Replace with your image asset path
          height: 125,
        ),
        centerTitle: true, // Center the image in the AppBar
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
        ],
        backgroundColor: const Color(0xff9AD4CC),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        child: BottomNavigationBar(
            currentIndex: _selectedIndex, // Highlight the selected tab
            onTap: _onItemTapped, // Handle tap events
            selectedFontSize: 12,
            selectedIconTheme: const IconThemeData(size: 25),
            unselectedFontSize: 10,
            unselectedIconTheme: const IconThemeData(size: 18),
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
            type: BottomNavigationBarType
                .fixed, // Ensure all icons remain visible
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: "Home",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.menu_book), label: "HealthEd"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month_outlined),
                  label: "Appointment"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat_outlined), label: "Chat"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline), label: "profile"),
            ]),
      ),
      body: _pages[_selectedIndex], // Show the selected page
    );
  }
}
