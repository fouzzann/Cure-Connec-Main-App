import 'package:cure_connect_service/views/screens/home_page/health_care_articles.dart';
import 'package:cure_connect_service/widgets/dr_carrousel/carrosel_slider.dart';
import 'package:cure_connect_service/widgets/home_content/category_grid.dart';
import 'package:cure_connect_service/widgets/home_content/category_see_all_option.dart';
import 'package:cure_connect_service/widgets/home_content/top_rated_dr_see_all_option.dart';
import 'package:flutter/material.dart';

class MainContainer extends StatelessWidget {
  const MainContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 34, right: 34),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Top Rated Doctors',
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
                  CategoryGrid(),
                  SizedBox(height: 30),
                  HealthCareArticles(),
                  SizedBox(height: 20,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
