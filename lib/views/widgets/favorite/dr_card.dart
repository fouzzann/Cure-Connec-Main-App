import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cure_connect_service/controllers/added_favorite_controller.dart';
import 'package:cure_connect_service/views/widgets/favorite/dr_actions.dart';
import 'package:cure_connect_service/views/widgets/favorite/dr_info.dart';
import 'package:flutter/material.dart';

class FavoritePageDoctorCard extends StatelessWidget {
  final String doctorId;
  final AddedFavoriteController controller;

  const FavoritePageDoctorCard({
    Key? key,
    required this.doctorId,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot?>(
      stream: FirebaseFirestore.instance
          .collection('doctors')
          .doc(doctorId)
          .snapshots(),
      builder: (context, snapshot) {
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
              DoctorImage(imageUrl: data['image']),
              const SizedBox(width: 12),
              Expanded(
                child: DoctorInfo(data: data),
              ),
              DoctorActions(
                doctorId: doctorId,
                controller: controller,
                data: data,
              ),
            ],
          ),
        );
      },
    );
  }
}

class DoctorImage extends StatelessWidget {
  final String? imageUrl;

  const DoctorImage({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        imageUrl ?? '',
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
    );
  }
}