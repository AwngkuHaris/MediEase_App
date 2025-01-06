import 'package:flutter/material.dart';

class MentalhealthPage extends StatelessWidget {
  const MentalhealthPage({super.key});

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
                'Mental Health',
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
                  'assets/images/mentalHealth.jpeg', 
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Mental health is just as important as physical health. It influences how we think, feel, and act in daily life, and plays a significant role in our relationships, work, and overall well-being.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  color: Colors.black,
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
                    'Benefits of Good Mental Health: ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '   • Emotional Stability: Helps in coping with stress, anxiety, and depression.\n'
                    '   • Improved Relationships: Strong mental health supports positive interactions with family, friends, and coworkers.\n'
                    '   • Better Decision-Making: Clearer thinking and better problem-solving skills.\n'
                    '   • Physical Health: Mental well-being can reduce the risk of chronic physical illnesses like heart disease and diabetes.',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Common Mental Health Conditions: ',
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
                    'Anxiety: ',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '   • Feelings of nervousness, worry, or fear that can affect daily functioning.\n'
                    '   • Symptoms: Restlessness, rapid heartbeat, trouble concentrating, excessive worry.\n'
                    '   • Treatment: Therapy (CBT), relaxation techniques, medications.',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Depression: ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '   • Persistent sadness, loss of interest in daily activities, and feelings of hopelessness.\n'
                    '   • Symptoms: Fatigue, changes in appetite, sleep disturbances, lack of motivation.\n'
                    '   • Treatment: Therapy (CBT, IPT), medication (antidepressants), lifestyle changes.',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Stress: ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '   • Physical or emotional tension caused by external pressures.\n'
                    '   • Symptoms: Irritability, difficulty sleeping, tension headaches, racing thoughts.\n'
                    '   • Treatment: Relaxation techniques, time management, support systems.',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Mood Disorders: ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '   • Includes conditions like bipolar disorder, characterized by extreme mood swings.\n'
                    '   • Symptoms: Extreme highs (mania) or lows (depression).\n'
                    '   • Treatment: Medication (mood stabilizers), therapy, lifestyle changes.',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'PTSD (Post-Traumatic Stress Disorder): ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '   • A mental health condition triggered by experiencing or witnessing a traumatic event.\n'
                    '   • Symptoms: Flashbacks, nightmares, severe anxiety, emotional numbness.\n'
                    '   • Treatment: Trauma-focused therapy, EMDR (Eye Movement Desensitization and Reprocessing), medications.',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Tips for Maintaining Mental Health',
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
                    'Build Strong Social Connections: ',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '   • Spend time with loved ones and engage in positive social activities.\n'
                    '   • Join support groups or community activities to connect with others.',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Practice Mindfulness and Meditation: ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '   • Engage in activities that bring awareness to the present moment, like deep breathing or meditation.\n'
                    '   • Try apps or guided sessions to develop a consistent mindfulness practice.',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Regular Physical Activity: ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '   • Exercise releases endorphins, which improve mood and reduce stress.\n'
                    '   • Even a short walk or yoga session can help clear your mind.',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Healthy Eating and Sleep: ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '   • Eat a balanced diet rich in fruits, vegetables, and healthy fats.\n'
                    '   • Ensure you get 7-9 hours of quality sleep each night for mental and emotional well-being.',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Time Management and Boundaries: ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '   • Set realistic goals and break tasks into manageable chunks.\n'
                    '   • Learn to say no and set boundaries to avoid overwhelm.',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Seek Professional Help When Needed: ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '   • It\’s important to reach out to a therapist or counselor when dealing with persistent mental health issues.\n'
                    '   • Helplines: Include a list of local mental health helplines or hotlines for emergency support ',
                    style: TextStyle(fontSize: 16, color: Colors.white),
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
