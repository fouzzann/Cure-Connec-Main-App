import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cure_connect_service/controllers/appointment_controller.dart';
import 'package:cure_connect_service/model/user_appointment_history_model.dart';
import 'package:cure_connect_service/services/calculate_avg_rating.dart';
import 'package:cure_connect_service/widgets/booked_appointment/appointment_info.dart';
import 'package:cure_connect_service/widgets/booked_appointment/doctor_info.dart';
import 'package:cure_connect_service/widgets/booked_appointment/message_cancel_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
const double _kPadding = 20.0;
const double _kBorderRadius = 24.0;

Widget buildAppointmentCard(UserAppointmentHistoryModel doctor,
    AppointmentController appointmentController) {
  return Container(
    margin: const EdgeInsets.only(bottom: _kPadding),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(_kBorderRadius),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: _kPadding,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(_kPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDoctorInfo(doctor),
              const SizedBox(height: _kPadding),
              buildAppointmentInfo(doctor),
              const SizedBox(height: _kPadding),
              Row(
                children: [
                  Expanded(
                    child: buildCancelButton(
                        doctor.appointmentModel.id!, appointmentController),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: buildMessageButton(doctor.doctorModel.uid),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: FutureBuilder<bool>(
            future: hasUserRated(doctor.appointmentModel.id!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              
              final bool hasRated = snapshot.data ?? false;
              
              return hasRated
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Rated',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : buildRatingButton(
                      doctor.doctorModel.uid,
                      doctor.appointmentModel.id!,
                      doctor.doctorModel.email,
                      appointmentController);
            },
          ),
        ),
      ],
    ),
  );
}

Future<bool> hasUserRated(String appointmentId) async {
  final userId = _auth.currentUser?.uid;
  if (userId == null) return false;

  final QuerySnapshot rating = await _firestore
      .collection('ratings')
      .where('userId', isEqualTo: userId)
      .where('appointmentId', isEqualTo: appointmentId)
      .get();

  return rating.docs.isNotEmpty;
}

Widget buildRatingButton(String doctorId, String appointmentId,
    String doctorEmail, AppointmentController appointmentController) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF4A78FF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    onPressed: () async {
      final hasRated = await hasUserRated(appointmentId);
      if (hasRated) {
        Get.snackbar(
          'Already Rated',
          'You have already submitted a rating for this appointment',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
      showRatingDialog(
          doctorId, appointmentId, doctorEmail, appointmentController);
    },
    child: const Text(
      'Rate',
      style: TextStyle(color: Colors.white),
    ),
  );
}

void showRatingDialog(String doctorId, String appointmentId, String doctorEmail,
    AppointmentController appointmentController) {
  int _rating = 0;
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
            initialRating: 0,
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
            Navigator.pop(context);
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
            if (_rating > 0) {
              await saveRatingToDatabase(doctorId, appointmentId, _rating.toDouble());
              await appointmentController.ratingFunction(doctorEmail, _rating);
              await calculateAvgRating(doctorEmail);
              Get.back();
              Get.snackbar(
                'Thank You!',
                'Your rating has been submitted successfully',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            } else {
              Get.snackbar(
                'Invalid Rating',
                'Please select a rating before submitting',
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

Future<void> saveRatingToDatabase(
    String doctorId, String appointmentId, double rating) async {
  await _firestore.collection('ratings').add({
    'doctorId': doctorId,
    'appointmentId': appointmentId,
    'rating': rating,
    'userId': _auth.currentUser!.uid,
    'timestamp': FieldValue.serverTimestamp(),
  });
}

Future<void> fetchAppointments(
    AppointmentController appointmentController) async {
  await appointmentController
      .getUserAppointmentHistory(_auth.currentUser!.email.toString());
}