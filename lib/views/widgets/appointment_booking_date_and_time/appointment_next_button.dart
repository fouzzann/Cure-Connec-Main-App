import 'dart:developer';
import 'package:cure_connect_service/controllers/appointment_controller.dart';
import 'package:cure_connect_service/views/screens/booking_pages/disease_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AppointmentNextButton extends StatelessWidget {
  final String? selectedTime;
  final DateTime selectedDate;
  final String drEmail;
  final String fee;
  final AppointmentController appointmentController;

  const AppointmentNextButton({
    Key? key,
    required this.selectedTime,
    required this.selectedDate,
    required this.drEmail,
    required this.fee,
    required this.appointmentController,
  }) : super(key: key);

  void _handleNextButton() async {
    final bool isBooked = await appointmentController.checkAlreadyBooked(
      drEmail,
      selectedTime.toString(),
      selectedDate,
    );
    
    log(isBooked.toString());
    
    if (!isBooked) {
      log('not booked');
      Get.to(
        () => DiseaseForm(
          selectedDate: selectedDate,
          selectedTime: selectedTime!,
          drEmail: drEmail,
          fee: fee,
        ),
        transition: Transition.rightToLeftWithFade,
      );
    } else {
      _showBookingError();
    }
  }

  void _showBookingError() {
    GetSnackBar(
      title: 'Time Slot Is Already Chosen',
      message: 'The selected time slot is no longer available. Please choose a different time.',
      backgroundColor: Colors.blueGrey.shade800,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.TOP,
      borderRadius: 12,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      icon: const Icon(
        Icons.error,
        color: Colors.white,
        size: 24,
      ),
      dismissDirection: DismissDirection.horizontal,
      isDismissible: true,
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: selectedTime != null ? _handleNextButton : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4A78FF),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: const Text(
          'Next',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}