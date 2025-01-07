import 'package:cure_connect_service/views/widgets/search_dr/search_page/filter_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../../controllers/search_controller.dart';

class SearchBarWidget extends StatelessWidget {
  final SearchDrController controller;
  final VoidCallback onShowFeeRange;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onShowFeeRange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: _buildTextField(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField() {
    return TextField(
      controller: controller.searchController,
      decoration: InputDecoration(
        hintText: 'Search doctors by name',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _buildSuffixIcon(),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 10,
        ),
      ),
      onChanged: controller.searchUsers,
    );
  }

  Widget _buildSuffixIcon() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (controller.searchController.text.isNotEmpty)
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              controller.searchController.clear();
              controller.fetchAllDoctors();
            },
          ),
        Obx(() => FilterButton(
          onPressed: onShowFeeRange,
          hasActiveFeeFilter: controller.hasActiveFeeFilter,
        )),
      ],
    );
  }
}