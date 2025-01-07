// lib/views/screens/search_dr/widgets/doctor_card.dart

import 'package:flutter/material.dart';
import '../../../../utils/app_colors/app.theme.dart';

class SearchPageDoctorCard extends StatelessWidget {
  final dynamic doctor;
  final VoidCallback onConnect;

  const SearchPageDoctorCard({
    super.key,
    required this.doctor,
    required this.onConnect,
  });

  @override
  Widget build(BuildContext context) {
    final String fullName = doctor.get('fullName') as String;
    final String category = doctor.get('category') as String;
    final String imageUrl = doctor.get('image') as String;
    final String drRating = doctor.get('rating') as String;
    final String location = doctor.get('location') as String;
    final String yearsOfExperience = doctor.get('yearsOfExperience') as String;

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDoctorImage(imageUrl),
            const SizedBox(width: 16),
            _buildDoctorInfo(
              fullName: fullName,
              category: category,
              drRating: drRating,
              location: location,
              yearsOfExperience: yearsOfExperience,
            ),
            _buildConnectButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorImage(String imageUrl) {
    return ClipOval(
      child: Image.network(
        imageUrl,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildDoctorInfo({
    required String fullName,
    required String category,
    required String drRating,
    required String location,
    required String yearsOfExperience,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fullName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            category,
            style: TextStyle(color: AppColors.mainTheme),
          ),
          const SizedBox(height: 8),
          _buildRatingAndLocation(drRating, location),
          Text('$yearsOfExperience Years of experience'),
        ],
      ),
    );
  }

  Widget _buildRatingAndLocation(String rating, String location) {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.orange, size: 16),
        Text(' $rating'),
        const SizedBox(width: 12),
        const Icon(Icons.location_on, color: Colors.grey, size: 16),
        Text(location),
      ],
    );
  }

  Widget _buildConnectButton() {
    return ElevatedButton(
      onPressed: onConnect,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.mainTheme,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text(
        'Connect',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}