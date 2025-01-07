// lib/views/screens/welcome_page/widgets/page_indicator.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/welcome_page_controller.dart';

class PageIndicator extends StatelessWidget {
  final int pageCount;
  final WelcomePageController controller;

  const PageIndicator({
    super.key,
    required this.pageCount,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) => Obx(
          () => Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            height: 4,
            width: controller.currentIndex.value == index ? 32 : 12,
            decoration: BoxDecoration(
              color: controller.currentIndex.value == index
                  ? Color(0xFF1A59A7)
                  : Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ),
    );
  }
}