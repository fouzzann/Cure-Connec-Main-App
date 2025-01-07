import 'package:cure_connect_service/views/widgets/splash_screen/app_tile.dart';
import 'package:cure_connect_service/views/widgets/splash_screen/loading_indicater.dart';
import 'package:cure_connect_service/views/widgets/splash_screen/logo_container.dart';
import 'package:flutter/material.dart';

class SplashContent extends StatelessWidget {
  final AnimationController mainController;
  final Animation<double> fadeAnimation;
  final Animation<double> slideAnimation;
  final Animation<double> pulseAnimation;

  const SplashContent({
    super.key,
    required this.mainController,
    required this.fadeAnimation,
    required this.slideAnimation,
    required this.pulseAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: mainController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, slideAnimation.value),
            child: FadeTransition(
              opacity: fadeAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LogoContainer(pulseAnimation: pulseAnimation),
                  SizedBox(height: 40),
                  AppTitle(),
                  SizedBox(height: 60),
                  LoadingIndicator(mainController: mainController),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}