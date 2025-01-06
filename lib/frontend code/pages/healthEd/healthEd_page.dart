import 'package:flutter/material.dart';
import 'package:mediease_app/frontend%20code/pages/healthEd/firstAid_page.dart';
import 'package:mediease_app/frontend%20code/pages/healthEd/healthyRelationships_page.dart';
import 'package:mediease_app/frontend%20code/pages/healthEd/mentalHealth_page.dart';
import 'package:mediease_app/frontend%20code/pages/healthEd/nutrition_page.dart';
import 'package:mediease_app/frontend%20code/pages/healthEd/physicalActivity_page.dart';
import 'package:mediease_app/frontend%20code/pages/healthEd/reproductiveHealth_page.dart';
import 'package:mediease_app/frontend%20code/pages/healthEd/sleepHygiene_page.dart';
import 'package:mediease_app/frontend%20code/pages/healthEd/substanceAwareness_page.dart';

class HealthEdPage extends StatelessWidget {
  const HealthEdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffCEECE3),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NutritionPage(), // Replace with your target page
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: buildCustomContainer(
                        imagePath: 'assets/images/nutrition.jpeg',
                        text: 'Nutrition & Diet',
                      ),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PhysicalactivityPage(), // Replace with your target page
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: buildCustomContainer(
                        imagePath: 'assets/images/physicalActivity.jpeg',
                        text: 'Physical Activity',
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MentalhealthPage(), // Replace with your target page
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: buildCustomContainer(
                        imagePath: 'assets/images/mentalHealth.jpeg',
                        text: 'Mental Health',
                      ),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SleephygienePage(), // Replace with your target page
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: buildCustomContainer(
                        imagePath: 'assets/images/sleep.jpeg',
                        text: 'Sleep Hygiene',
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FirstAidBasics(), // Replace with your target page
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: buildCustomContainer(
                        imagePath: 'assets/images/firstAid.jpeg',
                        text: 'First Aid Basics',
                      ),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ReproductiveHealthPage(), // Replace with your target page
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: buildCustomContainer(
                        imagePath: 'assets/images/reproductiveHealth.jpeg',
                        text: 'Reproductive Health',
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SubstanceAwarenessPage(), // Replace with your target page
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: buildCustomContainer(
                        imagePath: 'assets/images/substanceAwareness.png',
                        text: 'Substance Awareness',
                      ),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HealthyRelationshipsPage(), // Replace with your target page
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: buildCustomContainer(
                        imagePath: 'assets/images/healthyRelationship.JPG',
                        text: 'Healthy Relationships',
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}

Widget buildCustomContainer({
  required String imagePath,
  required String text,
}) {
  return Container(
    width: 159,
    height: 190,
    decoration: BoxDecoration(
      color: Color(0xff279DA4),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.asset(
                imagePath,
                fit: BoxFit
                    .cover, // Ensures the image covers the container, cropping if needed
                height: 110,
                width: 180, // Specify the width you want
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}
