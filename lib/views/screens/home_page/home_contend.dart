import 'package:cure_connect_service/views/widgets/home_content/top_rated_category_health_care/main_container.dart';
import 'package:flutter/material.dart';
import 'package:cure_connect_service/views/widgets/home_content/app_bar/search_bar.dart';
import 'package:cure_connect_service/views/widgets/home_content/app_bar/user_image.dart';
import 'package:cure_connect_service/views/widgets/home_content/app_bar/user_name.dart';

class HomeContent extends StatelessWidget {
  HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4A78FF),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 40, 24, 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [UserName(), UserImage()],
                ),
                const SizedBox(height: 24),
                AppBarSearchBar()
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(child: MainContainer()),
          ),
        ],
      ),
    );
  }
}
