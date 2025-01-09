import 'package:cure_connect_service/views/screens/see_all_options/see_all_top_rated_doctors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopRatedDrSeeallOption extends StatelessWidget {
  const TopRatedDrSeeallOption({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Get.to(() => SeeAllTopRatedDoctors(),  
        transition: Transition.rightToLeftWithFade);
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
