import 'package:get/get.dart';

class ChatController extends GetxController {
  final RxString searchQuery = ''.obs;

  void updateSearchQuery(String query) {
    searchQuery.value = query.toUpperCase();
  }
}
