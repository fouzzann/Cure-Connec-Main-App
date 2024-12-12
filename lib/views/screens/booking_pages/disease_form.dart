import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:cure_connect_service/controllers/appointment_controller.dart';
import 'package:cure_connect_service/model/appointment_model.dart';

class DiseaseForm extends StatelessWidget {
  final DateTime selectedDate;
  final String selectedTime;

  DiseaseForm({
    Key? key, 
    required this.selectedDate, 
    required this.selectedTime
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _diseaseController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final ValueNotifier<String> _genderNotifier = ValueNotifier<String>('Male');
  final TextEditingController _drGmail =TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    final AppointmentController appointmentController = Get.put(AppointmentController());


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Patient Details',
          style:TextStyle(
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
                  style:TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Appointment on ${selectedDate.toLocal().toString().split(' ')[0]} at $selectedTime',
                  style:TextStyle(
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
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      decoration: BoxDecoration(
                                        color: currentGender == gender 
                                            ? Color(0xFF4A78FF)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: Text(
                                          gender,
                                          style:TextStyle(
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
                
                // Submit Button
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      AppointmentModel appointment = AppointmentModel(
                        drGmail :_drGmail.text,
                        name: _nameController.text,
                        gender: _genderNotifier.value, 
                        age: int.parse(_ageController.text),
                        disease: _diseaseController.text,
                        appointmentDate: selectedDate,
                        appointmentTime: selectedTime,
                      );
                      await appointmentController.addAppointment(appointment);
                    }
                  },
                  style: ElevatedButton.styleFrom( 
                    backgroundColor:Color(0xFF4A78FF),
                    padding: const EdgeInsets.symmetric(vertical: 16), 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text( 
                    'Book',     
                    style: TextStyle(
                      color: Colors.white,  
                      fontSize: 16, 
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Loading and Error Indicators
                Obx(() {
                  if (appointmentController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (appointmentController.errorMessage.value.isNotEmpty) {
                    return Center(
                      child: Text(
                        appointmentController.errorMessage.value,
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }),
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
    required String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey[600]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ), 
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300), 
        ),
        focusedBorder: OutlineInputBorder( 
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF4A78FF), width: 2), 
        ),
      ),
    );
  }
}