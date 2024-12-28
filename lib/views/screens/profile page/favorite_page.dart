
import 'package:cure_connect_service/controllers/added_favorite_controller.dart';
import 'package:cure_connect_service/views/screens/booking_pages/dr_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FavoritePage extends GetView<AddedFavoriteController> {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AddedFavoriteController());

    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Favorite Doctors',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton( 
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF4A78FF),
            ),
          ); 
        }
  
        if (controller.favoriteDoctors.isEmpty) {
          return const Center(
            child: Text(
              'No favorite doctors found',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.favoriteDoctors.length,
          itemBuilder: (context, index) {
            final doctorId = controller.favoriteDoctors.elementAt(index);
            return _buildDoctorCard(doctorId);
          },
        );
      }),
    );
  }

  Widget _buildDoctorCard(String doctorId) {
    return FutureBuilder<DocumentSnapshot?>(
      future: controller.getDoctorDetails(doctorId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF4A78FF),
            ),
          );
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const SizedBox.shrink();
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;

        return Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  data['image'] ?? '',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey[200],
                    child: const Icon(Icons.person),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['fullName'] ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${data['category']} | ${data['hospitalName']}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            data['location'] ?? '',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Obx(() => IconButton(
                    icon: Icon(
                      controller.favoriteDoctors.contains(doctorId)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: controller.favoriteDoctors.contains(doctorId)
                          ? Colors.blue
                          : Colors.grey,
                    ),
                    onPressed: () => controller.toggleFavorite(doctorId),
                  )),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(
                          () => DoctorProfileView(
                                data: data,
                              ), 
                          transition: Transition.rightToLeftWithFade);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A78FF),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Connect',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}