import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
   UserImage({super.key});
final FirebaseAuth _auth = FirebaseAuth.instance;
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
        child: Image.network(
          _auth.currentUser!.photoURL.toString(),  
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
