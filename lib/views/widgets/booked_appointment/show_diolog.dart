import 'package:cure_connect_service/controllers/appointment_controller.dart';
import 'package:cure_connect_service/services/calculate_avg_rating.dart';
import 'package:cure_connect_service/views/widgets/booked_appointment/appointment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

void showRatingDialog(String doctorId, String appointmentId, String doctorEmail,
    AppointmentController appointmentController) {
  int _rating = 3;

  showDialog(
    context: Get.context!,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: const Text('Rate Your Experience'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('How was your experience with the doctor?'),
          const SizedBox(height: 16),
          RatingBar.builder(
            initialRating: _rating.toDouble(),
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Color(0xFF4A78FF),
            ),
            onRatingUpdate: (rating) {
              _rating = rating.toInt();
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.black),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4A78FF),
          ),
          onPressed: () async {
            try {
              await saveRatingToDatabase(
                  doctorId, appointmentId, _rating.toDouble());
              await appointmentController.ratingFunction(doctorEmail, _rating);
              await calculateAvgRating(doctorEmail);
              ratingController.markAsRated(appointmentId);
              Get.back();
              Get.snackbar(
                'Success',
                'Rating submitted successfully',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            } catch (e) {
              Get.snackbar(
                'Error',
                'Failed to submit rating',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            }
          },
          child: const Text(
            'Submit',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
