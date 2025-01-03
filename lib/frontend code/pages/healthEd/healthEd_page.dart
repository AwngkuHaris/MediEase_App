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
        body: Column(
      children: [
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubstanceAwarenessPage(),
                ),
              );
            },
            child: Text("Substance Awareness")),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ReproductiveHealthPage()),
              );
            },
            child: Text("Reproductive Health")),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FirstAidBasics()),
              );
            },
            child: Text("First Aid")),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HealthyRelationshipsPage(),
                ),
              );
            },
            child: Text("Healthy Relationships")),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MentalhealthPage(),
                ),
              );
            },
            child: Text("Mental Health")),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PhysicalactivityPage(),
                ),
              );
            },
            child: Text("Physical Activity")),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SleephygienePage(),
                ),
              );
            },
            child: Text("Sleep Hygiene")),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NutritionPage(),
                ),
              );
            },
            child: Text("nutrition")),
      ],
    ));
  }
}
