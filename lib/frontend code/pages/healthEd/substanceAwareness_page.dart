import 'package:flutter/material.dart';

class SubstanceAwarenessPage extends StatelessWidget {
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/substanceAwareness.png', // Placeholder image
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Substance Awareness and Prevention',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Understanding the risks and consequences of substance abuse is essential for a healthier community. Substance awareness helps individuals make informed decisions and avoid harmful behaviors.',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Key Topics:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    SizedBox(height: 8),
                    // Using separate Text widgets for each topic
                    Text(
                      '- Effects of drug and alcohol abuse on mental and physical health.',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    Text(
                      '- Recognizing signs of substance misuse in yourself or others.',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    Text(
                      '- How to seek help and available support systems.',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    Text(
                      '- Strategies for prevention and staying substance-free.',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    Text(
                      '- Community and family roles in promoting awareness.',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Remember, being informed is the first step towards prevention and recovery. Together, we can build a safer and healthier future.',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              
            ],
          ),
        ),
      ),
    );
  }
}
