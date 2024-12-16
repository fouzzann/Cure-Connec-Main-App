import 'dart:developer';

import 'package:cure_connect_service/model/doctor_model.dart';
import 'package:cure_connect_service/model/user_appointment_history_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cure_connect_service/model/appointment_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentController extends GetxController {
  var isLoading = false.obs;
  var appointmentId = Rxn<String>();
  var errorMessage = ''.obs;
  RxBool isBooked = false.obs;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  List<UserAppointmentHistoryModel> history =
      <UserAppointmentHistoryModel>[].obs;
  Future<void> addAppointment(AppointmentModel appointment) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        throw Exception('No logged-in user found.');
      }

      DocumentReference docRef =
          await db.collection('appointment').add(appointment.toMap());

      appointmentId.value = docRef.id;
      isLoading.value = false;

      Get.snackbar(
        'Success',
        'Appointment booked successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'Failed to book appointment';
      print('Error adding appointment: $e');
      Get.snackbar(
        'Error',
        'Failed to book appointment',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  getUserAppointmentHistory(String email) async {
    try {
      // fetch History
      final QuerySnapshot querySnapshot = await db
          .collection('appointment')
          .where('userEmail', isEqualTo: email)
          .get();
      final List<AppointmentModel> appointmentList =
          querySnapshot.docs.map((appointment) {
        return AppointmentModel.fromMap(
            appointment.data() as Map<String, dynamic>, appointment.id);
      }).toList();
      // fetch dr
      for (AppointmentModel element in appointmentList) {
        final DocumentSnapshot documentSnapshot =
            await db.collection('doctors').doc(element.drEmail).get();
            final Doctor doctorModel = Doctor.fromMap(documentSnapshot.data() as Map<String,dynamic>);
            history.add( UserAppointmentHistoryModel(appointmentModel: element, doctorModel: doctorModel));
      }
      log(history.toString());
    } catch (e) {
      log(e.toString());
    }
  }
}
