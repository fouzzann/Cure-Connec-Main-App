import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cure_connect_service/model/user_model.dart';
import 'package:cure_connect_service/views/screens/home_page/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

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