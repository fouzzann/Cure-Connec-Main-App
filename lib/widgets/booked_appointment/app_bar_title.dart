import 'package:flutter/material.dart';

PreferredSizeWidget buildAppBar() {
  return AppBar(
    elevation: 0,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    title: const Text(
      'My Appointments',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
    ),
    centerTitle: true,
  );
}
