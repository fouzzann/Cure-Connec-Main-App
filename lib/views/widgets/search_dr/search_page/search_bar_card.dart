import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cure_connect_service/utils/app_colors/app.theme.dart';
import 'package:flutter/material.dart';

class SearchPageDoctorCard extends StatelessWidget {
  final DocumentSnapshot doctor;
  final VoidCallback onConnect;

  const SearchPageDoctorCard({
    Key? key,
    required this.doctor,
    required this.onConnect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = doctor.data() as Map<String, dynamic>;

    return Card(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage:
              data['image'] != null ? NetworkImage(data['image']) : null,
          backgroundColor: AppColors.drSearchBar,
          child: data['image'] == null
              ? Icon(Icons.person, color: Colors.grey[600])
              : null,
        ),
        title: Text(
          data['fullName'] ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (data['category'] != null)
              Text(
                data['category'] ?? '',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.star, size: 20, color: Colors.amber.shade600),
                SizedBox(width: 4),
                Text(
                  '${data['rating']?.toString() ?? '0.0'}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.local_hospital,
                    size: 16, color: Colors.grey.shade600),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    data['hospitalName'] ?? 'Independent Practice',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            // Location with Icon
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.grey.shade600),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    data['location'] ?? 'Location not specified',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: onConnect,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.mainTheme,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          ),
          child: const Text(
            'Connect',
          ),
        ),
      ),
    );
  }
}


