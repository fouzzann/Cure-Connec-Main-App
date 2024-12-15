import 'package:cure_connect_service/model/doctor_model.dart';
import 'package:cure_connect_service/views/screens/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PaymentSuccessPage extends StatefulWidget {
  const PaymentSuccessPage({Key? key}) : super(key: key);

  @override
  _PaymentSuccessPageState createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  // Primary color from the theme
  static const Color primaryColor = Color(0xFF4A78FF);

  @override
  void initState() {
    super.initState();
    
    // Set status bar and navigation bar colors for a modern look
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    // Animation controller setup
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Scale animation for the success icon
    _scaleAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );

    // Fade animation for text elements
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Start the animations
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Modern App Bar
            Container(
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
                    onPressed: () => Get.to(()=> HomePage()),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(    
                      scale: _scaleAnimation.value,
                      child: Opacity(
                        opacity: _fadeAnimation.value,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Animated Success Icon
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    primaryColor,
                                    primaryColor.withOpacity(0.7),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: primaryColor.withOpacity(0.4),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(20),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 80,
                              ),
                            ),

                            const SizedBox(height: 32),

                            // Main Success Message
                            Text(
                              'Payment Successful',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                                letterSpacing: -0.5,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            const SizedBox(height: 16),

                            // Subtext
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: Text(
                                'Your payment has been processed successfully. '
                                'Thank you for your purchase!',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Bottom Action Buttons with Modern Design
            Container(
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
                  // Primary Action Button
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

                  // Secondary Action Button
                  OutlinedButton(
                    onPressed: () => Navigator.of(context)
                        .popUntil((route) => route.isFirst),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: primaryColor,
                      minimumSize: const Size(double.infinity, 56),
                      side: BorderSide(color: primaryColor.withOpacity(0.3), width: 2),
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
            ),
          ],
        ),
      ),
    );
  }
}