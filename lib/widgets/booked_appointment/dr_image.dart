import 'package:flutter/material.dart';

Widget buildDoctorImage(String imageUrl) {
  const double _kPadding = 20.0;
  const double _kImageSize = 80.0;
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
