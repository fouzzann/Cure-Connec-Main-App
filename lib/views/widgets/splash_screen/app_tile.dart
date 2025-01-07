// lib/views/screens/splash_screen/widgets/app_title.dart

import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'CURE CONNECT',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            letterSpacing: 3,
            color: Color(0xFF4A78FF),
            height: 1,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Healthcare Simplified',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF4A78FF).withOpacity(0.7),
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }
}
