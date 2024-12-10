import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart'; // Import for input formatters

class DiseaseForm extends StatefulWidget {
  @override
  _DiseaseFormState createState() => _DiseaseFormState();
}

class _DiseaseFormState extends State<DiseaseForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _diseaseController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String _gender = 'Male';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Get.snackbar('Success', 'Form submitted successfully');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text('Disease Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _gender,
                items: ['Male', 'Female'].map((gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _gender = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Gender',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your gender';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _ageController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // Allows digits only
                ],
                decoration: InputDecoration(
                  labelText: 'Your Age',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Age must be a valid number';
                  }
                  if (int.parse(value) <= 0) {
                    return 'Age must be greater than 0';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _diseaseController,
                decoration: InputDecoration(
                  labelText: 'Write Your Disease',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your disease';
                  }
                  return null;
                },
              ),
              Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4A78FF),
                  ),
                  child: Text(
                    'Pay 566 ₹',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ), 
      ),
    );
  }
}
