import 'package:cure_connect_service/views/screens/home_page/home_page.dart';
import 'package:cure_connect_service/views/screens/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late AnimationController _mainController;
  late AnimationController _pulseController;
  late AnimationController _rotationController;
  
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    
    // Main animations controller
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );

    // Pulse animation controller
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    // Rotation animation controller
    _rotationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    // Setup animations
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: Interval(0.0, 0.5, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: Interval(0.2, 0.7, curve: Curves.easeOut),
    ));

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _rotateAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * 3.14159,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.linear,
    ));

    _mainController.forward();

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
    _mainController.dispose();
    _pulseController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: [
            // Animated background patterns
            ...List.generate(3, (index) {
              return Positioned(
                top: index * 200.0,
                right: -100 + (index * 50.0),
                child: AnimatedBuilder(
                  animation: _rotateAnimation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _rotateAnimation.value + (index * 0.5),
                      child: Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF4A78FF).withOpacity(0.1),
                              Color(0xFF4A78FF).withOpacity(0.05),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
            
            // Main content
            Center(
              child: AnimatedBuilder(
                animation: _mainController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _slideAnimation.value),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Animated logo container
                          AnimatedBuilder(
                            animation: _pulseAnimation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _pulseAnimation.value,
                                child: Container(
                                  width: 150,
                                  height: 150,
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xFF4A78FF).withOpacity(0.2),
                                        blurRadius: 30,
                                        spreadRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: Image.asset(
                                    'assets/app_logo-removebg-preview.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              );
                            },
                          ),
                          
                          SizedBox(height: 40),
                          
                          // App name with modern styling
                          Column(
                            children: [
                              Text(
                                'CURE CONNECT',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 3,
                                  color: Color(0xFF4A78FF),
                                  height: 1,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                'Healthcare Simplified',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF4A78FF).withOpacity(0.7),
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: 60),
                          
                          // Modern loading indicator
                          Container(
                            width: 50,
                            height: 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: Color(0xFFE0E8FF),
                            ),
                            child: Stack(
                              children: [
                                AnimatedBuilder(
                                  animation: _mainController,
                                  builder: (context, child) {
                                    return FractionallySizedBox(
                                      widthFactor: _mainController.value,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(2),
                                          color: Color(0xFF4A78FF),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}