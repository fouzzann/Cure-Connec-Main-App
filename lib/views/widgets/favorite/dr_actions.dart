import 'package:cure_connect_service/controllers/added_favorite_controller.dart';
import 'package:cure_connect_service/views/screens/booking_pages/dr_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorActions extends StatelessWidget {
  final String doctorId;
  final AddedFavoriteController controller;
  final Map<String, dynamic> data;

  const DoctorActions({
    Key? key,
    required this.doctorId,
    required this.controller,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
              () => DoctorProfileView(data: data),
              transition: Transition.rightToLeftWithFade,
            );
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
    );
  }
}