import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dentist extends StatelessWidget {
  const Dentist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F5F5),
        title: Text(
          'Dentist',
          style: TextStyle(fontWeight: FontWeight.bold), 
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios)),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFFF5F5F5),
    );
  }
}
