import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cure_connect_service/controllers/favorite_controller.dart';
import 'package:cure_connect_service/views/utils/app_colors/app.theme.dart';
import 'package:cure_connect_service/widgets/6_categories/physiotherapist/dr_card.dart';
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
          return const Center(child: Text('No Physiotherapist found'));
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
