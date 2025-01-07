import 'package:cure_connect_service/views/widgets/welcome_page/navigation_bottom_widget.dart';
import 'package:cure_connect_service/views/widgets/welcome_page/page_indicatoe.dart';
import 'package:flutter/material.dart';
import '../../../../controllers/welcome_page_controller.dart';

class WelcomeBottomBar extends StatelessWidget {
  final int pageCount;
  final WelcomePageController controller;
  final VoidCallback onNavigate;

  const WelcomeBottomBar({
    super.key,
    required this.pageCount,
    required this.controller,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PageIndicator(
              pageCount: pageCount,
              controller: controller,
            ),
            SizedBox(height: 32),
            NavigationButton(
              pageCount: pageCount,
              controller: controller,
              onPressed: onNavigate,
            ),
          ],
        ),
      ),
    );
  }
}