import 'package:flutter/material.dart';

class LoginHeroImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Hero(
        tag: 'login_image',
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.white.withOpacity(0.8)],
              ).createShader(bounds);
            },
            child: Image.asset(
              'assets/Screenshot_2024-11-20_120720-removebg-preview.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}