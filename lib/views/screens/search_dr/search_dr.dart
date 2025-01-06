import 'package:cure_connect_service/controllers/search_controller.dart';
import 'package:cure_connect_service/views/screens/booking_pages/dr_profile_view.dart';
import 'package:cure_connect_service/views/screens/search_dr/fee_range_diolog.dart';
import 'package:cure_connect_service/utils/app_colors/app.theme.dart';
import 'package:cure_connect_service/views/widgets/doctor_search%20_/search_filter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchDr extends StatelessWidget {
  final SearchDrController controller = Get.find<SearchDrController>();

  SearchDr({super.key});

  void _showFeeRangeDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: FeeRangeDialog(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                    child: TextField(
                      controller: controller.searchController,
                      decoration: InputDecoration(
                        hintText: 'Search doctors by name',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: Row(
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
                            Obx(() => TextButton(
                                  onPressed: _showFeeRangeDialog,
                                  style: TextButton.styleFrom(
                                    side: const BorderSide(
                                        color: AppColors.mainTheme, width: 1.5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      const Text(
                                        'FILTER ₹',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.mainTheme,
                                        ),
                                      ),
                                      if (controller.hasActiveFeeFilter)
                                        Positioned(
                                          right: -8,
                                          top: -8,
                                          child: Container(
                                            padding: const EdgeInsets.all(2),
                                            decoration: const BoxDecoration(
                                              color: AppColors.mainTheme,
                                              shape: BoxShape.circle,
                                            ),
                                            constraints: const BoxConstraints(
                                              minWidth: 5,
                                              minHeight: 5,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ))
                          ],
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 10,
                        ),
                      ),
                      onChanged: controller.searchUsers,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: Obx(() => buildSearchResults())),
        ],
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
        var doctor = controller.users[index];
        String fullName = doctor.get('fullName') as String;
        String category = doctor.get('category') as String;
        String imageUrl = doctor.get('image') as String;
        String drRating = doctor.get('rating') as String;
        String location = doctor.get('location') as String;
        String yearsOfExperience = doctor.get('yearsOfExperience') as String;

        return Card(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipOval(
                  child: Image.network(
                    imageUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fullName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(category,style: TextStyle(
                        color: AppColors.mainTheme
                      ),),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 16,
                          ),
                          Text(' $drRating'),
                          const SizedBox(width: 12),
                          const Icon(
                            Icons.location_on,
                            color: Colors.grey,
                            size: 16,
                          ),
                          Text(location),
                          
                        ],
                      ),
                      Text('${yearsOfExperience} Years of experience') 
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(
                    () => DoctorProfileView(
                      data: doctor,  
                    ),
                    transition: Transition.rightToLeftWithFade,
                  );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainTheme,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Connect',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
