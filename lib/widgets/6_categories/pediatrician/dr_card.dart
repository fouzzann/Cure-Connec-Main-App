import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cure_connect_service/controllers/favorite_controller.dart';
import 'package:cure_connect_service/views/screens/booking_pages/dr_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class PediatricianDoctorCard extends StatelessWidget {
  final QueryDocumentSnapshot doc;
  final FavoritesController favoritesController;

  const PediatricianDoctorCard({
    required this.doc,
    required this.favoritesController,
  });

  @override
  Widget build(BuildContext context) {
    final data = doc.data() as Map<String, dynamic>;
    final isFavorite = favoritesController.isFavorite(doc.id);

    return Obx(() {
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
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
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Stack(
            children: [
              Row(
                children: [
                  _buildDoctorImage(data['image']),
                  const SizedBox(width: 12),
                  _buildDoctorInfo(data, isFavorite),
                ],
              ),
              _buildConnectButton(data),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildDoctorImage(String? imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        imageUrl ?? '',
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
    );
  }

  Widget _buildDoctorInfo(Map<String, dynamic> data, bool isFavorite) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDoctorNameAndFavoriteButton(data['fullName'], isFavorite),
          _buildDoctorDetails(data),
        ],
      ),
    );
  }

  Widget _buildDoctorNameAndFavoriteButton(String? fullName, bool isFavorite) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          fullName ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.blue : Colors.blue[400],
          ),
          onPressed: () => favoritesController.toggleFavorite(doc.id),
        ),
      ],
    );
  }

  Widget _buildDoctorDetails(Map<String, dynamic> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${data['category']} | ${data['hospitalName']} Hospital',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 13,
          ),
        ),
        Text(
          '${data['yearsOfExperience']} Years of experience',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 13,
          ),
        ),
        Row(
          children: [
            const Icon(Icons.location_on, size: 16, color: Colors.grey),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                '${data['location']}',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 16),
            const SizedBox(width: 4),
            Text(
              '4.3',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 13,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '(3,837 reviews)',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 13,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildConnectButton(Map<String, dynamic> data) {
    return Positioned(
      bottom: 10,
      right: 10,
      child: ElevatedButton(
        onPressed: () {
          Get.to(
            () => DoctorProfileView(
              data: data,
            ),
            transition: Transition.rightToLeftWithFade,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4A78FF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        child: const Text(
          'Connect',
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
      ),
    );
  }
}
