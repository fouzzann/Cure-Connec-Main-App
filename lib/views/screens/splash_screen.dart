import 'package:cure_connect_service/views/screens/home_page/home_page.dart';
import 'package:cure_connect_service/views/screens/welcome_page.dart';
import 'package:cure_connect_service/views/widgets/splash_screen/animation_background.dart';
import 'package:cure_connect_service/views/widgets/splash_screen/splash_animation_controller.dart';
import 'package:cure_connect_service/views/widgets/splash_screen/splash_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late SplashAnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = SplashAnimationController(vsync: this);
    _handleNavigation();
  }

  void _handleNavigation() {
    Future.delayed(Duration(seconds: 3), () {
      if (_auth.currentUser != null) {
        Get.offAll(() => HomePage(), 
          transition: Transition.fadeIn,
          duration: Duration(milliseconds: 800),
        );
      } else {
        Get.offAll(() => WelcomePage(),
          transition: Transition.fadeIn,
          duration: Duration(milliseconds: 800),
        );
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            AnimatedBackground(rotateAnimation: animationController.rotateAnimation),
            SplashContent(
              mainController: animationController.mainController,
              fadeAnimation: animationController.fadeAnimation,
              slideAnimation: animationController.slideAnimation,
              pulseAnimation: animationController.pulseAnimation,
            ),
          ],
        ),
      ),
    );
  }
}