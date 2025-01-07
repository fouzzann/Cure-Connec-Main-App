import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cure_connect_service/views/screens/home_page/home_page.dart';

class PaymentConfirmationHeader extends StatelessWidget {
  const PaymentConfirmationHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            'Payment Confirmation',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: Icon(Icons.close, color: Colors.black54),
            onPressed: () => Get.to(() => HomePage()),
          ),
        ],
      ),
    );
  }
}
