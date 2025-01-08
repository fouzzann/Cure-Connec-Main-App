import 'package:cure_connect_service/controllers/login_controller.dart';
import 'package:cure_connect_service/views/widgets/authentication/login_page/google_singin_button.dart';
import 'package:flutter/material.dart';

class LoginCard extends StatelessWidget {
  final LoginController controller;
  static const Color primaryColor = Color(0xFF4A78FF);

  const LoginCard({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Get Started',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 24),
          GoogleSignInButton(controller: controller),
          const SizedBox(height: 16),
          Text(
            'By continuing, you agree to our Terms of Service',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
