import 'package:cure_connect_service/model/user_appointment_history_model.dart';
import 'package:cure_connect_service/widgets/booked_appointment/icons_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget buildAppointmentInfo(UserAppointmentHistoryModel doctor) {
  String getFormattedDate() {
    try {
      final appointmentDate = doctor.appointmentModel.appointmentDate;
      if (appointmentDate == doctor) {
        return 'Not set';
      }
      // Now directly format the DateTime object
      return DateFormat('MMM dd').format(appointmentDate);
    } catch (e) {
      return 'Invalid date';
    }
  }

  String getFormattedTime() {
    try {
      if (doctor.appointmentModel.appointmentTime == doctor) {
        return 'Not set';
      }
      return doctor.appointmentModel.appointmentTime;
    } catch (e) {
      return 'Invalid time';
    }
  }

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
          getFormattedTime(),
        ),
        const SizedBox(width: 24),
        buildInfoColumn(
          Icons.calendar_today_rounded,
          'Date',
          getFormattedDate(),
        ),
        const SizedBox(width: 24),
        buildInfoColumn(
          Icons.star_rounded,
          'Rating',
          doctor.doctorModel.rating.toString(),
        ),
      ],
    ),
  );
}
