import 'dart:developer';
import 'package:cure_connect_service/controllers/appointment_controller.dart';
import 'package:cure_connect_service/model/appointment_model.dart';
import 'package:cure_connect_service/services/stripe_services.dart';
import 'package:cure_connect_service/views/screens/payment/payment_successfull_page.dart';
import 'package:cure_connect_service/views/widgets/disease_form/appointment_form_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DiseaseForm extends StatelessWidget {
  final DateTime selectedDate;
  final String selectedTime;
  final String drEmail;
  final String fee;

  DiseaseForm({
    Key? key,
    required this.selectedDate,
    required this.selectedTime,
    required this.drEmail,
    required this.fee,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _diseaseController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final ValueNotifier<String> _genderNotifier = ValueNotifier<String>('Male');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AppointmentController appointmentController =
      Get.put(AppointmentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Patient Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: AppointmentFormBody(
        formKey: _formKey,
        selectedDate: selectedDate,
        selectedTime: selectedTime,
        nameController: _nameController,
        diseaseController: _diseaseController,
        ageController: _ageController,
        genderNotifier: _genderNotifier,
        onSubmit: () => _handleSubmit(context),
      ),
    );
  }

  Future<void> _handleSubmit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        bool isBooked =
            await StripeServices.instance.makePayment(consultationFee: fee);
        log('Payment status: ${isBooked.toString()}');

        if (isBooked) {
          AppointmentModel appointment = AppointmentModel(
            drEmail: drEmail,
            name: _nameController.text.trim(),
            gender: _genderNotifier.value,
            age: int.parse(_ageController.text),
            disease: _diseaseController.text.trim(),
            appointmentDate: selectedDate,
            appointmentTime: selectedTime,
            userEmail: _auth.currentUser!.email.toString(),
            status: 'upcoming',
          );

          await appointmentController.addAppointment(appointment);
          _clearForm();
          Get.to(() => const PaymentSuccessPage());
        }
      } catch (e) {
        log('Error booking appointment: $e');
        Get.snackbar(
          'Error',
          'Failed to book appointment. Please try again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  void _clearForm() {
    _nameController.clear();
    _diseaseController.clear();
    _ageController.clear();
    _genderNotifier.value = 'Male';
  }
}
