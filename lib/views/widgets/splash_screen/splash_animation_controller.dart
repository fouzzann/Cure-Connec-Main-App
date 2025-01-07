// lib/controllers/splash_animation_controller.dart

import 'package:flutter/material.dart';

class SplashAnimationController {
  final TickerProvider vsync;
  late final AnimationController mainController;
  late final AnimationController pulseController;
  late final AnimationController rotationController;
  
  late final Animation<double> fadeAnimation;
  late final Animation<double> slideAnimation;
  late final Animation<double> pulseAnimation;
  late final Animation<double> rotateAnimation;

  SplashAnimationController({required this.vsync}) {
    _initializeControllers();
    _initializeAnimations();
    mainController.forward();
  }

  void _initializeControllers() {
    mainController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: vsync,
    );

    pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: vsync,
    )..repeat(reverse: true);

    rotationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: vsync,
    )..repeat();
  }

  void _initializeAnimations() {
    fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: mainController,
      curve: Interval(0.0, 0.5, curve: Curves.easeOut),
    ));

    slideAnimation = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: mainController,
      curve: Interval(0.2, 0.7, curve: Curves.easeOut),
    ));

    pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: pulseController,
      curve: Curves.easeInOut,
    ));

    rotateAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * 3.14159,
    ).animate(CurvedAnimation(
      parent: rotationController,
      curve: Curves.linear,
    ));
  }

  void dispose() {
    mainController.dispose();
    pulseController.dispose();
    rotationController.dispose();
  }
}