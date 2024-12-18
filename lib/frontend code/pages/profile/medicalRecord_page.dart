import 'package:flutter/material.dart';
import 'package:mediease_app/backend%20code/services/firestore.dart';

class MedicalrecordPage extends StatefulWidget {
  MedicalrecordPage({super.key});

  @override
  State<MedicalrecordPage> createState() => _MedicalrecordPageState();
}

class _MedicalrecordPageState extends State<MedicalrecordPage> {
  Map<String, dynamic>? userData;
  final FirestoreService _userService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final data = await _userService.getUserData();
    setState(() {
      userData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff9AD4CC),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff9AD4CC),
        title: Text("Medical Records"),
        titleTextStyle: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Personal Information",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Icon(Icons.edit_outlined)
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Text(
                        "Name:\n"
                        "Date of Birth:\n"
                        "Blood Type:\n"
                        "Allergies:\n"
                        "Chronic Conditions:\n",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        "${(userData?['name']?.isEmpty ?? true) ? 'Not set' : userData?['name']}\n"
                        "${(userData?['dateOfBirth']?.isEmpty ?? true) ? 'Not set' : userData?['dateOfBirth']}\n"
                        "${(userData?['bloodType']?.isEmpty ?? true) ? 'Not set' : userData?['bloodType']}\n"
                        "${(userData?['allergies']?.isEmpty ?? true) ? 'Not set' : userData?['allergies']}\n"
                        "${(userData?['chronicConditions']?.isEmpty ?? true) ? 'Not set' : userData?['chronicConditions']}\n",
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.black,
              ),
              Row(
                children: [
                  Text(
                    "Vaccination History",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Icon(Icons.edit_outlined)
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Text(
                        "COVID-19 Vaccine:\n"
                        "Tetanus:\n"
                        "HPV Vaccine:\n",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        "${(userData?['covidVaccine']?.isEmpty ?? true) ? 'Not set' : userData?['covidVaccine']}\n"
                        "${(userData?['tetanusVaccine']?.isEmpty ?? true) ? 'Not set' : userData?['tetanusVaccine']}\n"
                        "${(userData?['hpvVaccine']?.isEmpty ?? true) ? 'Not set' : userData?['hpvVaccine']}\n",
                      ),
                    ),
                  ),
                ],
              ),
              Divider(color: Colors.black),
              Row(
                children: [
                  Text(
                    "Emergency Contacts",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Icon(Icons.edit_outlined)
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Text(
                        "Primary:\n"
                        "Secondary:\n",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        "${(userData?['primaryContact']?.isEmpty ?? true) ? 'Not set' : userData?['primaryContact']}\n"
                        "${(userData?['secondaryContact']?.isEmpty ?? true) ? 'Not set' : userData?['secondaryContact']}\n",
                      ),
                    ),
                  ),
                ],
              ),
              Divider(color: Colors.black),
              Row(
                children: [
                  Text(
                    "Additional Notes",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Icon(Icons.edit_outlined)
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                  "${(userData?['notes']?.isEmpty ?? true) ? 'Not set' : userData?['notes']}\n",)
            ],
          ),
        ),
      ),
    );
  }
}
