import 'package:cure_connect_service/controllers/added_favorite_controller.dart';
import 'package:cure_connect_service/views/widgets/favorite/dr_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritePage extends GetView<AddedFavoriteController> {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AddedFavoriteController());

    return Scaffold(
      backgroundColor: Colors.white,
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
            return FavoritePageDoctorCard(
              doctorId: doctorId, 
              controller: controller,
            );
          },
        );
      }),
    );
  }
}