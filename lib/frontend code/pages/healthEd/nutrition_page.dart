import 'package:flutter/material.dart';

class NutritionPage extends StatelessWidget {
  const NutritionPage({super.key});

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
                'Nutrition & Diet',
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
                  'assets/images/nutrition.jpeg', 
                  fit: BoxFit.cover,
                  width: 300,
                  height: 200,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Basic of Nutririon',
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
                    'Macronutrients:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '   • Proteins: Essential for building and repairing tissues, making enzymes and hormones.\n'
                    'Sources: lean meat, fish, eggs, dairy, beans, lentils, nuts, and seeds.',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '   • Carbohydrates: The body\'s primary energy source. Includes whole grains, fruits, vegetables, and legumes. '
                    'Limit refined carbs like white bread and pastries.',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '   • Fats: Provide energy and support cell growth. Types:\n'
                    '       • Healthy fats: avocado, nuts, seeds, olive oil, fatty fish.\n'
                    '       • Limit saturated fats (red meat, butter) and avoid trans fats (processed snacks).',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Micronutrients:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '   • Vitamins: Essential for various bodily functions.\n'
                    '       • Vitamin A: Vision and immune function (carrots, sweet potatoes).\n'
                    '       • Vitamin C: Immune support and skin health (citrus, peppers).\n'
                    '       • Vitamin D: Bone health (sunlight, fortified foods).',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '   • Minerals:\n'
                    '       • Calcium: Bone strength (dairy, leafy greens).\n'
                    '       • Iron: Prevents anemia (red meat, spinach, beans).\n'
                    '       • Potassium: Heart and muscle function (bananas, potatoes).',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Dietary Guidelines',
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
                    'Balanced Meal Recommendations:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '• Use the Plate Method: Half vegetables and fruits, one-quarter lean protein, one-quarter whole grains.'
                    '• Include dairy or plant-based alternatives for calcium.'
                    '• Focus on variety and moderation.',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Portion Control:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '• Use smaller plates to avoid overeating.\n'
                    '• Visual cues for portions:\n'
                    '   • Protein: Palm-sized portion.\n'
                    '   • Carbs: Fist-sized.\n'
                    '   • Fats: Thumb-sized.',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Hydration:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '• Drink at least 8 glasses of water daily. \n'
                    '• Avoid sugary drinks and limit caffeine. \n',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Common Nutrition Myths',
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
                  SizedBox(height: 8),
                  Text(
                    '• Myth: Carbs make you fat. \n' 
                    '• Truth: Excess calories, not carbs, lead to weight gain. Choose complex carbs for sustained energy.',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '• Myth: Fat-free foods are healthier. \n' 
                    '• Truth: Fat-free often contains more sugar. Choose healthy fats instead.',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '• Myth:  Detox diets cleanse your body. \n' 
                    '• Truth: Your liver and kidneys detox naturally. Focus on a balanced diet.',
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
