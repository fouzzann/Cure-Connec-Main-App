import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  Header({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.1),
                spreadRadius: 10,
                blurRadius: 20,
              ),
            ],
            image: DecorationImage(
              image: NetworkImage(_auth.currentUser!.photoURL.toString()),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _auth.currentUser!.displayName.toString(),
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.verified,
                      size: 14,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Verified Profile',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
