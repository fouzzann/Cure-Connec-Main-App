import 'package:cure_connect_service/views/widgets/disease_form/book_appointment_button.dart';
import 'package:cure_connect_service/views/widgets/disease_form/costum_textfiled.dart';
import 'package:cure_connect_service/views/widgets/disease_form/gender_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppointmentFormBody extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final DateTime selectedDate;
  final String selectedTime;
  final TextEditingController nameController;
  final TextEditingController diseaseController;
  final TextEditingController ageController;
  final ValueNotifier<String> genderNotifier;
  final VoidCallback onSubmit;

  const AppointmentFormBody({
    Key? key,
    required this.formKey,
    required this.selectedDate,
    required this.selectedTime,
    required this.nameController,
    required this.diseaseController,
    required this.ageController,
    required this.genderNotifier,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Form(
          key: formKey,
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
              CustomTextField(
                controller: nameController,
                label: 'Full Name',
                icon: Icons.person_outline,
                validator: _nameValidator,
              ),
              const SizedBox(height: 16),
              GenderSelector(genderNotifier: genderNotifier),
              const SizedBox(height: 16),
              CustomTextField(
                controller: ageController,
                label: 'Your Age',
                icon: Icons.cake_outlined,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
                validator: _ageValidator,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: diseaseController,
                label: 'Describe Your Symptoms/Disease',
                icon: Icons.medical_services_outlined,
                maxLines: 3,
                validator: _diseaseValidator,
              ),
              const SizedBox(height: 32),
              BookAppointmentButton(onPressed: onSubmit),
            ],
          ),
        ),
      ),
    );
  }

  String? _nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    if (value.length > 50) {
      return 'Name cannot exceed 50 characters';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Name can only contain letters and spaces';
    }
    return null;
  }

  String? _ageValidator(String? value) {
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
  }

  String? _diseaseValidator(String? value) {
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
  }
}
