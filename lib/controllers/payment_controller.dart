import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PaymentController extends GetxController {
  Map<String, dynamic>? paymentIntentData;

  Future<void> makePayment({
    required String amount,
    required String currency,
  }) async {
    try {
      // Create a payment intent on the server
      paymentIntentData = await createPaymentIntent(amount, currency);
      if (paymentIntentData != null) {
        // Initialize payment sheet
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            applePay: PaymentSheetApplePay(
              merchantCountryCode: 'US',
            ),
            googlePay: PaymentSheetGooglePay(
              merchantCountryCode: 'US',
              testEnv: true,
            ),
            merchantDisplayName: 'Prospects',
            customerId: paymentIntentData!['customer'],
            paymentIntentClientSecret: paymentIntentData!['client_secret'],
            customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
          ),
        );
        // Display the payment sheet     
        await displayPaymentSheet();
      }
    } catch (e, s) {
      debugPrint('Error in makePayment: $e\n$s');
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      Get.snackbar(
        'Payment',
        'Payment Successful',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 2),
      );
    } on StripeException catch (e) {
      debugPrint("Stripe Exception: ${e.error.localizedMessage}");
      Get.snackbar(
        'Payment Failed',
        e.error.localizedMessage ?? 'An error occurred during payment',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      debugPrint('Error displaying payment sheet: $e');
    }
  }

  Future<Map<String, dynamic>?> createPaymentIntent(
    String amount,
    String currency,
  ) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      // Call Stripe API to create a payment intent
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization': 'Bearer YOUR_STRIPE_SECRET_KEY',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        debugPrint('Failed to create payment intent: ${response.body}');
        return null;
      }
    } catch (err) {
      debugPrint('Error creating payment intent: $err');
      return null;
    }
  }

  String calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100; // Stripe requires amounts in cents
    return a.toString();
  }
}
