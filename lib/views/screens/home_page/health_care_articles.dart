import 'package:cure_connect_service/views/widgets/health_care_articles_contant_and_widgets/health_article_home_page_section/health_news_card.dart';
import 'package:flutter/material.dart';

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
              HealthNewsCard(
                title: '10 Healthy Eating Habits',
                imageUrl: 'assets/healthy food image.png',
                readTime: '5 min read',
                index: 0,
              ),
              SizedBox(width: 16),
              HealthNewsCard(
                title: 'Mental Health Awareness',
                imageUrl: 'assets/mental health image.png',
                readTime: '4 min read',
                index: 1,
              ),
              SizedBox(width: 16),
              HealthNewsCard(
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
}
