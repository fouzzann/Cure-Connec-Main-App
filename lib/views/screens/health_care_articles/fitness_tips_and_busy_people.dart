import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FitnessTipsPage extends StatelessWidget {
  const FitnessTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFF4A78FF);

    return Scaffold(backgroundColor:Colors.white,
      appBar: AppBar(
        title: Text(
          'Fitness Tips for Busy People',  
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,color: Colors.black,),
          onPressed: () => Get.back(),
        ),
        backgroundColor:Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _IntroSection(primaryColor: primaryColor),
                const SizedBox(height: 16),
                ..._buildFitnessTips(context, primaryColor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFitnessTips(BuildContext context, Color primaryColor) {
    final tips = [
      {
        'number': '1',
        'title': 'Prioritize Your Health',
        'description': 'Recognize that your health is a priority, just like work and family commitments.',
        'details': [
          'Schedule fitness like you schedule meetings',
          'Commit to making time for your health',
          'Start with small, consistent efforts',
        ],
      },
      {
        'number': '2',
        'title': 'Set Realistic Goals',
        'description': 'Create achievable fitness goals that fit your lifestyle.',
        'details': [
          'Begin with 20-30 minute workouts',
          'Gradually increase intensity',
          'Celebrate progress, not perfection',
        ],
      },
      {
        'number': '3',
        'title': 'Use Short, Intense Workouts',
        'description': 'Maximize your limited time with High-Intensity Interval Training (HIIT).',
        'details': [
          'Quick 20-minute full-body workouts',
          'Alternate intense exercise and rest',
          'Burn more calories in less time',
        ],
      },
      {
        'number': '4',
        'title': 'Incorporate Fitness Into Daily Activities',
        'description': 'Find ways to stay active without dedicated workout time.',
        'details': [
          'Take stairs instead of elevator',
          'Walk or bike to work',
          'Do exercises during daily routines',
        ],
      },
      {
        'number': '5',
        'title': 'Use Technology and Apps',
        'description': 'Leverage fitness apps for guided, flexible workouts.',
        'details': [
          'Find apps with short workout routines',
          'Track progress digitally',
          'Get personalized fitness guidance',
        ],
      },
    ];

    return tips.map((tip) => _FitnessTipCard(
          tip: tip,
          primaryColor: primaryColor,
        )).toList();
  }
}

class _IntroSection extends StatelessWidget {
  final Color primaryColor;

  const _IntroSection({required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            Icons.fitness_center_rounded,
            color: primaryColor,
            size: 64,
          ),
          const SizedBox(height: 12),
          Text(
            'Staying Fit in a Busy World',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'Discover practical and effective ways to maintain your fitness, even with a demanding schedule. These tips will help you stay active, healthy, and energized.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[800],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _FitnessTipCard extends StatelessWidget {
  final Map<String, dynamic> tip;
  final Color primaryColor;

  const _FitnessTipCard({
    required this.tip,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(color: Colors.white,
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
                    backgroundColor: primaryColor,
                    child: Text(
                      tip['number'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      tip['title'],
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                tip['description'],
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 12),
              ...List.generate(
                (tip['details'] as List).length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: primaryColor,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          tip['details'][index],
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}