import 'package:flutter/material.dart';

class PhysicalactivityPage extends StatelessWidget {
  const PhysicalactivityPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade200,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark, color: Colors.white),
            onPressed: () {},
          ),
        ],
        title: Text(
          'HealthEd',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Physical Activity',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/physicalActivity.jpeg', 
                  height: 200,
                  width: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Importance:',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(39, 157, 164, 1),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Benefits: ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '• Physical Health: ',
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '   • Strengthens the heart and lungs.\n'
                    '   • Increases flexibility and muscle strength.\n'
                    '   • Enhances balance and coordination.\n'
                    '   • Reduces the risk of chronic diseases (diabetes, heart disease, hypertension).',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '• Mental Health: ',
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '   • Reduces symptoms of depression and anxiety.\n'
                    '   • Boosts mood and overall well-being by releasing endorphins.\n'
                    '   • Improves sleep quality.',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                   SizedBox(height: 16),
                  Text(
                    '• Weight Management: ',
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '   • Helps maintain or reduce body weight when combined with a balanced diet.',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Recommended Activity Levels',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(39, 157, 164, 1),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'For Adults: ',
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '   • 150 minutes of moderate-intensity aerobic activity weekly (e.g., brisk walking).\n'
                    '   • 75 minutes of vigorous-intensity aerobic activity weekly (e.g., running).\n'
                    '   • Strength training exercises on 2 or more days each week.\n'
                    '   • It\’s beneficial to spread exercise across the week, such as exercising for 30 minutes 5 days a week.',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'For Children \& Adolescents (6-17 years): ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '   • At least 60 minutes of physical activity daily.\n'
                    '   • This should include aerobic activity, muscle-strengthening activities, and bone-strengthening exercises.',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'For Other Adults: ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                   SizedBox(height: 8),
                  Text(
                    '   • Follow the same guidelines as adults, but adjust intensity based on fitness levels.\n'
                    '   • Focus on balance, flexibility, and strength exercises to prevent falls.',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Physical Activity for Specific Goals',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(39, 157, 164, 1),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Weight Loss: ',
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '   • Combine aerobic exercise with strength training.\n'
                    '   • Try HIIT (High-Intensity Interval Training) for maximum calorie burn in less time.\n'
                    '   • Stay consistent and pair physical activity with a balanced diet for the best results.',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Building Strength: ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '   • Focus on strength training 2-3 times a week, targeting all major muscle groups.\n'
                    '   • Increase weights or resistance over time for progressive muscle development.',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Improving Flexibility: ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                   SizedBox(height: 8),
                  Text(
                    '   • Regular stretching or yoga can improve flexibility.\n'
                    '   • Hold stretches for at least 15-30 seconds without bouncing.',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Stress Relief: ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                   SizedBox(height: 8),
                  Text(
                    '   • Yoga, Tai Chi, or simply going for a walk can reduce stress and improve mental clarity.\n'
                    '   • Breathing exercises during exercise can also help with relaxation.',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
