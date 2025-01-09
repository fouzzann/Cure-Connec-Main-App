import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';

// Controller
class SearchDrController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final RxList<DocumentSnapshot> users = <DocumentSnapshot>[].obs;
  final RxList<String> categories = <String>[].obs;
  final RxBool isLoading = false.obs;
  final Rx<String?> selectedCategory = Rx<String?>(null);
  Timer? _debounceTimer;

  final RxList<Map<String, dynamic>> feeRanges = <Map<String, dynamic>>[
    {'min': 100, 'max': 500, 'isSelected': false},
    {'min': 500, 'max': 1000, 'isSelected': false},
    {'min': 1000, 'max': 2000, 'isSelected': false},
    {'min': 2000, 'max': 3000, 'isSelected': false},
    {'min': 3000, 'max': double.infinity, 'isSelected': false},
  ].obs;

  bool get hasActiveFeeFilter => feeRanges.any((range) => range['isSelected']);

  @override
  void onInit() {
    super.onInit();
    loadCategories();
    fetchAllDoctors();
    restoreSearchState();
    ever(selectedCategory, (_) {
      searchUsers(searchController.text);
    });
  }

  @override
  void onClose() {
    saveSearchState();
    _debounceTimer?.cancel();
    searchController.dispose();
    users.clear();
    selectedCategory.value = null;
    super.onClose();
  }

  void toggleFeeRange(int index) {
    for (var range in feeRanges) {
      range['isSelected'] = false;
    }
    feeRanges[index]['isSelected'] = true;
    searchUsers(searchController.text);
  }

  void clearFeeFilter() {
    for (var range in feeRanges) {
      range['isSelected'] = false;
    }
    searchUsers(searchController.text);
  }

  void saveSearchState() {
    final box = GetStorage();
    box.write('searchText', searchController.text);
    box.write('selectedCategory', selectedCategory.value);
    final activeFeeRange = feeRanges.indexWhere((range) => range['isSelected']);
    box.write('selectedFeeRange', activeFeeRange);
  }

  void restoreSearchState() {
    final box = GetStorage();
    String? savedSearchText = box.read('searchText');
    String? savedCategory = box.read('selectedCategory');
    int? savedFeeRange = box.read('selectedFeeRange');

    if (savedSearchText != null) {
      searchController.text = savedSearchText;
    }
    if (savedCategory != null) {
      selectedCategory.value = savedCategory;
    }
    if (savedFeeRange != null && savedFeeRange >= 0 && savedFeeRange < feeRanges.length) {
      feeRanges[savedFeeRange]['isSelected'] = true;
    }

    if (savedSearchText != null || savedCategory != null || savedFeeRange != null) {
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

  // Fetch all doctors without searching
  Future<void> fetchAllDoctors() async {
    isLoading.value = true;

    try {
      QuerySnapshot doctorSnapshot = await FirebaseFirestore.instance.collection('doctors').get();
      users.value = doctorSnapshot.docs;
    } catch (e) {
      Get.snackbar('Error', 'Error fetching doctors',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
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

    if (query.isEmpty && selectedCategory.value == null && !hasActiveFeeFilter) {
      fetchAllDoctors();
      return;
    }

    isLoading.value = true;

    try {
      Query doctorsQuery = FirebaseFirestore.instance.collection('doctors');

      if (selectedCategory.value != null) {
        doctorsQuery = doctorsQuery.where('category', isEqualTo: selectedCategory.value);
      }

      QuerySnapshot initialResults = await doctorsQuery.get();

      var selectedRange = feeRanges.firstWhereOrNull((range) => range['isSelected']);
      if (selectedRange != null) {
        var filteredDocs = initialResults.docs.where((doc) {
          String feeStr = doc.get('consultationFee') as String;
          int fee = int.tryParse(feeStr) ?? 0;
          return fee >= selectedRange['min'] && (selectedRange['max'] == double.infinity || fee < selectedRange['max']);
        }).toList();

        users.value = filteredDocs;
      } else {
        users.value = initialResults.docs;
      }

      if (query.isNotEmpty) {
        String capitalizedQuery = query[0].toUpperCase() + query.substring(1).toLowerCase();
        users.value = users.where((doc) {
          String fullName = doc.get('fullName') as String;
          return fullName.startsWith(capitalizedQuery);
        }).toList();
      }

    } catch (e) {
      print('Search error: $e');
      Get.snackbar('Error', 'Error searching users',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
