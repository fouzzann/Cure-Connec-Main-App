  import 'package:flutter/material.dart';
  
Widget buildDoctorImage(String imageUrl) {
    double _kImageSize = 80.0;
     double _kPadding = 20.0;
    return Container(
      width: _kImageSize,
      height: _kImageSize,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(_kPadding),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_kPadding),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Icon(
            Icons.person,
            size: 40,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }