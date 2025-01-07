import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  bool isLoading = true; // Show a loading indicator while checking
  bool hasSubmittedFeedback = false; // Flag for feedback existence
  Map<String, dynamic>? feedbackData; // Store fetched feedback data

  @override
  void initState() {
    super.initState();
    _checkFeedback(); // Check if feedback exists
  }

  Future<void> _checkFeedback() async {
    try {
      // Get current user
      final User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        setState(() {
          isLoading = false; // Stop loading
        });
        return;
      }

      // Check if feedback exists
      final feedbackDoc = await FirebaseFirestore.instance
          .collection('feedback')
          .doc(currentUser.uid)
          .get();

      if (feedbackDoc.exists) {
        setState(() {
          hasSubmittedFeedback = true;
          feedbackData = feedbackDoc.data(); // Store feedback data
          isLoading = false; // Stop loading
        });
      } else {
        setState(() {
          hasSubmittedFeedback = false;
          isLoading = false; // Stop loading
        });
      }
    } catch (e) {
      print('Error checking feedback: $e');
      setState(() {
        isLoading = false; // Stop loading even if there's an error
      });
    }
  }

  int appEaseOfUse = 5,
      appFeatureSatisfaction = 5,
      appSpeedReliability = 5,
      appDesign = 5;
  int hospitalEaseOfAccess = 5,
      hospitalServiceSatisfaction = 5,
      hospitalEfficiency = 5,
      hospitalComfort = 5;

  final TextEditingController appLikeMostController = TextEditingController();
  final TextEditingController appImprovementsController =
      TextEditingController();
  final TextEditingController hospitalBestPartController =
      TextEditingController();
  final TextEditingController hospitalImprovementsController =
      TextEditingController();

  Future<void> submitFeedback() async {
    try {
      // Get the current user's UID
      final User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You must be logged in to submit feedback.')),
        );
        return;
      }

      final String userId = currentUser.uid;

      // Create the feedback data
      final feedbackData = {
        "userId": userId,
        "appFeedback": {
          "easeOfUse": appEaseOfUse,
          "featureSatisfaction": appFeatureSatisfaction,
          "speedReliability": appSpeedReliability,
          "design": appDesign,
          "comments": {
            "likeMost": appLikeMostController.text,
            "improvements": appImprovementsController.text,
          }
        },
        "hospitalServiceFeedback": {
          "easeOfAccess": hospitalEaseOfAccess,
          "serviceSatisfaction": hospitalServiceSatisfaction,
          "efficiencyReliability": hospitalEfficiency,
          "environmentComfort": hospitalComfort,
          "comments": {
            "bestPart": hospitalBestPartController.text,
            "improvements": hospitalImprovementsController.text,
          }
        },
        "submittedAt": FieldValue.serverTimestamp(),
      };

      // Save the feedback to Firestore with UID as the document ID
      final feedbackDocRef =
          FirebaseFirestore.instance.collection('feedback').doc(userId);

      // Check if the feedback already exists
      final feedbackDoc = await feedbackDocRef.get();
      if (feedbackDoc.exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You have already submitted feedback.')),
        );
        return;
      }

      // Add feedback to Firestore
      await feedbackDocRef.set(feedbackData);

      // Add a notification for feedback submission
      final notificationData = {
        "message": "Your feedback has been submitted successfully.",
        "createdAt": FieldValue.serverTimestamp(),
        "isRead": false,
      };

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('notifications')
          .add(notificationData);

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
                  'Feedback submitted successfully!',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog box
                  Navigator.pop(context); // Close the booking screen
                },
                child: const Text('Done'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error submitting feedback: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to submit feedback. Try again later.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Show a loading indicator while checking feedback
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      backgroundColor: const Color(0xff9AD4CC),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff9AD4CC),
        title: const Text("Feedback Form"),
        titleTextStyle: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      body: hasSubmittedFeedback
          ? _buildFeedbackSubmittedUI() // UI for users who submitted feedback
          : _buildFeedbackFormUI(), // UI for users who haven't submitted feedback
    );
  }

  Widget _buildFeedbackSubmittedUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  "Thank you for your feedback!",
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                if (feedbackData != null) ...[
                  Text(
                    "App Feedback:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      "Ease of Use: ${feedbackData!['appFeedback']['easeOfUse']} star"),
                  Text(
                      "Feature Satisfaction: ${feedbackData!['appFeedback']['featureSatisfaction']} star"),
                  Text(
                      "Speed & Reliability: ${feedbackData!['appFeedback']['speedReliability']} star"),
                  Text(
                      "Design: ${feedbackData!['appFeedback']['design']} star"),
                  SizedBox(
                    height: 10,
                  ),
                  Text("What you like most about the app:"),
                  Text(feedbackData!['appFeedback']['comments']['likeMost'] ??
                      "No comment provided."),
                  SizedBox(height: 10),
                  Text("Suggestions for improvement:"),
                  Text(feedbackData!['appFeedback']['comments']
                          ['improvements'] ??
                      "No comment provided."),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Hospital Service Feedback:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      "Ease of Access: ${feedbackData!['hospitalServiceFeedback']['easeOfAccess']} star"),
                  Text(
                      "Service Satisfaction: ${feedbackData!['hospitalServiceFeedback']['serviceSatisfaction']} star"),
                  Text(
                      "Efficiency & Reliability: ${feedbackData!['hospitalServiceFeedback']['efficiencyReliability']} star"),
                  Text(
                      "Environment & Comfort: ${feedbackData!['hospitalServiceFeedback']['environmentComfort']} star"),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Best experience at the hospital:"),
                  Text(feedbackData!['hospitalServiceFeedback']['comments']
                          ['bestPart'] ??
                      "No comment provided."),
                  Text("Hospital service improvements:"),
                  Text(feedbackData!['hospitalServiceFeedback']['comments']
                          ['improvements'] ??
                      "No comment provided."),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackFormUI() {
    return SingleChildScrollView(
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
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "App Feedback:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Text("Ease of Use:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(),
                RatingBar.builder(
                  itemSize: 20,
                  initialRating: 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      appEaseOfUse = rating.toInt();
                      ; // Update the variable with the new rating
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("Feature Satisfaction:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(),
                RatingBar.builder(
                  itemSize: 20,
                  initialRating: 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      appFeatureSatisfaction = rating.toInt();
                      ; // Update the variable with the new rating
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("Speed & Reliability:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(),
                RatingBar.builder(
                  itemSize: 20,
                  initialRating: 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      appSpeedReliability = rating.toInt();
                      ; // Update the variable with the new rating
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("Design:", style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(),
                RatingBar.builder(
                  itemSize: 20,
                  initialRating: 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      appDesign = rating.toInt();
                      ; // Update the variable with the new rating
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text("What do you like the most about the app?",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              height: 35,
              padding:
                  const EdgeInsets.all(8.0), // Padding inside the container
              decoration: BoxDecoration(
                color: Colors.white, // Background color of the container
                borderRadius: BorderRadius.circular(30.0), // Rounded corners
                border: Border.all(
                  color: Color(0xff05808C), // Border color
                  width: 1.0, // Border width
                ),
              ),
              child: TextField(
                controller: appLikeMostController,
                decoration: const InputDecoration(
                  border: InputBorder.none, // Removes the default border
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text("What can we improve in the app?",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              height: 35,
              padding:
                  const EdgeInsets.all(8.0), // Padding inside the container
              decoration: BoxDecoration(
                color: Colors.white, // Background color of the container
                borderRadius: BorderRadius.circular(30.0), // Rounded corners
                border: Border.all(
                  color: Color(0xff05808C), // Border color
                  width: 1.0, // Border width
                ),
              ),
              child: TextField(
                controller: appImprovementsController,
                decoration: const InputDecoration(
                  border: InputBorder.none, // Removes the default border
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(
              color: Colors.black,
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Hospital Service Feedback:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Text("Ease of Access:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(),
                RatingBar.builder(
                  itemSize: 20,
                  initialRating: 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      hospitalEaseOfAccess = rating.toInt();
                      ; // Update the variable with the new rating
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("Service Satisfaction:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(),
                RatingBar.builder(
                  itemSize: 20,
                  initialRating: 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      hospitalServiceSatisfaction = rating.toInt();
                      ; // Update the variable with the new rating
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("Efficiency & Reliability:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(),
                RatingBar.builder(
                  itemSize: 20,
                  initialRating: 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      hospitalEfficiency = rating.toInt();
                      ; // Update the variable with the new rating
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("Environment & Comfort:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(),
                RatingBar.builder(
                  itemSize: 20,
                  initialRating: 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      hospitalComfort = rating.toInt();
                      ; // Update the variable with the new rating
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "What was your best part of your experience at the hospital?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              height: 35,
              padding:
                  const EdgeInsets.all(8.0), // Padding inside the container
              decoration: BoxDecoration(
                color: Colors.white, // Background color of the container
                borderRadius: BorderRadius.circular(30.0), // Rounded corners
                border: Border.all(
                  color: Color(0xff05808C), // Border color
                  width: 1.0, // Border width
                ),
              ),
              child: TextField(
                controller: hospitalBestPartController,
                decoration: const InputDecoration(
                  border: InputBorder.none, // Removes the default border
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("What could be improved in the hospital service?",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              height: 35,
              padding:
                  const EdgeInsets.all(8.0), // Padding inside the container
              decoration: BoxDecoration(
                color: Colors.white, // Background color of the container
                borderRadius: BorderRadius.circular(30.0), // Rounded corners
                border: Border.all(
                  color: Color(0xff05808C), // Border color
                  width: 1.0, // Border width
                ),
              ),
              child: TextField(
                controller: hospitalImprovementsController,
                decoration: const InputDecoration(
                  border: InputBorder.none, // Removes the default border
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            MaterialButton(
              onPressed: () {
                submitFeedback();
              },
              minWidth: 300,
              height: 50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: const Color(0xff00589F),
              child: const Text(
                "Submit Feedback",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
