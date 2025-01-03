import 'package:flutter/material.dart';

class FirstAidBasics extends StatelessWidget {
  const FirstAidBasics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          "First Aid Basics",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff9AD4CC),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                   ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/firstAid.jpeg', // Placeholder image
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'First Aid Basics',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildSectionTitle('What is First Aid?'),
            const SizedBox(height: 8),
            _buildTextContent(
                'First Aid is the initial assistance or care given to a person suffering from an injury or illness until professional medical help is available.'),
            const SizedBox(height: 16),
            _buildSectionTitle('Essential First Aid Steps:'),
            const SizedBox(height: 8),
            _buildCard([
              _buildStep(
                icon: Icons.warning,
                title: '1. Check for Danger',
                description:
                    'Ensure the scene is safe for you and the victim before providing aid.',
              ),
              _buildStep(
                icon: Icons.phone,
                title: '2. Call for Help',
                description:
                    'Dial emergency services for assistance. Provide the necessary information about the situation and location.',
              ),
              _buildStep(
                icon: Icons.healing,
                title: '3. Provide Basic First Aid',
                description:
                    '- For bleeding: Apply pressure to the wound with a clean cloth.\n'
                    '- For burns: Cool under running water for 10 minutes.\n'
                    '- For choking: Perform back blows or abdominal thrusts.',
              ),
              _buildStep(
                icon: Icons.monitor_heart,
                title: '4. Monitor the Victim',
                description:
                    'Keep the victim calm and check their vital signs (breathing, pulse) until help arrives.',
              ),
            ]),
            const SizedBox(height: 16),
            _buildSectionTitle('First Aid Kit Essentials:'),
            const SizedBox(height: 8),
            _buildCard([
              _buildListItem('Adhesive bandages (various sizes)'),
              _buildListItem('Sterile gauze pads and medical tape'),
              _buildListItem('Antiseptic wipes and ointment'),
              _buildListItem('Scissors and tweezers'),
              _buildListItem('Gloves and a CPR mask'),
              _buildListItem('Pain relievers and emergency contact numbers'),
            ]),
            const SizedBox(height: 16),
            _buildSectionTitle('Did You Know?'),
            const SizedBox(height: 8),
            _buildTextContent(
                'Performing CPR immediately can double or triple a cardiac arrest victim’s chance of survival. Always be prepared!'),
            const SizedBox(height: 16),
            Image.asset(
              'assets/images/helpSupport.jpeg',
              height: 200,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Emergency services feature coming soon!')),
          );
        },
        child: const Icon(Icons.emergency),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.teal,
      ),
    );
  }

  Widget _buildTextContent(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        height: 1.5,
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      shadowColor: Colors.teal.shade200,
      color: Colors.teal.shade50,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  Widget _buildStep(
      {required IconData icon,
      required String title,
      required String description}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.teal, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.teal, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
