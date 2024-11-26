import 'package:cure_connect_service/controllers/dr_carousel.dart';
import 'package:cure_connect_service/widgets/home_content/app_bar/search_bar.dart';
import 'package:cure_connect_service/widgets/home_content/app_bar/user_image.dart';
import 'package:cure_connect_service/widgets/home_content/app_bar/user_name.dart';
import 'package:cure_connect_service/widgets/home_content/category_grid.dart';
import 'package:cure_connect_service/widgets/home_content/category_see_all_option.dart';
import 'package:cure_connect_service/widgets/home_content/top_rated_dr_see_all_option.dart';
import 'package:flutter/material.dart';

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
                  children: [
                   UserName(),
                   UserImage()
                  ],
                ),
                const SizedBox(height: 24),
              AppBarSearchBar()
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 55, left: 34, right: 34),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Top rated Doctors',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                        TopRatedDrSeeallOption()
                      ],
                    ),
                    SizedBox(height: 30),
                    DrCarousel(),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Category's",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                              CategorySeeAllOption()
                            ],
                          ),
                          SizedBox(height: 30),
                          CategoryGrid()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
