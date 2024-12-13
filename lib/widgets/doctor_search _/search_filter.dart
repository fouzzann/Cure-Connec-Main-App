import 'package:cure_connect_service/views/utils/app_colors/app.theme.dart';
import 'package:flutter/material.dart';

Widget buildCategoryFilter(dynamic controller) {
    if (controller.categories.isEmpty) {
      return const SizedBox();
    }  

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.drSearchBar,
          borderRadius: BorderRadius.circular(12),
        ), 
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            value: controller.selectedCategory.value,
            hint: const Text('Select Category'),
            items: [
              const DropdownMenuItem<String>(
                value: null,
                child: Text('All Categories'),
              ), 
              ...controller.categories
                  .map((category) => DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      ))
                  .toList(),
            ],
            onChanged: (value) {
              controller.selectedCategory.value = value;
              controller.searchUsers(controller.searchController.text);
            },
          ),
        ),
      ),
    );
  }
