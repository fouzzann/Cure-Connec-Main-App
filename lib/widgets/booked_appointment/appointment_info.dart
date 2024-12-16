import 'package:cure_connect_service/model/user_appointment_history_model.dart';
import 'package:cure_connect_service/widgets/booked_appointment/icons_text.dart';
import 'package:flutter/material.dart';

Widget buildAppointmentInfo(UserAppointmentHistoryModel doctor) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey[50],
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      children: [
        buildInfoColumn(
          Icons.access_time_rounded,
          'Time',
          doctor.appointmentModel.appointmentTime,
        ),
        const SizedBox(width: 24),
        buildInfoColumn(
          Icons.calendar_today_rounded,
          'Date',
          doctor.appointmentModel.appointmentTime,
        ),
        const SizedBox(width: 24),
        buildInfoColumn(
          Icons.star_rounded,
          'Rating',
          '3.3',
        ),
      ],
    ),
  );
}
