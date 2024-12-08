import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Nephrologist extends StatefulWidget {
  const Nephrologist({super.key});

  @override
  State<Nephrologist> createState() => _NephrologistState();
}

class _NephrologistState extends State<Nephrologist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F5F5),
        title: Text(
          'Nephrologist',
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
