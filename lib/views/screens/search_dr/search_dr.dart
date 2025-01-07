import 'package:cure_connect_service/views/screens/search_dr/fee_range_diolog.dart';
import 'package:cure_connect_service/views/widgets/doctor_search%20_/search_filter.dart';
import 'package:cure_connect_service/views/widgets/search_dr/search_page/doctor_card.dart';
import 'package:cure_connect_service/views/widgets/search_dr/search_page/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/search_controller.dart';
import '../booking_pages/dr_profile_view.dart';

class SearchDr extends StatelessWidget {
  final SearchDrController controller = Get.find<SearchDrController>();

  SearchDr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Obx(() => buildCategoryFilter(controller)),
          SearchBarWidget(
            controller: controller,
            onShowFeeRange: showFeeRangeDialog,
          ),
          Expanded(child: Obx(() => buildSearchResults())),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
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

  Widget buildSearchResults() {
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
          onConnect: () => navigateToDoctorProfile(doctor),
        );
      },
    );
  }

  void navigateToDoctorProfile(dynamic doctor) {
    Get.to(
      () => DoctorProfileView(data: doctor.data()),
      transition: Transition.rightToLeftWithFade,
    );
  }
}