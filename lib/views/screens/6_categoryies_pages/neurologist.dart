import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Neurologist extends StatelessWidget {
  const Neurologist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F5F5),
        title: Text(
          'Neurologist',
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
