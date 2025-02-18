import 'package:cure_connect_service/controllers/search_controller.dart';
import 'package:cure_connect_service/firebase_options.dart';
import 'package:cure_connect_service/model/api/publisheble_key.dart';
import 'package:cure_connect_service/views/screens/splash_screen.dart';
import 'package:cure_connect_service/utils/app_colors/app.theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

void main() async {
  await _setUp();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); 
  Get.put(SearchDrController());
  runApp(MyApp());
}

Future <void> _setUp()async{
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.mainTheme,
        ),
        primarySwatch: Colors.orange),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
