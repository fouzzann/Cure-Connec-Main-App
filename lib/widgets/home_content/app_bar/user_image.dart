import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  UserImage({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Container(
      height: size.height * 0.085, // Responsive height
      width: size.height * 0.085, // Keep aspect ratio square
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: size.width * 0.005, // Responsive border width
        ),
      ),
      child: ClipOval(
        child: Image.network(
          _auth.currentUser!.photoURL.toString(),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
