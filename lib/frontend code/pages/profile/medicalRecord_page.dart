import 'package:flutter/material.dart';
import 'package:mediease_app/backend%20code/services/firestore.dart';
import 'package:intl/intl.dart'; // Add this import for date formatting

class MedicalrecordPage extends StatefulWidget {
  const MedicalrecordPage({super.key});

  @override
  State<MedicalrecordPage> createState() => _MedicalrecordPageState();
}

class _MedicalrecordPageState extends State<MedicalrecordPage> {
  Map<String, dynamic>? userData;
  final FirestoreService _userService = FirestoreService();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    setState(() {
      isLoading = true;
    });
    final data = await _userService.getUserData();
    setState(() {
      userData = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff9AD4CC),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff9AD4CC),
        title: const Text("Medical Records"),
        titleTextStyle: const TextStyle(
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
                  GestureDetector(
                      onTap: _showEditPersonalInfoDialog,
                      child: Icon(Icons.edit_outlined)),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: const Text(
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
              const Divider(
                color: Colors.black,
              ),
              Row(
                children: [
                  Text(
                    "Vaccination History",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: _showEditVaccinationHistoryDialog,
                      child: Icon(Icons.edit_outlined)),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: const Text(
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
              const Divider(color: Colors.black),
              Row(
                children: [
                  Text(
                    "Emergency Contacts",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: _showEditEmergencyContactsDialog,
                      child: Icon(Icons.edit_outlined)),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: const Text(
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
              const Divider(color: Colors.black),
              Row(
                children: [
                  Text(
                    "Additional Notes",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: _showEditNotesDialog,
                      child: Icon(Icons.edit_outlined)),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "${(userData?['notes']?.isEmpty ?? true) ? 'Not set' : userData?['notes']}\n",
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showEditPersonalInfoDialog() {
    final nameController = TextEditingController(text: userData?['name'] ?? '');
    final bloodTypeController =
        TextEditingController(text: userData?['bloodType'] ?? '');
    final allergiesController =
        TextEditingController(text: userData?['allergies'] ?? '');
    final chronicConditionsController =
        TextEditingController(text: userData?['chronicConditions'] ?? '');

    // Date of birth handling
    DateTime? selectedDateOfBirth;
    if (userData?['dateOfBirth'] != null) {
      selectedDateOfBirth = DateTime.tryParse(
          userData!['dateOfBirth']); // Assuming the date is stored as a string
    }

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text("Edit Personal Information"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: "Name"),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDateOfBirth ?? DateTime.now(),
                        firstDate: DateTime(1900), // Earliest selectable date
                        lastDate: DateTime.now(), // Latest selectable date
                      );
                      if (pickedDate != null) {
                        // Update the dialog state to show the selected date immediately
                        setDialogState(() {
                          selectedDateOfBirth = pickedDate;
                        });
                      }
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        controller: TextEditingController(
                          text: selectedDateOfBirth != null
                              ? DateFormat('dd-MM-yyyy')
                                  .format(selectedDateOfBirth!)
                              : '',
                        ),
                        decoration: const InputDecoration(
                          labelText: "Date of Birth",
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                      ),
                    ),
                  ),
                  TextField(
                    controller: bloodTypeController,
                    decoration: const InputDecoration(labelText: "Blood Type"),
                  ),
                  TextField(
                    controller: allergiesController,
                    decoration: const InputDecoration(labelText: "Allergies"),
                  ),
                  TextField(
                    controller: chronicConditionsController,
                    decoration:
                        const InputDecoration(labelText: "Chronic Conditions"),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              MaterialButton(
                color: const Color(0xff9AD4CC),
                onPressed: () async {
                  await _userService.updateUserData(
                    name: nameController.text,
                    dateOfBirth: selectedDateOfBirth != null
                        ? DateFormat('dd-MM-yyyy').format(selectedDateOfBirth!)
                        : null,
                    bloodType: bloodTypeController.text,
                    allergies: allergiesController.text,
                    chronicConditions: chronicConditionsController.text,
                  );
                  await _fetchUserData();
                  Navigator.pop(context);
                },
                child: const Text("Save"),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showEditVaccinationHistoryDialog() {
    final covidVaccineController =
        TextEditingController(text: userData?['covidVaccine'] ?? '');
    final tetanusVaccineController =
        TextEditingController(text: userData?['tetanusVaccine'] ?? '');
    final hpvVaccineController =
        TextEditingController(text: userData?['hpvVaccine'] ?? '');

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text("Edit Vaccination History"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: covidVaccineController,
                    decoration:
                        const InputDecoration(labelText: "COVID-19 Vaccine"),
                  ),
                  TextField(
                    controller: tetanusVaccineController,
                    decoration:
                        const InputDecoration(labelText: "Tetanus Vaccine"),
                  ),
                  TextField(
                    controller: hpvVaccineController,
                    decoration: const InputDecoration(labelText: "HPV Vaccine"),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              MaterialButton(
                color: const Color(0xff9AD4CC),
                onPressed: () async {
                  await _userService.updateUserData(
                    covidVaccine: covidVaccineController.text,
                    tetanusVaccine: tetanusVaccineController.text,
                    hpvVaccine: hpvVaccineController.text,
                  );
                  await _fetchUserData();
                  Navigator.pop(context);
                },
                child: const Text("Save"),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showEditEmergencyContactsDialog() {
    final primaryContactController =
        TextEditingController(text: userData?['primaryContact'] ?? '');
    final secondaryContactController =
        TextEditingController(text: userData?['secondaryContact'] ?? '');

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text("Edit Emergency Contacts"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: primaryContactController,
                    decoration:
                        const InputDecoration(labelText: "Primary Contact"),
                  ),
                  TextField(
                    controller: secondaryContactController,
                    decoration:
                        const InputDecoration(labelText: "Secondary Contact"),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              MaterialButton(
                color: const Color(0xff9AD4CC),
                onPressed: () async {
                  await _userService.updateUserData(
                    primaryContact: primaryContactController.text,
                    secondaryContact: secondaryContactController.text,
                  );
                  await _fetchUserData();
                  Navigator.pop(context);
                },
                child: const Text("Save"),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showEditNotesDialog() {
    final notesController =
        TextEditingController(text: userData?['notes'] ?? '');

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text("Edit Additional Notes"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: notesController,
                    decoration: const InputDecoration(labelText: "Notes"),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              MaterialButton(
                color: const Color(0xff9AD4CC),
                onPressed: () async {
                  await _userService.updateUserData(
                    notes: notesController.text,
                  );
                  await _fetchUserData();
                  Navigator.pop(context);
                },
                child: const Text("Save"),
              ),
            ],
          );
        },
      ),
    );
  }
}
