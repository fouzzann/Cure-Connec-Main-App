import 'package:cure_connect_service/views/screens/booking_pages/dr_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final Set<String> _favoriteDoctors = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedFavorites = prefs.getStringList('favorites') ?? [];

      setState(() {
        _favoriteDoctors.addAll(storedFavorites);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorSnackbar('Failed to load favorites');
    }
  }

  void _toggleFavorite(String doctorId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        if (_favoriteDoctors.contains(doctorId)) {
          _favoriteDoctors.remove(doctorId);
        } else {
          _favoriteDoctors.add(doctorId);
        }
      });

      await prefs.setStringList('favorites', _favoriteDoctors.toList());
    } catch (e) {
      _showErrorSnackbar('Failed to update favorites');
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorite Doctors',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF4A78FF),
              ),
            )
          : _favoriteDoctors.isEmpty
              ? const Center(
                  child: Text(
                    'No favorite doctors found',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: _favoriteDoctors.length,
                  itemBuilder: (context, index) {
                    final doctorId = _favoriteDoctors.elementAt(index);
                    return _buildDoctorCard(doctorId);
                  },
                ),
    );
  }

  Widget _buildDoctorCard(String doctorId) {
    return FutureBuilder<DocumentSnapshot>(
      future:
          FirebaseFirestore.instance.collection('doctors').doc(doctorId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF4A78FF),
            ),
          );
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const SizedBox.shrink();
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;

        return Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  data['image'] ?? '',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey[200],
                    child: const Icon(Icons.person),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['fullName'] ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${data['category']} | ${data['hospitalName']}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            data['location'] ?? '',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(
                      _favoriteDoctors.contains(doctorId)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: _favoriteDoctors.contains(doctorId)
                          ? Colors.blue
                          : Colors.grey,
                    ),
                    onPressed: () => _toggleFavorite(doctorId),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(
                          () => DoctorProfileView(
                                data: data,
                              ), 
                          transition: Transition.rightToLeftWithFade);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A78FF),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Connect',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
