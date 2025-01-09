import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cure_connect_service/controllers/appointment_controller.dart';
import 'package:cure_connect_service/controllers/rating_controller.dart';
import 'package:cure_connect_service/model/user_appointment_history_model.dart';
import 'package:cure_connect_service/views/widgets/booked_appointment/appointment_info.dart';
import 'package:cure_connect_service/views/widgets/booked_appointment/doctor_info.dart';
import 'package:cure_connect_service/views/widgets/booked_appointment/message_cancel_button.dart';
import 'package:cure_connect_service/views/widgets/booked_appointment/rating_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
const double _kPadding = 20.0;
const double _kBorderRadius = 24.0;
final RatingController ratingController = Get.put(RatingController());

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
                    child: buildMessageButton(doctor.doctorModel.uid,
                        doctor.doctorModel.contact.toString()),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: AppointmentRatingButton(
            appointmentId: doctor.appointmentModel.id!,
            doctorId: doctor.doctorModel.uid,
            doctorEmail: doctor.doctorModel.email,
            appointmentController: appointmentController,
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
  appointmentController
      .getUserAppointmentHistory(_auth.currentUser!.email.toString());
}
