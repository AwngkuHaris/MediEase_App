import 'package:flutter/material.dart';

class ReproductiveHealthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          "Reproductive Health",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff9AD4CC),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
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
                      'assets/images/reproductiveHealth.jpeg', // Placeholder image
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Reproductive Health Matters',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Reproductive health encompasses a range of physical, emotional, and social aspects that contribute to an individual\'s well-being. It involves understanding your body, making informed choices, and accessing appropriate healthcare services when needed.',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Key Aspects of Reproductive Health:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '- Access to contraception and family planning resources to empower individuals and families.',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  Text(
                    '- Comprehensive education about sexual health to prevent unwanted pregnancies and the spread of STIs.',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  Text(
                    '- Regular health check-ups and screenings for conditions like cervical cancer, breast health, and prostate health.',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  Text(
                    '- Awareness and prevention of sexually transmitted infections (STIs) such as HIV/AIDS, chlamydia, and gonorrhea.',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  Text(
                    '- Support for maternal health, including prenatal care, safe childbirth practices, and postnatal support for new mothers.',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  Text(
                    '- Psychological support and counseling for issues related to sexual health, infertility, or family planning.',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Healthy Practices for Reproductive Health:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '- Maintain a balanced diet and stay physically active to support hormonal and reproductive health.',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  Text(
                    '- Practice safe sex and use protection, such as condoms, to reduce the risk of STIs.',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  Text(
                    '- Avoid smoking, excessive alcohol, and drugs that may impact fertility or reproductive organs.',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  Text(
                    '- Stay informed about vaccination options like HPV vaccines, which help prevent certain types of cancers.',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Remember, reproductive health is not just about preventing diseases; it\'s about living a fulfilling and healthy life. Empower yourself and others by spreading awareness and promoting good health practices.',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Learn More'),
                      content: Text(
                        'Explore more about reproductive health by consulting healthcare professionals, accessing trusted online resources, or attending community workshops.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: Text(
                  'Learn More',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

