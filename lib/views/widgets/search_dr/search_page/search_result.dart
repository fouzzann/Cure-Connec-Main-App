import 'package:cure_connect_service/controllers/search_controller.dart';
import 'package:cure_connect_service/utils/app_colors/app.theme.dart';
import 'package:cure_connect_service/views/screens/booking_pages/dr_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildSearchResults(SearchDrController controller) {
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
                    Text(
                      category,
                      style: TextStyle(color: AppColors.mainTheme),
                    ),
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
                    Text('$yearsOfExperience Years of experience'),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(
                    () => DoctorProfileView(
                      data: doctor.data(),
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
