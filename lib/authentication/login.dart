import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cure_connect_service/model/user_model.dart';
import 'package:cure_connect_service/views/screens/home_page/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final RxBool isLoading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> loginWithGoogle() async {
    try {
      isLoading.value = true;

      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        _showNotification('Sign In Cancelled', 'Google sign in was cancelled',
            isError: true);
        return;
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        final user = userCredential.user;
        _showNotification('Success', 'Welcome back!', isError: false);
        final UserModel userModel = UserModel(
            name: user!.displayName.toString(),
            image: user.photoURL.toString(),
            uid: user.uid.toString(),
            email: user.email.toString());
        FirebaseFirestore.instance
            .collection('users')
            .doc(user.email) 
            .set(userModel.toMap());
        Get.offAll(() => HomePage(), transition: Transition.fadeIn);
      }
    } catch (e) {
      _showNotification('Error', 'Failed to sign in with Google',
          isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  void _showNotification(String title, String message,
      {required bool isError}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor:
          isError ? Colors.red.withOpacity(0.1) : Colors.green.withOpacity(0.1),
      colorText: isError ? Colors.red : Colors.green,
      duration: const Duration(seconds: 2),
      borderRadius: 12,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      animationDuration: const Duration(milliseconds: 500),
      backgroundGradient: LinearGradient(
        colors: isError
            ? [Colors.red.withOpacity(0.05), Colors.red.withOpacity(0.1)]
            : [Colors.green.withOpacity(0.05), Colors.green.withOpacity(0.1)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    _setupAuthListener();
  }

  void _setupAuthListener() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        Get.offAll(() => HomePage(), transition: Transition.fadeIn);
      }
    });
  }
}

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
              _buildAppBar(),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    _buildHeroImage(),
                    _buildWelcomeText(),
                    const Spacer(),
                    _buildLoginCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.arrow_back_ios_new,
              color: Colors.white, size: 20),
        ),
        onPressed: () => Get.back(),
      ),
      title: const Text(
        '',
        style: TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
        ),
      ),
      centerTitle: true,
      pinned: true,
    );
  }

  Widget _buildHeroImage() {
    return Expanded(
      flex: 2,
      child: Hero(
        tag: 'login_image',
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.white.withOpacity(0.8)],
              ).createShader(bounds);
            },
            child: Image.asset(
              'assets/Screenshot_2024-11-20_120720-removebg-preview.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Column(
        children: [
          Text(
            "Welcome to Healthcare",
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 32,
              fontWeight: FontWeight.w800,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Join our trusted network. Connect with top doctors and manage your health journey.",
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginCard() {
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Get Started',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 24),
          _buildGoogleButton(),
          const SizedBox(height: 16),
          Text(
            'By continuing, you agree to our Terms of Service',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildGoogleButton() {
    return Obx(() {
      return Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed:
              controller.isLoading.value ? null : controller.loginWithGoogle,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            elevation: controller.isLoading.value ? 0 : 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: Colors.grey.withOpacity(0.2),
                width: 1,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: controller.isLoading.value
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                      strokeWidth: 2,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/google.png',
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Continue with Google',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      );
    });
  }
}
