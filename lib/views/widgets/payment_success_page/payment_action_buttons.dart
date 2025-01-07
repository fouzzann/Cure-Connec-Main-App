import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cure_connect_service/views/screens/home_page/home_page.dart';

class PaymentActionButtons extends StatelessWidget {
  const PaymentActionButtons({Key? key}) : super(key: key);

  static const Color primaryColor = Color(0xFF4A78FF);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Receipt feature coming soon'),
                  backgroundColor: primaryColor,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: primaryColor,
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 6,
              shadowColor: primaryColor.withOpacity(0.4),
            ),
            child: const Text(
              'View Receipt',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () => Get.offAll(() => HomePage()),
            style: OutlinedButton.styleFrom(
              foregroundColor: primaryColor,
              minimumSize: const Size(double.infinity, 56),
              side: BorderSide(
                  color: primaryColor.withOpacity(0.3), width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Back to Home',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
