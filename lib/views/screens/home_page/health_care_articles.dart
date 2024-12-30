import 'package:cure_connect_service/views/screens/health_care_articles/10_health_eating_habits.dart';
import 'package:cure_connect_service/views/screens/health_care_articles/fitness_tips_and_busy_people.dart';
import 'package:cure_connect_service/views/screens/health_care_articles/mental_health.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HealthCareArticles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Health Care Articles',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black87,
              ), 
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'See All',
                style: TextStyle(
                  color: Color(0xFF4A78FF),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildHealthNewsCard(
                title: '10 Healthy Eating Habits',
                imageUrl: 'assets/healthy food image.png',
                readTime: '5 min read',
                index: 0,
              ),
              SizedBox(width: 16),
              _buildHealthNewsCard(
                title: 'Mental Health Awareness',
                imageUrl: 'assets/mental health image.png',
                readTime: '4 min read',
                index: 1,
              ),
              SizedBox(width: 16),
              _buildHealthNewsCard(
                title: 'Fitness Tips for Busy People',
                imageUrl: 'assets/fitness 2.png',
                readTime: '3 min read',
                index: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _navigateToArticle(int index) {
    switch (index) {
      case 0:
        Get.to(() => HealthyEatingHabits());
        break;
      case 1:
        Get.to(() => MentalHealth());  
        break;
      case 2:
        Get.to(() => FitnessTipsPage()); 
        break;
    }
  }

  Widget _buildHealthNewsCard({
    required String title,
    required String imageUrl,
    required String readTime,
    required int index,
  }) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(
              imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 150,
                  color: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      readTime,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ), 
                    TextButton(
                      onPressed: () => _navigateToArticle(index),
                      child: Text(
                        'Read More',
                        style: TextStyle(
                          color: Color(0xFF4A78FF),
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

