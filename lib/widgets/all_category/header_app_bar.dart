import 'package:cure_connect_service/views/screens/search_dr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, size: 20),
              onPressed: () => Get.back(),
            ),
            const Text(
              'Categories',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.search, color: Colors.grey),
          onPressed: () {
            Get.to(() => SearchDr(), transition: Transition.downToUp);
          },
        ),
      ],
    );
  }