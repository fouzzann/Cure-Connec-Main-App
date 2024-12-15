import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cure_connect_service/model/appointment_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentController extends GetxController {
  var isLoading = false.obs;
  var appointmentId = Rxn<String>();
  var errorMessage = ''.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addAppointment(AppointmentModel appointment) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        throw Exception('No logged-in user found.');
      }

      DocumentReference docRef =
          await _firestore.collection('appointment').add(appointment.toMap());

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
}