import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cure_connect_service/controllers/favorite_controller.dart';
import 'package:cure_connect_service/utils/app_colors/app.theme.dart';
import 'package:cure_connect_service/views/widgets/6_categories/physiotherapist/dr_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Physiotherapist extends StatelessWidget {
  const Physiotherapist({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoritesController favoritesController =
        Get.put(FavoritesController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F5F5),
        title: Text(
          'Physiotherapist',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Expanded(child: _buildDoctorsList(favoritesController)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorsList(FavoritesController favoritesController) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('doctors')
          .where('isAccepted', isEqualTo: true)
          .where('category', isEqualTo: 'Physiotherapist')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(color: AppColors.mainTheme));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return _buildEmptyState(context);
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final doc = snapshot.data!.docs[index];
            return PhysiotherapistDoctorCard(
              doc: doc,
              favoritesController: favoritesController,
            );
          },
        );
      },
    );
  }
}

Widget _buildEmptyState(BuildContext context) {
  return Center(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.mainTheme.withOpacity(0.1),
            ),
            child: Icon(
              Icons.person_off_sharp,
              size: 40,
              color: AppColors.mainTheme,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No Physiotherapist found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Please check back later for updates. Thank you for your patience, and feel free to reach out if you need assistance in the meantime.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
    ),
  ); 
}
