import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesController extends GetxController {
  final RxSet<String> favoriteDoctors = <String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    // ignore: invalid_use_of_protected_member
    favoriteDoctors.value = prefs.getStringList('favorites')?.toSet() ?? {};
  }

  Future<void> toggleFavorite(String doctorId) async {
    final prefs = await SharedPreferences.getInstance();

    if (favoriteDoctors.contains(doctorId)) {
      favoriteDoctors.remove(doctorId);
    } else {
      favoriteDoctors.add(doctorId);
    }

    await prefs.setStringList('favorites', favoriteDoctors.toList());
  }

  bool isFavorite(String doctorId) {
    return favoriteDoctors.contains(doctorId);
  }
}
