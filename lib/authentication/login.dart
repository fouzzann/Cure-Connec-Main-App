import 'package:cure_connect_service/controllers/login_controller.dart';
import 'package:cure_connect_service/views/widgets/authentication/login_page/login_app_bar.dart';
import 'package:cure_connect_service/views/widgets/authentication/login_page/login_card.dart';
import 'package:cure_connect_service/views/widgets/authentication/login_page/login_hero_message.dart';
import 'package:cure_connect_service/views/widgets/authentication/login_page/login_welcome_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  LoginPage({super.key});

  static const Color primaryColor = Color(0xFF4A78FF);
  static const Color secondaryColor = Color(0xFF6C63FF);

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              primaryColor,
              secondaryColor,
              Colors.white,
            ],
            stops: const [0.0, 0.4, 0.9],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              LoginAppBar(),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    LoginHeroImage(),
                    LoginWelcomeText(),
                    const Spacer(),
                    LoginCard(controller: controller),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}