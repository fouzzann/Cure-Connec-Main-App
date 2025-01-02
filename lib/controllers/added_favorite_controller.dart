import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddedFavoriteController extends GetxController {
  final RxSet<String> favoriteDoctors = <String>{}.obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    try {
      isLoading.value = true;
      final prefs = await SharedPreferences.getInstance();
      final storedFavorites = prefs.getStringList('favorites') ?? [];
      // ignore: invalid_use_of_protected_member
      favoriteDoctors.value = storedFavorites.toSet();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to load favorites',
        backgroundColor: Color(0xFFFF0000),
        colorText: const Color(0xFFFFFFFF),
      );
    }
  }

  Future<void> toggleFavorite(String doctorId) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      if (favoriteDoctors.contains(doctorId)) {
        favoriteDoctors.remove(doctorId);
      } else {
        favoriteDoctors.add(doctorId);
      }

      await prefs.setStringList('favorites', favoriteDoctors.toList());
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update favorites',
        backgroundColor: const Color(0xFFFF0000),
        colorText: const Color(0xFFFFFFFF),
      );
    }
  }

  Future<DocumentSnapshot?> getDoctorDetails(String doctorId) async {
    try {
      return await FirebaseFirestore.instance
          .collection('doctors')
          .doc(doctorId)
          .get();
    } catch (e) {
      return null;
    }
  }
}
