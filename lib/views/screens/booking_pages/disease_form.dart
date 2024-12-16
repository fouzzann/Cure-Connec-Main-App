import 'dart:developer';

import 'package:cure_connect_service/controllers/appointment_controller.dart';
import 'package:cure_connect_service/model/appointment_model.dart';
import 'package:cure_connect_service/services/stripe_services.dart';
import 'package:cure_connect_service/views/screens/payment/payment_successfull_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

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
  final AppointmentController appointmentController = Get.put(AppointmentController());

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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
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
                    if (value.length < 2) {
                      return 'Name must be at least 2 characters';
                    }
                    if (value.length > 50) {
                      return 'Name cannot exceed 50 characters';
                    }
                    // Check if name contains only letters and spaces
                    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                      return 'Name can only contain letters and spaces';
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
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      decoration: BoxDecoration(
                                        color: currentGender == gender
                                            ? const Color(0xFF4A78FF)
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
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    final age = int.tryParse(value);
                    if (age == null) {
                      return 'Please enter a valid number';
                    }
                    if (age < 1) {
                      return 'Age cannot be less than 1';
                    }
                    if (age > 120) {
                      return 'Age cannot be more than 120';
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
                    if (value.length < 10) {
                      return 'Please provide more details (at least 10 characters)';
                    }
                    if (value.length > 1000) {
                      return 'Description cannot exceed 500 characters';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 32),

                // Book Appointment Button
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        bool isBooked = await StripeServices.instance
                            .makePayment(consultationFee: fee);
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
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A78FF),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
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

  void _clearForm() {
    _nameController.clear();
    _diseaseController.clear();
    _ageController.clear();
    _genderNotifier.value = 'Male';
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
        labelStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(icon, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4A78FF)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ), 
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
      
      keyboardType: keyboardType,
      validator: validator,
      inputFormatters: inputFormatters,
      maxLines: maxLines ?? 1,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}