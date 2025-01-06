import 'package:flutter/material.dart';

class StatRow extends StatelessWidget {
  final Map<String, dynamic> data;

  const StatRow({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStat(
            icon: Icons.local_hospital,
            value: 'Hospital',
            label: 'Work',
            iconColor: Color(0xFF4A78FF),
          ),
          _buildStat(
            icon: Icons.workspace_premium_outlined,
            value: "${data['yearsOfExperience']} Years",
            label: 'Experience',
            iconColor: Color(0xFF4A78FF),
          ),
          _buildStat(
            icon: Icons.star_outlined,
            value: data['rating'] ?? '0.0',
            label: 'Rating',
            iconColor: Color(0xFF4A78FF),
          ),
          _buildStat(
            icon: Icons.security_update_good,
            value: 'Verified',
            label: 'Profile',
            iconColor: Color(0xFF4A78FF),
          ),
        ],
      ),
    );
  }

  Widget _buildStat({
    required IconData icon,
    required String value,
    required String label,
    required Color iconColor,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
