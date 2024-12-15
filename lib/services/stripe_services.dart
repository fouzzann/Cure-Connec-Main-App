import 'dart:developer';

import 'package:cure_connect_service/model/api/publisheble_key.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeServices {
  StripeServices._();
  static final StripeServices instance = StripeServices._();
   
  Future<bool> makePayment() async {
    try {
      String? paymentIntentClientSecret = await _createPaymentIntent(1330, "usd");  
      if (paymentIntentClientSecret == null) return false;
      
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentClientSecret,
              merchantDisplayName: "fouzan"));
      
      // Return the result of payment processing
      return await _processPayment();
    } catch (e) {
      log(e.toString());
      return false;
    }
  }   

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        'amount': _calculateAmount(amount),
        'currency': currency
      };
      var response = await dio.post("https://api.stripe.com/v1/payment_intents",
          data: data,
          options: Options(
            contentType: Headers.formUrlEncodedContentType, 
            headers: {
              'Authorization': 'Bearer ${stripeSecretKey}',
              'content-Type': 'application/x-www-form-urlencoded'
            }
          )
      );
      
      if (response.data != null) {
        return response.data["client_secret"];
      }
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<bool> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet(); 
      await Stripe.instance.confirmPaymentSheetPayment();
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  String _calculateAmount(int amount) {
    final calculatedAmount = amount * 100;
    return calculatedAmount.toString();
  }
}