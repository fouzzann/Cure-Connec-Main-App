import 'package:cure_connect_service/views/screens/6_categoryies_pages/dentist.dart';
import 'package:cure_connect_service/views/screens/6_categoryies_pages/nephrologist.dart';
import 'package:cure_connect_service/views/screens/6_categoryies_pages/neurologist.dart';
import 'package:cure_connect_service/views/screens/6_categoryies_pages/ophthalmologist.dart';
import 'package:cure_connect_service/views/screens/6_categoryies_pages/pediatrician.dart';
import 'package:cure_connect_service/views/screens/6_categoryies_pages/physiotherapist.dart';
import 'package:cure_connect_service/utils/category_widget_colors.dart';
import 'package:cure_connect_service/views/widgets/home_content/category_designs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;

    final List<Widget> categoryPages = [
      Physiotherapist(),
      Dentist(),
      Ophthalmologist(),
      Neurologist(),
      Pediatrician(),
      Nephrologist()
    ];

    final double gridPadding = size.width * 0.02;
    final double iconSize = size.width * 0.1;
    final double fontSize = size.width * 0.028;
    final double containerPadding = size.width * 0.02;
    final double spacing = size.width * 0.04;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(gridPadding),
      itemCount: categoryTitles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: isSmallScreen ? 0.9 : 1.0,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Get.to(
              () => categoryPages[index % categoryPages.length],
              transition: Transition.size,
            );
          },
          child: Container(
            padding: EdgeInsets.all(containerPadding),
            decoration: BoxDecoration(
              color: categoryColors[index % categoryColors.length],
              borderRadius: BorderRadius.circular(size.width * 0.03),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: size.width * 0.015,
                  offset: Offset(0, size.width * 0.005),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  categorysImages[index],
                  height: iconSize,
                  width: iconSize,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: size.height * 0.01),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    categoryTitles[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize,
                      color:
                          categoryTextColors[index % categoryTextColors.length],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
