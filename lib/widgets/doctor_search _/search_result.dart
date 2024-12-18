import 'package:cure_connect_service/controllers/search_controller.dart';
import 'package:cure_connect_service/views/utils/app_colors/app.theme.dart';
import 'package:cure_connect_service/widgets/doctor_search%20_/list_view_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildSearchResults() {
  final SearchDrController controller = Get.find<SearchDrController>();

  if (controller.isLoading.value) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.mainTheme),
    );
  }

  if (controller.users.isEmpty &&
      (controller.searchController.text.isNotEmpty ||
          controller.selectedCategory.value != null)) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_search_outlined,
            size: 100,
            color: AppColors.drSearchBar 
          ),
          const SizedBox(height: 16),
          Text(
            'No doctors found',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  if (controller.users.isEmpty) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.group_outlined,
            size: 100,  
            color: AppColors.drSearchBar,
          ),
          const SizedBox(height: 16),
          Text(
            'Search Doctors by Name or Category',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  return ListViewBuilder();
}