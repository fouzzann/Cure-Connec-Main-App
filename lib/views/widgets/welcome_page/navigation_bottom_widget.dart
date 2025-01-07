// lib/views/screens/welcome_page/widgets/navigation_button.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/welcome_page_controller.dart';

class NavigationButton extends StatelessWidget {
  final int pageCount;
  final WelcomePageController controller;
  final VoidCallback onPressed;

  const NavigationButton({
    super.key,
    required this.pageCount,
    required this.controller,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: Obx(
        () => ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF1A59A7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
            elevation: 2,
          ),
          child: Text(
            controller.currentIndex.value == pageCount - 1
                ? 'Get Started'
                : 'Continue',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}