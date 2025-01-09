import 'package:cure_connect_service/controllers/search_controller.dart';
import 'package:cure_connect_service/utils/app_colors/app.theme.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final SearchDrController controller;
  final VoidCallback onShowFeeRange;

  const SearchBarWidget({
    Key? key,
    required this.controller,
    required this.onShowFeeRange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.drSearchBar,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: controller.searchController,
                onChanged: controller.searchUsers,
                decoration: const InputDecoration(
                  hintText: 'Search doctors by name',
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: AppColors.drSearchBar,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: onShowFeeRange,
            ),
          ),
        ],
      ),
    );
  }
}
