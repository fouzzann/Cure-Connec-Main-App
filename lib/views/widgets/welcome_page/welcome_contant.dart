import 'package:cure_connect_service/views/widgets/welcome_screen/welcome_page_content.dart';
import 'package:flutter/material.dart';

class WelcomeContentView extends StatelessWidget {
  final WelcomeContent content;

  const WelcomeContentView({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: content.backgroundColor,
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            content.imagePath,
            height: 250,
          ),
          SizedBox(height: 32),
          Text(
            content.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A59A7),
            ),
          ),
          SizedBox(height: 16),
          Text(
            content.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}