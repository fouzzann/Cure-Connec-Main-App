import 'dart:developer';

import 'package:cure_connect_service/controllers/appointment_controller.dart';
import 'package:cure_connect_service/model/appointment_model.dart';
import 'package:cure_connect_service/services/stripe_services.dart';
import 'package:cure_connect_service/views/screens/payment/payment_successfull_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
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
  // Track if the appointment is booked

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Patient Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Complete Your Booking',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Appointment on ${selectedDate.toLocal().toString().split(' ')[0]} at $selectedTime',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),

                // Name Input
                _buildTextField(
                  controller: _nameController,
                  label: 'Full Name',
                  icon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Gender Selector
                ValueListenableBuilder<String>(
                  valueListenable: _genderNotifier,
                  builder: (context, currentGender, child) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: ['Male', 'Female', 'Other']
                            .map((gender) => Expanded(
                                  child: GestureDetector(
                                    onTap: () => _genderNotifier.value = gender,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      decoration: BoxDecoration(
                                        color: currentGender == gender
                                            ? Color(0xFF4A78FF)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: Text(
                                          gender,
                                          style: TextStyle(
                                            color: currentGender == gender
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 16),

                // Age Input
                _buildTextField(
                  controller: _ageController,
                  label: 'Your Age',
                  icon: Icons.cake_outlined,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    final age = int.tryParse(value);
                    if (age == null || age <= 0 || age > 120) {
                      return 'Please enter a valid age';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Disease/Symptoms Input
                _buildTextField(
                  controller: _diseaseController,
                  label: 'Describe Your Symptoms/Disease',
                  icon: Icons.medical_services_outlined,
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please describe your symptoms';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 32),

                // Book/Finish Button
                // Obx(() {
                //   return
                // }),
                ElevatedButton(
                  onPressed: () async {
                    bool isBooked = false;
                    if (_formKey.currentState!.validate()) {
                      isBooked = await StripeServices.instance
                          .makePayment(consultationFee: fee);
                      log('status${isBooked.toString()}');
                      if (isBooked) {
                        AppointmentModel appointment = AppointmentModel(
                          drEmail: drEmail,
                          name: _nameController.text,
                          gender: _genderNotifier.value,
                          age: int.parse(_ageController.text),
                          disease: _diseaseController.text,
                          appointmentDate: selectedDate,
                          appointmentTime: selectedTime,
                          userEmail: _auth.currentUser!.email.toString(),
                          status: 'upcoming',
                        );
                        await appointmentController.addAppointment(appointment);
                        _nameController.clear();
                        _diseaseController.clear();
                        _ageController.clear();
                        _genderNotifier.value = 'Male';
                        Get.to(() => PaymentSuccessPage());
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4A78FF),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Book Appointment',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    int? maxLines,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey),
        prefixIcon: Icon(icon, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      keyboardType: keyboardType,
      validator: validator,
      inputFormatters: inputFormatters,
      maxLines: maxLines ?? 1,
    );
  }
}
