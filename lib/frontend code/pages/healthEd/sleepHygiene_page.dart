import 'package:flutter/material.dart';

class SleephygienePage extends StatelessWidget {
  const SleephygienePage ({super.key});

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
                'Sleep Hygiene',
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
                  'assets/images/sleep.jpeg',
                  fit: BoxFit.cover,
                  width: 300,
                  height: 200,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Good sleep hygiene is essential for improving the quality of sleep, which impacts overall health, mood, productivity, and well-being. Practicing good sleep hygiene helps regulate your sleep-wake cycle, making it easier to fall asleep, stay asleep, and feel rested upon waking.',
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
                    'Benefits of Proper Sleep Hygiene: ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '   • Improved Sleep Quality: Helps you fall asleep faster and enjoy deeper sleep.\n'
                    '   • Better Mental Health: Reduces stress, anxiety, and irritability.\n'
                    '   • Physical Health: Supports immune function, reduces the risk of chronic diseases, and promotes physical recovery.\n'
                    '   • Increased Productivity: Enhances focus, memory, and decision-making skills.',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Sleep Hygiene Tips ',
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
                    'Create a Consistent Sleep Schedule: ',
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '   • Set Regular Bedtimes.\n'
                    '   • Avoid Naps',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Create a Sleep-Friendly Environment: ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '   • Comfortable Mattress and Pillow. \n'
                    '   • Dark Room.\n'
                    '   • Quiet Environment. \n'
                    '   • Cool Room Temperature.\n'
                    '   • Limit Electronics.',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Establish a Relaxing Pre-Sleep Routine: ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                   SizedBox(height: 8),
                  Text(
                    '   • Wind Down.\n'
                    '   • Avoid Stimulants: Avoid caffeine, nicotine, and alcohol close to bedtime. \n'
                    '   • Mindfulness or Meditation.',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Be Mindful of What You Eat and Drink: ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                   SizedBox(height: 8),
                  Text(
                    '   • Limit Heavy Meals. \n'
                    '   • Hydrate Wisely.\n'
                    '   • Caffeine-Free Drinks.',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Get Regular Physical Activity: ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                   SizedBox(height: 8),
                  Text(
                    '   • Exercise During the Day.\n'
                    '   • Avoid Intense Exercise Before Bed.',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Managing Sleep Disorders',
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
                    'If you continue to have trouble sleeping despite following good sleep hygiene, you may have a sleep disorder. Here are some common ones: ',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                      'Imsomnia: ',
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '   • Difficulty falling asleep or staying asleep, leading to fatigue during the day.\n'
                    '   • Management: Cognitive Behavioral Therapy for Insomnia (CBT-I), relaxation techniques, and establishing a bedtime routine.',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Sleep Apnea: ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '   • Breathing disruptions during sleep, often accompanied by snoring.\n'
                    '   • Management: Seek medical attention for diagnosis and potential treatments like a CPAP machine. ',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Restless Leg Syndrome (RLS): ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                   SizedBox(height: 8),
                  Text(
                    '   • Uncomfortable sensations in the legs, often leading to a constant urge to move them, especially at night.\n'
                    '   • Management: Avoiding caffeine and alcohol, regular exercise, and stretching before bed can help.',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Narcolepsy: ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                   SizedBox(height: 8),
                  Text(
                    '   • Excessive daytime sleepiness and sudden sleep attacks during the day.\n'
                    '   • Management: Proper diagnosis and medication can help manage symptoms.',
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
