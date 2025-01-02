import 'package:flutter/material.dart';

class Helpsupport extends StatelessWidget {
  const Helpsupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF9AD4CC),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff9AD4CC),
        title: const Text("Help & Support"),
        titleTextStyle: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Stack(
            children: [
              // Background Image
              Container(
                height: 200,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/helpSupport.jpeg',
                  fit: BoxFit.cover,
                ),
              ),

              // White overlay
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.white
                    .withValues(alpha: 60), // Semi-transparent white
              ),

              // Content
              Column(
                children: [
                  const SizedBox(height: 16),
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          'Help & Support',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Hi! How can we help?',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Try "book appointment"',
                                prefixIcon:
                                    Icon(Icons.search, color: Colors.grey),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 12),

                                // Default border
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      8), // Rounded corners
                                  borderSide: BorderSide(
                                    color: Colors.grey, // Border color
                                    width: 1.0, // Border width
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Popular Questions',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 12),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                _buildQuestionTile('How do I schedule an appointment?'),
                _buildQuestionTile('How do I update my medical records?'),
                _buildQuestionTile('What is the process after appointment?'),
                _buildQuestionTile('How is the payment process?'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionTile(String question) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          question,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
        onTap: () {
          // Handle tap
        },
      ),
    );
  }
}
