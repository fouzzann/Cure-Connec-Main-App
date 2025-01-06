// lib/features/doctors/widgets/custom_app_bar.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    required this.title,
    super.key,
  });

  @override
  Size get preferredSize => Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(top: 18),
        child: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFF2B3467)),
        ),
      ),
      backgroundColor: Colors.white,
      title: Padding(
        padding: const EdgeInsets.only(top: 18),
        child: Text(
          title,
          style: TextStyle(
            color: Color(0xFF2B3467),
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
      ),
      centerTitle: true,
    );
  }
}