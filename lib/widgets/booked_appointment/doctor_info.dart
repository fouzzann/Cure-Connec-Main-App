import 'package:cure_connect_service/model/user_appointment_history_model.dart';
import 'package:cure_connect_service/widgets/booked_appointment/dr_image.dart';
import 'package:flutter/material.dart';

Widget buildDoctorInfo(UserAppointmentHistoryModel doctor) {
  return Row(
    children: [
      buildDoctorImage(doctor.doctorModel.image),
      const SizedBox(width: 16),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              doctor.doctorModel.fullName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              doctor.doctorModel.category,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF4A78FF),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ), 
      ),
    ],
  );
}
