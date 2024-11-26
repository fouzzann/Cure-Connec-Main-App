import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  const UserImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/Donex Fiance.webp',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
