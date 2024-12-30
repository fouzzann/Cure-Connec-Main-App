import 'package:cure_connect_service/controllers/appointment_controller.dart';
import 'package:cure_connect_service/model/user_appointment_history_model.dart';
import 'package:cure_connect_service/widgets/booked_appointment/appointment_info.dart';
import 'package:cure_connect_service/widgets/booked_appointment/doctor_info.dart';
import 'package:cure_connect_service/widgets/booked_appointment/message_cancel_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

const double _kPadding = 20.0;
const double _kBorderRadius = 24.0;
Widget buildAppointmentCard(UserAppointmentHistoryModel doctor, AppointmentController appointmentController) {
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
    child: Padding(
      padding: const EdgeInsets.all(_kPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildDoctorInfo(doctor),
          const SizedBox(height: _kPadding),
          buildAppointmentInfo(doctor),
          const SizedBox(height: _kPadding),
          buildActionButtons(doctor.doctorModel.uid,
              doctor.appointmentModel.id!, appointmentController),
        ],
      ),
    ),
  );
}

Widget buildActionButtons(
    uid, String docId, AppointmentController appointmentController) {
  return Row(
    children: [
      Expanded(
        child: buildCancelButton(docId, appointmentController),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: buildMessageButton(uid),
      ),
    ],
  );
}

Future<void> fetchAppointments(AppointmentController appointmentController) async {
  appointmentController
      .getUserAppointmentHistory(_auth.currentUser!.email.toString()); 
}
