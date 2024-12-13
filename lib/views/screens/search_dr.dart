import 'package:cure_connect_service/controllers/search_controller.dart';
import 'package:cure_connect_service/views/utils/app_colors/app.theme.dart';
import 'package:cure_connect_service/widgets/doctor_search%20_/search_filter.dart';
import 'package:cure_connect_service/widgets/doctor_search%20_/search_result.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchDr extends StatelessWidget {
  final SearchDrController controller = Get.put(SearchDrController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.keyboard_arrow_down_outlined, size: 40),
        ),
        title: const Text(
          'Search Doctors',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Obx(() => buildCategoryFilter(controller)),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller.searchController,
              decoration: InputDecoration(
                hintText: 'Search doctors by name',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: controller.searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          controller.searchController.clear();
                          controller.searchUsers('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.drSearchBar,
              ),
              onChanged: controller.searchUsers,
            ),
          ),
          Expanded(child: Obx(() => buildSearchResults())),
        ],
      ),
    );
  }
}
