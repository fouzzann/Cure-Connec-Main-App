import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HealthyEatingHabits extends StatelessWidget {
  const HealthyEatingHabits({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '10 Healthy Eating Habits', 
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white,),
          onPressed: () => Get.back(),
        ),
        backgroundColor: const Color(0xFF4A78FF), // Updated color
        elevation: 0,
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _IntroSection(),
              SizedBox(height: 16),
              _HealthHabitItem(
                number: '1',
                title: 'Eat a Balanced Diet',
                description: 'A balanced diet is crucial for providing all the nutrients your body needs to function properly.',
                details: [
                  'Choose whole grains like brown rice and quinoa',
                  'Include lean proteins from chicken, fish, and plant sources',
                  'Incorporate healthy fats from olive oil and avocados',
                  'Aim for a colorful variety of fruits and vegetables',
                ],
              ),
              _HealthHabitItem(
                number: '2',
                title: 'Start with a Healthy Breakfast',
                description: 'Breakfast sets the tone for your entire day, providing essential energy and nutrients.',
                details: [
                  'Whole grain toast or oatmeal for fiber',
                  'Protein sources like eggs or Greek yogurt',
                  'Add fresh fruits for vitamins and antioxidants',
                  'Never skip your morning meal',
                ],
              ),
              _HealthHabitItem(
                number: '3',
                title: 'Include More Fruits and Vegetables',
                description: 'Fruits and vegetables are packed with essential nutrients and help prevent chronic diseases.',
                details: [
                  'Aim for 5 servings daily',
                  'Eat a variety of colors',
                  'Add to cereals, salads, and smoothies',
                  'Choose fresh, seasonal produce',
                ],
              ),
              _HealthHabitItem(
                number: '4',
                title: 'Drink Plenty of Water',
                description: 'Water is essential for digestion, nutrient transportation, and overall bodily functions.',
                details: [
                  'Drink at least 8 cups daily',
                  'Replace sugary drinks with water',
                  'Add lemon or cucumber for flavor',
                  'Stay hydrated throughout the day',
                ],
              ),
              _HealthHabitItem(
                number: '5',
                title: 'Control Portion Sizes',
                description: 'Managing portion sizes is key to maintaining a healthy weight and preventing overeating.',
                details: [
                  'Use smaller plates',
                  'Eat slowly and mindfully',
                  'Listen to your body\'s hunger cues',
                  'Stop eating when you feel satisfied',
                ],
              ),
              _HealthHabitItem(
                number: '6',
                title: 'Reduce Sugar and Salt Intake',
                description: 'Minimizing added sugars and sodium can prevent various health issues.',
                details: [
                  'Limit processed foods',
                  'Choose natural sweeteners',
                  'Use herbs and spices instead of salt',
                  'Read food labels carefully',
                ],
              ),
              _HealthHabitItem(
                number: '7',
                title: 'Plan Your Meals',
                description: 'Meal planning helps ensure nutritious eating and reduces impulsive food choices.',
                details: [
                  'Weekly meal preparation',
                  'Create a grocery list',
                  'Prep meals in advance',
                  'Avoid last-minute unhealthy options',
                ],
              ),
              _HealthHabitItem(
                number: '8',
                title: 'Eat Mindfully',
                description: 'Mindful eating helps you enjoy food and recognize your body\'s signals.',
                details: [
                  'Eat without distractions',
                  'Chew thoroughly',
                  'Appreciate food\'s flavors and textures',
                  'Pay attention to hunger and fullness',
                ],
              ),
              _HealthHabitItem(
                number: '9',
                title: 'Choose Healthy Snacks',
                description: 'Smart snacking provides nutrition and helps maintain energy levels.',
                details: [
                  'Opt for nuts, seeds, and fruits',
                  'Prepare snacks in advance',
                  'Avoid processed snack foods',
                  'Keep nutritious options handy',
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IntroSection extends StatelessWidget {
  const _IntroSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFE1F2FF), // Updated color
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'Eating healthy is one of the most important steps toward living a longer and healthier life. Our bodies need a variety of nutrients to stay strong, active, and mentally sharp. By adopting these habits, you can improve your overall well-being and reduce the risk of many chronic diseases.',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: const Color(0xFF1E293B), // Updated color
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _HealthHabitItem extends StatelessWidget {
  final String number;
  final String title;
  final String description;
  final List<String> details;

  const _HealthHabitItem({
    required this.number,
    required this.title,
    required this.description,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: const Color(0xFF4A78FF), // Updated color
                    child: Text(
                      number,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF4A78FF), // Updated color
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 12),
              ...details.map((detail) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: const Color(0xFF4A78FF), // Updated color
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        detail,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
