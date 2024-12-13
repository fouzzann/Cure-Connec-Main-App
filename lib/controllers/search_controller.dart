import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchDrController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final RxList<DocumentSnapshot> users = <DocumentSnapshot>[].obs;
  final RxList<String> categories = <String>[].obs;
  final RxBool isLoading = false.obs;
  final RxnString selectedCategory = RxnString(); // Use RxnString for nullable reactive variables.

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  Future<void> loadCategories() async {
    try {
      final categoriesSnapshot =
          await FirebaseFirestore.instance.collection('categories').get();
      categories.value =
          categoriesSnapshot.docs.map((doc) => doc['name'] as String).toList();
    } catch (e) {
      Get.snackbar('Error', 'Error loading categories',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void searchUsers(String query) async {
    if (query.isEmpty && selectedCategory.value == null) {
      users.clear();
      return;
    }

    isLoading.value = true;

    try {
      Query doctorsQuery = FirebaseFirestore.instance.collection('doctors');

      if (selectedCategory.value != null) {
        doctorsQuery =
            doctorsQuery.where('category', isEqualTo: selectedCategory.value);
      }

      if (query.isNotEmpty) {
        String capitalizedQuery =
            query[0].toUpperCase() + query.substring(1).toLowerCase();
        doctorsQuery = doctorsQuery
            .where('fullName', isGreaterThanOrEqualTo: capitalizedQuery)
            .where('fullName', isLessThan: capitalizedQuery + '\uf8ff');
      }

      final userQuery = await doctorsQuery.get();
      users.value = userQuery.docs;
    } catch (e) {
      Get.snackbar('Error', 'Error searching users',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
