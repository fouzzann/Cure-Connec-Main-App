// lib/views/screens/splash_screen/widgets/logo_container.dart

import 'package:flutter/material.dart';

class LogoContainer extends StatelessWidget {
  final Animation<double> pulseAnimation;

  const LogoContainer({
    super.key,
    required this.pulseAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: pulseAnimation.value,
          child: Container(
            width: 150,
            height: 150,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF4A78FF).withOpacity(0.2),
                  blurRadius: 30,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Image.asset(
              'assets/app_logo-removebg-preview.png',
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }
}


