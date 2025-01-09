import 'package:cure_connect_service/views/screens/see_all_options/see_all_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategorySeeAllOption extends StatelessWidget {
  const CategorySeeAllOption({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        Get.to(() => SeeAllCategoryPage(),
        transition: Transition.rightToLeft);
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: const Text(
        'See All',
        style: TextStyle(
          color: Color(0xFF4A78FF),
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
