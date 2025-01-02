import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SearchDrController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final RxList<DocumentSnapshot> users = <DocumentSnapshot>[].obs;
  final RxList<String> categories = <String>[].obs;
  final RxBool isLoading = false.obs;
  final RxnString selectedCategory = RxnString();
  Timer? _debounceTimer;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
    restoreSearchState();
    ever(selectedCategory, (_) {
      searchUsers(searchController.text);
    });
  }

  @override
  void onClose() {
    saveSearchState();

    // Clean up resources
    _debounceTimer?.cancel();
    searchController.dispose();
    users.clear();
    selectedCategory.value = null;
    super.onClose();
  }

  void saveSearchState() {
    final box = GetStorage();
    box.write('searchText', searchController.text);
    box.write('selectedCategory', selectedCategory.value);
  }

  void restoreSearchState() {
    final box = GetStorage();
    String? savedSearchText = box.read('searchText');
    String? savedCategory = box.read('selectedCategory');

    if (savedSearchText != null) {
      searchController.text = savedSearchText;
    }
    if (savedCategory != null) {
      selectedCategory.value = savedCategory;
    }

    if (savedSearchText != null || savedCategory != null) {
      searchUsers(savedSearchText ?? '');
    }
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

  void searchUsers(String query) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _performSearch(query);
    });
  }

  void _performSearch(String query) async {
    query = query.trim();

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
