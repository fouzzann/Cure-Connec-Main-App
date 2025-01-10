import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cure_connect_service/controllers/search_controller.dart';
import 'package:cure_connect_service/views/screens/booking_pages/dr_profile_view.dart';
import 'package:cure_connect_service/views/screens/search_dr/fee_range_diolog.dart';
import 'package:cure_connect_service/views/widgets/search_dr/search_page/search_bar_widget.dart';
import 'package:cure_connect_service/views/widgets/search_dr/search_page/search_bar_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchDr extends StatelessWidget {
  final SearchDrController controller = Get.find<SearchDrController>();

  SearchDr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildCategoryFilter(),
          SearchBarWidget(
            controller: controller,
            onShowFeeRange: showFeeRangeDialog,
          ),
          Expanded(child: _buildSearchResults()),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
       backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.keyboard_arrow_down_outlined, size: 40),
      ),
      title: const Text(
        'Search Doctors',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Obx(() {
      if (controller.categories.isEmpty) {
        return const SizedBox.shrink();
      }

      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String?>(
              isExpanded: true,
              value: controller.selectedCategory.value,
              hint: const Text('Select Category'),
              items: [
                const DropdownMenuItem<String?>(
                  value: null,
                  child: Text('All Categories'),
                ),
                ...controller.categories.map((String category) {
                  return DropdownMenuItem<String?>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
              ],
              onChanged: (String? newValue) {
                controller.selectedCategory.value = newValue;
              },
            ),
          ),
        ),
      );
    });
  }

  Widget _buildSearchResults() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.users.isEmpty) {
        return const Center(child: Text('No doctors available'));
      }

      return ListView.builder(
        itemCount: controller.users.length,
        itemBuilder: (context, index) {
          final doctor = controller.users[index];
          return SearchPageDoctorCard(
            doctor: doctor,
            onConnect: () => _navigateToDoctorProfile(doctor),
          );
        },
      );
    });
  }

  void _navigateToDoctorProfile(DocumentSnapshot doctor) {
    Get.to(
      () => DoctorProfileView(data: doctor.data() as Map<String, dynamic>),
      transition: Transition.rightToLeftWithFade,
    );
  }

  void showFeeRangeDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(  
          borderRadius: BorderRadius.circular(16),
        ),
        child: FeeRangeDialog(), 
      ),
    );
  }
}




 