import 'dart:developer';
import 'package:cure_connect_service/model/doctor_model.dart';
import 'package:cure_connect_service/model/user_appointment_history_model.dart';
import 'package:cure_connect_service/services/calculate_avg_rating.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cure_connect_service/model/appointment_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AppointmentController extends GetxController {
  var isLoading = false.obs;
  var appointmentId = Rxn<String>();
  var errorMessage = ''.obs;
  RxBool isBooked = false.obs;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  RxList<UserAppointmentHistoryModel> history =
      <UserAppointmentHistoryModel>[].obs;
  RxList<Doctor> availableDoctors = <Doctor>[].obs;

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
      log('Error adding appointment: $e');
      Get.snackbar(
        'Error',
        'Failed to book appointment',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> getUserAppointmentHistory(String email) async {
    try {
      isLoading.value = true;
      history.clear();

      final QuerySnapshot querySnapshot = await db
          .collection('appointment')
          .where('userEmail', isEqualTo: email)
          .get();

      final List<AppointmentModel> appointmentList =
          querySnapshot.docs.map((appointment) {
        return AppointmentModel.fromMap(
            appointment.data() as Map<String, dynamic>, appointment.id);
      }).toList();

      for (AppointmentModel element in appointmentList) {
        final DocumentSnapshot documentSnapshot =
            await db.collection('doctors').doc(element.drEmail).get();

        final Doctor doctorModel =
            Doctor.fromMap(documentSnapshot.data() as Map<String, dynamic>);

        history.add(UserAppointmentHistoryModel(
            appointmentModel: element, doctorModel: doctorModel));
      }

      log('Appointment History: ${history.length} appointments');
    } catch (e) {
      log('Error fetching appointment history: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<Doctor>> getAvailableDoctors(
      DateTime selectedDate, String selectedTime) async {
    try {
      isLoading.value = true;
      availableDoctors.clear();

      // Get all doctors first
      final QuerySnapshot doctorsSnapshot =
          await db.collection('doctors').get();
      final List<Doctor> allDoctors = doctorsSnapshot.docs
          .map((doc) => Doctor.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      // Check availability for each doctor
      for (Doctor doctor in allDoctors) {
        bool isBooked =
            await checkAlreadyBooked(doctor.email, selectedTime, selectedDate);

        if (!isBooked) {
          availableDoctors.add(doctor);
        }
      }

      return availableDoctors;
    } catch (e) {
      log('Error getting available doctors: $e');
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> checkAlreadyBooked(String drEmail, String currentSelectedTime,
      DateTime currentSelectedDate) async {
    try {
      final QuerySnapshot querySnapshot = await db
          .collection('appointment')
          .where('drGmail', isEqualTo: drEmail)
          .get();

      for (DocumentSnapshot element in querySnapshot.docs) {
        final data = element.data() as Map<String, dynamic>;
        final time = data['appointmentTime'];
        final Timestamp dateStamp = data['appointmentDate'];

        final formatedBeforeDate =
            DateFormat("yyyy-MM-dd").format(dateStamp.toDate());
        final formatedCurrentDate =
            DateFormat("yyyy-MM-dd").format(currentSelectedDate);

        if (formatedCurrentDate == formatedBeforeDate &&
            time == currentSelectedTime) {
          return true;
        }
      }
      return false;
    } catch (e) {
      log('Error checking booking status: $e');
      return true;
    }
  }

  Future<void> ratingFunction(String doctorEmail, int rating) async {
    try {
      if (rating != 0) {
        log(doctorEmail);
        final doctor = await db.collection('doctors').doc(doctorEmail).get();
        log(doctor.exists.toString());
        List<dynamic> dynamicList =
            doctor.data()?['ratingList'] ?? [] ; 
        List<int> ratingList = dynamicList.map((e) => e as int).toList();

        ratingList.add(rating);
        await db
            .collection('doctors')
            .doc(doctorEmail)
            .update({'ratingList': ratingList});
        final avg = await calculateAvgRating(doctorEmail);
        
        final avgRating=avg.toStringAsFixed(1);;
        log(avgRating);
        await db
            .collection('doctors')
            .doc(doctorEmail)
            .update({'rating': avgRating}); 
      }
    } catch (e) { 
      log('rating:$e');
    }
  }
}
