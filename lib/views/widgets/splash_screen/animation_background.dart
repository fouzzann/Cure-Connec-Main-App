// lib/views/screens/splash_screen/widgets/animated_background.dart

import 'package:flutter/material.dart';

class AnimatedBackground extends StatelessWidget {
  final Animation<double> rotateAnimation;

  const AnimatedBackground({
    super.key,
    required this.rotateAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(3, (index) {
        return Positioned(
          top: index * 200.0,
          right: -100 + (index * 50.0),
          child: AnimatedBuilder(
            animation: rotateAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: rotateAnimation.value + (index * 0.5),
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF4A78FF).withOpacity(0.1),
                        Color(0xFF4A78FF).withOpacity(0.05),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}