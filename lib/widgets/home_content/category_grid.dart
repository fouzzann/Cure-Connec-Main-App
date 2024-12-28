import 'package:cure_connect_service/views/screens/6_categoryies_pages/dentist.dart';
import 'package:cure_connect_service/views/screens/6_categoryies_pages/nephrologist.dart';
import 'package:cure_connect_service/views/screens/6_categoryies_pages/neurologist.dart';
import 'package:cure_connect_service/views/screens/6_categoryies_pages/ophthalmologist.dart';
import 'package:cure_connect_service/views/screens/6_categoryies_pages/pediatrician.dart';
import 'package:cure_connect_service/views/screens/6_categoryies_pages/physiotherapist.dart';
import 'package:cure_connect_service/views/utils/category_widget_colors.dart';
import 'package:cure_connect_service/widgets/home_content/category_designs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen size
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

    // Calculate responsive dimensions
    final double gridPadding = size.width * 0.02;
    final double iconSize = size.width * 0.1;  // 10% of screen width
    final double fontSize = size.width * 0.028; // 2.8% of screen width
    final double containerPadding = size.width * 0.02;
    final double spacing = size.width * 0.04; // 4% of screen width

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(gridPadding),
      itemCount: categoryTitles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        // Maintain aspect ratio based on screen size
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
              borderRadius: BorderRadius.circular(size.width * 0.03), // Responsive border radius
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: size.width * 0.015, // Responsive blur
                  offset: Offset(0, size.width * 0.005), // Responsive offset
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
                SizedBox(height: size.height * 0.01), // Responsive spacing
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    categoryTitles[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize,
                      color: categoryTextColors[index % categoryTextColors.length],
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