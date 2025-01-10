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
          return 
          _buildEmptyState(context);
          
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

Widget _buildEmptyState(BuildContext context) {
  return Center(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.purple.withOpacity(0.1), 
            ),
            child: Icon(
              Icons.favorite,
              size: 40,
              color: Colors.purple,  
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No favorite found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Your favorite doctors list is empty. Add doctors to your favorites to see them here.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
    ),
  ); 
}