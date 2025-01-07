import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final AnimationController mainController;

  const LoadingIndicator({
    super.key,
    required this.mainController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: Color(0xFFE0E8FF),
      ),
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: mainController,
            builder: (context, child) {
              return FractionallySizedBox(
                widthFactor: mainController.value,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Color(0xFF4A78FF),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}