import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserName extends StatelessWidget {
  UserName({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hi ${_auth.currentUser!.displayName.toString()}!",
          style: TextStyle(
            color: Colors.white,
            fontSize: size.width * 0.045, // Responsive font size
            fontWeight: FontWeight.w300,
          ),
        ),
        Text(
          'Find your Doctor',
          style: TextStyle(
            color: Colors.white,
            fontSize: size.width * 0.08, // Responsive font size
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}